clc;
clear all;

%% 载入数据
% load('monitor4');
load('BurstTestData.mat');

average=BurstTestData;
average2 = downsample(average(:,4), 2);
average3 = downsample(average(:,4), 3);
average5 = downsample(average(:,4), 5);
average10 = downsample(average(:,4), 10);
average15 = downsample(average(:,4), 15);

flag = 0;
average(:,4) = SmoothOrWden(average(:,4) ,flag);
average2 = SmoothOrWden(average2,flag);
average3 = SmoothOrWden(average3,flag);
average5 = SmoothOrWden(average5,flag);
average10 = SmoothOrWden(average10,flag);
average15 = SmoothOrWden(average15,flag);

flag = 0;
average(:,4) = SmoothOrWden(average(:,4) ,flag);
average2 = SmoothOrWden(average2,flag);
average3 = SmoothOrWden(average3,flag);
average5 = SmoothOrWden(average5,flag);
average10 = SmoothOrWden(average10,flag);
average15 = SmoothOrWden(average15,flag);

figure;
subplot(2,3,1);
plot(average(:,4),'LineWidth',2);
xlabel('采样频率：1min/次')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% title('4号监测点压力曲线');
% set(gca,'XTick',0:300:1500);
% grid on;
% figure;
subplot(2,3,2);
plot(average2,'LineWidth',2);
xlabel('采样频率：2min/次')
% ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
% figure;
subplot(2,3,3);
plot(average3,'LineWidth',2);
xlabel('采样频率：3min/次')
% ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
subplot(2,3,4);
plot(average5,'LineWidth',2);
xlabel('采样频率：5min/次')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
subplot(2,3,5);
plot(average10,'LineWidth',2);
xlabel('采样频率：10min/次')
% ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
subplot(2,3,6);
plot(average15,'LineWidth',2);
xlabel('采样频率：15min/次')
% ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);

