%Normal Distribution Test
clc;
clear all;
%% 载入数据
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
    %作差值计算
    for j = 1:monitorNum
        for k = 1:sampleNum-1
            bigDiffMatrix(k,monitorNum*(i-1)+j)  = preSub(k+1,j)-preSub(k,j);
        end
    end       
end

[rowB,columnB] = size(bigDiffMatrix);
for r = 1:columnB
     preSmooth(:,r) = smooth(bigDiffMatrix(:,r));
end

%计算历史数据的平均值和标准差
for i = 1:monitorNum
    for j = 1:sampleNum-1
        temp = [preSmooth(j,i) preSmooth(j,i+monitorNum) preSmooth(j,i+2*monitorNum) preSmooth(j,i+3*monitorNum) preSmooth(j,i+4*monitorNum)];
        average(j,i) = mean(temp);
        standardDeviation(j,i) = std(temp);
    end
end

save average average;
save standardDeviation standardDeviation;
disp('End')
%% 小波降噪，平滑处理(需不需要呢？)
% lev  = 3;
% for i = 1:monitorNum
%     %平滑降噪
%     preSmooth(:,i) = smooth(preDiff(:,i));
%     % 小波降噪
%     preWden(:,i) = wden(preSmooth(:,i),'heursure','s','mln',lev,'sym8');
% end


