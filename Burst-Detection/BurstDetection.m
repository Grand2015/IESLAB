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
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat')
%% 原始数据插值处理
lev = 3;
monitorNum=14;%监测点个数
sampleNum=1440;%采样点数，即1个/分钟
for i = 1:monitorNum
    %作差值处理
    for j = 1:sampleNum-1
        observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
    end
    observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
    % 小波降噪
    observe4_3Wden(:,i) = wden(observe4_3Smooth(:,i),'heursure','s','mln',lev,'sym8');
    %计算14个测点的平均值和标准差
    observe4_3average(1,i)=mean(observe4_3Wden(:,i));
    pre4_3T(i,:)=observe4_3Wden(:,i)';
    observe4_3std(1,i)=std(pre4_3T(i,:),1);
end

hist(observe4_3Wden(:,1),100); hold on;
[b, x]=hist(observe4_3Wden(:,1),100);
num=numel(observe4_3Wden(:,1));

miu=observe4_3average(1,1);
sigma=observe4_3std(1,1);
y1=normpdf(x,miu,sigma);
y2=normcdf(x,miu,sigma);

% [f,xi] = ksdensity(observe4_3Wden(:,1));
% plot(xi,f);


figure(1);
subplot 211;
plot(x,b/num);   %概率密度
title('4月3日第一个测点压力变化正态分布的概率密度')
c=cumsum(b/num);        %累积分布
% figure; 
subplot 212;
plot(x,c,'+',x,y2,'--');
title('4月3日第一个测点压力变化正态分布的累积分布');
figure(2);
plot(x,c,'+',x,y2,'--');
title('4月3日第一个测点压力变化正态分布的累积分布');
xlabel('');ylabel('概率');

% figure(1)  
% subplot 211
% plot(x,y1)
% title('4月3日第一个测点压力变化正态分布的概率密度')
% subplot 212
% plot(x,y2)
% title('4月3日第一个测点压力变化正态分布的累积分布')







