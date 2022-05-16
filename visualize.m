lambda = readtable("counts.txt");
lambda = lambda.Var1 / 10^2;
T = size(lambda, 1);

theta = 500 * 3.664 / 10^6;
omega = 0.001;
beta = 5 * 1800000 * 3.664 / 10^6;

m0 = 500;

% Optimal algorithm
optm = readtable("capacity_d1_w" + omega + ".txt");
optm = optm.Var1;

optq = readtable("workload_d1_w" + omega + ".txt");
optq = optq.Var1;

% Predicted algorithm
predm = readtable("capacity_e10_d1_w" + omega + ".txt");
predm = predm.Var1;

predq = solve_workload_discrete(lambda, optm);

predlambda = readtable("lambda_e10_d1_w" + omega + ".txt");
predlambda = predlambda.Var1;

MAE = sum(omega * (T - (1:T))' .* abs(predlambda - lambda));

% Accumulated cost algorithm
[acat, acam, acaq] = solve_aca(theta, omega, beta, m0, lambda, predm, predq, 1);

% Timer algorithm
timerm = solve_timeralg(theta, beta, m0, lambda);

% Figure
set(0, 'defaultfigurecolor', [1 1 1]);
set(0, 'defaultaxesfontname', 'Palatino');
set(0, 'defaultaxesfontsize', 14);
C = linspecer(6);

figure;
hold on;

h = plot((1:T) / (60 * 60), lambda);
set(h, "Color", C(3, :));
set(h, "LineWidth", 0.8);
set(h, "LineStyle", "-");

h = plot((1:T) / (60 * 60), predlambda);
set(h, "Color", C(5, :));
set(h, "LineWidth", 0.8);
set(h, "LineStyle", "-");

h = plot((1:T) / (60 * 60), optm);
set(h, "Color", C(4, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-.");

h = plot((1:T) / (60 * 60), predm);
set(h, "Color", C(6, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-.");

h = plot((1:T) / (60 * 60), timerm);
set(h, "Color", C(1, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

h = plot(acat / (60 * 60), acam);
set(h, "Color", C(2, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

xlabel("Hours", "Interpreter", "latex");
ylabel("Number of servers", "Interpreter", "latex");
xlim([0 22]);
ylim([0 800]);

legend("$\lambda$", "Opt", "Timer", "ACA", "FontSize", 14, "Location", "southwest", "Interpreter", "latex");

% Cost of the optimal algorithm
costopt = cost(lambda, theta, omega, beta, m0, optm, 1:size(lambda, 1), optq, 1:size(lambda, 1));
disp(costopt);
disp(MAE / costopt);

% Cost of the ACA
costaca = cost(lambda, theta, omega, beta, m0, acam, acat, acaq, acat);
disp(costaca);
disp(costaca / costopt);

% Cost of the timer algorithm
[timert, timerq] = solve_workload(lambda, timerm);
costtimer = cost(lambda, theta, omega, beta, m0, timerm, 1:size(lambda, 1), timerq, timert);
disp(costtimer);
disp(costtimer / costopt);
