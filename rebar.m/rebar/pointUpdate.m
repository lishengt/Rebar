function [point, k] = pointUpdate(point, action, distinct, k)
    global obstacles step path;

    n_steps = size(action, 2);

    for i = 1:n_steps
       if action(i) == 0 || action(i) == 7
           continue;
       elseif action(i) == 1
           point(1) = point(1) + step;
       elseif action(i) == 2
           point(1) = point(1) - step;
       elseif action(i) == 3
           point(2) = point(2) + step;
       elseif action(i) == 4
           point(2) = point(2) - step;
       elseif action(i) == 5
           point(3) = point(3) + step;
       elseif action(i) == 6
           point(3) = point(3) - step;
       end

       [x, y, z] = toGrid(point, step);
       try
        obstacles(x, y, z) = 1;
       catch ME
           disp('“Ï≥£');
           disp(point);
           ME;
       end

       path(k,:) = point;
       
       if sum((point-distinct).^2,2)==0
           break;
       end
       
       k = k + 1;
    end

end

