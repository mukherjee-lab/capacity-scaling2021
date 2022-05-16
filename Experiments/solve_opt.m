function [cost, m, q] = solve_opt(omega, theta, beta, m0, lambda)

delta = 1;
T = size(lambda, 1);
n = T / delta;

c = [
    repelem(omega * delta, n-1, 1); 0.5 * omega * delta;
    repelem(beta, n, 1);
    repelem(theta * delta, n, 1)
];
A = [
    spdiags([repelem(-1, n, 1) repelem(1, n, 1)], [-1 0], n, n) sparse(n, n) delta * speye(n);
    sparse(n, n) speye(n) spdiags([repelem(1, n, 1) repelem(-1, n, 1)], [-1 0], n, n)
];
b = [
    repelem(delta * lambda, 1 / delta);
    -m0; repelem(0, n-1, 1)
];

options = optimoptions("linprog", "Display", "iter");
x = linprog(c, -A, -b, [], [], repelem(0, n + n + n, 1), [], options);

cost = c' * x;
m = x(2*n+1:3*n);
q = x(1:n);