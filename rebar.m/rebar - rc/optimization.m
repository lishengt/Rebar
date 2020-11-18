function [out] = optimization(points, n_individuals, n_vars, c, wmax, wmin, vmax, vmin, iternum)
global obstacles step path;

    for axis = 1:3
        start = points{1, axis}{1, 1};
        goal = points{1, axis}{1, 2};
        
%         [start, goal] = is_anchor(start, goal);

        rows = size(start, 1);
        
        for num = 1:rows

            point = start(num, :);
            distinct = goal(num, :);

            problem = Problem(obstacles, step, point, distinct);  
            
            path = zeros(250, 3);
            path(1, :) = point;
            k = 2;
            while(1) 
                if sqrt(sum((point-distinct).^2, 2)) <= 10
                    break;
                end
                
%                 nfo = NFO(n_individuals, n_vars, 0.3, 0.1, iternum, problem);
%                 action = nfo.iter();
%                 de = DE(n_individuals, n_vars, 0.1, 0.5, iternum, problem);
%                 action = de.iter();
                algorithm = PSO(n_individuals, n_vars, c, wmax, wmin, vmax, vmin, iternum, problem);
                action = algorithm.iter();

                [point, k] = pointUpdate(point, action, distinct, k);
                problem = Problem(obstacles, step, point, distinct);
                
            end
            n = size(path(1:k, :),1);
            
            for ii = 1:n
                [x, y, z] = toGrid(path(ii, :), step);
                obstacles(x, y, z) = 1;
            end
            Axis{num} = path(1:k, :);
        end
        out{axis} = Axis(1:rows);       
    end

end

