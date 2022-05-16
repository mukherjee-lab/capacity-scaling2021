function [t, m, q] = solve_ftp(omega, beta, m0, lambda)

% Solve differential equation
[t, y] = ode45(@(t, y) ftpalg(omega, beta, lambda, t, y), [1 size(lambda, 1)], [m0; 0]);
m = y(:, 1);
q = y(:, 2);