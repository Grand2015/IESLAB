%% 正态分布累计概率
% clear
% x=-4:0.01:4;
% miu=0;sigma=1;
% y1=normpdf(x,miu,sigma);
% y2=normcdf(x,miu,sigma);
% figure(1) 
% subplot 221
% plot(x,y1)
% title('正态分布的概率密度')
% subplot 222
% plot(x,y2)
% title('正态分布的累积分布')

 %% point1 数据曲线
% load('observe4_3.mat');
% t=1:1:1440;
% plot(t,observe4_3(:,1));

clc;
clear all;
%% 载入4月3日数据数据
load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');    
%% 原始数据插值处理
lev = 3;
for i=1:14
observe4_3Smooth(:,i)= smooth(observe4_3(:,i));
%% 小波降噪
pre4_3Wden(:,i) = wden(observe4_3Smooth(:,i),'heursure','s','mln',lev,'sym8');
%计算一列的平均值和标准差
observe4_3average(1,i)=mean(pre4_3Wden(:,i));
pre4_3(i,:)=pre4_3Wden(:,i)';
observe4_3std(1,i)=std(pre4_3(i,:),1);
end
%  x=-5:0.01:5;
% hist(pre4_3(:,1),20); hold on;
% a=randn(10000,1); 
[b, x]=hist(pre4_3Wden(:,1),100);
% % b = hist(pre4_3Wden(:,1),1001);
num=numel(pre4_3Wden(:,1));
figure;plot(x,b/num);   %概率密度
c=cumsum(b/num);        %累积分布
figure; plot(x,c);
% miu=observe4_3average;
% sigma=observe4_3std;
% y1=normpdf(x,miu,sigma);
% y2=normcdf(x,miu,sigma);
% figure(1)  
% subplot 211
% plot(x,y1)
% title('4月3日第一个测点压力变化正态分布的概率密度')
% subplot 212
% plot(x,y2)
% title('4月3日第一个测点压力变化正态分布的累积分布')







