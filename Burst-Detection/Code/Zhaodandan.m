%  赵丹丹方法
%  大论文前最后一版
%  作者：grand
%  时间：2017.11.23
clc;
clear all;
%% 载入数据
load('BurstTestDataDel.mat');
for i = 1:14
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
    figure(i);
	title([num2str(i),'号测点压力变化累计概率']);
    

	normplot(BurstTestDataDel(:,i))
% 	title(['第',num2str(i),'测点压力变化累计概率']);
    
%     plot(t,BurstTestData(:,2),)
    ylabel('Probabillity')
    xlabel('ΔP')
    set(gca,'linewidth',2);
    set(gca,'FontSize',25);
    
end
% figure;
% plot(BurstTestDataDel(:,3),'LineWidth',2);
% xlabel('采样时间/min')
% ylabel('压力差/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('3号监测点关于时间的压力差曲线');
% figure
% plot(BurstTestDataDel(:,5),'LineWidth',2);
% xlabel('采样时间/min')
% ylabel('压力差/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('5号监测点关于时间的压力差曲线');
% figure;
% plot(BurstTestDataDel(:,7),'LineWidth',2);
% xlabel('采样时间/min')
% ylabel('压力差/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('7号监测点关于时间的压力差曲线');
% figure
% plot(BurstTestDataDel(:,9),'LineWidth',2);
% xlabel('采样时间/min')
% ylabel('压力差/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('9号监测点关于时间的压力差曲线');
