function [t, m, q] = solve_aca(omega, theta, beta, m0, lambda, mpred, qpred, conf)

% Solve differential equation
[t, y] = ode45(@(t, y) aca(omega, theta, beta, lambda, mpred, qpred, conf, t, y), [1 size(lambda, 1)], [m0; 0]);
m = y(:, 1);
q = y(:, 2);