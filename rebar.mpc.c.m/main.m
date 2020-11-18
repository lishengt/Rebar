clear; clc; close all;

% 坐标系边长和步长设置
axis.x = 100;
axis.y = 100;
axis.z = 100;
axis.step = 1;

% 获取碰撞空间 (collision space)
cs = get_space(axis);

% 设置钢筋排布顺序并获取钢筋
order = ['zaxis'; 'yaxis'; 'xaxis'];
bars = get_bars(order);

% 判断是否存在钢筋需要排布
if isempty(bars)
   msgID = 'RebarError:NoRebar';
   msgtext = '请保证至少一根钢筋';
   throw(MException(msgID, msgtext)); 
end


% 获取问题
problem = Problem();
problem.axis = axis;

% 算法参数设置
% NFO
alg = 'nfo';
parameter.problem = problem;
parameter.n_individuals = 50;
parameter.n_vars = nan; % 后面动态设置
parameter.xu = 7;
parameter.xl = 1;
parameter.weight = [0.9, 0.4];
parameter.learning_rate = 1.3;
parameter.croosover_rate = 0.1;
parameter.termination = 500;
algorithm = get_algorithm(alg, parameter);


% % PSO
% alg = 'pso';
% parameter.problem = problem;
% parameter.n_individuals = 30;
% parameter.n_vars = nan; % 后面动态设置
% parameter.xu = 7;
% parameter.xl = 1;
% parameter.weight = [0.9, 0.4];
% parameter.c1 = 1.49;
% parameter.c2 = 1.49;
% parameter.termination = 1000;
% algorithm = get_algorithm(alg, parameter);


% % DE
% alg = 'de';
% parameter.problem = problem;
% parameter.n_individuals = 50;
% parameter.n_vars = nan; % 后面动态设置
% parameter.xu = 7;
% parameter.xl = 1;
% parameter.F = 0.5;
% parameter.croosover_rate = 0.1;
% parameter.termination = 500;
% algorithm = get_algorithm(alg, parameter);


% 设置排布一次的钢筋的数量
num = 3; 

% 设置MPC的horizon
horizon = 5;

% 优化
while(1)
    
    [is_over, need, bars] = over(bars, num);

    cs = optimization(need, cs, algorithm, horizon);
    
    if is_over
        break
    end
end


function [is_over, need, bars] = over(bars, num)
    % 获取钢筋数量
    n_bars = size(bars, 2);
    
    % 当排布数量不低于钢筋数量时，获取相应部分钢筋，否则全部获取
    if n_bars <= num
        need = bars;
        bars = [];
        is_over = 1;
    else
        need = bars(1:num);
        bars = bars(num+1:end);
        is_over = 0;
    end
end