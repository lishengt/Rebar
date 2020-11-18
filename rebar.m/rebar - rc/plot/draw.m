function draw(out)
    c = ['r'; 'g'; 'b'];
    for i = 1:3
       c_ = c(i, :);
       Axis = out{i};
       n = size(Axis, 2);
       for j = 1:n
           path = Axis{j};
           plot3(path(:, 1),path(:, 2),path(:, 3), 'Color', c_);
           hold on;
       end
    end
    xlabel("x axis");
    ylabel("y axis");
    zlabel("z axis");
    axis equal;
end
