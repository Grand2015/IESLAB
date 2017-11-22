clc;
clear all;
%% 载入数据
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%实验室hongwei_PC文件路径
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC文件路径
% path = 'C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\';%张慧PC路径
fileName= 'PressureDataAll.xls';
sheetNameBurst='20150404';

Path = [path,fileName];%实验室路径

monitor    = 0;     %监测点编号循环基数
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
% [row,column] = size(sheetName);
%获取爆管实验当天压力数据
BurstTestData = xlsread(Path,sheetNameBurst,'C3:P1442');
t=1:1:1440;
figure;
plot(t,BurstTestData(:,8));
chazhiculi = LinearInterpolation(BurstTestData(:,8));
figure;
plot(t,chazhiculi);
jiangzao = SmoothOrWden(chazhiculi,0);
figure;
plot(t,jiangzao);
plot(t,BurstTestData(:,2),'LineWidth',2)
% xlabel('采样')
ylabel('Pressure')
set(gca,'linewidth',2);
set(gca,'FontSize',25);
set(gca,'XTick',0:300:1500);
% title('')
