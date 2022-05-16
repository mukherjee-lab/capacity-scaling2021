function dy = ftpalg(omega, beta, lambda, t, y)

m = y(1, :);
q = y(2, :);

ts = floor(t);
te = floor(t - 1.05 * sqrt(2 * beta / omega));

if te > 0
    if m < 10^-5
        dm = max(1.05 * sqrt(omega / (2 * beta)) * (lambda(ts) - lambda(te)), 0);
    else
        dm = 1.05 * sqrt(omega / (2 * beta)) * (lambda(ts) - lambda(te));
    end
else
    dm = 1.05 * sqrt(omega / (2 * beta)) * lambda(ts);
end

if q < 10^-5
    dq = max(lambda(ts) - m, 0);
else
    dq = lambda(ts) - m;
end

dy = [dm; dq];