%Normal Distribution Test
clc;
clear all;
%% 载入数据
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%实验室hongwei_PC文件路径
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC文件路径
fileName= 'PressureData.xls';
sheetName = [
 '2015-03-20'
 '2015-03-21'
 '2015-03-22'
 '2015-04-04'
 '2015-04-05'
 '2015-04-08'
 '2015-04-09'
 '2015-04-10'
];
Path = [path,fileName];%实验室路径

monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
sum = zeros(sampleNum-1,monitorNum);
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
%     [rowPre,columnPre] = size(preSub);
    for j = 1:monitorNum
        for k = 1:sampleNum-1
            preDiff(k,j) = preSub(k+1,j)-preSub(k,j);
        end
    end
    sum = sum+preDiff;
%     NaNCountCheckSum = numel(find(isnan(sum)));
    if i==row
        average = sum/row;
    end
end

%% 小波降噪，平滑处理
lev  = 3;
for i = 1:monitorNum
    %平滑降噪
    preSmooth(:,i) = smooth(average(:,i));
    % 小波降噪
    preWden(:,i) = wden(preSmooth(:,i),'heursure','s','mln',lev,'sym8');
end
%% 校验离散数据是否符合正态分布

for i=1:monitorNum
    % 方法一：
%     temp1=observe4_3Wden(:,1);
%     alpha = 0.05;
%     [mu, sigma] = normfit(temp1);
%     p1 = normcdf(temp1, mu, sigma);
%     [H1,s1] = kstest(temp1, [temp1, p1], alpha);
%     if H1 == 0
%         disp('该数据源服从正态分布。')
%     else
%         disp('该数据源不服从正态分布。')
%     end

    % 方法二，校验结果参考http://10kn.com/matlab-normality-test/
    [H,P,LSTAT,CV] = lillietest(preWden(:,i),alpha);
    normplot(preWden(:,i));
end

