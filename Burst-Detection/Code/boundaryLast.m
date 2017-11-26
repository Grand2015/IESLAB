%  压力数据SPC
%  大论文前最后一版
%  作者：grand
%  时间：2017.11.22
clc;
clear all;
%% 载入数据
load('BurstTestDataSmooth.mat');%数据均已做平滑处理
load('average.mat');
load('standard.mat');
load('BurstTestDataDel.mat');%数据均已做平滑处理
load('averageDel.mat');
load('standardDel.mat');

% BurstTestDataSmooth = BurstTestDataDel;
% average = averageDel;
% standard = standardDel;

figure;
plot(average(:,2),'LineWidth',2);
% hold on;
% plot(average(:,9)-8*standard(:,9),'--','LineWidth',2);
% hold on;
% figure
% plot(average(:,6)-0.28,'LineWidth',2);
xlabel('采样时间/min')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',25);
% title('2号监测点压力曲线');
set(gca,'XTick',0:300:1500);
grid on;
% figure
% plot(average(:,7)-0.28,'LineWidth',2);
% figure
% plot(standard(:,6),'LineWidth',2);
% xlabel('采样时间/min')
% ylabel('标准差')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('6号监测点压力差标准差曲线');
% for i=1:14
% figure;
% plot(BurstTestDataSmooth(:,i),'LineWidth',2);
% hold on;
% plot(average(:,i)-4*standard(:,i),'--','LineWidth',2);
% hold on;
% xlabel('采样时间/min')
% ylabel('压力/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% legend('实测曲线','4Δ下限');
% title([num2str(i),'号监测点压力曲线']);
% % box off;
% end
% plot(average(:,1));
%% 数据处理
monitorNum = 14;    %监测点个数
sampleNum  = 1440-1;  %采样点数，即1个/分钟

multiple = 4;%Delta的倍数
step = 2;%连续出现超过step个数据，判断为爆管事件
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