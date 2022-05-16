function m = solve_timeralg(theta, beta, m0, lambda)

T = size(lambda, 1);
tau = round(beta / theta);

m = zeros(T, 1);

for i = 1:T
    if i <= tau
        m(i) = max([lambda(1:i); m0]);
    else
        m(i) = max(lambda((i-tau):i));
    end
end