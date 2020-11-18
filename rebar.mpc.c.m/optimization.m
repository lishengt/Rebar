function cs = optimization(bars, cs, algorithm, horizon)
    tic
    
    best = nan;
    
    while(1)
        [is_over, bars, h, n] = termination(bars, horizon);
        if is_over
            break;
        end
        
        % 更新问题设置
        algorithm.problem.cs = cs;
        algorithm.problem.bars = bars;
        algorithm.problem.horizon = h;
        
        % 个体维度等于钢筋数量乘以MPC的horizon
        algorithm.n_vars = h*n;
        
        best = algorithm.iter(best);
 
        [cs, bars] = update_point(cs, best, algorithm, h);
    end
    
    toc
    
    function [is_over, bars, h, n] = termination(bars, horizon)
        % 获取钢筋数量
        n1 = size(bars, 2);
        
        % 记录达到终点的钢筋，记为1，否则为0
        over = zeros(1, n1);
        
        % 改变预测时域
        h = zeros(1, n1);
        
        for i = 1:n1  
           bar = bars(i);
           
           % 判断horizon是否大于路径步数
           h_ = sum(abs(bar.current - bar.goal));
           h(i) = horizon;
           if h_ < horizon
              h(i) = h_; 
           end

           % 判断钢筋是否达到终点，是则设为1，否则为0
           if isequal(bar.current, bar.goal)
               over(i) = 1;
           end
        end
        
        is_over = all(over>0);
        bars = bars(over==0);

        h = max(h);

        % 获取最新钢筋数量
        n = size(bars, 2);
    end
end

