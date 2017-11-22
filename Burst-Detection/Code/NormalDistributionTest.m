%Normal Distribution Test
%产生赵丹丹方法的拐点程序
clc;
clear all;
%% 载入数据
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%实验室hongwei_PC文件路径
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
sum = zeros(sampleNum,monitorNum);
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
    
    for k=1:monitorNum
        preSmooth(:,k) = smooth(preSub(:,k));
    end
%      preSmooth=preSub;   
    sum = sum+preSmooth;
    if i==row
        average = sum/row;
    end
end

%作差值计算
for j = 1:monitorNum
    for k = 1:sampleNum-1
        preDiff(k,j) = average(k+1,j)-average(k,j);
    end
end

%% 小波降噪，平滑处理
% lev  = 3;
% for i = 1:monitorNum
%     平滑降噪
%     preSmooth(:,i) = smooth(preDiff(:,i));
%     小波降噪
%     preWden(:,i) = wden(preSmooth(:,i),'heursure','s','mln',lev,'sym8');
% end

%% 校验离散数据是否符合正态分布
result = zeros(4,monitorNum);
% header = ['H' 'P' 'I' 'CV']; 
% 
% for m = 1:4
% 	result(m,1)=header(i,:);
% end
alpha=0.05;
for i = 1:monitorNum
    % 方法一：
%     temp=zscore(preDiff(:,1));
%     [mu, sigma] = normfit(temp);
%     p = normcdf(temp, mu, sigma);
%     [H,s] = kstest(temp, [temp, p], alpha);
% %     result(5,i)=s;
%     if H == 0
%         disp('该数据源服从正态分布。')
%     else
%         disp('该数据源不服从正态分布。')
%     end
% 
%     % 方法二，校验结果参考http://10kn.com/matlab-normality-test/
%     
% %     [H,P,LSTAT,CV] = lillietest(preWden(:,i),alpha);
%     [result(1,i),result(2,i),result(3,i),result(4,i)] = lillietest(preDiff(:,i),alpha);
%     
%     figure(1);
% 	subplot(4,4,i);
% 	hist(preDiff(:,i),100);
% 	title(['第',num2str(i),'测点压力变化直方图']);
% 	
% 	figure(2);	
% 	subplot(4,4,i);
% 	normplot(preDiff(:,i));
% 	title(['第',num2str(i),'测点压力变化累计概率']);
    
    figure(i+2);
	normplot(preDiff(:,i))
% 	title(['第',num2str(i),'测点压力变化累计概率']);
    
%     plot(t,BurstTestData(:,2),)
    ylabel('Probabillity')
    xlabel('Delta Pressure')
    set(gca,'linewidth',2);
    set(gca,'FontSize',25);
    
end

