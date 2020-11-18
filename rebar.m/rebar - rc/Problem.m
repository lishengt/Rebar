classdef Problem
    properties
        obstacles;
        step;
        start;
        goal;
    end
    
    methods
        function obj = Problem(obstacles, step, start, goal)
            obj.obstacles = obstacles;
            obj.step = step;
            obj.start = start;
            obj.goal = goal;
        end
        
        function y = solve(obj, x)
            [row,col] = size(x);
            y = zeros(1,row);
            
            for i = 1:row
                cst1 = 0;
                cst2 = 0;
                cst3 = 0;
                
                point = obj.start;
                
                for j = 1:col
                    if x(i,j) == 0
                        continue;
                    elseif x(i,j) == 1
                        point(1) = point(1) + obj.step;
                    elseif x(i,j) == 2
                        point(1) = point(1) - obj.step;
                    elseif x(i,j) == 3
                        point(2) = point(2) + obj.step;
                    elseif x(i,j) == 4
                        point(2) = point(2) - obj.step;
                    elseif x(i,j) == 5
                        point(3) = point(3) + obj.step;
                    elseif x(i,j) == 6
                        point(3) = point(3) - obj.step;
                    elseif x(i, j) == 7
                        cst3 = 100000;
                    end

                    if point(1) < 0 || point(1) > 7200 || point(2) < 0 || point(2) > 7200 || point(3) < 0 || point(3) > 7200
                        cst2 = 100000;
                    else
                        [xs, ys, zs] = toGrid(point, obj.step);
                        clashflag = obj.obstacles(xs, ys, zs);
                        if clashflag == 1
                            cst1 = 100000;
                        end
                    end
                end
                dis1 = sqrt(sum((point - obj.start).^2, 2));
                dis2 = sqrt(sum((point - obj.goal).^2, 2));
                y(i) = 0.1*dis1 + 0.9*dis2 + cst1 + cst2 + cst3;
            end
        end
    end
end

