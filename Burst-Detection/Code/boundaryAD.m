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
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%实验室数据路径
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
[row,column] = size(monitor1);
% monitor1Smooth = 
for i = 1:column
    monitor1Smooth(:,i) = smooth(monitor1(:,i),5);
end



