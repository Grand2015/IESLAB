%% �����Ե����յ�����Ա����ǵĸ�ѹ������о�
clc;
clear all;

%% ����4��3����������
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');
%��λMPa

%����14�����Ĺյ�����
load('CriticalPre');%��λm
%% ԭʼ���ݲ�ֵ����
lev  = 3;
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����

for i = 1:monitorNum
    observe4_3Smooth(:,i) = smooth(observe4_3(:,i));
    %����ֵ����
    for j = 1:sampleNum-1
        observe4_3diff(j,i) = observe4_3Smooth(j+1,i) - observe4_3Smooth(j,i);
    end
    
    % С������
%     observe4_3Wden(:,i) = wden(observe4_3diff(:,i),'heursure','s','mln',lev,'sym8');
end
%1MPaԼ����100mˮ��
%��1�α�������(��ͬ����)

observe4_3diff = observe4_3diff*100;
% CriticalPre = abs(CriticalPre);

%����������
% �ӵ�һ�ʼ���ȼ��n��x�������õ������С�Ϊy��
n=6;
pre4_3Sample = downsample(observe4_3diff, n);
sampleNum=sampleNum/n;

burstCount = 0;
step = 1;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;
%�ж��Ƿ�������
for i = 1:monitorNum
    for j = 1:sampleNum
        if(pre4_3Sample(j,i)<CriticalPre(1,i))
            %�о��ж�����Ƿ������һ�����ݼ�������ȽϺ���
            if(j<sampleNum)
                if(flag==0)
                    burstBegin = j;
                end
                burstEnd = 0;
                flag = 1;
                count = count+1;
            elseif(j==sampleNum)
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
        elseif((pre4_3Sample(j,i)>=CriticalPre(1,i)) && (1==flag))
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


% 
% t=1:1:sampleNum;
% for i = 1:monitorNum
%     figure(i);
% 	plot(t,pre4_3Sample(t,i),'-b',t,CriticalPre(1,i),'.r');
% 	title(['��',num2str(i),'���ѹ���仯']);
% end


disp('End')


