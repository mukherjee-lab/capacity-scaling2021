function out = sample_discrete(time, in, T)

out = zeros(T, 1);

j = 1;
for i = 2:size(time, 1)
    while time(i - 1) <= j && j <= time(i)
        out(j) = ((time(i) - j) * in(i - 1) + (j - time(i - 1)) * in(i)) / (time(i) - time(i - 1));
        j = j + 1;
    end
end