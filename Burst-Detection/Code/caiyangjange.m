clc;
clear all;

%% ��������
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
xlabel('����Ƶ�ʣ�1min/��')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% title('4�ż���ѹ������');
% set(gca,'XTick',0:300:1500);
% grid on;
% figure;
subplot(2,3,2);
plot(average2,'LineWidth',2);
xlabel('����Ƶ�ʣ�2min/��')
% ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
% figure;
subplot(2,3,3);
plot(average3,'LineWidth',2);
xlabel('����Ƶ�ʣ�3min/��')
% ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
subplot(2,3,4);
plot(average5,'LineWidth',2);
xlabel('����Ƶ�ʣ�5min/��')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
subplot(2,3,5);
plot(average10,'LineWidth',2);
xlabel('����Ƶ�ʣ�10min/��')
% ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);
% figure;
subplot(2,3,6);
plot(average15,'LineWidth',2);
xlabel('����Ƶ�ʣ�15min/��')
% ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',15);

