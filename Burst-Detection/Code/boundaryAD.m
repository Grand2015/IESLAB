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
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%ʵ��������·��
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\AllData\';%���˵���·��
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

flag = 0;
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

BurstTestData = SmoothOrWden(BurstTestData,flag);

%% ѹ��ֵ��ֵ����ѹ��ֵ
% flag=1��ʾ�����P�Ľ����Output=��Input��flag=0��ʾ���P�Ľ����Output=Input
% ����deltaҪ����ǰ�棬��ΪdeltaP��P����һ�����ݣ���ֹ���ݲ���ȫ������
flag = 1;
[average1,standard1,monitor1Del] = POrDeltaP(monitor1,flag);
[average2,standard2,monitor2Del] = POrDeltaP(monitor2,flag);
[average3,standard3,monitor3Del] = POrDeltaP(monitor3,flag);
[average4,standard4,monitor4Del] = POrDeltaP(monitor4,flag);
[average5,standard5,monitor5Del] = POrDeltaP(monitor5,flag);
[average6,standard6,monitor6Del] = POrDeltaP(monitor6,flag);
[average7,standard7,monitor7Del] = POrDeltaP(monitor7,flag);
[average8,standard8,monitor8Del] = POrDeltaP(monitor8,flag);
[average9,standard9,monitor9Del] = POrDeltaP(monitor9,flag);
[average10,standard10,monitor10Del] = POrDeltaP(monitor10,flag);
[average11,standard11,monitor11Del] = POrDeltaP(monitor11,flag);
[average12,standard12,monitor12Del] = POrDeltaP(monitor12,flag);
[average13,standard13,monitor13Del] = POrDeltaP(monitor13,flag);
[average14,standard14,monitor14Del] = POrDeltaP(monitor14,flag);
[averageTest,standardTest,BurstTestDataDel] = POrDeltaP(BurstTestData,flag);

averageDel = [average1 average2 average3 average4 average5 average6 average7 average8 average9 average10 average11 average12 average13 average14];
standardDel = [standard1 standard2 standard3 standard4 standard5 standard6 standard7 standard8 standard9 standard10 standard11 standard12 standard13 standard14];

flag = 0;
[average1,standard1,monitor1] = POrDeltaP(monitor1,flag);
[average2,standard2,monitor2] = POrDeltaP(monitor2,flag);
[average3,standard3,monitor3] = POrDeltaP(monitor3,flag);
[average4,standard4,monitor4] = POrDeltaP(monitor4,flag);
[average5,standard5,monitor5] = POrDeltaP(monitor5,flag);
[average6,standard6,monitor6] = POrDeltaP(monitor6,flag);
[average7,standard7,monitor7] = POrDeltaP(monitor7,flag);
[average8,standard8,monitor8] = POrDeltaP(monitor8,flag);
[average9,standard9,monitor9] = POrDeltaP(monitor9,flag);
[average10,standard10,monitor10] = POrDeltaP(monitor10,flag);
[average11,standard11,monitor11] = POrDeltaP(monitor11,flag);
[average12,standard12,monitor12] = POrDeltaP(monitor12,flag);
[average13,standard13,monitor13] = POrDeltaP(monitor13,flag);
[average14,standard14,monitor14] = POrDeltaP(monitor14,flag);

average = [average1 average2 average3 average4 average5 average6 average7 average8 average9 average10 average11 average12 average13 average14];
standard = [standard1 standard2 standard3 standard4 standard5 standard6 standard7 standard8 standard9 standard10 standard11 standard12 standard13 standard14];

%% �쳣�¼����
% 1,HJM��P����
% 2,��P����
% 3,ZDD�յ㷽��
% ������Ϊ1,2��ʱ��input1��ʾaverage��input2��ʾstandard
% ������Ϊ3��ʱ��input1��ʾ�յ����ݣ�input��Ϊ0
% multiple:Delta�ı���

% ����յ�����
averageDel = averageDel*100;
[row,column] = size(averageDel);
for i = 1:column
    figure(i);
	normplot(averageDel(:,i));
	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
end


%% �������
SystemInfor( );





