%利用平均值加减4.3.2.1倍Delta与4月3日数据进行对比
%认为比较

clc;
clear all;

%% 载入数据
%载入4月3日数据
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%载入测点平均值和标准差
load('average.mat');%14个测点的压力差值的平均值
load('standardDeviation.mat');
%% 原始数据差值处理
lev  = 3;
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
t = 1:sampleNum-1;
Hg=100;%1MPa约等于100m水柱

multiple = 1;%Delta的倍数
step = 8;%连续出现超过step个数据，判断为爆管事件
burstCount = 0;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;

for i = 1:monitorNum
    observe4_3Smooth(:,i) = smooth(observe4_3(:,i));
    for j = 1:sampleNum-1 
    %作差值处理
        observe4_3diff(j,i) = observe4_3Smooth(j+1,i) - observe4_3Smooth(j,i);
        upperLimit(j,i) = average(j,i)+multiple*standardDeviation(j,i);
        lowerLimit(j,i) = average(j,i)-multiple*standardDeviation(j,i);
     end
end 

for i = 1:monitorNum
    for j = 1:sampleNum-1
        if(observe4_3diff(j,i)<lowerLimit(j,i))
            %感觉判断最后是否是最后一个数据加在这里比较合适
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
% title(['第1测点压力数据与',num2str(multiple),'倍Delta']);
%% 数据显示
for i = 1:monitorNum
    t = 1:sampleNum-1;
    figure(i);
    plot(t,observe4_3diff(:,i)*Hg,'-r',t,lowerLimit(:,i)*Hg,'-b');
%     plot(t,upperLimit(:,i)*Hg,'-b',t,observe4_3diff(:,i)*Hg,'-r',t,lowerLimit(:,i)*Hg,'-b');
    title(['第',num2str(i),'测点压力数据与',num2str(multiple),'倍Delta']);
end
disp('End')


% y = downsample(x, n)
% 从第一项开始，等间隔n对x采样，得到的序列。为y。

