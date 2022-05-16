omega = 0.1;
theta = 15 * 850 / (1000 * 60 * 60);
beta = 4 * 60 * 60 * theta;

for type = ["sin" "shark" "peak" "real"]
    for f = [0.01 0.1 1 10 100]
        run_timer(omega * f, theta, beta, type);
    end

    for f = [0.01 0.1 10 100]
        run_timer(omega, theta * f, beta, type);
    end

    for f = [0.01 0.1 10 100]
        run_timer(omega, theta, beta * f, type);
    end
end