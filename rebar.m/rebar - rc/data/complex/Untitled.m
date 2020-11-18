clear;clc;close all;

load('column_bar_2_1.mat');
load('beam1_bar_top_2_1.mat');
load('beam1_bar_bottom_2_1.mat');
load('beam2_bar_top_2_1.mat');
load('beam2_bar_bottom_2_1.mat')

for i = 1:12
    z1 = column_bar{i};
    n = size(z1, 1);
    tt = z1(1, :);
    for m = 2:n
        x = [tt(1), z1(m, 1)];
        y = [tt(2), z1(m, 2)];
        z = [tt(3), z1(m, 3)];
        plot3(x, y, z, 'Color', 'b');
        hold on
        tt = z1(m, :);
    end
end

for j = 1:5
    z1 =  beam1_bar_bottom{j};
    
    n = size(z1, 1);
    tt = z1(1, :);
    for m = 2:n
        x = [tt(1), z1(m, 1)];
        y = [tt(2), z1(m, 2)];
        z = [tt(3), z1(m, 3)];
        plot3(x, y, z, 'Color', 'g');
        hold on
        tt = z1(m, :);
    end
end

for j = 1:4
    z1 =  beam1_bar_top{j};
    
    n = size(z1, 1);
    tt = z1(1, :);
    for m = 2:n
        x = [tt(1), z1(m, 1)];
        y = [tt(2), z1(m, 2)];
        z = [tt(3), z1(m, 3)];
        plot3(x, y, z, 'Color', 'g');
        hold on
        tt = z1(m, :);
    end
end

for j = 1:5
    z1 =  beam2_bar_bottom{j};
    
    n = size(z1, 1);
    tt = z1(1, :);
    for m = 2:n
        x = [tt(1), z1(m, 1)];
        y = [tt(2), z1(m, 2)];
        z = [tt(3), z1(m, 3)];
        plot3(x, y, z, 'Color', 'r');
        hold on
        tt = z1(m, :);
    end
end

for j = 1:4
    z1 =  beam2_bar_top{j};
    
    n = size(z1, 1);
    tt = z1(1, :);
    for m = 2:n
        x = [tt(1), z1(m, 1)];
        y = [tt(2), z1(m, 2)];
        z = [tt(3), z1(m, 3)];
        plot3(x, y, z, 'Color', 'r');
        hold on
        tt = z1(m, :);
    end
end