%  压力数据SPC
%  大论文前最后一版
%  作者：grand
%  时间：2017.11.22
clc;
clear all;
%% 载入数据
load('BurstTestDataSmoothd.mat');%数据均已做平滑处理
load('averaged.mat');
load('standardd.mat');
figure;
plot(averaged(:,4),'LineWidth',2);
% plot(BurstTestDataSmoothd(:,10),'LineWidth',2);
xlabel('采样间隔2分钟')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
% title('100立方米压力曲线');

% for i=1:14
% plot(averaged(:,i));
% hold on;
% end

% load('BurstTestDataDel.mat');%数据均已做平滑处理
% load('averageDel.mat');
% load('standardDel.mat');

% BurstTestDataSmooth = BurstTestDataDel;
% average = averageDel;
% standard = standardDel;

% figure;
% plot(average(:,2),'LineWidth',2);
% % hold on;
% % plot(average(:,9)-8*standard(:,9),'--','LineWidth',2);
% % hold on;
for i=59:61
    BurstTestDataSmoothd(i,14)=nan;
end
BurstTestDataSmoothd(60,14)=0.2653;
BurstTestDataSmoothd = LinearInterpolation(BurstTestDataSmoothd);

for i=299:301
    BurstTestDataSmoothd(i,14)=nan;
end
% BurstTestDataSmoothd(25,14)=0.2823;
% BurstTestDataSmoothd(29,14)=0.28;
BurstTestDataSmoothd(300,14)=0.309;
BurstTestDataSmoothd = LinearInterpolation(BurstTestDataSmoothd);
% 
% for i=185:190
%     BurstTestDataSmoothd(i,14)=nan;
% end
% BurstTestDataSmoothd(187,14)=0.316;
% BurstTestDataSmoothd = LinearInterpolation(BurstTestDataSmoothd);
% 
% for i=199:201
%     BurstTestDataSmoothd(i,14)=nan;
% end
% BurstTestDataSmoothd(200,14)=0.306;
% BurstTestDataSmoothd = LinearInterpolation(BurstTestDataSmoothd);
% 
for i=508:511
    BurstTestDataSmoothd(i,14)=nan;
end
BurstTestDataSmoothd(510,14)=0.3065;
BurstTestDataSmoothd = LinearInterpolation(BurstTestDataSmoothd);


figure;
plot(BurstTestDataSmoothd(:,14),'LineWidth',2);
% hold on;
% plot(average(:,i)-4*standard(:,i),'--','LineWidth',2);
% hold on;
xlabel('采样点/个')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',25);
% legend('实测曲线','4Δ下限');
% title('三个时间段爆管模拟实验');

figure
subplot(2,2,1)
plot(BurstTestDataSmoothd(:,10),'LineWidth',2);
xlabel('采样间隔2分钟')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('100立方米压力曲线');
subplot(2,2,2)
plot(BurstTestDataSmoothd(:,11),'LineWidth',2);
xlabel('采样间隔2分钟')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('200立方米压力曲线');
subplot(2,2,3)
plot(BurstTestDataSmoothd(:,14),'LineWidth',2);
xlabel('采样间隔2分钟')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('300立方米压力曲线');
subplot(2,2,4)
plot(BurstTestDataSmoothd(:,8),'LineWidth',2);
xlabel('采样间隔2分钟')
ylabel('压力/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('500立方米压力曲线');
% set(gca,'XTick',0:300:1500);
% grid on;
% % figure
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
sampleNum  = 144;  %采样点数，即1个/分钟

multiple = 1;%Delta的倍数
step = 8;%连续出现超过step个数据，判断为爆管事件
burstCount = 0;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;

for i = 1:monitorNum
    for j = 1:sampleNum 
        upperLimit(j,i) = averaged(j,i)+multiple*standardd(j,i);
        lowerLimit(j,i) = averaged(j,i)-multiple*standardd(j,i);
     end
end 

for i = 1:monitorNum
    for j = 1:sampleNum
        if(BurstTestDataSmoothd(j,i)<lowerLimit(j,i))
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
        elseif((BurstTestDataSmoothd(j,i)>lowerLimit(j,i)) && (1==flag))
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