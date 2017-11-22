%  ѹ������SPC
%  ������ǰ���һ��
%  ���ߣ�grand
%  ʱ�䣺2017.11.22
clc;
clear all;
%% ��������
load('BurstTestDataSmooth.mat');%���ݾ�����ƽ������
load('average.mat');
load('standard.mat');

% figure;
% plot(BurstTestDataSmooth(:,1));
% hold on;
% plot(average(:,1)-4*standard(:,1));
% hold on;
% plot(average(:,1));
%% ���ݴ���
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����

multiple = 1;%Delta�ı���
step = 8;%�������ֳ���step�����ݣ��ж�Ϊ�����¼�
burstCount = 0;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;

for i = 1:monitorNum
    for j = 1:sampleNum 
        upperLimit(j,i) = average(j,i)+multiple*standard(j,i);
        lowerLimit(j,i) = average(j,i)-multiple*standard(j,i);
     end
end 

for i = 1:monitorNum
    for j = 1:sampleNum
        if(BurstTestDataSmooth(j,i)<lowerLimit(j,i))
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
        elseif((BurstTestDataSmooth(j,i)>lowerLimit(j,i)) && (1==flag))
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
% plot(BurstTestDataSmooth)

disp('End')