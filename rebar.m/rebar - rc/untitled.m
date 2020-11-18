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


z_start = {[40,147,253,360;40,147,253,360],...
           [3440,3547,3653,3760;40,147,253,360],...
           [6840,6947,7053,7160;40,147,253,360],...
           [40,147,253,360;3440,3547,3653,3760],...
           [3440,3547,3653,3760;3440,3547,3653,3760],...
           [6840,6947,7053,7160;3440,3547,3653,3760],...
           [40,147,253,360;6840,6947,7053,7160],...
           [3440,3547,3653,3760;6840,6947,7053,7160],...
           [6840,6947,7053,7160;6840,6947,7053,7160]};
z_len = [0, 4000;4000,6760];

y_start = {[80, 195, 290],...
           [3485, 3600, 3713],...
           [6910, 7015, 7120],...
           [80, 195, 290],...
           [3485, 3600, 3713],...
           [6910, 7015, 7120],...
           [80, 195, 290],...
           [3485, 3600, 3713],...
           [6910, 7015, 7120]};
y_len = [1900, 40;1900, 40;1900, 40;...
         1900,5300;1900,5300;1900,5300;...
         5300,7160;5300,7160;5300,7160];

x_start = {[80, 195, 290],...
           [80, 195, 290],...
           [80, 195, 290],...
           [3485, 3600, 3713],...
           [3485, 3600, 3713],...
           [3485, 3600, 3713],...
           [6910, 7015, 7120],...
           [6910, 7015, 7120],...
           [6910, 7015, 7120]};
x_len = [1900, 40;1900, 5300;5300,7160;...
         1900, 40;1900, 5300;5300,7160;...
         1900, 40;1900, 5300;5300,7160];


yz = [3040,3360; 6440,6680];
xz = [3080,3320; 6480,6640];
     
