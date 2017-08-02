clc;
clear all;

%% ����������� 
load('point1.mat');
load('point2.mat');
load('point3.mat');
load('point4.mat');
load('point5.mat');
load('point6.mat');
load('point7.mat');
load('point8.mat');
load('point9.mat');
load('point10.mat');
load('point11.mat');
load('point12.mat');
load('point13.mat');
load('point14.mat');
load('Plant.mat');
%%  ѡȡ��һ������㣬��������任���Է���ģ��Ҫ�� ������4,8,10,11,14
%point4
[col,row] = size(point2);
p2 = reshape(point2,row*col,1);

%point8
[col,row] = size(point3);
p3 = reshape(point3,row*col,1);

%point10
[col,row] = size(point5);
p5 = reshape(point5,row*col,1);

% %point11
% [col,row] = size(point11);
% p11 = reshape(point11,row*col,1);
% 
% %point14
% [col,row] = size(point14);
% p14 = reshape(point14,row*col,1);

region1 = [p2(7201:17280),p3(23041:33120),p5(23041:33120)];

%% ����Ԥ���������н��봦��
for i=1:3
    Plant(:,i) = smooth(Plant(:,i),5);
end

for i=1:3
    region1(:,i) = smooth(region1(:,i),5);
end

interval = 5;
lev = 3;
% ˮ��ѹ��������ز���
for i = 1:3
    plant(:,i) = wden(Plant(:,i),'heursure','s','mln',lev,'sym8');
    plantPressure(:,i) = downsample(plant(:,i),interval);
end

% ����ѹ��������ز���
for i = 1:3
    pressure(:,i) = wden(region1(:,i),'heursure','s','mln',lev,'sym8');
    region1_5m(:,i) = downsample(pressure(:,i),interval);
end
%%
week = 7*1440/interval;
day = 1440/interval;

%ʹ��3��20��3��26���������ݽ�ģ��Ԥ��3��27��
trainY = region1_5m(2:6*day+1,:);
trainX = plantPressure(1:6*day,1);
test = region1_5m(1+6*day:week,:);

figure
plot(trainX)
%% VARX ģ�ͽ���
nAR = 4;
n = 3;
trainNumber =6*day;

EstExpandX = kron(trainX,eye(n));
EstCellX = mat2cell(EstExpandX,n*ones(trainNumber,1));
nX = size(EstExpandX,2);

Spec = vgxset('n',n,'nAR',nAR,'nX',nX,'Constant',true);
EstSpec = vgxvarx(Spec,trainY,EstCellX);


%% ģ�Ͳ������
a = EstSpec.a;
b = EstSpec.b;
A1 = EstSpec.AR{1,1};
A2 = EstSpec.AR{2,1};
A3 = EstSpec.AR{3,1};
A4 = EstSpec.AR{4,1};

%% ����Ԥ��
forecast = day;

simy  = region1_5m(6*day-nAR+1:week,:)';

output = plantPressure(6*day:week-1,1);
outputX = kron(output,eye(n));
outCellX = mat2cell(outputX,n*ones(day,1));

j= 1;
for i = 1:forecast
   sim(:,i) = A1*simy(:,j+3)+ A2*simy(:,j+2)+ A3*simy(:,j+1)+ A4*simy(:,j) + cell2mat(outCellX(i))*b+ a 
   j = j+1;
end
simY = sim';

%% R ����
%�ܵ����ƽ��TSS
test_num = day;
for i = 1:n
    TSS (i) = var(test(:,i),1)*test_num;
end

% �в�ƽ����ESS
for i = 1:n
    ESS(i) = 0;  
    for j = 1:test_num
        ESS(i) = ESS(i) + (test(j,i)-simY(j,i))^2; 
    end
end

% R����
for i = 1:n
    R(i) = 1-ESS(i)/TSS(i);
end


%% F ���� 
%  RSS�ع�ƽ����
RSS = TSS-ESS;

pointNumber = 3;
p = pointNumber*nAR;
n = test_num;
part1 = RSS/p;
part2 = ESS/(n-p-1);
for i = 1:pointNumber
    F(i) = part1(i)/part2(i);
end


%% ������
error = abs(simY-test);
%MAE
MAE = mae(error);
%������
perror = error./test;
num =test_num;
for i = 1:pointNumber
    tol_perror(i) = 0;
    for j = 1:num
        tol_perror(i) = tol_perror(i)+ perror(j,i);
    end
end
Ave = tol_perror./num;
%% �ж���Χ�ڸ��� 
er = find(perror(:,1)<0.01);
er1 = length(er)/num;
er = find(perror(:,1)<0.02);
er2 = length(er)/num;
er = find(perror(:,1)<0.03);
er3 = length(er)/num;
er = find(perror(:,1)<0.05);
er5 = length(er)/num;
ermax = max(perror(:,1));

figure
plot(simY(:,1))
hold on
plot(test(:,1),'r')
legend('���� Ԥ��ֵ','���� ��ʵֵ');
title('2�Žڵ�');

figure
plot(simY(:,2))
hold on
plot(test(:,2),'r')
legend('���� Ԥ��ֵ','���� ��ʵֵ');
title('3�Žڵ�');

figure
plot(simY(:,3))
hold on
plot(test(:,3),'r')
legend('���� Ԥ��ֵ','���� ��ʵֵ');
title('5�Žڵ�');

% figure
% plot(simY(:,4))
% hold on
% plot(test(:,4),'r')
% legend('���� Ԥ��ֵ','���� ��ʵֵ');
% title('11�Žڵ�');
% 
% 
% figure
% plot(simY(:,5))
% hold on
% plot(test(:,5),'r')
% legend('���� Ԥ��ֵ','���� ��ʵֵ');
% title('14�Žڵ�');






