%% 代码说明：
% 改变采样频率
% 作者：grand
% 时间：2017.11.29

%% 代码说明：
% 对洪嘉明师兄代码优化，主要考虑是否进行小波降噪的情况
% boundaryAD:boundary all data
% 重新整理输入数据，对每一天的数据进行处理，剔除一天中缺失较重的
% 测点数据
% 作者：grand
% 时间：2017.09.09

%% 代码
clc;
clear all;
%% 载入数据
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
%载入4月3日爆管实验数据
% path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%实验室数据路径
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\AllData\';%个人电脑路径
% path = 'C:\IESLAB\SCADA-Data\AllData\'; %东华图书馆PC路径
% day43='BurstTestData.mat';
% Path = [path,day43];
load('BurstTestData.mat');
%载入测点数据
fileName= 'monitor';
suffix='.mat';
for i = 1:monitorNum
    Path = [fileName,num2str(i),suffix];
    load(Path);
end
%% 改变采样间隔
sample = 2;

    monitor1d = downsample(monitor1, sample);
    monitor2d = downsample(monitor2, sample);
    monitor3d = downsample(monitor3, sample);
    monitor4d = downsample(monitor4, sample);
    monitor5d = downsample(monitor5, sample);
    monitor6d = downsample(monitor6, sample);
    monitor7d = downsample(monitor7, sample);
    monitor8d = downsample(monitor8, sample);
    monitor9d = downsample(monitor9, sample);
    monitor10d = downsample(monitor10, sample);
    monitor11d = downsample(monitor11, sample);
    monitor12d = downsample(monitor12, sample);
    monitor13d = downsample(monitor13, sample);
    monitor14d = downsample(monitor14, sample);
    BurstTestDatad = downsample(BurstTestData, sample);

%% 数据预处理
% case1：小波降噪+平滑滤波
% case2：平滑滤波
% 用flag做标记，flag=1表示case1，flag=0表示case2

flag = 0;
monitor1d = SmoothOrWden(monitor1d,flag);
monitor2d = SmoothOrWden(monitor2d,flag);
monitor3d = SmoothOrWden(monitor3d,flag);
monitor4d = SmoothOrWden(monitor4d,flag);
monitor5d = SmoothOrWden(monitor5d,flag);
monitor6d = SmoothOrWden(monitor6d,flag);
monitor7d = SmoothOrWden(monitor7d,flag);
monitor8d = SmoothOrWden(monitor8d,flag);
monitor9d = SmoothOrWden(monitor9d,flag);
monitor10d = SmoothOrWden(monitor10d,flag);
monitor11d = SmoothOrWden(monitor11d,flag);
monitor12d = SmoothOrWden(monitor12d,flag);
monitor13d = SmoothOrWden(monitor13d,flag);
monitor14d = SmoothOrWden(monitor14d,flag);

BurstTestDataSmoothd = SmoothOrWden(BurstTestDatad,flag);
save BurstTestDataSmoothd BurstTestDataSmoothd;
%% 压力值差值或者压力值
% flag=1表示输出δP的结果，Output=δInput；flag=0表示输出P的结果，Output=Input
% 计算delta要放在前面，因为deltaP比P少了一行数据，防止数据不能全部覆盖


flag = 0;
[average1,standard1,monitor1d] = POrDeltaP(monitor1d,flag);
[average2,standard2,monitor2d] = POrDeltaP(monitor2d,flag);
[average3,standard3,monitor3d] = POrDeltaP(monitor3d,flag);
[average4,standard4,monitor4d] = POrDeltaP(monitor4d,flag);
[average5,standard5,monitor5d] = POrDeltaP(monitor5d,flag);
[average6,standard6,monitor6d] = POrDeltaP(monitor6d,flag);
[average7,standard7,monitor7d] = POrDeltaP(monitor7d,flag);
[average8,standard8,monitor8d] = POrDeltaP(monitor8d,flag);
[average9,standard9,monitor9d] = POrDeltaP(monitor9d,flag);
[average10,standard10,monitor10d] = POrDeltaP(monitor10d,flag);
[average11,standard11,monitor11d] = POrDeltaP(monitor11d,flag);
[average12,standard12,monitor12d] = POrDeltaP(monitor12d,flag);
[average13,standard13,monitor13d] = POrDeltaP(monitor13d,flag);
[average14,standard14,monitor14d] = POrDeltaP(monitor14d,flag);

averaged = [average1 average2 average3 average4 average5 average6 average7 average8 average9 average10 average11 average12 average13 average14];
standardd = [standard1 standard2 standard3 standard4 standard5 standard6 standard7 standard8 standard9 standard10 standard11 standard12 standard13 standard14];
save averaged averaged;
save standardd standardd;

%% 代码输出
SystemInfor( );










