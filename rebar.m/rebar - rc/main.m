clear;
clc;
close all;

% 添加文件路径
addpath inputData;
addpath plot;

% 宏定义
XLENGTH = 7500;
YLENGTH = 7500;
ZLENGTH = 7500;

type = ['m1';'m2';'m3';'m4';'m5';'m6';'m7';'m8';'m9';'t1';'t2';'t3';'t4';'t5';'t6';'t7';'t8';'t9'];

% 获取障碍物信息
global obstacles step;

step = 20;
obstacles = getSpaceGrid(XLENGTH, YLENGTH, ZLENGTH, step);


rng('default')
rng('shuffle')

times = zeros(1, 18);
for i = 1:18
    % 获取坐标信息
    tic
    points = getPoints(type(i,:), ['zaxis'; 'yaxis'; 'xaxis'], 'start', 'goal');
    out = optimization(points, 30, 2, 2, 0.9, 0.4, 2, -2, 150);
    times(i) = toc;
    fprintf('Joint NO.%s:%fs\n', type(i,:), toc);
    draw(out);
    save(sprintf(".\\outputData\\%s.mat", type(i, :)), 'out');
end



