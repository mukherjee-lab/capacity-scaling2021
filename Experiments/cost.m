function c = cost(lambda, delta, theta, omega, beta, m0, m, tm, q, tq)

flowtime = cumtrapz(tq, q);
flowtime = flowtime(end);
switching = diff([m0; m]);
switching = sum(switching(switching > 0));
power = cumtrapz(tm, m);
power = power(end);

disp("The avg flow-time is " + flowtime / (100 * sum(lambda)) + "s per job"); % assume jobs use 1/10th of server for 0.1 sec
disp("The avg switching cost is " + switching * 60 * 60 / (size(lambda, 1) * delta) + " times per hour");
disp("The avg power cost is " + power / size(lambda, 1) + " servers");

c = omega * flowtime + beta * switching + theta * power;