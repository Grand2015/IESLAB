%将现有数据进行预处理
%对24天的数据进行处理（其中4.6，4.15数据大量丢失，舍弃本次数据）
%现对22天的数据进行处理
%将每个测点每天的压力数据整理到一个矩阵中，然后进行分析
%然后对每个测点不同时间的数据进行处理（HJM方法，δP方法，ZDD方法）

%以下为数据丢失情况
% 20150320 数据完整
% 20150321 数据完整
% 20150324 测点2数据大量缺失
% 20150325 测点2数据大量缺失
% 20150326 测点2，6，7数据大量缺失
% 20150327 测点2，6，7数据大量缺失
% 20150328 测点2，6，7数据大量缺失
% 20150329 测点2，6，7数据大量缺失
% 20150330 测点2，6，7数据大量缺失
% 20150331 测点2，6，7数据大量缺失
% 20150401 测点2，6，7数据大量缺失
% 20150402 测点2，6，7数据大量缺失
% 20150403 数据完整
% 20150404 数据完整
% 20150405 数据完整
% 20150406 数据全部丢失
% 20150408 数据完整
% 20150409 数据完整
% 20150410 数据完整
% 20150411 测点1数据大量缺失
% 20150412 测点1数据大量缺失
% 20150413 测点1，11数据大量缺失
% 20150414 测点1，11数据大量缺失
% 20150415 数据全部丢失

clc;
clear all;
%% 载入数据
% path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%实验室hongwei_PC文件路径
path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC文件路径
% path = 'C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\';%张慧PC路径
fileName= 'PressureDataAll.xls';
sheetNameBurst='20150403';
sheetName = [
 '20150320'
 '20150321'
 '20150324'
 '20150325'
 '20150326'
 '20150327'
 '20150328'
 '20150329'
 '20150330'
 '20150331'
 '20150401'
 '20150402'
 '20150404'
 '20150405'
 '20150408'
 '20150409'
 '20150410'
 '20150411'
 '20150412'
 '20150413'
 '20150414'
];
Path = [path,fileName];%实验室路径

monitor    = 0;     %监测点编号循环基数
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
[row,column] = size(sheetName);
%获取爆管实验当天压力数据
BurstTestData = xlsread(Path,sheetNameBurst,'C3:P1442');

%获取爆管实验前后压力数据
for i = 1:row
    preSub = xlsread(Path,sheetName(i,:),'C3:P1442');
	monitor = monitor+1;
	monitor1(:,monitor) = preSub(:,1);
	monitor2(:,monitor) = preSub(:,2);
	monitor3(:,monitor) = preSub(:,3);
	monitor4(:,monitor) = preSub(:,4);
	monitor5(:,monitor) = preSub(:,5);
	monitor6(:,monitor) = preSub(:,6);
	monitor7(:,monitor) = preSub(:,7);
	monitor8(:,monitor) = preSub(:,8);
	monitor9(:,monitor) = preSub(:,9);
	monitor10(:,monitor) = preSub(:,10);
	monitor11(:,monitor) = preSub(:,11);
	monitor12(:,monitor) = preSub(:,12);
	monitor13(:,monitor) = preSub(:,13);
	monitor14(:,monitor) = preSub(:,14);
	
end

%% 对测点大量的缺省数据进行剔除
%主要是测点1,2,6,7,11
%monitor1
for i = 21:-1:1
	monitor1(:,i) = [];
end

%monitor2
for i = 12:-1:3
	monitor2(:,i) = [];
end

%monitor6/7
for i = 12:-1:5
	monitor6(:,i) = [];
    monitor7(:,i) = [];
end

%monitor11
monitor11(:,21) = [];
monitor11(:,20) = [];

%直接通过观察数据直接将部分列设为空值

%% 插值处理 
%monitor1
monitor1 = LinearInterpolation(monitor1);
save monitor1 monitor1

monitor2 = LinearInterpolation(monitor2);
save monitor2 monitor2

monitor3 = LinearInterpolation(monitor3);
save monitor3 monitor3

monitor4 = LinearInterpolation(monitor4);
save monitor4 monitor4

monitor5 = LinearInterpolation(monitor5);
save monitor5 monitor5

monitor6 = LinearInterpolation(monitor6);
save monitor6 monitor6

monitor7 = LinearInterpolation(monitor7);
save monitor7 monitor7

monitor8 = LinearInterpolation(monitor8);
save monitor8 monitor8

monitor9 = LinearInterpolation(monitor9);
save monitor9 monitor9

monitor10 = LinearInterpolation(monitor10);
save monitor10 monitor10

monitor11 = LinearInterpolation(monitor11);
save monitor11 monitor11

monitor12 = LinearInterpolation(monitor12);
save monitor12 monitor12

monitor13 = LinearInterpolation(monitor13);
save monitor13 monitor13

monitor14 = LinearInterpolation(monitor14);
save monitor14 monitor14

%爆管实验数据进行差值处理
BurstTestData = LinearInterpolation(BurstTestData);
save BurstTestData BurstTestData