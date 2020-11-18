main();
%% 
% 主函数

function main

    clear; close, clc;
    
    global starting ending step
    
    step = 20;
    
    load points.mat points;
    
    starting = points{1}{1}(1,:);
    ending = points{1}{2}(1, :);
  
    task1.starting = starting;
    task1.ending = ending;
    task1.direction = get_direction();
    
    
    starting = points{1}{1}(2,:);
    ending = points{1}{2}(2, :);
  
    task2.starting = starting;
    task2.ending = ending;
    task2.direction = get_direction();
    
    Tasks = get_tasks(task1, task2);
    
    pop=100; 
    gen=100; 
    selection_pressure = 'roulette wheel'; 
    p_il = 1; 
    rmp=0.3; 
    out = MFEA(Tasks,pop,gen,selection_pressure,rmp,p_il);
    
    task_for_comparison_with_SOO = 1;
    data_SOO=SOO(Tasks(task_for_comparison_with_SOO),task_for_comparison_with_SOO,pop,gen,selection_pressure,p_il);
    
    disp(out);
    disp(data_SOO);
end
%% 
% 

function Tasks = get_tasks(task1, task2)
    
    n=10;
    Tasks(1).dims=n;
    
    Tasks(1).fnc=@(x)task(x, task1.starting, task1.ending, task1.direction);
    Tasks(1).Lb=zeros(1,n);
    Tasks(1).Ub=6*ones(1,n);
    
    n=10;
    Tasks(2).dims=n;
    Tasks(2).fnc=@(x)task(x, task2.starting, task2.ending, task2.direction);
    Tasks(2).Lb=zeros(1,n);
    Tasks(2).Ub=6*ones(1,n);
    
end
%% 
% 
% 
% 目标方程

function obj = task(x, starting, ending, direction)
    
    [nrows, ncols] = size(x);
    
    obj = zeros(nrows) * inf;
    
    for i = 1:nrows
        sequence = zeros(ncols+1,3);
        
        sequence(1, :) = starting;
        
        for j = 1:ncols
            if x(i, j) == 0
                sequence(j+1, :) = sequence(j, :) + direction.static;
            elseif x(i, j) == 1
                sequence(j+1, :) = sequence(j, :) + direction.forward;
            elseif x(i, j) == 2
                sequence(j+1, :) = sequence(j, :) + direction.up;
            elseif x(i, j) == 3
                sequence(j+1, :) = sequence(j, :) + direction.down;
            elseif x(i, j) == 4
                sequence(j+1, :) = sequence(j, :) + direction.left;
            elseif x(i, j) == 5
                sequence(j+1, :) = sequence(j, :) + direction.right;
            end
        end
        
        vect = sequence - starting;
        
        vec_direction = repmat(direction.base, ncols+1, 1);
        
        a = dot(vect, vec_direction, 2);
        b = vecnorm(vect, 2, 2);
        
        cosin = a ./ (b + 0.00001);

        g = sum(cosin * 10);
        h = norm(ending-sequence(end, :));
        
        obj(i) = g + h;
    end
end
%% 
% 获取钢筋方向

function direction = get_direction()
    global starting ending step
    
    temp = ending - starting;
    
    index = find(temp);
    
    static = [0, 0, 0];
    if index == 1
        base = [1, 0, 0];
        forward = [step, 0, 0];
        up = [0, 0, step];
        down = [0, 0, -step];
        left = [0, step, 0];
        right = [0, -step, 0];
    elseif index == 2
        base = [0, 1, 0];
        forward = [0, step, 0];
        up = [0, 0, step];
        down = [0, 0, -step];
        left = [step, 0, 0];
        right = [-step, 0, 0];
    elseif index == 3
        base = [0, 0, 1];
        forward = [0, 0, step];
        up = [-step, 0, 0];
        down = [step, 0, 0];
        left = [0, -step, 0];
        right = [0, step, 0];
    else
        msg = 'index out of array';
        index_err = MException('BadIndex', msg);
        throw(index_err);
    end
    
    direction.base = base;
    direction.static = static;
    direction.forward = forward;
    direction.up = up;
    direction.down = down;
    direction.left = left;
    direction.right = right;
end
%% 
%