function dy = aca(omega, theta, beta, lambda, mpred, qpred, conf, t, y)

r1low = [2.00; 1.16; 0.87; 0.64; 0.43];
r1high = [2.00; 6.07; 11.03; 20.35; 45.75];
r2low = [1.00; 0.88; 0.74; 0.59; 0.41];
r2high = [1.00; 1.38; 1.86; 2.60; 4.08];

m = y(1, :);
q = y(2, :);
t = floor(t);

if m - mpred(t) > max(q - qpred(t), 0) * sqrt(omega / (2 * beta))
    r1 = r1low(conf);
else
    r1 = r1high(conf);
end

if m > mpred(t) && q <= qpred(t)
    r2 = r2high(conf);
else
    r2 = r2low(conf);
end

dm = (r1 * omega * q - r2 * theta * m) / beta;

if q < 10^-5
    dq = max(lambda(t) - m, 0);
else
    dq = lambda(t) - m;
end

dy = [dm; dq];