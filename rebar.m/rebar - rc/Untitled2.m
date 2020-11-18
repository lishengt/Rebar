clear;clc

addpath inputData;

ss = ["m1";"m2";"m3";"m4";"m5";"m6";"m7";"m8";"m9";...
      "t1";"t2";"t3";"t4";"t5";"t6";"t7";"t8";"t9"];


xlsx = ["m1_xlsx";"m2_xlsx";"m3_xlsx";"m4_xlsx";...
        "m5_xlsx";"m6_xlsx";"m7_xlsx";"m8_xlsx";"m9_xlsx";...
        "t1_xlsx";"t2_xlsx";"t3_xlsx";"t4_xlsx";...
        "t5_xlsx";"t6_xlsx";"t7_xlsx";"t8_xlsx";"t9_xlsx"];

y_types = ["y1";"y2";"y3";"y_top1";"y_top2"];
x_types = ["x1";"x2";"x3";"x_top1";"x_top2"];
ztypes = ["z1";"z2";"z3";"z4";"z5";"z6";"z7";"z8";"z9";"z10";"z11";"z12"];

for i = 1:18

    % 导入数据
    for j = 1:12
        z1 = importfile(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(i,:), xlsx(i), ztypes(j, :)));

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
    
    % y axis
    for j = 1:5
        z1 = importfile(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(i,:), xlsx(i), y_types(j, :)));

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
    
     % x axis
    for j = 1:5
        z1 = importfile(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(i,:), xlsx(i), x_types(j, :)));

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
    
    disp(i);
    
end