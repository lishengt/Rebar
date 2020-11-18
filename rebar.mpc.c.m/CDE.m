classdef CDE
    properties
        problem;
        termination;
        n_individuals;
        n_vars;
        xu;
        xl;
        F;
        cr;
    end
    
    methods
        function obj = CDE(parameter)
            obj.problem = parameter.problem;
            obj.termination = parameter.termination;
            obj.n_individuals = parameter.n_individuals;
            obj.n_vars = parameter.n_vars;
            obj.xu =  parameter.xu;
            obj.xl = parameter.xl;
            obj.F = parameter.F;
            obj.cr = parameter.croosover_rate;
        end
        
        function v = mutation(obj, x)
            
            idx = zeros(obj.n_individuals, 3);
            
            for i = 1:obj.n_individuals
                idx(i, :) = randperm(obj.n_individuals, 3);
            end
            
            v = x(idx(:,1), :) + obj.F * (x(idx(:, 2), :) - x(idx(:, 3), :));
        end
        
        function u = crossover(obj, x, v)
            u = x;
            r = rand(obj.n_individuals, obj.n_vars);
            u(r < obj.cr) = v(r < obj.cr);
            
            % 边界修正
            xu_ = repmat(obj.xu, obj.n_individuals, obj.n_vars);
            xl_ = repmat(obj.xl, obj.n_individuals, obj.n_vars);
            [i, j] = find(u > xu_);
            u(i, j) = xu_(i, j);
            
            [i, j] = find(u < xl_);
            u(i, j) = xl_(i, j);
            
        end
        
        function x = selection(obj, x, u)
            res = obj.problem.solve(x);
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
                   v = obj.mutation(x);
                   u = obj.crossover(x, v);
                   x = obj.selection(x, u);
                end  
            end
            
            % 输出种群和最优的一个个体
            res = obj.problem.solve(x);
            [~, idx] = min(res);
            best = fix(x(idx, :));
        end
        
    end
end

