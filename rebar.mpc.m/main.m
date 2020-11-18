clear;
clc;
close all;
rng('default')
rng('shuffle')

% 宏定义
XLENGTH = 100;
YLENGTH = 100;
ZLENGTH = 100;

% 获取障碍物信息
obstacles = getSpaceGrid(XLENGTH, YLENGTH, ZLENGTH, 1);

% 设置钢筋排布顺序
order = ['zaxis'; 'yaxis'; 'xaxis'];
bars = getBars(order);

index = sort(randperm(length(bars)));

% 参数设置
n_individuals = 100;
horizon = 5;
c = 2;
wmax = 0.9;
wmin = 0.4;
vmax = 2;
vmin = -2;
iternum = 500;


num = 2; % 排布一次的钢筋数量
% 优化
while(1)
    
    [is_over, index, need] = over(index, bars, num);
    
    if is_over
        break
    end
    
    obstacles = optimization(need, obstacles, n_individuals, ...
    horizon, c, wmax, wmin, vmax, vmin, iternum);
end


function [is_over, index, need] = over(index, bars, num)
    is_over = 0;
    
    if num > length(index)
       num = length(index); 
    end
    
    idx = index(1:num);
    need = bars(idx);
    
    
    if isempty(index)
        is_over = 1;
    end
    
    index(1:num) = 0;
    index = index(index > 0);
    
end