k = 0;
for l = 1:2
    
    
    for i = 1:9
        k = k + 1;
        
        start = z_start{i};
        for j = 1:12
            dat = zeros(1, 3);
               
            if j == 1 || j == 2 || j == 3 || j == 4
                dat(end+1, :) = [start(1,j), start(2, 1), z_len(l,1)];
                dat(end+1, :) = [start(1,j), start(2, 1), z_len(l,2)];
                
                if l == 2
                    
                    dat(end+1, :) = [start(1,j), start(2, 1)+100, z_len(l,2)];
                end
                
            end
            
            if j == 5
                dat(end+1, :) = [start(1,1), start(2, 2), z_len(l,1)];
                dat(end+1, :) = [start(1,1), start(2, 2), z_len(l,2)];
                if l == 2
                    dat(end, :) = [start(1,1), start(2, 2), z_len(l,2)-40];
                    dat(end+1, :) = [start(1,1)+100, start(2, 2), z_len(l,2)-40];
                end
            end
            
            if j == 6
                dat(end+1, :) = [start(1,4), start(2, 2), z_len(l,1)];
                dat(end+1, :) = [start(1,4), start(2, 2), z_len(l,2)];
                if l == 2
                    dat(end, :) = [start(1,4), start(2, 2), z_len(l,2)-40];
                    dat(end+1, :) = [start(1,4)-100, start(2, 2), z_len(l,2)-40];
                end
            end
            
            if j == 7
                dat(end+1, :) = [start(1,1), start(2, 3), z_len(l,1)];
                dat(end+1, :) = [start(1,1), start(2, 3), z_len(l,2)];
                if l == 2
                    dat(end, :) = [start(1,1), start(2, 3), z_len(l,2)-40];
                    dat(end+1, :) = [start(1,1)+100, start(2, 3), z_len(l,2)-40];
                end
            end
            
            if j == 8
                dat(end+1, :) = [start(1,4), start(2, 3), z_len(l,1)];
                dat(end+1, :) = [start(1,4), start(2, 3), z_len(l,2)];
                if l == 2
                    dat(end, :) = [start(1,4), start(2, 3), z_len(l,2)-40];
                    dat(end+1, :) = [start(1,4)-100, start(2, 3), z_len(l,2)-40];
                end
            end
            
            if j == 9 || j == 10 || j == 11 || j == 12
                dat(end+1, :) = [start(1,j-8), start(2, 4), z_len(l,1)];
                dat(end+1, :) = [start(1,j-8), start(2, 4), z_len(l,2)];
                if l == 2
                    
                    dat(end+1, :) = [start(1,j-8), start(2, 4)-100, z_len(l,2)];
                end
            end          
            dat = dat(2:end,:);
            
            delete(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(k,:), xlsx(k), ztypes(j, :)));
            xlswrite(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(k,:), xlsx(k), ztypes(j, :)), dat);
        end

        % y axis
        start = y_start{i};
        for j = 1:5
            dat = zeros(1, 3);
            
            if j == 1 || j == 2 || j == 3
                 dat(end+1, :) = [start(j), y_len(i, 1), yz(l, 1)];
                 dat(end+1, :) = [start(j), y_len(i, 2), yz(l, 1)];
                 if i == 1 || i == 2 || i == 3 || i == 7 || i == 8 || i == 9
                     dat(end+1, :) = [start(j), y_len(i, 2), yz(l, 1)+100];
                 end
            end
            
            if j == 4
                dat(end+1, :) = [start(1), y_len(i, 1), yz(l, 2)];
                dat(end+1, :) = [start(1), y_len(i, 2), yz(l, 2)];
                
                
                if i == 1 || i == 2 || i == 3 || i == 7 || i == 8 || i == 9
                     dat(end+1, :) = [start(1), y_len(i, 2), yz(l, 2)-100];
                end
            end
            
            if j == 5
                dat(end+1, :) = [start(3), y_len(i, 1), yz(l, 2)];
                dat(end+1, :) = [start(3), y_len(i, 2), yz(l, 2)];
                if i == 1 || i == 2 || i == 3 || i == 7 || i == 8 || i == 9
                     dat(end+1, :) = [start(3), y_len(i, 2), yz(l, 2)-100];
                end
            end
            dat = dat(2:end,:);

            delete(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(k,:), xlsx(k), y_types(j, :)));
            xlswrite(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(k,:), xlsx(k), y_types(j, :)), dat);
        end
        

         % x axis
        start = x_start{i};
        for j = 1:5
            dat = zeros(1, 3);
            
            if j == 1 || j == 2 || j == 3
                 dat(end+1, :) = [x_len(i, 1),start(j), xz(l, 1)];
                 dat(end+1, :) = [x_len(i, 2),start(j), xz(l, 1)];
                 if i == 1 || i == 3 || i == 4 || i == 6 || i == 7 || i ==9
                     dat(end+1, :) = [x_len(i, 2),start(j), xz(l, 1)+60];
                 end
            end
            
            if j == 4
                dat(end+1, :) = [x_len(i, 1), start(1), xz(l, 2)];
                dat(end+1, :) = [x_len(i, 2), start(1), xz(l, 2)];
                if i == 1 || i == 3 || i == 4 || i == 6 || i == 7 || i ==9
                     dat(end+1, :) = [x_len(i, 2), start(1), xz(l, 2)-60];
                end
            end
            
            if j == 5
                dat(end+1, :) = [x_len(i, 1), start(3), xz(l, 2)];
                dat(end+1, :) = [x_len(i, 2), start(3), xz(l, 2)];
                if i == 1 || i == 3 || i == 4 || i == 6 || i == 7 || i ==9
                     dat(end+1, :) = [x_len(i, 2), start(3), xz(l, 2)-60];
                end
            end 
            dat = dat(2:end,:);
            
            delete(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(k,:), xlsx(k), x_types(j, :)));
            xlswrite(sprintf(".\\data\\%s\\%s\\%s.xlsx", ss(k,:), xlsx(k), x_types(j, :)), dat);
        end

        disp(i);

    end
end