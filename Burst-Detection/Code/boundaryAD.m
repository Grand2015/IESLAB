%% ����˵����
% �Ժ����ʦ�ִ����Ż�����Ҫ�����Ƿ����С����������
% boundaryAD:boundary all data
% ���������������ݣ���ÿһ������ݽ��д����޳�һ����ȱʧ���ص�
% �������

%% ����
clc;
clear all;
%% ��������
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
%����4��3�ձ���ʵ������
% path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%ʵ��������·��
path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\AllData\';%���˵���·��
day43='BurstTestData.mat';
Path = [path,day43];
load(Path);
%����������
fileName= 'monitor';
suffix='.mat';
for i = 1:monitorNum
    Path = [path,fileName,num2str(i),suffix];
    load(Path);
end

%% ����Ԥ����
% case1��С������+ƽ���˲�
% case2��ƽ���˲�
% ��flag����ǣ�flag=1��ʾcase1��flag=0��ʾcase2

flag = 1;
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


%% ѹ��ֵ��ֵ����ѹ��ֵ



%% �������
SystemInfor( );





