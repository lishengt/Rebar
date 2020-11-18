classdef Problem
   
    properties
        cs;
        bars;
        horizon;
        axis;
    end
    
    methods
        function  pre = prediction(~, var, current)
            if var == 1
                pre = current;
            elseif var == 2
                pre = current + [1, 0, 0];
            elseif var == 3
                pre = current + [-1, 0, 0];
            elseif var == 4
                pre = current + [0, 1, 0];
            elseif var == 5
                pre = current + [0, -1, 0];
            elseif var == 6
                pre = current + [0, 0, 1];
            elseif var == 7
                pre = current + [0, 0, -1];
            else
                msgID = 'PredictionError:OutBound';
                msgtext = 'Inappropriate boundary setting';
                throw(MException(msgID, msgtext));
            end
        end
        
        function isOut = is_out_bound(obj, current)
            x_out = current(1) < 0 || current(1) > obj.axis.x;
            y_out = current(2) < 0 || current(2) > obj.axis.y;
            z_out = current(3) < 0 || current(3) > obj.axis.z;
            
            isOut = x_out || y_out || z_out;
        end
        
        function [x, y, z] = get_location(obj, current)
            x = ceil(current(1) / obj.axis.step) + 1;
            y = ceil(current(2) / obj.axis.step) + 1;
            z = ceil(current(3) / obj.axis.step) + 1;
        end
        
        function [is_obstacle] = obstacle_detect(obj, current)
            [x, y, z] = obj.get_location(current);
            
            is_obstacle = 0;
            if obj.cs(x, y, z) == 1
               is_obstacle = 1; 
            end
        end
        
        function y = solve(obj, u)
            u = fix(u);
            n_bars = length(obj.bars);
            row = size(u, 1);
            u = reshape(u, row, [], obj.horizon);
            
            y = zeros(row, 1);
            for i = 1:row
                points = zeros(n_bars, obj.horizon, 3);
                
                for j = 1:n_bars
                    cst1 = 0; cst2 = 0;
                        
                    bar = obj.bars(j);
                    current = bar.current;
                    
                    for k = 1:obj.horizon
                        current = obj.prediction(u(i, j, k), current);
                        
                        points(j, k, :) = current;
                        
                        if obj.is_out_bound(current)
                            cst1 = inf;   
                        elseif obj.obstacle_detect(current)
                            cst2 = inf;
                        end
                        
                        dis1 = norm(current - bar.current);
                        dis2 = norm(current - bar.goal);
                        g = 0.1*dis1 + 0.9*dis2 + cst1 + cst2;
                        y(i) = y(i) + g;
                    end
                end
                
                cst3 = 0;
                for m = 1:obj.horizon
                   a = points(:, m, 1);
                   b = points(:, m, 2);
                   c = points(:, m, 3);
                   if length(unique(a)) ~= length(a)
                      if length(unique(b)) ~= length(b)
                          if length(unique(c)) ~= length(c)
                              cst3 = 1e+6;
                          end
                      end
                   end
                end
                
                y(i) = y(i) + cst3;
            end
        end
    end
end

