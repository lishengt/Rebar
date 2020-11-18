clear;
clc;
close all;
addpath outputData
addpath data

ss = ['m1';'m2';'m3';'m4';'m5';'m6';'m7';'m8';'m9';'t1';'t2';'t3';'t4';'t5';'t6';'t7';'t8';'t9'];


y_types = ["y1";"y2";"y3";"y_top1";"y_top2"];
x_types = ["x1";"x2";"x3";"x_top1";"x_top2"];

for i = 1:18
    
    disp(i)
    load(sprintf('%s.mat', ss(i,:)));
    
%      z轴
    z_data = out{1};
    
    n = size(z_data, 2);
    
    if n ~= 12
        temp = {};
        for m = 1:12
           A = z_data{m};
           B = z_data{m+12};
           C = cat(1, A, B);
           temp{m} = C;
        end
    else
        temp = z_data;
    end
    
    
    for j = 1:12
        zz = temp{j};
        kk = size(zz, 1);
        
        dat = zeros(1, 3);
        t = zz(1, :);
        dat(end, :) = t;
        for m = 2:kk-1
            xxx = zz(m, 1) == t(1);
            yyy = zz(m, 2) == t(2);
            zzz = zz(m, 3) == t(3);
            if zz(m, 1) ~= t(1) || zz(m, 2) ~= t(2)
                dat(end+1, :) = t;
                dat(end+1, :) = zz(m, :);         
            end
            t = zz(m, :);
        end
        dat(end+1, :) = zz(end, :);
        xlswrite(sprintf('.\\data\\%s\\z%d.xlsx', ss(i, :), j), dat);      
    end
    
%     y轴
    dat = [];
    y_data = out{2};
    
    n = size(y_data, 2);
    
    if n ~= 5
        temp = {};
        for m = 1:5
           A = y_data{m};
           B = y_data{m+5};
           C = cat(1, A, B);
           temp{m} = C;
        end
    else
        temp = y_data;
    end
     
    for j = 1:5
        yy = temp{j};
        kk = size(yy, 1);

        dat = zeros(1, 3);
        t = yy(1, :);
        dat(end, :) = t;
        for m = 2:kk-1
            xxx = yy(m, 1) == t(1);
            yyy = yy(m, 2) == t(2);
            zzz = yy(m, 3) == t(3);
            
            if yy(m, 1) ~= t(1) || yy(m, 3) ~= t(3)
                dat(end+1, :) = t;
                dat(end+1, :) = yy(m, :);         
            end
            t = yy(m, :);
            
        end
        dat(end+1, :) = yy(end, :);
        xlswrite(sprintf('.\\data\\%s\\%s.xlsx', ss(i, :), y_types(j,:)), dat);      
    end
    
    %     x轴
    dat = [];
    y_data = out{3};
    
    n = size(y_data, 2);
    
    if n ~= 5
        temp = {};
        for m = 1:5
           A = y_data{m};
           B = y_data{m+5};
           C = cat(1, A, B);
           temp{m} = C;
        end
    else
        temp = y_data;
    end
     
    for j = 1:5
        yy = temp{j};
        kk = size(yy, 1);

        dat = zeros(1, 3);
        t = yy(1, :);
        dat(end, :) = t;
        for m = 2:kk-1
            xxx = yy(m, 1) == t(1);
            yyy = yy(m, 2) == t(2);
            zzz = yy(m, 3) == t(3);
            
            if yy(m, 2) ~= t(2) || yy(m, 3) ~= t(3)
                dat(end+1, :) = t;
                dat(end+1, :) = yy(m, :);         
            end
            t = yy(m, :);
            
        end
        dat(end+1, :) = yy(end, :);
        xlswrite(sprintf('.\\data\\%s\\%s.xlsx', ss(i, :), x_types(j,:)), dat);      
    end
end