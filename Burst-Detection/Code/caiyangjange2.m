%% ����˵����
% �ı����Ƶ��
% ���ߣ�grand
% ʱ�䣺2017.11.29

%% ����˵����
% �Ժ����ʦ�ִ����Ż�����Ҫ�����Ƿ����С����������
% boundaryAD:boundary all data
% ���������������ݣ���ÿһ������ݽ��д����޳�һ����ȱʧ���ص�
% �������
% ���ߣ�grand
% ʱ�䣺2017.09.09

%% ����
clc;
clear all;
%% ��������
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
%����4��3�ձ���ʵ������
% path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%ʵ��������·��
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\AllData\';%���˵���·��
% path = 'C:\IESLAB\SCADA-Data\AllData\'; %����ͼ���PC·��
% day43='BurstTestData.mat';
% Path = [path,day43];
load('BurstTestData.mat');
%����������
fileName= 'monitor';
suffix='.mat';
for i = 1:monitorNum
    Path = [fileName,num2str(i),suffix];
    load(Path);
end
%% �ı�������
sample = 2;

    monitor1d = downsample(monitor1, sample);
    monitor2d = downsample(monitor2, sample);
    monitor3d = downsample(monitor3, sample);
    monitor4d = downsample(monitor4, sample);
    monitor5d = downsample(monitor5, sample);
    monitor6d = downsample(monitor6, sample);
    monitor7d = downsample(monitor7, sample);
    monitor8d = downsample(monitor8, sample);
    monitor9d = downsample(monitor9, sample);
    monitor10d = downsample(monitor10, sample);
    monitor11d = downsample(monitor11, sample);
    monitor12d = downsample(monitor12, sample);
    monitor13d = downsample(monitor13, sample);
    monitor14d = downsample(monitor14, sample);
    BurstTestDatad = downsample(BurstTestData, sample);

%% ����Ԥ����
% case1��С������+ƽ���˲�
% case2��ƽ���˲�
% ��flag����ǣ�flag=1��ʾcase1��flag=0��ʾcase2

flag = 0;
monitor1d = SmoothOrWden(monitor1d,flag);
monitor2d = SmoothOrWden(monitor2d,flag);
monitor3d = SmoothOrWden(monitor3d,flag);
monitor4d = SmoothOrWden(monitor4d,flag);
monitor5d = SmoothOrWden(monitor5d,flag);
monitor6d = SmoothOrWden(monitor6d,flag);
monitor7d = SmoothOrWden(monitor7d,flag);
monitor8d = SmoothOrWden(monitor8d,flag);
monitor9d = SmoothOrWden(monitor9d,flag);
monitor10d = SmoothOrWden(monitor10d,flag);
monitor11d = SmoothOrWden(monitor11d,flag);
monitor12d = SmoothOrWden(monitor12d,flag);
monitor13d = SmoothOrWden(monitor13d,flag);
monitor14d = SmoothOrWden(monitor14d,flag);

BurstTestDataSmoothd = SmoothOrWden(BurstTestDatad,flag);
save BurstTestDataSmoothd BurstTestDataSmoothd;
%% ѹ��ֵ��ֵ����ѹ��ֵ
% flag=1��ʾ�����P�Ľ����Output=��Input��flag=0��ʾ���P�Ľ����Output=Input
% ����deltaҪ����ǰ�棬��ΪdeltaP��P����һ�����ݣ���ֹ���ݲ���ȫ������


flag = 0;
[average1,standard1,monitor1d] = POrDeltaP(monitor1d,flag);
[average2,standard2,monitor2d] = POrDeltaP(monitor2d,flag);
[average3,standard3,monitor3d] = POrDeltaP(monitor3d,flag);
[average4,standard4,monitor4d] = POrDeltaP(monitor4d,flag);
[average5,standard5,monitor5d] = POrDeltaP(monitor5d,flag);
[average6,standard6,monitor6d] = POrDeltaP(monitor6d,flag);
[average7,standard7,monitor7d] = POrDeltaP(monitor7d,flag);
[average8,standard8,monitor8d] = POrDeltaP(monitor8d,flag);
[average9,standard9,monitor9d] = POrDeltaP(monitor9d,flag);
[average10,standard10,monitor10d] = POrDeltaP(monitor10d,flag);
[average11,standard11,monitor11d] = POrDeltaP(monitor11d,flag);
[average12,standard12,monitor12d] = POrDeltaP(monitor12d,flag);
[average13,standard13,monitor13d] = POrDeltaP(monitor13d,flag);
[average14,standard14,monitor14d] = POrDeltaP(monitor14d,flag);

averaged = [average1 average2 average3 average4 average5 average6 average7 average8 average9 average10 average11 average12 average13 average14];
standardd = [standard1 standard2 standard3 standard4 standard5 standard6 standard7 standard8 standard9 standard10 standard11 standard12 standard13 standard14];
save averaged averaged;
save standardd standardd;

%% �������
SystemInfor( );










