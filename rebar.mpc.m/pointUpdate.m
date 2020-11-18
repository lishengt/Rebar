function [obstacles, bars] = pointUpdate(obstacles, res, problem, horizon)

    res = reshape(res, [], horizon);
    
    [row, ~] = size(res);
    
    
    bars = problem.bars;
    
    fprintf('Current Point:\n');
    for i = 1:row
        bar = problem.bars(i);
        bar.current_location = problem.prediction(res(i, 1),...
            bar.current_location);
        [xs, ys, zs] = problem.getLocation(bar.current_location);
        obstacles(xs, ys, zs) = 1;

        fprintf("\t%s Point: [%d, %d, %d]\n", bar.type, bar.current_location);
        
        x = [bar.start(1), bar.current_location(1)];
        y = [bar.start(2), bar.current_location(2)];
        z = [bar.start(3), bar.current_location(3)];
        plot3(x, y, z, 'Color', bar.color);
        hold on;
        bar.start = bar.current_location;
        bars(i) = bar;
    end
    title('MPC For Bar');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    xticks(0:10:max(bar.goal));
    yticks(0:10:max(bar.goal));
    zticks(0:10:max(bar.goal));

    grid on;
    axis equal;
end

