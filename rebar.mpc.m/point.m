function [Start, End] = point(Type, ClearSpace, Num)

    if rem(Num, 2) ~= 0
        throw(MException(...
        'BadNumber: the number of bars need to be set as even number'));
    end

    xStartPoint = [0, 2, 2]; xEndPoint = [100, 2, 2];
    yStartPoint = [2, 0, 2]; yEndPoint = [2, 100, 2];
    zStartPoint = [2, 2, 0]; zEndPoint = [2, 2, 100];

    xStart = zeros(Num, 3);
    xEnd = zeros(Num, 3);
    
    yStart = zeros(Num, 3);
    yEnd = zeros(Num, 3);
    
    zStart = zeros(Num, 3);
    zEnd = zeros(Num, 3);

    for i = 1:Num
        if i <= Num / 2
            xStart(i) = xStartPoint + [0, ClearSpace * (i-1), 0];
            xEnd(i) = xEndPoint + [0, ClearSpace * (i-1), 0];
            
            yStart(i) = yStartPoint + [ClearSpace * (i-1), 0, 0];
            yEnd(i) = yEndPoint + [ClearSpace * (i-1), 0, 0];
        else
            xStart(i) = xStartPoint + [0, 0, ClearSpace * (i-1)];
            xEnd(i) = xEndPoint + [0, 0, ClearSpace * (i-1)];
            
            yStart(i) = yStartPoint + [0, 0, ClearSpace * (i-1)];
            yEnd(i) = yEndPoint + [0, 0, ClearSpace * (i-1)];
        end
    end
    
    xType = 'xaxis';
    if strcmp(Type, xType)
       Start = xStart;
       End = xEnd;
    end
    
    yType = 'yaxis';
    if strcmp(Type, yType)
       Start = yStart;
       End = yEnd;
    end
    
    zType = 'zaxis';
    if strcmp(Type, zType)
       
        
        
        Start = zStart;
        End = zEnd;
    end
end

