function [ps, pe] = is_anchor(start, goal)

    n_rows = size(start, 1);

    newstart = zeros(2*n_rows, 3);
    newgoal = zeros(2*n_rows, 3);

    k = n_rows;
    for i = 1:n_rows
       temp = abs(goal(i, :) - start(i, :));

       max_value = max(temp);
       min_value = min(temp);

       for j = 1:3
          if temp(j) ~= max_value && temp(j) ~= min_value
              newstart(i, j) = start(i, j);
              newgoal(i, j) = start(i, j);

              k = k+1;
              newstart(k, :) = newgoal(i, :);
              newgoal(k, :) = goal(i,:);
          else
            newstart(i, j) = start(i, j);
            newgoal(i, j) = goal(i, j);
          end
       end
    end
    ps = newstart(1:k, :);
    pe = newgoal(1:k, :);

end

