clc;
clear all;
%% 载入4月3日数据数据
load('observe4_3.mat');    
%% 原始数据插值处理
   observe4_3Smooth(:,1)= smooth(observe4_3(:,1));
%% 小波降噪
lev = 3;
   pre4_3(:,1) = wden(observe4_3Smooth(:,1),'heursure','s','mln',lev,'sym8');
%计算一列的平均值和标准差
observe4_3average=mean(pre4_3(:,1));
% observe4_3std=std(pre4_3,0,1);
% observe4_3std=pre4_3(:,1)';
observe4_3std=std(pre4_3(:,1)',1);

%%输出一列的平均值和标准差
% fprintf('第一个监测点的平均值为%d',observe4_3average);
% fprintf('第一个监测点的标准差为%d',observe4_3std);
% 
x=-4:0.01:4;
miu=observe4_3average;
sigma=observe4_3std;
y1=normpdf(x,miu,sigma);
y2=normcdf(x,miu,sigma);
figure(1)  
subplot 221
plot(x,y1)
title('正态分布的概率密度')
subplot 222
plot(x,y2)
title('正态分布的累积分布')









