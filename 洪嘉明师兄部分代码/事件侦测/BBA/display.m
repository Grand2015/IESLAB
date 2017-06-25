clc;
clear all;
%% 导入数据

load('leak.mat');

%% 设定参数
lev = 3;
interval =1;

%% 4月3日爆管当天数据处理
for i = 1:14
    L(:,i)= smooth(leak(:,i),5);
end
for i = 1:14
    ll(:,i) = wden(L(:,i),'heursure','s','mln',lev,'sym8');
    Leak(:,i) = downsample(ll(:,i),interval);
end

figure
plot(Leak);
legend('勾乘路平江路口','东山路古越龙山','敦煌新村','舜江路人民路口','城东体育馆南门','平江路鲁迅路口','平江路涂山路口','绍钦印染','人民东路','舜江路鲁迅路口','舜江路卧龙路口','城东基地','延安东路','秦望路五泄路口');
xlabel('采样频率/1min');
ylabel('压力/Mpa');
grid on
title('2015年4月3日DMA区14个监测点压力时间序列');