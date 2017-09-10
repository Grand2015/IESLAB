%% 代码说明：
% 对洪嘉明师兄代码优化，主要考虑是否进行小波降噪的情况
% boundaryAD:boundary all data
% 重新整理输入数据，对每一天的数据进行处理，剔除一天中缺失较重的
% 测点数据

%% 代码
clc;
clear all;
%% 载入数据
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
%载入4月3日爆管实验数据
% path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%实验室数据路径
path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\AllData\';%个人电脑路径
day43='BurstTestData.mat';
Path = [path,day43];
load(Path);
%载入测点数据
fileName= 'monitor';
suffix='.mat';
for i = 1:monitorNum
    Path = [path,fileName,num2str(i),suffix];
    load(Path);
end

%% 数据预处理
% case1：小波降噪+平滑滤波
% case2：平滑滤波
% 用flag做标记，flag=1表示case1，flag=0表示case2

flag = 1;
monitor1 = SmoothOrWden(monitor1,flag);
monitor2 = SmoothOrWden(monitor2,flag);
monitor3 = SmoothOrWden(monitor3,flag);
monitor4 = SmoothOrWden(monitor4,flag);
monitor5 = SmoothOrWden(monitor5,flag);
monitor6 = SmoothOrWden(monitor6,flag);
monitor7 = SmoothOrWden(monitor7,flag);
monitor8 = SmoothOrWden(monitor8,flag);
monitor9 = SmoothOrWden(monitor9,flag);
monitor10 = SmoothOrWden(monitor10,flag);
monitor11 = SmoothOrWden(monitor11,flag);
monitor12 = SmoothOrWden(monitor12,flag);
monitor13 = SmoothOrWden(monitor13,flag);
monitor14 = SmoothOrWden(monitor14,flag);


%% 压力值差值或者压力值



%% 代码输出
SystemInfor( );





