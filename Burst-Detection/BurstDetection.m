%% 正态分布累计概率
clear
x=-4:0.01:4;
miu=0;sigma=1;
y1=normpdf(x,miu,sigma);
y2=normcdf(x,miu,sigma);
figure(1)
subplot 221
plot(x,y1)
title('正态分布的概率密度')
subplot 222
plot(x,y2)
title('正态分布的累积分布')
