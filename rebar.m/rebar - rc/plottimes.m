figure(2)

stem(times);

for i = 1:18
    text(i-0.5, times(i)+2, sprintf('%.2f', times(i)));
end