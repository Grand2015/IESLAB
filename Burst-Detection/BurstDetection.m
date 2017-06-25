%% 正态分布累计概率
clear
x=-4:0.01:4;
miu=0;sigma=1;
y1=normpdf(x,miu,sigma);
y2=normcdf(x,miu,sigma);
%前者是密度，后者是分布
y3=normrnd(miu,sigma,1,length(x));
%高斯白噪声
z1=x+4;
z2=sort(y3);
y4=normcdf(z2,miu,sigma);
figure(1)
subplot 221
plot(x,y1)
title('正态分布的概率密度')
subplot 222
plot(x,y2)
title('正态分布的累积分布')
