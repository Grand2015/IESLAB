%% ��̬�ֲ��ۼƸ���
% clear
% x=-4:0.01:4;
% miu=0;sigma=1;
% y1=normpdf(x,miu,sigma);
% y2=normcdf(x,miu,sigma);
% figure(1) 
% subplot 221
% plot(x,y1)
% title('��̬�ֲ��ĸ����ܶ�')
% subplot 222
% plot(x,y2)
% title('��̬�ֲ����ۻ��ֲ�')

 %% point1 ��������
% load('observe4_3.mat');
% t=1:1:1440;
% plot(t,observe4_3(:,1));