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
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%实验室数据路径
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\AllData\';%个人电脑路径
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

flag = 0;
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

BurstTestData = SmoothOrWden(BurstTestData,flag);

%% 压力值差值或者压力值
% flag=1表示输出δP的结果，Output=δInput；flag=0表示输出P的结果，Output=Input
% 计算delta要放在前面，因为deltaP比P少了一行数据，防止数据不能全部覆盖
flag = 1;
[average1,standard1,monitor1Del] = POrDeltaP(monitor1,flag);
[average2,standard2,monitor2Del] = POrDeltaP(monitor2,flag);
[average3,standard3,monitor3Del] = POrDeltaP(monitor3,flag);
[average4,standard4,monitor4Del] = POrDeltaP(monitor4,flag);
[average5,standard5,monitor5Del] = POrDeltaP(monitor5,flag);
[average6,standard6,monitor6Del] = POrDeltaP(monitor6,flag);
[average7,standard7,monitor7Del] = POrDeltaP(monitor7,flag);
[average8,standard8,monitor8Del] = POrDeltaP(monitor8,flag);
[average9,standard9,monitor9Del] = POrDeltaP(monitor9,flag);
[average10,standard10,monitor10Del] = POrDeltaP(monitor10,flag);
[average11,standard11,monitor11Del] = POrDeltaP(monitor11,flag);
[average12,standard12,monitor12Del] = POrDeltaP(monitor12,flag);
[average13,standard13,monitor13Del] = POrDeltaP(monitor13,flag);
[average14,standard14,monitor14Del] = POrDeltaP(monitor14,flag);
[averageTest,standardTest,BurstTestDataDel] = POrDeltaP(BurstTestData,flag);

averageDel = [average1 average2 average3 average4 average5 average6 average7 average8 average9 average10 average11 average12 average13 average14];
standardDel = [standard1 standard2 standard3 standard4 standard5 standard6 standard7 standard8 standard9 standard10 standard11 standard12 standard13 standard14];

flag = 0;
[average1,standard1,monitor1] = POrDeltaP(monitor1,flag);
[average2,standard2,monitor2] = POrDeltaP(monitor2,flag);
[average3,standard3,monitor3] = POrDeltaP(monitor3,flag);
[average4,standard4,monitor4] = POrDeltaP(monitor4,flag);
[average5,standard5,monitor5] = POrDeltaP(monitor5,flag);
[average6,standard6,monitor6] = POrDeltaP(monitor6,flag);
[average7,standard7,monitor7] = POrDeltaP(monitor7,flag);
[average8,standard8,monitor8] = POrDeltaP(monitor8,flag);
[average9,standard9,monitor9] = POrDeltaP(monitor9,flag);
[average10,standard10,monitor10] = POrDeltaP(monitor10,flag);
[average11,standard11,monitor11] = POrDeltaP(monitor11,flag);
[average12,standard12,monitor12] = POrDeltaP(monitor12,flag);
[average13,standard13,monitor13] = POrDeltaP(monitor13,flag);
[average14,standard14,monitor14] = POrDeltaP(monitor14,flag);

average = [average1 average2 average3 average4 average5 average6 average7 average8 average9 average10 average11 average12 average13 average14];
standard = [standard1 standard2 standard3 standard4 standard5 standard6 standard7 standard8 standard9 standard10 standard11 standard12 standard13 standard14];

%% 异常事件侦测
% 1,HJM的P方法
% 2,δP方法
% 3,ZDD拐点方法
% 当方法为1,2的时候，input1表示average，input2表示standard
% 当方法为3的时候，input1表示拐点数据，input设为0
% multiple:Delta的倍数

% 计算拐点数据
averageDel = averageDel*100;
[row,column] = size(averageDel);
for i = 1:column
    figure(i);
	normplot(averageDel(:,i));
	title(['第',num2str(i),'测点压力变化累计概率']);
end


%% 代码输出
SystemInfor( );





