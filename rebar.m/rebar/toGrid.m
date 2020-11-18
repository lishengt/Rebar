function [x, y, z] = toGrid(point, step)
x = ceil(point(1) / step) + 1;
y = ceil(point(2) / step) + 1;
z = ceil(point(3) / step) + 1;
end

