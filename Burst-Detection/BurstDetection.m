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

clc;
clear all;
%% ����4��3����������
load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');    
%% ԭʼ���ݲ�ֵ����
lev = 3;
for i=1:14
observe4_3Smooth(:,i)= smooth(observe4_3(:,i));
%% С������
pre4_3Wden(:,i) = wden(observe4_3Smooth(:,i),'heursure','s','mln',lev,'sym8');
%����һ�е�ƽ��ֵ�ͱ�׼��
observe4_3average(1,i)=mean(pre4_3Wden(:,i));
pre4_3(i,:)=pre4_3Wden(:,i)';
observe4_3std(1,i)=std(pre4_3(i,:),1);
end
%  x=-5:0.01:5;
% hist(pre4_3(:,1),20); hold on;
% a=randn(10000,1); 
[b, x]=hist(pre4_3Wden(:,1),100);
% % b = hist(pre4_3Wden(:,1),1001);
num=numel(pre4_3Wden(:,1));
figure;plot(x,b/num);   %�����ܶ�
c=cumsum(b/num);        %�ۻ��ֲ�
figure; plot(x,c);
% miu=observe4_3average;
% sigma=observe4_3std;
% y1=normpdf(x,miu,sigma);
% y2=normcdf(x,miu,sigma);
% figure(1)  
% subplot 211
% plot(x,y1)
% title('4��3�յ�һ�����ѹ���仯��̬�ֲ��ĸ����ܶ�')
% subplot 212
% plot(x,y2)
% title('4��3�յ�һ�����ѹ���仯��̬�ֲ����ۻ��ֲ�')







