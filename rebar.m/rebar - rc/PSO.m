classdef PSO
    properties
        n_individuals
        n_vars
        c
        wmax
        wmin
        vmax
        vmin
        iternum
        problem
    end
    
    methods
        function obj = PSO(n_individuals, n_vars, c, wmax, wmin, vmax, vmin, iternum, problem)
            obj.n_individuals = n_individuals;
            obj.n_vars = n_vars;
            obj.c = c;
            obj.wmax = wmax;
            obj.wmin = wmin;
            obj.vmax = vmax;
            obj.vmin = vmin;
            obj.iternum = iternum;
            obj.problem = problem;
        end
        
        function int = decode(obj,x)
            int = zeros(obj.n_individuals, obj.n_vars);
            for i=1:obj.n_individuals
                for j = 1:obj.n_vars
                    if x(i,3*j-2) == 0
                        if x(i,3*j-1) == 0
                            if x(i,3*j) == 0
                                int(i,j) = 0;
                            else
                                int(i,j) = 1;
                            end
                        else
                            if x(i,3*j) == 0
                                int(i,j) = 2;
                            else
                                int(i,j) = 3;
                            end
                        end
                    else
                        if x(i,3*j-1) == 0
                            if x(i,3*j) == 0
                                int(i,j) = 4;
                            else
                                int(i,j) = 5;
                            end
                        else
                            if x(i,3*j) == 0
                                int(i,j) = 6;
                            else
                                int(i,j) = 7;
                            end
                        end
                    end
                end
            end
        end
        
        function [x,v] = updateVelocityPosition(obj, x, v, pbest, gbest, w)
            for i = 1:obj.n_individuals
                for j = 1:3*obj.n_vars
                    v(i,j) = w * v(i,j) + obj.c * rand * (pbest(i,j) - x(i,j)) + obj.c * rand * (gbest(j) - x(i,j));
                    if v(i,j) > obj.vmax
                        v(i,j) = obj.vmax;
                    elseif v(i,j) < obj.vmin
                        v(i,j) = obj.vmin;
                    end
                    sv = abs(tanh(v(i,j)));
                    if rand < sv
                        x(i,j) = ~x(i,j);
                    else
                        x(i,j) = x(i,j);
                    end
                end
            end
        end
        
        function [pbest,prslt,gbest,grslt] = updatePbestGbest(obj,x,pbest,prslt,gbest,grslt)
            int = obj.decode(x);
            rslt = obj.problem.solve(int);
            for i = 1:obj.n_individuals
                if rslt(i) < prslt(i)
                    prslt(i) = rslt(i);
                    pbest(i,:) = x(i,:);
                end
            end
            [gminrslt,gminidx] = min(rslt);
            if gminrslt < grslt
                grslt = gminrslt;
                gbest = x(gminidx,:);
            end
        end
        
        function best_x = iter(obj)
            x = unidrnd(2,obj.n_individuals, 3*obj.n_vars) - 1;
            v = zeros(obj.n_individuals ,3*obj.n_vars);
            pbest = x;
            int = obj.decode(x);
            prslt = obj.problem.solve(int);
            [grslt,gidx] = min(prslt);
            gbest = x(gidx,:);
            
            for i = 1:obj.iternum
                w = obj.wmax - i * (obj.wmax - obj.wmin) / obj.iternum;
                [x,v] = obj.updateVelocityPosition(x,v,pbest,gbest,w);
                [pbest,prslt,gbest,grslt] = obj.updatePbestGbest(x,pbest,prslt,gbest,grslt);
            end
            
%             best_int = obj.decode(x);
%             best_rslt = obj.problem.solve(int);
%             [~,best_index] = sort(best_rslt);
            best_x = roundn(mean(obj.decode(x)),0);
        end
    end
end

