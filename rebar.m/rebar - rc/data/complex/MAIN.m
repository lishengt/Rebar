clear all
level =2;
no = 1;

typex = 3;
typey = 3;
beam1_height = 400;
beam1_weight = 350;
beam2_height =400 ;
beam2_weight = 350;
column_height = 400;
column_weight = 400;
column_bar_dia = [20,20,20,20,20,20,20,20,20,20,20,20];
beam1_bar_dia_top = [20,20,20,20];
beam1_bar_dia_bottom = [20,20,20,20,20];
beam2_bar_dia_top = [20,20,20,20];
beam2_bar_dia_bottom = [20,20,20,20,20];

column_position_point = [7000,200,4000];
beam1_position_point = [7025, 1900,6800;7025,0,6800];
beam2_position_point = [5300,175,6800;7200,175,6800];



column_bar = {[6840,40,4000;6840,40,6760;6840,140,6760],[6947,40,4000;6947,40,6760;6947,140,6760],...
    [7053,40,4000;7053,40,6760;7053,140,6760],[7160,40,4000;7160,40,6760;7160,140,6760],...
    [6840,147,4000;6840,147,6720;6940,147,6720],[7160,147,4000;7160,147,6720;7060,147,6720],...
    [6840,253,4000;6840,253,6720;6940,253,6720],[7160,253,4000;7160,253,6720;7060,253,6720],...
    [6840,360,4000;6840,360,6760;6840,260,6760],[6947,360,4000;6947,360,6760;6947,260,6760],...
    [7053,360,4000;7053,360,6760;7053,260,6760],[7160,360,4000;7160,360,6760;7160,260,6760]};
beam1_bar_top = {[6890,1900,6720;6890,600,6720;6890,400,6680;6890,40,6680;6890,40,6620],...
    [7160,1900,6720;7160,600,6720;7120,500,6720],...
    [7120,500,6720;7120,400,6680;7120,200,6680],...
    [7120,200,6680;7120,40,6680;7120,40,6620]};
beam1_bar_bottom = {[6890,1900,6440;6890,40,6440;6890,40,6540],...
    [7015,1900,6440;7015,40,6440;7015,40,6540],...
    [7160,1900,6440;7160,600,6440;7120,500,6440],...
    [7120,500,6440;7120,400,6440;7120,200,6440],...
    [7120,200,6440;7120,40,6440;7120,40,6540]};
beam2_bar_top = {[5300,40,6720;6600,40,6720;6700,80,6720],...
    [6700,80,6720;6800,80,6640;7000,80,6640],...
    [7000,80,6640;7160,80,6640;7160,80,6600],...
    [5300,290,6720;6600,290,6720;6800,290,6640;7180,290,6640;7180,290,6600]};
beam2_bar_bottom = {[5300,40,6440;6600,40,6440;6700,80,6440],...
    [6700,80,6440;6800,80,6480;7000,80,6480],...
    [7000,80,6480;7160,80,6480;7160,80,6560],...
    [5300,195,6440;6600,195,6440;6800,195,6480;7180,195,6480;7180,195,6560],...
    [5300,290,6440;6600,290,6440;6800,290,6480;7180,290,6480;7180,290,6560]};

save('typex','typex');
oldname = strcat('typex','.mat');
newname = strcat('typex_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('typey','typey');
oldname = strcat('typey','.mat');
newname = strcat('typey_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);

save('beam1_height','beam1_height');
oldname = strcat('beam1_height','.mat');
newname = strcat('beam1_height_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam1_weight','beam1_weight');
oldname = strcat('beam1_weight','.mat');
newname = strcat('beam1_weight_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('column_height','column_height');
oldname = strcat('column_height','.mat');
newname = strcat('column_height_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('column_weight','column_weight');
oldname = strcat('column_weight','.mat');
newname = strcat('column_weight_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam2_height','beam2_height');
oldname = strcat('beam2_height','.mat');
newname = strcat('beam2_height_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam2_weight','beam2_weight');
oldname = strcat('beam2_weight','.mat');
newname = strcat('beam2_weight_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);

save('column_bar_dia','column_bar_dia');
oldname = strcat('column_bar_dia','.mat');
newname = strcat('column_bar_dia_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam1_bar_dia_top','beam1_bar_dia_top');
oldname = strcat('beam1_bar_dia_top','.mat');
newname = strcat('beam1_bar_dia_top_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam1_bar_dia_bottom','beam1_bar_dia_bottom');
oldname = strcat('beam1_bar_dia_bottom','.mat');
newname = strcat('beam1_bar_dia_bottom_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam2_bar_dia_top','beam2_bar_dia_top');
oldname = strcat('beam2_bar_dia_top','.mat');
newname = strcat('beam2_bar_dia_top_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam2_bar_dia_bottom','beam2_bar_dia_bottom');
oldname = strcat('beam2_bar_dia_bottom','.mat');
newname = strcat('beam2_bar_dia_bottom_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);

save('column_position_point','column_position_point');
oldname = strcat('column_position_point','.mat');
newname = strcat('column_position_point_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam1_position_point','beam1_position_point');
oldname = strcat('beam1_position_point','.mat');
newname = strcat('beam1_position_point_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam2_position_point','beam2_position_point');
oldname = strcat('beam2_position_point','.mat');
newname = strcat('beam2_position_point_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);

save('column_bar','column_bar');
oldname = strcat('column_bar','.mat');
newname = strcat('column_bar_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam1_bar_top','beam1_bar_top');
oldname = strcat('beam1_bar_top','.mat');
newname = strcat('beam1_bar_top_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam1_bar_bottom','beam1_bar_bottom');
oldname = strcat('beam1_bar_bottom','.mat');
newname = strcat('beam1_bar_bottom_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam2_bar_top','beam2_bar_top');
oldname = strcat('beam2_bar_top','.mat');
newname = strcat('beam2_bar_top_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
save('beam2_bar_bottom','beam2_bar_bottom');
oldname = strcat('beam2_bar_bottom','.mat');
newname = strcat('beam2_bar_bottom_',num2str(level),'_',num2str(no),'.mat');
movefile(oldname,newname);
