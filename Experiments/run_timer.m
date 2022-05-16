function run_timer(omega, theta, beta, type)

if type == "sin"
    delta = 5;
    time = (1:delta:(3 * 24 * 60 * 60))';
    
    lambda = 1000 * (0.5 + 0.5 * sin(time * 2 * pi / (24 * 60 * 60) - 0.5 * pi));
elseif type == "shark"
    delta = 5;
    time = (1:delta:(3 * 24 * 60 * 60))';
    
    lambda = 1000 * (0.5 + 0.5 * sin(time * 2 * pi / (24 * 60 * 60) - 0.5 * pi));
    lambda = 1000 * (lambda >= 0.5 * 1000);
elseif type == "peak"
    delta = 1;
    time = (1:delta:24 * 60 * 60)';
    
    lambda = 1000 * (time <= 5 * 60);
elseif type == "real"
    delta = 1;
    load("counts_20160426_merged.mat", "countsMerged");
    lambda = countsMerged;
end

omega = omega * delta;
theta = theta * delta;

T = size(lambda, 1);
m0 = 0;

% Timer algorithm
timerm = solve_timeralg(theta, beta, m0, lambda);

disp("Timer");
costtimer = cost(lambda, delta, theta, omega, beta, m0, timerm, 1:T, zeros(T, 1), 1:T);

plot(1:T, timerm);

% Save data
fname = "data_" + type + "_w" + omega + "_t" + theta + "_b" + beta + ".mat";
save(fname, "costtimer", "timerm");