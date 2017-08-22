%将HJM方法运用到统一数据上

clc;
clear all;
%% 载入数据
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%实 验室hongwei_PC文件路径
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC文件路径
% path = 'C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\';%张慧PC路径
fileName= 'PressureData.xls';
sheetName = [
 '2015-04-04'
 '2015-04-05'
 '2015-04-08'
 '2015-04-09'
 '2015-04-10'
];
Path = [path,fileName];%实验室路径

monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
[row,column] = size(sheetName);

for i = 1:row
    preSub  = xlsread(Path,sheetName(i,:),'C3:P1442');
%     preSub = xlsread(Path,sheetName(4,:),'C3:P1442');
    %检测数据中是否存在缺省值（NaN）
    NaNCount = numel(find(isnan(preSub)));%某天压力数据中缺省个数
    if NaNCount
        for n = 1:monitorNum
            if numel(find(isnan(preSub(:,n))))
                [rowNaN,columnNaN] = find(isnan(preSub(:,n)));
                count = numel(columnNaN);
                for c = 1:count
                    valNum = rowNaN(c,1);%valNum是压力数据中每个监测点的缺省压力值的纵坐标
                    valNext = valNum+1;
                    while (isnan(preSub(valNext,n)))
                        valNext = valNext+1;
                    end
                    a = 1/(valNext-valNum+1);
                    preSub(valNum,n) = preSub(valNum-1,n)+a*(preSub(valNext,n)-preSub(valNum-1,n));
                end
            end
        end
    end
    %检验线性插值处理结果
    NaNCountCheck = numel(find(isnan(preSub)));
    if NaNCountCheck
        fprintf('压力数据中仍然存在: %d 个缺省值', NaNCountCheck);
        pause( );
    end
    
    %作平滑处理
    for j = 1:monitorNum
        preSmooth(:,j) = smooth(preSub(:,j));
        bigDiffMatrix(:,monitorNum*(i-1)+j) = preSmooth(:,j);
    end       
end

%计算历史数据的平均值和标准差
for i = 1:monitorNum
    for j = 1:sampleNum
        temp = [bigDiffMatrix(j,i) bigDiffMatrix(j,i+monitorNum) bigDiffMatrix(j,i+2*monitorNum) bigDiffMatrix(j,i+3*monitorNum) bigDiffMatrix(j,i+4*monitorNum)];
        average(j,i) = mean(temp);
        standardDeviation(j,i) = std(temp);
    end
end

%对4月3日数据进行处理（插值，平滑）
preSub = observe4_3;
NaNCount = numel(find(isnan(preSub)));%某天压力数据中缺省个数
if NaNCount
    for n = 1:monitorNum
        if numel(find(isnan(preSub(:,n))))
            [rowNaN,columnNaN] = find(isnan(preSub(:,n)));
            count = numel(columnNaN);
            for c = 1:count
                valNum = rowNaN(c,1);%valNum是压力数据中每个监测点的缺省压力值的纵坐标
                valNext = valNum+1;
                while (isnan(preSub(valNext,n)))
                    valNext = valNext+1;
                end
                a = 1/(valNext-valNum+1);
                preSub(valNum,n) = preSub(valNum-1,n)+a*(preSub(valNext,n)-preSub(valNum-1,n));
            end
        end
    end
end
%检验线性插值处理结果
NaNCountCheck = numel(find(isnan(preSub)));
if NaNCountCheck
    fprintf('压力数据中仍然存在: %d 个缺省值', NaNCountCheck);
    pause( );
end
for i = 1:monitorNum
    observe4_3Smooth(:,i) = smooth(preSub(:,i));
end 

multiple = 2;%Delta的倍数
step = 4;%连续出现超过step个数据，判断为爆管事件
burstCount = 0;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;

for i = 1:monitorNum
    for j = 1:sampleNum 
        upperLimit(j,i) = average(j,i)+multiple*standardDeviation(j,i);
        lowerLimit(j,i) = average(j,i)-multiple*standardDeviation(j,i);
     end
end 

for i = 1:monitorNum
    for j = 1:sampleNum
        if(observe4_3Smooth(j,i)<lowerLimit(j,i))
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
        elseif((observe4_3Smooth(j,i)>lowerLimit(j,i)) && (1==flag))
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

% save average average;
% save standardDeviation standardDeviation;
disp('End')











