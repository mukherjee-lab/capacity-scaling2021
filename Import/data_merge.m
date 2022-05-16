countsMerged = zeros(5 * 24 * 60 * 60, 1);

load("counts_20160426_231401.mat");
countsMerged(1:(24 * 60 * 60)) = counts(1:(24 * 60 * 60));
countsMerged(50) = 0;

load("counts_20160427_231425.mat");
countsMerged((24 * 60 * 60 + 1):(2 * 24 * 60 * 60)) = counts(1:(24 * 60 * 60));

load("counts_20160428_231449.mat");
countsMerged((2 * 24 * 60 * 60 + 1):(3 * 24 * 60 * 60)) = counts(1:(24 * 60 * 60));

load("counts_20160429_231513.mat");
countsMerged((3 * 24 * 60 * 60 + 1):(4 * 24 * 60 * 60)) = counts(1:(24 * 60 * 60));

load("counts_20160430_231537.mat");
countsMerged((3 * 24 * 60 * 60 + 1):(4 * 24 * 60 * 60)) = counts(1:(24 * 60 * 60));

countsMerged = countsMerged(3602:end);
countsMerged = countsMerged(1:342000);
save("counts_20160426_merged.mat", "countsMerged");

time = datetime(2016, 6, 26, 23, 14, 1) - 5.5 * hours + seconds(3602) + seconds(1:size(countsMerged, 1));

figure;
hold on;
plot(time, countsMerged);
plot(time, movmean(countsMerged, 3 * 60 * 60));