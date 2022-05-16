omega = 0.1;
theta = 15 * 850 / (1000 * 60 * 60);
beta = 4 * 60 * 60 * theta;
delta = 5;

type = "shark";
conf = 5;
err = 1;

cr_f1 = zeros(5, 1);
cr_b1 = zeros(5, 1);
cr_t1 = zeros(5, 1);
i = 1;

for f = [0.01 0.1 1 10 100]
    fname = "data_" + type + "_w" + omega * delta + "_t" + theta * f * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
    load(fname, "cr_ftp", "cr_bcs", "optcost");
    
    fname = "data_" + type + "_w" + omega * delta + "_t" + theta * f * delta + "_b" + beta + ".mat";
    load(fname, "costtimer");
    
    cr_f1(i) = cr_ftp;
    cr_b1(i) = cr_bcs;
    cr_t1(i) = costtimer / optcost;
    i = i + 1;
end

err = 2;

cr_f2 = zeros(5, 1);
cr_b2 = zeros(5, 1);
i = 1;

for f = [0.01 0.1 1 10 100]
    fname = "data_" + type + "_w" + omega * delta + "_t" + theta * f * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
    load(fname, "cr_ftp", "cr_bcs", "optcost");
    
    cr_f2(i) = cr_ftp;
    cr_b2(i) = cr_bcs;
    i = i + 1;
end

err = 3;

cr_f3 = zeros(5, 1);
cr_b3 = zeros(5, 1);
i = 1;

for f = [0.01 0.1 1 10 100]
    fname = "data_" + type + "_w" + omega * delta + "_t" + theta * f * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
    load(fname, "cr_ftp", "cr_bcs", "optcost");
    
    cr_f3(i) = cr_ftp;
    cr_b3(i) = cr_bcs;
    i = i + 1;
end

err = 4;

cr_f4 = zeros(5, 1);
cr_b4 = zeros(5, 1);
i = 1;

for f = [0.01 0.1 1 10 100]
    fname = "data_" + type + "_w" + omega * delta + "_t" + theta * f * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
    load(fname, "cr_ftp", "cr_bcs", "optcost");
    
    cr_f4(i) = cr_ftp;
    cr_b4(i) = cr_bcs;
    i = i + 1;
end

% Plot
set(0, 'defaultfigurecolor', [1 1 1]);
set(0, 'defaultaxesfontsize', 16);
set(0, 'defaultaxesticklabelinterpreter', 'latex');
set(0, 'defaulttextinterpreter', 'latex');
set(0, 'defaultlegendfontsize', 16);
set(0, 'defaultlegendinterpreter', 'latex');
C = linspecer(5);

figure;
hold on;
grid on;
box on;
set(gca, "XMinorTick", "on", "YMinorTick", "on");
set(gca, "XScale", "log");

h = plot(theta * [0.01 0.1 1 10 100], cr_f1);
set(h, "Color", C(1, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

h = plot(theta * [0.01 0.1 1 10 100], cr_b1);
set(h, "Color", C(1, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = plot(theta * [0.01 0.1 1 10 100], cr_f2);
set(h, "Color", C(2, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

h = plot(theta * [0.01 0.1 1 10 100], cr_b2);
set(h, "Color", C(2, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = plot(theta * [0.01 0.1 1 10 100], cr_f3);
set(h, "Color", C(3, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

h = plot(theta * [0.01 0.1 1 10 100], cr_b3);
set(h, "Color", C(3, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = plot(theta * [0.01 0.1 1 10 100], cr_f4);
set(h, "Color", C(4, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

h = plot(theta * [0.01 0.1 1 10 100], cr_b4);
set(h, "Color", C(4, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = plot(theta * [0.01 0.1 1 10 100], cr_t1);
set(h, "Color", C(5, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", ":");

xlabel("$\theta$");
xlim([theta * 0.01 theta * 100]);
ylabel("Competitive Ratio (CR)");
legend("AP (type 1)", "ABCS (type 1)", "AP (type 2)", "ABCS (type 2)", "AP (type 3)", "ABCS (type 3)", "AP (type 4)", "ABCS (type 4)", "Timer");