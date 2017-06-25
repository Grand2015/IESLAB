clc;
clear all;
%% ��������

load('leak.mat');

%% �趨����
lev = 3;
interval =1;

%% 4��3�ձ��ܵ������ݴ���
for i = 1:14
    L(:,i)= smooth(leak(:,i),5);
end
for i = 1:14
    ll(:,i) = wden(L(:,i),'heursure','s','mln',lev,'sym8');
    Leak(:,i) = downsample(ll(:,i),interval);
end

figure
plot(Leak);
legend('����·ƽ��·��','��ɽ·��Խ��ɽ','�ػ��´�','˴��·����·��','�Ƕ�����������','ƽ��·³Ѹ·��','ƽ��·Ϳɽ·��','����ӡȾ','����·','˴��·³Ѹ·��','˴��·����·��','�Ƕ�����','�Ӱ���·','����·��й·��');
xlabel('����Ƶ��/1min');
ylabel('ѹ��/Mpa');
grid on
title('2015��4��3��DMA��14������ѹ��ʱ������');