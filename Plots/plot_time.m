omega = 0.1;
theta = 15 * 850 / (1000 * 60 * 60);
beta = 4 * 60 * 60 * theta;
delta = 1;

type = "real";
conf = 1;

err = 1;
fname = "data_" + type + "_w" + omega * delta + "_t" + theta * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
load(fname, "lambda", "predlambda", "optm", "predm", "ftpm", "bcsm");
time = 1:size(lambda, 1);

fname = "data_" + type + "_w" + omega * delta + "_t" + theta * delta + "_b" + beta + ".mat";
load(fname, "timerm");

% Figure
set(0, 'defaultfigurecolor', [1 1 1]);
set(0, 'defaultaxesfontsize', 16);
set(0, 'defaultaxesticklabelinterpreter', 'latex');
set(0, 'defaulttextinterpreter', 'latex');
set(0, 'defaultlegendfontsize', 16);
set(0, 'defaultlegendinterpreter', 'latex');
C = linspecer(6);

figure;
hold on;
grid on;
box on;
set(gca, "XMinorTick", "on", "YMinorTick", "on");

h1 = plot(time ./ (60 * 60), lambda);
set(h1, "Color", C(3, :));
set(h1, "LineWidth", 1);
set(h1, "LineStyle", "--");

h3 = plot(time ./ (60 * 60), optm);
set(h3, "Color", C(1, :));
set(h3, "LineWidth", 1.5);
set(h3, "LineStyle", "-.");

% h4 = plot(time, predm);
% set(h4, "Color", C(6, :));
% set(h4, "LineWidth", 1.5);
% set(h4, "LineStyle", "-.");

% h5 = plot(time ./ (60 * 60), predm + ftpm);
% set(h5, "Color", C(4, :));
% set(h5, "LineWidth", 1.5);
% set(h5, "LineStyle", "--");

h6 = plot(time ./ (60 * 60), bcsm);
set(h6, "Color", C(2, :));
set(h6, "LineWidth", 1.5);
set(h6, "LineStyle", "-");

% h6 = plot(time ./ (60 * 60), timerm);
% set(h6, "Color", C(6, :));
% set(h6, "LineWidth", 1.5);
% set(h6, "LineStyle", ":");

% h2 = plot(time, predlambda);
% set(h2, "Color", C(5, :));
% set(h2, "LineWidth", 1.5);
% set(h2, "LineStyle", "-");

% 
% err = 2;
% fname = "data_" + type + "_w" + omega * f * delta + "_t" + theta * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
% load(fname, "bcsm");
% 
% h6 = plot(time, bcsm);
% set(h6, "Color", C(2, :));
% set(h6, "LineWidth", 1.5);
% set(h6, "LineStyle", "-");
% 
% err = 4;
% fname = "data_" + type + "_w" + omega * f * delta + "_t" + theta * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
% load(fname, "bcsm");
% 
% h6 = plot(time, bcsm);
% set(h6, "Color", C(5, :));
% set(h6, "LineWidth", 1.5);
% set(h6, "LineStyle", "-");

xlabel("Hours");
ylabel("Number of servers");
legend({"$\lambda$", "Opt", "ABCS"});
xlim([0, time(end) ./ (60 * 60)]);
ylim([0 1600]);