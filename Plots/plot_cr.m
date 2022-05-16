% Parameters
set(0, 'defaultfigurecolor', [1 1 1]);
set(0, 'defaultaxesfontsize', 16);
set(0, 'defaultaxesticklabelinterpreter', 'latex');
set(0, 'defaulttextinterpreter', 'latex');
set(0, 'defaultlegendfontsize', 16);
set(0, 'defaultlegendinterpreter', 'latex');
C = linspecer(3);

data = [
5       5.;
21/5	7.35634;
11/3	10.3128;
23/7	13.9473;
3       18.3362;
25/9	23.5549;
13/5	29.6767;
27/11	36.7799;
7/3     44.9451;
29/13	54.2547;
15/7	64.7933;
31/15	76.6473;
2       89.9049;
33/17	104.656;
17/9	120.994;
35/19	139.011;
9/5     158.803;
37/21	180.467;
19/11	204.102;
39/23	229.809;
5/3     257.69;
41/25	287.848;
21/13	320.388;
43/27	355.419;
11/7	393.047;
45/29	433.383;
23/15	476.538;
];

bcr = data(:, 1);
wcr = data(:, 2);

% Plot
figure;
hold on;
grid on;
box on;
set(gca, "XMinorTick", "on", "YMinorTick", "on");

h = plot(bcr, wcr);
set(h, "Color", C(1, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = yline(5, '--');
set(h, "Color", C(2, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

xlabel("Optimistic Competitive Ratio (OCR)", "FontSize", 14);
ylabel("Pessimistic Competitive Ratio (PCR)", "FontSize", 14);
xlim([1, 5]);
ylim([0, 250]);
%yticks([5 50 100 150 200 250]);

% Plot
C = linspecer(4);

[eta, r] = meshgrid(0:2:20, 1:1:27);                                
cr = min((1 + eta) .* bcr(r), wcr(r));

figure;
hold on;
grid on;
box on;
shading interp;
colormap parula;
set(gca, "XMinorTick", "on", "YMinorTick", "on");

h = surf(eta, r, cr, "EdgeColor", "none");
%set(gca, 'XScale', 'log');
%xlim([0, 10]);
%ylim([0, 9]);
%zlim([0, 200]);
xlabel("Accuracy of predictions ($(\sqrt{2 \omega \beta} + \theta) \eta$)", "FontSize", 14);
ylabel("Confidence (r)", "FontSize", 14);
zlabel("Competitive Ratio (CR)", "FontSize", 14);

% Plot
C = linspecer(4);

eta = 0:0.1:100;
cr1 = min((1 + eta) * bcr(1), wcr(1));
cr2 = min((1 + eta) * bcr(3), wcr(3));
cr3 = min((1 + eta) * bcr(6), wcr(6));
cr4 = min((1 + eta) * bcr(9), wcr(9));

figure;
hold on;
grid on;
box on;
set(gca, "XMinorTick", "on", "YMinorTick", "on");

h = plot(eta, cr1);
set(h, "Color", C(1, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = plot(eta, cr2);
set(h, "Color", C(2, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

h = plot(eta, cr3);
set(h, "Color", C(3, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-.");

h = plot(eta, cr4);
set(h, "Color", C(4, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", ":");

xlabel("Accuracy of predictions ($(\sqrt{2 \omega \beta} + \theta) \eta$)", "FontSize", 14);
ylabel("Competitive Ratio (CR)", "FontSize", 14);
legend({"r = 1", "r = 2", "r = 3", "r = 4"}, "Location", "northwest");
set(gca, 'XScale', 'log');
xlim([0, 100]);
ylim([0, 50]);


% Plot
C = linspecer(3);

figure;
hold on;
grid on;
box on;
set(gca, "XMinorTick", "on", "YMinorTick", "on");

h = plot(([0 2:size(data, 1)]) / 3 + 1, data(:, 1));
set(h, "Color", C(1, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = plot(([0 2:size(data, 1)]) / 3 + 1, data(:, 2));
set(h, "Color", C(2, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "-");

h = yline(5, '--');
set(h, "Color", C(3, :));
set(h, "LineWidth", 1.5);
set(h, "LineStyle", "--");

xlabel("Confidence (r)", "FontSize", 14);
ylabel("Competitive Ratio (CR)", "FontSize", 14);
legend({"Optimistic Competitive Ratio (OCR)", "Pessimistic Competitive Ratio (PCR)"}, "Location", "northwest");
xlim([0, 5]);
ylim([0, 50]);