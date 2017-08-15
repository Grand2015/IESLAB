%����ƽ��ֵ�Ӽ�4.3.2.1��Delta��4��3�����ݽ��жԱ�
%��Ϊ�Ƚ�

clc;
clear all;

%% ��������
%����4��3������
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%������ƽ��ֵ�ͱ�׼��
load('average.mat');%14������ѹ����ֵ��ƽ��ֵ
load('standardDeviation.mat');
%% ԭʼ���ݲ�ֵ����
lev  = 3;
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
t = 1:sampleNum-1;
Hg=100;%1MPaԼ����100mˮ��

multiple = 1;%Delta�ı���
step = 8;%�������ֳ���step�����ݣ��ж�Ϊ�����¼�
burstCount = 0;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;

for i = 1:monitorNum
    observe4_3Smooth(:,i) = smooth(observe4_3(:,i));
    for j = 1:sampleNum-1 
    %����ֵ����
        observe4_3diff(j,i) = observe4_3Smooth(j+1,i) - observe4_3Smooth(j,i);
        upperLimit(j,i) = average(j,i)+multiple*standardDeviation(j,i);
        lowerLimit(j,i) = average(j,i)-multiple*standardDeviation(j,i);
     end
end 

for i = 1:monitorNum
    for j = 1:sampleNum-1
        if(observe4_3diff(j,i)<lowerLimit(j,i))
            %�о��ж�����Ƿ������һ�����ݼ�������ȽϺ���
            if(j<sampleNum-1)
                if(flag==0)
                    burstBegin = j;
                end
                burstEnd = 0;
                flag = 1;
                count = count+1;
            elseif(j==sampleNum-1)
                if(0==flag)
                    count=1;
                else
                    count=count+1;
                end
                if(count>=step)
                    burstCount = burstCount+1;
                    burstEnd = j;
                    burstTime(i,indexTime) = burstBegin;
                    burstTime(i,indexTime+1) = burstEnd;
                    burstBegin = 0;
                    burstEnd = 0;
                end
                flag = 0;
                count = 0;
            end
        elseif((observe4_3diff(j,i)>=lowerLimit(j,i)) && (1==flag))
            if(count>=step)
                burstCount = burstCount+1;
                burstEnd = j-1;
                burstTime(i,indexTime) = burstBegin;
                burstTime(i,indexTime+1) = burstEnd;
                indexTime = indexTime+3;
                burstBegin = 0;
                burstEnd = 0;
            end
            flag = 0;
            count = 0;
        end
    end
    burstCountMatrix(1,i) = burstCount;
    burstCount = 0;
    indexTime=1;
end

% figure(multiple);
% plot(t,upperLimit(:,1)*Hg,'-b',t,observe4_3diff(:,1)*Hg,'-r',t,lowerLimit(:,1)*Hg,'-b');
% title(['��1���ѹ��������',num2str(multiple),'��Delta']);
%% ������ʾ
for i = 1:monitorNum
    t = 1:sampleNum-1;
    figure(i);
    plot(t,observe4_3diff(:,i)*Hg,'-r',t,lowerLimit(:,i)*Hg,'-b');
%     plot(t,upperLimit(:,i)*Hg,'-b',t,observe4_3diff(:,i)*Hg,'-r',t,lowerLimit(:,i)*Hg,'-b');
    title(['��',num2str(i),'���ѹ��������',num2str(multiple),'��Delta']);
end
disp('End')


% y = downsample(x, n)
% �ӵ�һ�ʼ���ȼ��n��x�������õ������С�Ϊy��

