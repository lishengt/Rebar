classdef CNFO
    properties
        problem;
        termination;
        n_individuals;
        n_vars;
        xu;
        xl;
        lr;
        cr;
        weight;
    end
    
    methods
        function obj = CNFO(parameter)
            obj.problem = parameter.problem;
            obj.termination = parameter.termination;
            obj.n_individuals = parameter.n_individuals;
            obj.n_vars = parameter.n_vars;
            obj.xu = parameter.xu;
            obj.xl = parameter.xl;
            obj.lr = parameter.learning_rate;
            obj.cr = parameter.croosover_rate;
            obj.weight = parameter.weight;
        end

        function [xc, xw, res] = localization(obj, x)

            res = obj.problem.solve(x);
            
            % 每一个个体复制n_individuals次
            xx = repelem(x, obj.n_individuals, 1);
            rr = repelem(res, obj.n_individuals, 1);
            
            % 种群复制n_individuals次
            xxx = repmat(x, obj.n_individuals, 1);
            rrr = repmat(res, obj.n_individuals, 1);
            
            % 计算个体和其它个体间的距离
            d = vecnorm(xx - xxx, 2, 2);
            d1 = reshape(d, obj.n_individuals, obj.n_individuals);
            d2 = d1;
            
            % 计算xc
            r = rrr < rr;
            r = reshape(r, obj.n_individuals, obj.n_individuals);
            d1(~r) = inf;
            [~, idx] = min(d1);
            xc = x(idx,:);
            [~, idx] = min(res);
            xc(idx, :) = x(idx, :);
            
            % 计算xw
            r = rrr > rr;
            r = reshape(r, obj.n_individuals, obj.n_individuals);
            d2(~r) = inf;
            [~, idx] = min(d2);
            xw = x(idx,:);
            [~, idx] = max(res);
            xw(idx, :) = x(idx, :);
        end
        
        function v = mutation(obj, x, xc, xw)
            r1 = rand(obj.n_individuals, obj.n_vars);
            r2 = rand(obj.n_individuals, obj.n_vars);
            v = x + obj.lr*r1.*(xc-x) + obj.lr*r2.*(xc - xw);
        end
        
        function u = crossover(obj, x, v)
            r = rand(obj.n_individuals, obj.n_vars);
            j = repmat(1:1:obj.n_vars, obj.n_individuals, 1);
            jrand = randi([1, obj.n_vars], obj.n_individuals, obj.n_vars);
            
            x(r<obj.cr) = v(r<obj.cr);
            x(j == jrand) = v(j == jrand);
            
            u = x;
            
            % 边界修正
            xu_ = repmat(obj.xu, obj.n_individuals, obj.n_vars);
            xl_ = repmat(obj.xl, obj.n_individuals, obj.n_vars);
            [i, j] = find(u > xu_);
            u(i, j) = xu_(i, j);
            
            [i, j] = find(u < xl_);
            u(i, j) = xl_(i, j);
        end
        
        function x = selection(obj, x, u, res)
            ures = obj.problem.solve(u);
            
            idx = find(ures < res);
            
            x(idx, :) = u(idx, :);
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
                % 随机策略，防止上一次的优化结果全相等时种群不能进化的情况
                x = randi([1,7], obj.n_individuals, obj.n_vars);
                
                % 迭代优化
                for i = 1:obj.termination
                   [xc, xw, res] = obj.localization(x);
                   v = obj.mutation(x, xc, xw);
                   u = obj.crossover(x, v);
                   x = obj.selection(x, u, res);
                end  
            end
            
            % 输出种群和最优的一个个体
            res = obj.problem.solve(x);
            [~, idx] = min(res);
            best = fix(x(idx, :));
        end   
    end
end

