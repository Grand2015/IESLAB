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
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\AllData\';%ʵ��������·��
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
[row,column] = size(monitor1);
% monitor1Smooth = 
for i = 1:column
    monitor1Smooth(:,i) = smooth(monitor1(:,i),5);
end



