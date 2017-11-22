clc;
clear all;
%% ��������
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%ʵ����hongwei_PC�ļ�·��
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC�ļ�·��
% path = 'C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\';%�Ż�PC·��
fileName= 'PressureDataAll.xls';
sheetNameBurst='20150404';

Path = [path,fileName];%ʵ����·��

monitor    = 0;     %������ѭ������
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
% [row,column] = size(sheetName);
%��ȡ����ʵ�鵱��ѹ������
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
% xlabel('����')
ylabel('Pressure')
set(gca,'linewidth',2);
set(gca,'FontSize',25);
set(gca,'XTick',0:300:1500);
% title('')
