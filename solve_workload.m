function [t, q] = solve_workload(lambda, m)

% Solve differential equation
options = odeset("RelTol", 10^-4);
[t, q] = ode45(@(t, y) workload(lambda, m, t, y), [1 size(lambda, 1)], 0, options);