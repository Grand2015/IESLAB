%% 利用赵丹丹拐点问题对爆管是的负压差进行研究
clc;
clear all;

%% 载入4月3日数据数据
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');
%单位MPa

%载入14个测点的拐点数据
load('CriticalPre');%单位m
%% 原始数据插值处理
lev  = 3;
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟

for i = 1:monitorNum
    observe4_3Smooth(:,i) = smooth(observe4_3(:,i));
    %作差值处理
    for j = 1:sampleNum-1
        observe4_3diff(j,i) = observe4_3Smooth(j+1,i) - observe4_3Smooth(j,i);
    end
    
    % 小波降噪
%     observe4_3Wden(:,i) = wden(observe4_3diff(:,i),'heursure','s','mln',lev,'sym8');
end
%1MPa约等于100m水柱
%第1次爆管数据(不同流量)

observe4_3diff = observe4_3diff*100;
% CriticalPre = abs(CriticalPre);

%增大采样间隔
% 从第一项开始，等间隔n对x采样，得到的序列。为y。
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
%判断是否发生爆管
for i = 1:monitorNum
    for j = 1:sampleNum
        if(pre4_3Sample(j,i)<CriticalPre(1,i))
            %感觉判断最后是否是最后一个数据加在这里比较合适
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
% 	title(['第',num2str(i),'测点压力变化']);
% end


disp('End')


