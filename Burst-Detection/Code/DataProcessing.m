%���������ݽ���Ԥ����
%��24������ݽ��д�������4.6��4.15���ݴ�����ʧ�������������ݣ�
%�ֶ�22������ݽ��д���
%��ÿ�����ÿ���ѹ����������һ�������У�Ȼ����з���
%Ȼ���ÿ����㲻ͬʱ������ݽ��д���HJM��������P������ZDD������

%����Ϊ���ݶ�ʧ���
% 20150320 ��������
% 20150321 ��������
% 20150324 ���2���ݴ���ȱʧ
% 20150325 ���2���ݴ���ȱʧ
% 20150326 ���2��6��7���ݴ���ȱʧ
% 20150327 ���2��6��7���ݴ���ȱʧ
% 20150328 ���2��6��7���ݴ���ȱʧ
% 20150329 ���2��6��7���ݴ���ȱʧ
% 20150330 ���2��6��7���ݴ���ȱʧ
% 20150331 ���2��6��7���ݴ���ȱʧ
% 20150401 ���2��6��7���ݴ���ȱʧ
% 20150402 ���2��6��7���ݴ���ȱʧ
% 20150403 ��������
% 20150404 ��������
% 20150405 ��������
% 20150406 ����ȫ����ʧ
% 20150408 ��������
% 20150409 ��������
% 20150410 ��������
% 20150411 ���1���ݴ���ȱʧ
% 20150412 ���1���ݴ���ȱʧ
% 20150413 ���1��11���ݴ���ȱʧ
% 20150414 ���1��11���ݴ���ȱʧ
% 20150415 ����ȫ����ʧ

clc;
clear all;
%% ��������
% path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%ʵ����hongwei_PC�ļ�·��
path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC�ļ�·��
% path = 'C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\';%�Ż�PC·��
fileName= 'PressureDataAll.xls';
sheetNameBurst='20150403';
sheetName = [
 '20150320'
 '20150321'
 '20150324'
 '20150325'
 '20150326'
 '20150327'
 '20150328'
 '20150329'
 '20150330'
 '20150331'
 '20150401'
 '20150402'
 '20150404'
 '20150405'
 '20150408'
 '20150409'
 '20150410'
 '20150411'
 '20150412'
 '20150413'
 '20150414'
];
Path = [path,fileName];%ʵ����·��

monitor    = 0;     %������ѭ������
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
[row,column] = size(sheetName);
%��ȡ����ʵ�鵱��ѹ������
BurstTestData = xlsread(Path,sheetNameBurst,'C3:P1442');

%��ȡ����ʵ��ǰ��ѹ������
for i = 1:row
    preSub = xlsread(Path,sheetName(i,:),'C3:P1442');
	monitor = monitor+1;
	monitor1(:,monitor) = preSub(:,1);
	monitor2(:,monitor) = preSub(:,2);
	monitor3(:,monitor) = preSub(:,3);
	monitor4(:,monitor) = preSub(:,4);
	monitor5(:,monitor) = preSub(:,5);
	monitor6(:,monitor) = preSub(:,6);
	monitor7(:,monitor) = preSub(:,7);
	monitor8(:,monitor) = preSub(:,8);
	monitor9(:,monitor) = preSub(:,9);
	monitor10(:,monitor) = preSub(:,10);
	monitor11(:,monitor) = preSub(:,11);
	monitor12(:,monitor) = preSub(:,12);
	monitor13(:,monitor) = preSub(:,13);
	monitor14(:,monitor) = preSub(:,14);
	
end

%% �Բ�������ȱʡ���ݽ����޳�
%��Ҫ�ǲ��1,2,6,7,11
%monitor1
for i = 21:-1:1
	monitor1(:,i) = [];
end

%monitor2
for i = 12:-1:3
	monitor2(:,i) = [];
end

%monitor6/7
for i = 12:-1:5
	monitor6(:,i) = [];
    monitor7(:,i) = [];
end

%monitor11
monitor11(:,21) = [];
monitor11(:,20) = [];

%ֱ��ͨ���۲�����ֱ�ӽ���������Ϊ��ֵ

%% ��ֵ���� 
%monitor1
monitor1 = LinearInterpolation(monitor1);
save monitor1 monitor1

monitor2 = LinearInterpolation(monitor2);
save monitor2 monitor2

monitor3 = LinearInterpolation(monitor3);
save monitor3 monitor3

monitor4 = LinearInterpolation(monitor4);
save monitor4 monitor4

monitor5 = LinearInterpolation(monitor5);
save monitor5 monitor5

monitor6 = LinearInterpolation(monitor6);
save monitor6 monitor6

monitor7 = LinearInterpolation(monitor7);
save monitor7 monitor7

monitor8 = LinearInterpolation(monitor8);
save monitor8 monitor8

monitor9 = LinearInterpolation(monitor9);
save monitor9 monitor9

monitor10 = LinearInterpolation(monitor10);
save monitor10 monitor10

monitor11 = LinearInterpolation(monitor11);
save monitor11 monitor11

monitor12 = LinearInterpolation(monitor12);
save monitor12 monitor12

monitor13 = LinearInterpolation(monitor13);
save monitor13 monitor13

monitor14 = LinearInterpolation(monitor14);
save monitor14 monitor14

%����ʵ�����ݽ��в�ֵ����
BurstTestData = LinearInterpolation(BurstTestData);
save BurstTestData BurstTestData