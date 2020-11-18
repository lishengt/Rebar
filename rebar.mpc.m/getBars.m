function bars = getBars(order)

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


    % xStartPoints = [0, 2, 5; 0, 5, 5; 0, 8, 5];
    % xEndPoints = [10, 2, 5; 10, 5, 5; 10, 8, 5];
    % yStartPoints = [2, 0, 5; 5, 0, 5; 8, 0, 5];
    % yEndPoints = [2, 10, 5; 5, 10, 5; 8, 10, 5];
    % zStartPoints = [5, 5, 0];
    % zEndPoints = [5, 5, 10];

    % xStartPoints = [0, 5, 5];
    % xEndPoints = [10, 5, 5];
    % yStartPoints = [5, 0, 5];
    % yEndPoints = [5, 11, 5];
    % zStartPoints = [5, 5, 0];
    % zEndPoints = [5, 5, 12];


    [xNum, ~] = size(xStartPoints);
    [yNum, ~] = size(yStartPoints);
    [zNum, ~] = size(zStartPoints);

    xbars = Bar.empty(xNum, 0);
    ybars = Bar.empty(yNum, 0);
    zbars = Bar.empty(zNum, 0);


    for i = 1: xNum
        bar = Bar(xStartPoints(i, :), xEndPoints(i, :));
        bar.current_location = bar.start;
        bar.type = 'XAxis';
        bar.color = 'r';
        xbars(i) = bar;
    end


    for i = 1: yNum
        bar = Bar(yStartPoints(i, :), yEndPoints(i, :));
        bar.current_location = bar.start;
        bar.type = 'YAxis';
        bar.color = 'g';
        ybars(i) = bar;
    end


    for i = 1: zNum
        bar = Bar(zStartPoints(i, :), zEndPoints(i, :));
        bar.current_location = bar.start;
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