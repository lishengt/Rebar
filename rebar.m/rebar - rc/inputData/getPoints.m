function [ axis ] = getPoints(type, file, start, goal)

AXIS = size(file,1);

axis = {};

% file = ['.\\inputData\\%s\\%s\\%s'; '.\\inputData\\%s\\yaxis\\%s'; '.\\inputData\\%s\\xaxis\\%s'];

for i = 1:AXIS
   ps = importfile(sprintf('.\\inputData\\%s\\%s\\%s', type, file(i, :), start));
   pe = importfile(sprintf('.\\inputData\\%s\\%s\\%s', type, file(i, :), goal));
   axis{i} = {ps, pe};
end

end

