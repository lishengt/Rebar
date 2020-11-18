clear;
clc;
close all;

% 添加文件路径
addpath inputData;
addpath plot;

% 宏定义
XLENGTH = 1200;
YLENGTH = 1200;
ZLENGTH = 1200;

INTEROR = 'interior';
EXTERIOR = 'exterior';
CORNER = 'corner';

type = INTEROR;
% type = EXTERIOR;
% type = CORNER;

% 获取坐标信息
points = getPoints(type, ['zaxis'; 'yaxis'; 'xaxis'], 'start', 'goal');


% 获取障碍物信息
global obstacles step;
step = 20;
obstacles = getSpaceGrid(XLENGTH, YLENGTH, ZLENGTH, step);


rng('default')
rng('shuffle')

out = optimization(points, 30, 2, 2, 0.9, 0.4, 2, -2, 300);

draw(out);
saveData(type, out);

