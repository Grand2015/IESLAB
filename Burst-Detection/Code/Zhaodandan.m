%  �Ե�������
%  ������ǰ���һ��
%  ���ߣ�grand
%  ʱ�䣺2017.11.23
clc;
clear all;
%% ��������
load('BurstTestDataDel.mat');
for i = 1:14
    % ����һ��
%     temp=zscore(preDiff(:,1));
%     [mu, sigma] = normfit(temp);
%     p = normcdf(temp, mu, sigma);
%     [H,s] = kstest(temp, [temp, p], alpha);
% %     result(5,i)=s;
%     if H == 0
%         disp('������Դ������̬�ֲ���')
%     else
%         disp('������Դ��������̬�ֲ���')
%     end
% 
%     % ��������У�����ο�http://10kn.com/matlab-normality-test/
%     
% %     [H,P,LSTAT,CV] = lillietest(preWden(:,i),alpha);
%     [result(1,i),result(2,i),result(3,i),result(4,i)] = lillietest(preDiff(:,i),alpha);
%     
%     figure(1);
% 	subplot(4,4,i);
% 	hist(preDiff(:,i),100);
% 	title(['��',num2str(i),'���ѹ���仯ֱ��ͼ']);
% 	
% 	figure(2);	
% 	subplot(4,4,i);
% 	normplot(preDiff(:,i));    
    figure(i);
	title([num2str(i),'�Ų��ѹ���仯�ۼƸ���']);
    

	normplot(BurstTestDataDel(:,i))
% 	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
    
%     plot(t,BurstTestData(:,2),)
    ylabel('Probabillity')
    xlabel('��P')
    set(gca,'linewidth',2);
    set(gca,'FontSize',25);
    
end
% figure;
% plot(BurstTestDataDel(:,3),'LineWidth',2);
% xlabel('����ʱ��/min')
% ylabel('ѹ����/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('3�ż������ʱ���ѹ��������');
% figure
% plot(BurstTestDataDel(:,5),'LineWidth',2);
% xlabel('����ʱ��/min')
% ylabel('ѹ����/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('5�ż������ʱ���ѹ��������');
% figure;
% plot(BurstTestDataDel(:,7),'LineWidth',2);
% xlabel('����ʱ��/min')
% ylabel('ѹ����/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('7�ż������ʱ���ѹ��������');
% figure
% plot(BurstTestDataDel(:,9),'LineWidth',2);
% xlabel('����ʱ��/min')
% ylabel('ѹ����/MPa')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% title('9�ż������ʱ���ѹ��������');
