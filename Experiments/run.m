function [cr_ftp, cr_bcs] = run(omega, theta, beta, type, conf, err)

fname = "data_" + type + "_w" + omega + "_t" + theta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";

if isfile(fname)
    load(fname, "cr_ftp", "cr_bcs");
    return;
end

if type == "sin"
    delta = 5;
    time = (1:delta:(3 * 24 * 60 * 60))';
    
    lambda = 1000 * (0.5 + 0.5 * sin(time * 2 * pi / (24 * 60 * 60) - 0.5 * pi));

    if err == 1
        predlambda = 0 * lambda;
    elseif err == 2
        predlambda = 0 * lambda + 1000 * 0.5;
    elseif err == 3
        predlambda = 1000 * (0.5 + 0.5 * cos(time * 2 * pi / (24 * 60 * 60) - 0.5 * pi));
    elseif err == 4
        predlambda = lambda;
    end
elseif type == "shark"
    delta = 5;
    time = (1:delta:(3 * 24 * 60 * 60))';
    
    lambda = 1000 * (0.5 + 0.5 * sin(time * 2 * pi / (24 * 60 * 60) - 0.5 * pi));
    lambda = 1000 * (lambda >= 0.5 * 1000);

    if err == 1
        predlambda = 0 * lambda;
    elseif err == 2
        predlambda = 0 * lambda + 1000 * 0.5;
    elseif err == 3
        predlambda = 1000 * (0.5 + 0.5 * cos(time * 2 * pi / (24 * 60 * 60) - 0.5 * pi));
        predlambda = 1 * (predlambda >= 0.5);
    elseif err == 4
        predlambda = lambda;
    end
elseif type == "peak"
    delta = 1;
    time = (1:delta:24 * 60 * 60)';
    
    lambda = 1000 * (time <= 5 * 60);
    
    if err == 1
        predlambda = 0 * lambda;
    elseif err == 2
        predlambda = 0.5 * lambda;
    elseif err == 4
        predlambda = lambda;
    end
elseif type == "real"
    delta = 1;
    load("counts_20160426_merged.mat", "countsMerged");
    lambda = countsMerged;
    
    if err == 1
        predlambda = 0 * lambda;
    elseif err == 2
        predlambda = movmean(lambda, 3 * 60 * 60);
    elseif err == 4
        predlambda = lambda;
    end
end

omega = omega * delta;
theta = theta * delta;

T = size(lambda, 1);
m0 = 0;

% Opt algorithm
[optcost, optm, optq] = solve_opt(omega, theta, beta, m0, lambda);

% FTP algorithm
[~, predm, predq] = solve_opt(omega, theta, beta, m0, predlambda);
[ftpt, ftpm, ftpq] = solve_ftp(omega, beta, m0, max(lambda - predlambda, 0));

ftpm = sample_discrete(ftpt, ftpm, T);
ftpq = sample_discrete(ftpt, ftpq, T);

disp("FTP");
costftp = cost(lambda, delta, theta, omega, beta, m0, predm + ftpm, 1:T, predq + ftpq, 1:T);
cr_ftp = costftp / optcost;

% BCS-ML algorithm
[bcst, bcsm, bcsq] = solve_aca(omega, theta, beta, m0, lambda, predm + ftpm, predq + ftpq, conf);

disp("BCS");
costbcs = cost(lambda, delta, theta, omega, beta, m0, bcsm, bcst, bcsq, bcst);
cr_bcs = costbcs / optcost;

bcsm = sample_discrete(bcst, bcsm, T);
bcsq = sample_discrete(bcst, bcsq, T);

% Save data
fname = "data_" + type + "_w" + omega + "_t" + theta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
save(fname, "time", "omega", "beta", "theta", "lambda", "predlambda", "optcost", "optm", "optq", "predm", "predq", "ftpm", "ftpq", "costftp", "cr_ftp", "bcsm", "bcsq", "costbcs", "cr_bcs");

% Figure
% set(0, 'defaultfigurecolor', [1 1 1]);
% set(0, 'defaultaxesfontsize', 16);
% set(0, 'defaultaxesticklabelinterpreter', 'latex');
% set(0, 'defaulttextinterpreter', 'latex');
% set(0, 'defaultlegendfontsize', 16);
% set(0, 'defaultlegendinterpreter', 'latex');
% 
% C = linspecer(6);
% 
% figure;
% hold on;
% grid on;
% box on;
% set(gca, "XMinorTick", "on", "YMinorTick", "on");
% 
% h1 = plot(time, lambda);
% set(h1, "Color", C(3, :));
% set(h1, "LineWidth", 1.5);
% set(h1, "LineStyle", "-");
% 
% h2 = plot(time, predlambda);
% set(h2, "Color", C(5, :));
% set(h2, "LineWidth", 1.5);
% set(h2, "LineStyle", "-");
% 
% h3 = plot(time, optm);
% set(h3, "Color", C(4, :));
% set(h3, "LineWidth", 1.5);
% set(h3, "LineStyle", "-.");
% 
% h4 = plot(time, predm);
% set(h4, "Color", C(6, :));
% set(h4, "LineWidth", 1.5);
% set(h4, "LineStyle", "-.");
% 
% h5 = plot(time, predm + ftpm);
% set(h5, "Color", C(1, :));
% set(h5, "LineWidth", 1.5);
% set(h5, "LineStyle", "--");
% 
% h6 = plot(time, bcsm);
% set(h6, "Color", C(2, :));
% set(h6, "LineWidth", 1.5);
% set(h6, "LineStyle", "-");
% 
% xlabel("Seconds");
% ylabel("Number of servers");
% legend({"$\lambda$", "$\tilde{\lambda}$", "Opt", "FTP ($\tilde{m}_1$)", "FTP ($\tilde{m}$)", "BCS"});
% xlim([0, time(end)]);
% 
% savefig("data.fig");