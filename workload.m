function dq = workload(lambda, m, t, q)

if q < 10^-5
    dq = max(lambda(floor(t)) - m(floor(t)), 0);
else
    dq = lambda(floor(t)) - m(floor(t));
end