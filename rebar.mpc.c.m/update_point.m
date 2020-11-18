function [cs, bars] = update_point(cs, u, algorithm, horizon)

    u = reshape(u, [], horizon);
    
    [row, ~] = size(u);
    
    
    bars = algorithm.problem.bars;
    
    fprintf('Current Point:\n');
    for i = 1:row
        % 更新钢筋坐标，障碍物空间相应位置置1
        bar = algorithm.problem.bars(i);
        bar.current= algorithm.problem.prediction(u(i, 1), bar.current);
        
        try
            [xs, ys, zs] = algorithm.problem.get_location(bar.current);
            cs(xs, ys, zs) = 1;
        catch
            msgID = 'OptimizationFailed:OptimizationFailed';
            msgtext = 'Optimization failed';
            throw(MException(msgID, msgtext));
        end

        % 打印当前坐标
        fprintf("\t%s Point: [%d, %d, %d]\n", bar.type, bar.current);
        
        % 绘图
        x = [bar.start(1), bar.current(1)];
        y = [bar.start(2), bar.current(2)];
        z = [bar.start(3), bar.current(3)];
        plot3(x, y, z, 'Color', bar.color);
        hold on;
        bar.start = bar.current;
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

