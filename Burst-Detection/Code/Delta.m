%����ƽ��ֵ�Ӽ�4.3.2.1��Delta��4��3�����ݽ��жԱ�

clc;
clear all;

%% ��������
%����4��3������
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%������ƽ��ֵ�ͱ�׼��
load('average.mat');
load('standardDeviation.mat');
%% ԭʼ���ݲ�ֵ����
lev  = 3;
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
multiple = 4;%Delta�ı���
for i = 1:monitorNum
    for j = 1:sampleNum-1
        %����ֵ����
        observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
        upperLimit(j,i) = average(j,i)+multiple*standardDeviation(j,i);
        lowerLimit(j,i) = average(j,i)-multiple*standardDeviation(j,i);
    end
    observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
    % С������(û������)
    observe4_3Wden(:,i) = wden(observe4_3diff(:,i),'heursure','s','mln',lev,'sym8');
end

%% ������ʾ
for i = 1:monitorNum
    %1MPaԼ����100mˮ��
    t = 1:sampleNum-1;
    figure(i);
    plot(t,upperLimit(:,i),'-b',t,observe4_3Smooth(:,i),'-r',t,lowerLimit(:,i),'-b');
    title(['��',num2str(i),'���ѹ��������',num2str(multiple),'��Delta']);
end
disp('End')


% y = downsample(x, n)
% �ӵ�һ�ʼ���ȼ��n��x�������õ������С�Ϊy��

