function obstacles = optimization(bars, ...
                                  obstacles,...
                                  n_individuals,...
                                  horizon,...
                                  c,...
                                  wmax,...
                                  wmin,...
                                  vmax,...
                                  vmin,...
                                  iternum)

    tic
    
    problem = Problem(1);  
   
    x = nan;
    while(1)
        [isOver, bars,h, n] = termination(bars, horizon);
        if isOver
            break;
        end
        
        problem.obstacles = obstacles;
        problem.bars = bars;
        problem.horizon = h;
        algorithm = PSO(n_individuals, h*n, c, wmax, ...
            wmin, vmax, vmin, iternum, problem);
        
        [x, best] = algorithm.iter(x);
        
%         nfo = NFO(n_individuals, h*n, 0.3, 0.1, iternum, problem);
%         res = nfo.iter();
%         de = DE(n_individuals, h*n, 0.1, 0.5, iternum, problem);
%         res = de.iter();
     
        [obstacles, bars] = pointUpdate(obstacles, best, problem, h);
    end
    
    toc
    
    function [isOver, bars, h, n] = termination(bars, horizon)
        n1 = size(bars, 2);
        over = zeros(1, n1);
        
        % 改变预测时域
        h = zeros(1, n1);
        
        for i = 1:n1
            
           bar = bars(i);
           
           h(i) = sum(abs(bar.current_location - bar.goal));
           if h(i) >= horizon
              h(i) = horizon; 
           end
           
           if isequal(bar.current_location, bar.goal)
               over(i) = 1;
           end
        end
        h = min(h(h > 0));
        
        isOver = all(over>0);
        bars = bars(over==0);

        % 改变变量维度
        n2 = size(bars, 2);
        n = 0;
        for i = 1:n2
           n = n + length(bars(i));
        end
    end
end

