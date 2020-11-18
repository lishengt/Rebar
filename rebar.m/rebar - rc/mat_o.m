function mat_o(type, no,level, typex,typey,column_position_point,...
               beam1_position_point,beam2_position_point,...
               column_bar,beam1_bar_top,beam1_bar_bottom,...
               beam2_bar_top,beam2_bar_bottom)
%     level =1;
%     no = 1;
% 
%     typex = 4;
%     typey = 3;
    beam1_height = 400;
    beam1_weight = 350;
    beam2_height =400 ;
    beam2_weight = 350;
    column_height = 400;
    column_weight = 400;
    column_bar_dia = [20,20,20,20,20,20,20,20,20,20,20,20];
    beam1_bar_dia_top = [20,20,20,20];
    beam1_bar_dia_bottom = [20,20,20,20];
    beam2_bar_dia_top = [20,20,20,20];
    beam2_bar_dia_bottom = [20,20,20,20];

%     column_position_point = [200,200,0];
%     beam1_position_point = [200,1900,3200;200,0,3200];
%     beam2_position_point = [1900,200,3200;0,200,3200];



%     column_bar = {[20,20,0;20,20,4000],[140,20,0;140,20,4000],...
%         [260,20,0;260,20,4000],[380,20,0;380,20,4000],...
%         [20,140,0;20,140,4000],[380,140,0;380,140,4000],...
%         [20,260,0;20,260,4000],[380,260,0;380,260,4000],...
%         [20,380,0;20,380,4000],[140,380,0;140,380,4000],...
%         [260,380,0;260,380,4000],[380,380,0;380,380,1200]};
%     beam1_bar_top = {[20,1900,3380;20,400,3380;40,400,3380;40,20,3380;40,20,3280],...
%         [180,1900,3380;180,20,3380;180,20,3280]};
%     beam1_bar_bottom = {[20,1900,3020;20,400,3020;40,400,3020;40,20,3020;40,20,3120],...
%         [100,1900,3020;100,20,3020;100,20,3120],...
%         [180,1900,3020;180,20,3020;180,20,3120]};
%     beam2_bar_top = {[1900,20,3380;400,20,3380;400,40,3380;200,40,3380;200,40,3360;20,40,3360;20,40,3280],...
%         [1900,180,3380;200,180,3380;200,180,3360;20,180,3360;20,180,3280]};
%     beam2_bar_bottom = {[1900,20,3020;400,20,3020;400,40,3020;200,40,3020;200,40,3040;20,40,3040;20,40,3140],...
%         [1900,100,3020;200,100,3020;200,100,3040;20,100,3040;20,100,3120],...
%         [1900,180,3020;200,180,3020;200,180,3040;20,180,3040;20,180,3120]};


    save(sprintf(".\\data\\%s\\%s",type,'typex'),'typex');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'typex'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'typex'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'typey'),'typey');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'typey'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'typey'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);

    save(sprintf(".\\data\\%s\\%s",type,'beam1_height'),'beam1_height');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_height'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_height'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam1_weight'),'beam1_weight');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_weight'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_weight'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'column_height'),'column_height');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'column_height'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'column_height'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'column_weight'),'column_weight');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'column_weight'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'column_weight'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam2_height'),'beam2_height');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_height'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_height'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam2_weight'),'beam2_weight');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_weight'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_weight'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);

    save(sprintf(".\\data\\%s\\%s",type,'column_bar_dia'),'column_bar_dia');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'column_bar_dia'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'column_bar_dia'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam1_bar_dia_top'),'beam1_bar_dia_top');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_dia_top'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_dia_top'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam1_bar_dia_bottom'),'beam1_bar_dia_bottom');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_dia_bottom'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_dia_bottom'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam2_bar_dia_top'),'beam2_bar_dia_top');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_dia_top'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_dia_top'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam2_bar_dia_bottom'),'beam2_bar_dia_bottom');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_dia_bottom'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_dia_bottom'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);

    save(sprintf(".\\data\\%s\\%s",type,'column_position_point'),'column_position_point');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'column_position_point'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'column_position_point'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam1_position_point'),'beam1_position_point');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_position_point'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_position_point'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam2_position_point'),'beam2_position_point');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_position_point'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_position_point'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);

    save(sprintf(".\\data\\%s\\%s",type,'column_bar'),'column_bar');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'column_bar'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'column_bar'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam1_bar_top'),'beam1_bar_top');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_top'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_top'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam1_bar_bottom'),'beam1_bar_bottom');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_bottom'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam1_bar_bottom'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam2_bar_top'),'beam2_bar_top');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_top'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_top'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
    save(sprintf(".\\data\\%s\\%s",type,'beam2_bar_bottom'),'beam2_bar_bottom');
    oldname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_bottom'),'.mat');
    newname = strcat(sprintf(".\\data\\%s\\%s",type,'beam2_bar_bottom'),'_',num2str(level),'_',num2str(no),'.mat');
    movefile(oldname,newname);
end

