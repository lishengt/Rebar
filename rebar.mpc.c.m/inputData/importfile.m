function data = importfile(workbookFile, sheetName, range)
%IMPORTFILE 导入电子表格中的数据
%   DATA = IMPORTFILE(FILE) 读取名为 FILE 的 Microsoft Excel
%   电子表格文件的第一张工作表中的所有数值数据并返回这些数据。
%
%   DATA = IMPORTFILE(FILE,SHEET) 从指定的工作表中读取。
%
%   DATA = IMPORTFILE(FILE,SHEET,RANGE) 从指定的工作表和指定的范围中读取。使用语法 'C1:C2'
%   指定范围，其中 C1 和 C2 是区域的对角。%
% 示例:
%   start = importfile('start.xlsx','Sheet1','A1:C8');
%
%   另请参阅 XLSREAD。

% 由 MATLAB 自动生成于 2020/05/31 14:19:15

%% 输入处理

% 如果未指定工作表，则将读取第一张工作表
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% 如果未指定范围，则将读取所有数据
if nargin <= 2 || isempty(range)
    range = '';
end

%% 导入数据
data = xlsread(workbookFile, sheetName, range);

