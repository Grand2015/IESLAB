clc;
clear all;
%% ����4��3����������
load('observe4_3.mat');    
%% ԭʼ���ݲ�ֵ����
   observe4_3Smooth(:,1)= smooth(observe4_3(:,1));
%% С������
lev = 3;
   pre4_3(:,1) = wden(observe4_3Smooth(:,1),'heursure','s','mln',lev,'sym8');
%����һ�е�ƽ��ֵ�ͱ�׼��
observe4_3average=mean(pre4_3(:,1));
% observe4_3std=std(pre4_3,0,1);
% observe4_3std=pre4_3(:,1)';
observe4_3std=std(pre4_3(:,1)',1);

%%���һ�е�ƽ��ֵ�ͱ�׼��
% fprintf('��һ�������ƽ��ֵΪ%d',observe4_3average);
% fprintf('��һ������ı�׼��Ϊ%d',observe4_3std);
% 
x=-4:0.01:4;
miu=observe4_3average;
sigma=observe4_3std;
y1=normpdf(x,miu,sigma);
y2=normcdf(x,miu,sigma);
figure(1)  
subplot 221
plot(x,y1)
title('��̬�ֲ��ĸ����ܶ�')
subplot 222
plot(x,y2)
title('��̬�ֲ����ۻ��ֲ�')









