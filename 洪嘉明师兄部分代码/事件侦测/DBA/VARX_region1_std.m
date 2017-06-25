clc;
clear all;
%% ��������
load('Pressure10_smooth.mat');%ƽ��������10��ѹ������, ���ݴ�3��20�տ�ʼ��4��4�գ�һ��15�� ����4��3��ģ�ⱬ��
load('Plant.mat');% ��ˮ��ѹ������Ϊƽˮ����������ϣ���������

%% ��������
interval = 5;   %����Ƶ��
lev = 3;        %�������
week = 7*1440/interval;
day = 1440/interval;

%%  С�����룬���ز���
% ˮ��ѹ��������ز���
for i = 1:3
    plant(:,i) = wden(Plant(:,i),'heursure','s','mln',lev,'sym8');
    plantPressure(:,i) = downsample(plant(:,i),interval);
end

% ����ѹ��������ز���
for i = 1:10
    pressure(:,i) = wden(Pressure10_smooth(:,i),'heursure','s','mln',lev,'sym8');
    pressure5m(:,i) = downsample(pressure(:,i),interval);
end

%% VARX ģ�ͽ���
region1 = [pressure5m(:,1),pressure5m(:,6)];

nAR = 4;
n = 2;
trainNumber =5*day;
plantNumber = 3;
simY1 = [];
for i = 1:10
    frequency = 5;  %����ÿ�ν�ģ���ݼ�� 
    trainY = region1((i-1)*day+2:(frequency+i-1)*day+1,:);
    trainX = plantPressure((i-1)*day+1:(frequency+i-1)*day,plantNumber);
    % �����ⲿ�����ʽ
    EstExpandX = kron(trainX,eye(n));
    EstCellX = mat2cell(EstExpandX,n*ones(trainNumber,1));
    nX = size(EstExpandX,2);
    % ����ģ���������
    Spec = vgxset('n',n,'nAR',nAR,'nX',nX,'Constant',true);
    EstSpec = vgxvarx(Spec,trainY,EstCellX);
    
    % ��ȡģ�Ͳ���
    a = EstSpec.a;
    b = EstSpec.b;
    A1 = EstSpec.AR{1,1};
    A2 = EstSpec.AR{2,1};
    A3 = EstSpec.AR{3,1};
    A4 = EstSpec.AR{4,1};
    
    % ʹ��ģ�ͽ���Ԥ��
    forecast = day;
    simy  = region1((frequency+i-1)*day-nAR+1:(frequency+i)*day,:)';

    output = plantPressure((frequency+i-1)*day:(frequency+i)*day-1,plantNumber);%
    outputX = kron(output,eye(n));
    outCellX = mat2cell(outputX,n*ones(day,1));

    k= 1;
    for j = 1:forecast
       sim(:,j) = A1*simy(:,k+3)+ A2*simy(:,k+2)+ A3*simy(:,k+1)+ A4*simy(:,k) + cell2mat(outCellX(k))*b+ a 
       k = k+1;
    end
    simY1 = [simY1,sim];

    
end
SimY =simY1';

%% �������
Real = region1(frequency*day+1:15*day,:)
diff = Real-SimY;

% ����3
disc_day1 = diff(1:day,:);
disc_day2 = diff(1+1*day:2*day,:);
disc_day3 = diff(1+2*day:3*day,:);
disc_day4 = diff(1+3*day:4*day,:);
disc_day5 = diff(1+4*day:5*day,:);
disc_day6 = diff(1+5*day:6*day,:);
disc_day7 = diff(1+6*day:7*day,:);
disc_day8 = diff(1+7*day:8*day,:);
disc_day9 = diff(1+8*day:9*day,:);
Leak = diff(1+9*day:10*day,:); % ���ܵ���Ԥ�����

for i = 1:2
    disc_mean(:,i) = (disc_day1(:,i)+disc_day2(:,i)+disc_day3(:,i)+disc_day4(:,i)+disc_day5(:,i)+disc_day6(:,i)+disc_day7(:,i)+disc_day8(:,i)+disc_day9(:,i))./9;%ƽ��ֵ
end

%��׼��
k = 1; 
disc_std1 =[ disc_day1(:,k),disc_day2(:,k),disc_day3(:,k),disc_day4(:,k),disc_day5(:,k),disc_day6(:,k),disc_day7(:,k),disc_day8(:,k),disc_day9(:,k)]';
k = 2;
disc_std2 =[ disc_day1(:,k),disc_day2(:,k),disc_day3(:,k),disc_day4(:,k),disc_day5(:,k),disc_day6(:,k),disc_day7(:,k),disc_day8(:,k),disc_day9(:,k)]';


std1 = std(disc_std1,1)';
std2 = std(disc_std2,1)';

std  = [std1,std2];


%% ȷ�����±߽�ֵ
for i = 1:2
    disc_down(:,i) = disc_mean(:,i)-2*std(:,i);
end

for i = 1:2
    disc_up(:,i) = disc_mean(:,i)+2*std(:,i);
end


%% ͳ�Ƴ����߽緶Χ���� 
begin = 0;
for i = 1:2
    k = 0;
    for j = 1:288
        if(disc_down(j,i)-Leak(j,i) > 0)
            begin =1;
        end
        if begin == 1
            if(Leak(j,i)-disc_down(j,i) > 0)
                k = k+1;
                begin = 0;
            end
        end    
    end
    exceedNumber(:,i) = k;
end

%% ͳ��ÿ�γ��������߽�ʱ��ε������ϵ�ÿ��ֵռ��׼��ı���
ptNumber = 2;
diff = 0;
n = 1;
i = 1
begin =0;

    for j = 1:288
        if(disc_down(j,ptNumber)-Leak(j,ptNumber) > 0)
            begin =1;
            diff = disc_down(j,ptNumber)-Leak(j,ptNumber);
            proportion(n,i) = diff/std(j,ptNumber);
            n= n+1;
        end
        if begin == 1
            if(Leak(j,ptNumber)-disc_down(j,ptNumber) > 0)
                begin = 0;
                n = 1;
                i = i+1
            end
        end    
    end

%% ͳ��ÿ������ ���ܵ���ÿ�γ����߽緶Χʱ����ʼʱ��ͽ���ʱ�䣬�Լ�������
%  ����һ��n*3�ľ��󣬴���������� 
%  ��һ�д����ʼʱ��
%  �ڶ��д�Ž���ʱ��
%  �����д��������

begin = 0;
%ptNumber =1;
eventRecord = [];
r = 1;
maxDiff = 0;
firstExceed = 1;
for i = 1:288
    if (disc_down(i,ptNumber)-Leak(i,ptNumber) > 0)
        begin = 1;
        if firstExceed == 1;
            eventRecord(r,1) = i;
            firstExceed =0;
        end
        if(disc_down(i,ptNumber)-Leak(i,ptNumber) > maxDiff)
            maxDiff = disc_down(i,ptNumber)-Leak(i,ptNumber);
        end
    end
    
    if begin == 1
        if(Leak(i,ptNumber)-disc_down(i,ptNumber) > 0)  
            eventRecord(r,2) = i;
            eventRecord(r,3) = maxDiff;
            r = r+1;
            maxDiff = 0;
            begin = 0;;
            firstExceed = 1;
        end
    end
    
end




%% ��ͼ
figure
plot(Leak(:,2))
hold on
plot(disc_down(:,2),':r')
legend('����ֵ','�±߽�');
xlabel('����Ƶ��/5min');
ylabel('ѹ��/Mpa');
grid on
title('No.5����');





