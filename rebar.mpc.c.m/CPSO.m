classdef CPSO
    properties
        n_individuals = 30;
        n_vars = 2;
        weight = 1;
        xu = 1;
        xl = 0;
        c1 = 0;
        c2 = 0;
        termination = 100;
        problem;
    end
    
    methods
        function obj = CPSO(parameter)
            obj.problem = parameter.problem;
            obj.termination = parameter.termination;
            obj.n_individuals = parameter.n_individuals;
            obj.n_vars = parameter.n_vars;
            obj.xu = parameter.xu;
            obj.xl = parameter.xl;
            obj.weight = parameter.weight;
            obj.c1 = parameter.c1;
            obj.c2 = parameter.c2;
        end
        
        function [x,v,pbest,pres,gbest, gres] = initialization(obj, x)
            % 未提供种群则随机初始化
            if all(all(isnan(x)))
                x = randi([1,7], obj.n_individuals, obj.n_vars);
            end
            
            % 设置初始速度
            v = zeros(obj.n_individuals, obj.n_vars);
            
            % 计算个体最优位置和适应度值
            pbest = x;
            pres = obj.problem.solve(x);  
            
            % 计算种群最优位置和适应度值
            [gres, idx] = min(pres);
            gbest = x(idx, :);
            gres = repmat(gres, obj.n_individuals, 1);
            gbest = repmat(gbest, obj.n_individuals, 1);
        end
        
        function [x, v, pbest, pres, gbest, gres] = update(obj, w, x, v,...
                                                           pbest, pres,...
                                                           gbest, gres)
            
            % 获取随机值
            r1 = rand(obj.n_individuals, obj.n_vars);
            r2 = rand(obj.n_individuals, obj.n_vars);
            
            % 速度和位置更新
            v = w*v + obj.c1*r1.*(pbest - x)+obj.c2*r2.*(gbest - x);
            x = x + v;
            
            % 边界修正
            xu_ = repmat(obj.xu, obj.n_individuals, obj.n_vars);
            xl_ = repmat(obj.xl, obj.n_individuals, obj.n_vars);
            [i, j] = find(x > xu_);
            x(i, j) = xu_(i, j);
            [i, j] = find(x < xl_);
            x(i, j) = xl_(i, j);
            
            
            % 更新个体和种群最优位置，最优值
            res = obj.problem.solve(x);
            
            idx = find(res < pres);
            pbest(idx, :) = x(idx, :);
            pres(idx) = res(idx);
            
            [gres_, idx] = min(res);
            if gres_ < gres(1)
               gbest = repmat(x(idx, :), obj.n_individuals, 1); 
               gres = repmat(gres_, obj.n_individuals, 1);
            end
        end
        
        function [x, is_ok] = apply_previous(obj, x)
            
            n_bars = size(obj.problem.bars, 2);
            
            ref = zeros(1, n_bars);
            for i = 1:n_bars
                bar = obj.problem.bars(i);
                if strcmp(bar.type, 'XAxis')
                    ref(i) = 2;
                end
                if strcmp(bar.type, 'YAxis')
                    ref(i) = 4;
                end
                if strcmp(bar.type, 'ZAxis')
                    ref(i) = 6;
                end
            end
            
            x = repmat(x, obj.n_individuals, 1);
            
            ref = repmat(ref, 1, obj.problem.horizon);
            ref = repmat(ref, obj.n_individuals, 1);
            
            res = obj.problem.solve(x);
            ref_res = obj.problem.solve(ref);
            
            is_ok = 1;
            if res(1) == ref_res(1) && res(1) ~= inf
                is_ok = 0;
            end
        
        end
        
        function best = iter(obj, x)
            is_nan = all(all(isnan(x)));
            
            is_ok = 1;
            if ~is_nan
                x = x(1:obj.n_vars);
                [x, is_ok] = obj.apply_previous(x);
            end
            
            
            if is_ok
                [x,v,pbest,pres,gbest, gres] = initialization(obj, x);
                
                % 迭代优化
                for i = 1:obj.termination
                   w = obj.weight(1) - i * (obj.weight(1) - obj.weight(2)) / obj.termination;
                   
                   [x, v, pbest, pres, gbest, gres] = obj.update(w, x, v,...
                                                           pbest, pres,...
                                                           gbest, gres);
                end 
            end
            
            % 输出种群和最优的一个个体
            res = obj.problem.solve(x);
            [~, idx] = min(res);
            best = fix(x(idx, :));
            
        end
        
    end
end

