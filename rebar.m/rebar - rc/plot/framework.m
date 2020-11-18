function framework(points)

start = points{1, 1}{1, 1};
goal = points{1, 2}{1, 1};

% x·½ÏòÂ·¾¶
n = size(start, 1);

for i = 1:n
   plot3([start(i, 1), goal(i, 1)], [start(i, 2), goal(i, 2)], [start(i, 3), goal(i, 3)]);
   hold on;
end

end

