%% 利用赵丹丹拐点问题对爆管是的负压差进行研究
clc;
clear all;

%% 载入4月3日数据数据
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');
%单位MPa

%载入14个测点的拐点数据
load('CriticalPre');%单位m，数据平滑处理得出的拐点
%% 原始数据插值处理
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟

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





lev  = 3;

for i = 1:monitorNum
    observe4_3Smooth(:,i) = smooth(preSub(:,i));
    %作差值处理
    for j = 1:sampleNum-1
%         observe4_3diff(j,i) = preSub(j+1,i) - preSub(j,i);
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
n=1;
pre4_3Sample = downsample(observe4_3diff, n);
if(n==1)
    sampleNum=sampleNum-1;
else
    sampleNum=sampleNum/n;
end

burstCount = 0;
step = 5;%连续的几个点
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
        elseif((pre4_3Sample(j,i)>CriticalPre(1,i)) && (1==flag))
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


