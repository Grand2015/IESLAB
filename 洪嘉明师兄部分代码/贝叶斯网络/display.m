clear all;

load('pro')

x = 1:288
y = 0.59;
bar(pro(:,10))
hold on 
plot(x,y)
xlabel('采样频率/5min');
ylabel('异常事件发生概率值');
title('No.14监测点')