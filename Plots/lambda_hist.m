lambda = readtable("counts.txt");
lambda = lambda.Var1;
T = size(lambda, 1);

n = T / (15 * 60);
bincounts = zeros(n, 1);

for i = 1:T
    bincounts(ceil(i / (15 * 60))) = bincounts(ceil(i / (15 * 60))) + lambda(i);
end

set(0, 'defaultfigurecolor', [1 1 1]);
set(0, 'defaultaxesfontname', 'Palatino');
set(0, 'defaultaxesfontsize', 14);
C = linspecer(4);

x = (0:n) * 15 / 60;
y = bincounts;

h = histogram('BinEdges', x(1:89), 'BinCounts', y(1:88));
set(h, "FaceColor", C(3, :));
%xlim([0 22]);

xlabel("Hours", "Interpreter", "latex");
ylabel("Number of requests", "Interpreter", "latex");