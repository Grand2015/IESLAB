%利用平均值加减4.3.2.1倍Delta与4月3日数据进行对比

clc;
clear all;

%% 载入数据
%载入4月3日数据
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%载入测点平均值和标准差
load('average.mat');
load('standardDeviation.mat');
%% 原始数据差值处理
lev  = 3;
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
multiple = 4;%Delta的倍数
for i = 1:monitorNum
    for j = 1:sampleNum-1
        %作差值处理
        observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
        upperLimit(j,i) = average(j,i)+multiple*standardDeviation(j,i);
        lowerLimit(j,i) = average(j,i)-multiple*standardDeviation(j,i);
    end
    observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
    % 小波降噪(没有利用)
    observe4_3Wden(:,i) = wden(observe4_3diff(:,i),'heursure','s','mln',lev,'sym8');
end

%% 数据显示
for i = 1:monitorNum
    %1MPa约等于100m水柱
    t = 1:sampleNum-1;
    figure(i);
    plot(t,upperLimit(:,i),'-b',t,observe4_3Smooth(:,i),'-r',t,lowerLimit(:,i),'-b');
    title(['第',num2str(i),'测点压力数据与',num2str(multiple),'倍Delta']);
end
disp('End')


% y = downsample(x, n)
% 从第一项开始，等间隔n对x采样，得到的序列。为y。

