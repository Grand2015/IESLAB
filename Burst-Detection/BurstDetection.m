%% ��̬�ֲ��ۼƸ���
clear
x=-4:0.01:4;
miu=0;sigma=1;
y1=normpdf(x,miu,sigma);
y2=normcdf(x,miu,sigma);
%ǰ�����ܶȣ������Ƿֲ�
y3=normrnd(miu,sigma,1,length(x));
%��˹������
z1=x+4;
z2=sort(y3);
y4=normcdf(z2,miu,sigma);
figure(1)
subplot 221
plot(x,y1)
title('��̬�ֲ��ĸ����ܶ�')
subplot 222
plot(x,y2)
title('��̬�ֲ����ۻ��ֲ�')
