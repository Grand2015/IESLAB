%����ƽ��ֵ�Ӽ�4.3.2.1��Delta��4��3�����ݽ��жԱ�
%��Ϊ�Ƚ�

clc;
clear all;

%% ��������
%����4��3������
load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
% load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%������ƽ��ֵ�ͱ�׼��
load('average.mat');%14������ѹ����ֵ��ƽ��ֵ
load('standardDeviation.mat');
%% ԭʼ���ݲ�ֵ����
lev  = 3;
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
t = 1:sampleNum-1;
Hg=100;
% multiple = 4;%Delta�ı���
for multiple = 1:4
    for i = 1:monitorNum
        for j = 1:sampleNum-1 
            %����ֵ����
            observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
            upperLimit(j,i) = average(j,i)+multiple*standardDeviation(j,i);
            lowerLimit(j,i) = average(j,i)-multiple*standardDeviation(j,i);
%         if (observe4_3diff(j,i) > upperLimit(j,i)) || (observe4_3diff(j,i) < lowerLimit(j,i))
%             
%         end
        end
        observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
        % С������(û������)
        observe4_3Wden(:,i) = wden(observe4_3diff(:,i),'heursure','s','mln',lev,'sym8');
    end
    figure(multiple);
    plot(t,upperLimit(:,1)*Hg,'-b',t,observe4_3Smooth(:,1)*Hg,'-r',t,lowerLimit(:,1)*Hg,'-b');
    title(['��1���ѹ��������',num2str(multiple),'��Delta']);
end
%% ������ʾ
%1MPaԼ����100mˮ��
Hg=100;
for i = 1:monitorNum
    t = 1:sampleNum-1;
    figure(i);
    plot(t,upperLimit(:,i)*Hg,'-b',t,observe4_3Smooth(:,i)*Hg,'-r',t,lowerLimit(:,i)*Hg,'-b');
    title(['��',num2str(i),'���ѹ��������',num2str(multiple),'��Delta']);
end
disp('End')


% y = downsample(x, n)
% �ӵ�һ�ʼ���ȼ��n��x�������õ������С�Ϊy��

