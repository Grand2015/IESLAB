%  ѹ������SPC
%  ������ǰ���һ��
%  ���ߣ�grand
%  ʱ�䣺2017.11.22
clc;
clear all;
%% ��������
load('BurstTestDataSmoothd.mat');%���ݾ�����ƽ������
load('averaged.mat');
load('standardd.mat');
figure;
plot(averaged(:,4),'LineWidth',2);
% plot(BurstTestDataSmoothd(:,10),'LineWidth',2);
xlabel('�������2����')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
% title('100������ѹ������');

% for i=1:14
% plot(averaged(:,i));
% hold on;
% end

% load('BurstTestDataDel.mat');%���ݾ�����ƽ������
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
xlabel('������/��')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',25);
% legend('ʵ������','4������');
% title('����ʱ��α���ģ��ʵ��');

figure
subplot(2,2,1)
plot(BurstTestDataSmoothd(:,10),'LineWidth',2);
xlabel('�������2����')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('100������ѹ������');
subplot(2,2,2)
plot(BurstTestDataSmoothd(:,11),'LineWidth',2);
xlabel('�������2����')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('200������ѹ������');
subplot(2,2,3)
plot(BurstTestDataSmoothd(:,14),'LineWidth',2);
xlabel('�������2����')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('300������ѹ������');
subplot(2,2,4)
plot(BurstTestDataSmoothd(:,8),'LineWidth',2);
xlabel('�������2����')
ylabel('ѹ��/MPa')
set(gca,'linewidth',2);
set(gca,'FontSize',10);
title('500������ѹ������');
% set(gca,'XTick',0:300:1500);
% grid on;
% % figure
% plot(average(:,7)-0.28,'LineWidth',2);
% figure
% plot(standard(:,6),'LineWidth',2);
% xlabel('����ʱ��/min')
% ylabel('��׼��')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('6�ż���ѹ�����׼������');
% for i=1:14
% figure;
% plot(BurstTestDataSmooth(:,i),'LineWidth',2);
% hold on;
% plot(average(:,i)-4*standard(:,i),'--','LineWidth',2);
% hold on;
% xlabel('����ʱ��/min')
% ylabel('ѹ��/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% legend('ʵ������','4������');
% title([num2str(i),'�ż���ѹ������']);
% % box off;
% end
% plot(average(:,1));
%% ���ݴ���
monitorNum = 14;    %�������
sampleNum  = 144;  %������������1��/����

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
        upperLimit(j,i) = averaged(j,i)+multiple*standardd(j,i);
        lowerLimit(j,i) = averaged(j,i)-multiple*standardd(j,i);
     end
end 

for i = 1:monitorNum
    for j = 1:sampleNum
        if(BurstTestDataSmoothd(j,i)<lowerLimit(j,i))
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