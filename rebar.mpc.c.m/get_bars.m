function bars = get_bars(order)
    % 添加文件路径
    addpath inputData;

    INTEROR = 'interior';
    % EXTERIOR = 'exterior';
    % CORNER = 'corner';

    type = INTEROR;
    % type = EXTERIOR;
    % type = CORNER;

    % 获取坐标信息
    points = getPoints(type, order, 'start', 'goal');

    % 获取坐标
    for i = 1:3
        if strcmp(order(i, :), 'xaxis')
            xStartPoints = points{i}{1};
            xEndPoints = points{i}{2};
        elseif strcmp(order(i, :), 'yaxis')
            yStartPoints = points{i}{1};
            yEndPoints = points{i}{2};
        else
            zStartPoints = points{i}{1};
            zEndPoints = points{i}{2};
        end
    end

    [xNum, ~] = size(xStartPoints);
    [yNum, ~] = size(yStartPoints);
    [zNum, ~] = size(zStartPoints);

    xbars = Bar.empty(xNum, 0);
    ybars = Bar.empty(yNum, 0);
    zbars = Bar.empty(zNum, 0);

    for i = 1: xNum
        bar = Bar(xStartPoints(i, :), xEndPoints(i, :));
        bar.current = bar.start;
        bar.type = 'XAxis';
        bar.color = 'r';
        xbars(i) = bar;
    end

    for i = 1: yNum
        bar = Bar(yStartPoints(i, :), yEndPoints(i, :));
        bar.current = bar.start;
        bar.type = 'YAxis';
        bar.color = 'g';
        ybars(i) = bar;
    end

    for i = 1: zNum
        bar = Bar(zStartPoints(i, :), zEndPoints(i, :));
        bar.current = bar.start;
        bar.type = 'ZAxis';
        bar.color = 'b';
        zbars(i) = bar;
    end
    
    if strcmp(order(1, :), 'xaxis')
        if strcmp(order(2, :), 'yaxis')
            bars = [xbars, ybars, zbars];
        else
            bars = [xbars, zbars, ybars];
        end     
    elseif strcmp(order(1, :), 'yaxis')
        if strcmp(order(2, :), 'xaxis')
            bars = [ybars, xbars, zbars];
        else
            bars = [ybars, zbars, zbars];
        end 
    else
        if strcmp(order(2, :), 'yaxis')
            bars = [zbars, ybars, xbars];
        else
            bars = [zbars, xbars, ybars];
        end 
    end
end