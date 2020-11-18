classdef Problem
   
    properties
        obstacles;
        step;
        bars;
        horizon;
        xLen = 100;
        yLen = 100;
        zLen = 100;
    end
    
    methods
        function obj = Problem(step)
            obj.step = step;
        end
        
        function  pre = prediction(~, var, current)
            if var == 0 || var == 7
                pre = current;
            elseif var == 1
                pre = current + [1, 0, 0];
            elseif var == 2
                pre = current + [-1, 0, 0];
            elseif var == 3
                pre = current + [0, 1, 0];
            elseif var == 4
                pre = current + [0, -1, 0];
            elseif var == 5
                pre = current + [0, 0, 1];
            elseif var == 6
                pre = current + [0, 0, -1];
            else
                throw(MException("Error in direction!"))
            end
        end
        
        function isOut = isOutBound(obj, current)
            xOut = current(1) < 0 || current(1) > obj.xLen;
            yOut = current(2) < 0 || current(2) > obj.yLen;
            zOut = current(3) < 0 || current(3) > obj.zLen;
            
            isOut = xOut || yOut || zOut;
        end
        
        function [x, y, z] = getLocation(obj, current)
            x = ceil(current(1) / obj.step) + 1;
            y = ceil(current(2) / obj.step) + 1;
            z = ceil(current(3) / obj.step) + 1;
        end
        
        function [isObstacle] = obstacleDetect(obj, current)
            [x, y, z] = obj.getLocation(current);
            
            isObstacle = 0;
            if obj.obstacles(x, y, z) == 1
               isObstacle = 1; 
            end
        end
        
        function y = solve(obj, u)
            n_bars = length(obj.bars);
            row = length(u);
            u = reshape(u, row, [], obj.horizon);
            
            y = zeros(row, 1);
            for i = 1:row
                cst3 = 0;
                points = zeros(n_bars, obj.horizon, 3);
                
                for j = 1:n_bars
                    cst1 = 0; cst2 = 0;
                        
                    bar = obj.bars(j);
                    current = bar.current_location;
                    
                    for k = 1:obj.horizon
                        current = obj.prediction(u(i, j, k), current);
                        
                        points(j, k, :) = current;
                        
                        if obj.isOutBound(current)
                            cst1 = inf;   
                        elseif obj.obstacleDetect(current)
                            cst2 = inf;
                        end
                        
                        dis1 = norm(current - bar.current_location);
                        dis2 = norm(current - bar.goal);
                        g = 0.1*dis1 + 0.9*dis2 + cst1 + cst2;
                        y(i) = y(i) + g;
                    end
                end
                
                for m = 1:obj.horizon
                   a = points(:, m, 1);
                   b = points(:, m, 2);
                   c = points(:, m, 3);
                   if length(unique(a)) ~= length(a)
                      if length(unique(b)) ~= length(b)
                          if length(unique(c)) ~= length(c)
                              cst3 = inf;
                          end
                      end
                   end
                end
                
                y(i) = y(i) + cst3;
            end
        end
    end
end

