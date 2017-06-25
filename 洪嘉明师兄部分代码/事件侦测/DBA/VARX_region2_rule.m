clc;
clear all;
%% 导入数据
load('Pressure10_smooth.mat');%平滑处理后的10个压力监测点, 数据从3月20日开始到4月4日，一共15天 其中4月3日模拟爆管
load('Plant.mat');% 入水口压力依次为平水大道，凤鸣南，凤鸣北；
load('leak.mat')

%% 参数设置
interval = 5;   %采样频率
lev = 3;        %降噪参数
week = 7*1440/interval;
day = 1440/interval;

%% 4月3日爆管当天数据处理
for i = 1:14
    L(:,i)= smooth(leak(:,i),5);
end
for i = 1:14
    ll(:,i) = wden(L(:,i),'heursure','s','mln',lev,'sym8');
    Leak(:,i) = downsample(ll(:,i),interval);
end
%%  小波降噪，并重采样
% 水厂压力降噪后重采样
for i = 1:3
    plant(:,i) = wden(Plant(:,i),'heursure','s','mln',lev,'sym8');
    plantPressure(:,i) = downsample(plant(:,i),interval);
end

% 监测点压力降噪后重采样
for i = 1:10
    pressure(:,i) = wden(Pressure10_smooth(:,i),'heursure','s','mln',lev,'sym8');
    pressure5m(:,i) = downsample(pressure(:,i),interval);
end

%% VARX 模型建立
region1 = [pressure5m(:,4),pressure5m(:,7),pressure5m(:,9)];

nAR = 4;
n = 3;
trainNumber =5*day;
plantNumber = 3;
simY1 = [];
for i = 1:10
    frequency = 5;  %设置每次建模数据间隔 
    trainY = region1((i-1)*day+2:(frequency+i-1)*day+1,:);
    trainX = plantPressure((i-1)*day+1:(frequency+i-1)*day,plantNumber);
    % 设置外部输入格式
    EstExpandX = kron(trainX,eye(n));
    EstCellX = mat2cell(EstExpandX,n*ones(trainNumber,1));
    nX = size(EstExpandX,2);
    % 定义模型输入参数
    Spec = vgxset('n',n,'nAR',nAR,'nX',nX,'Constant',true);
    EstSpec = vgxvarx(Spec,trainY,EstCellX);
    
    % 获取模型参数
    a = EstSpec.a;
    b = EstSpec.b;
    A1 = EstSpec.AR{1,1};
    A2 = EstSpec.AR{2,1};
    A3 = EstSpec.AR{3,1};
    A4 = EstSpec.AR{4,1};
    
    % 使用模型进行预测
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


%% 差异分析
Real = region1(frequency*day+1:15*day,:)
diff = Real-SimY;

% 区域3
disc_day1 = diff(1:day,:);
disc_day2 = diff(1+1*day:2*day,:);
disc_day3 = diff(1+2*day:3*day,:);
disc_day4 = diff(1+3*day:4*day,:);
disc_day5 = diff(1+4*day:5*day,:);
disc_day6 = diff(1+5*day:6*day,:);
disc_day7 = diff(1+6*day:7*day,:);
disc_day8 = diff(1+7*day:8*day,:);
disc_day9 = diff(1+8*day:9*day,:);
Leak = diff(9*day+1:10*day,:) % 爆管当天预测差异

for i = 1:3
    disc_mean(:,i) = (disc_day1(:,i)+disc_day2(:,i)+disc_day3(:,i)+disc_day4(:,i)+disc_day5(:,i)+disc_day6(:,i)+disc_day7(:,i)+disc_day8(:,i)+disc_day9(:,i))./9;%平均值
end

%标准差
k = 1; 
disc_std1 =[ disc_day1(:,k),disc_day2(:,k),disc_day3(:,k),disc_day4(:,k),disc_day5(:,k),disc_day6(:,k),disc_day7(:,k),disc_day8(:,k),disc_day9(:,k)]';
k = 2;
disc_std2 =[ disc_day1(:,k),disc_day2(:,k),disc_day3(:,k),disc_day4(:,k),disc_day5(:,k),disc_day6(:,k),disc_day7(:,k),disc_day8(:,k),disc_day9(:,k)]';
k = 3; 
disc_std3 =[ disc_day1(:,k),disc_day2(:,k),disc_day3(:,k),disc_day4(:,k),disc_day5(:,k),disc_day6(:,k),disc_day7(:,k),disc_day8(:,k),disc_day9(:,k)]';



std1 = std(disc_std1,1)';
std2 = std(disc_std2,1)';
std3 = std(disc_std3,1)';

std  = [std1,std2,std3];



%% 确定每个差异占标准差的比值
difference = Leak - disc_mean;
prop_num = 1;
for i = 1:3
    for j = 1:288
        propotion(prop_num,i) = difference(j,i)/std(j,i);
        prop_num = prop_num+1;
    end
    prop_num = 1;
end

%% 关于编写确定爆管事件发生的规则
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    任何一个时间点超过正负4个标准差
%    连续2个时间点超过正负3个标准差
%    连续4个时间点超过正负2个标准差
%    连续5个时间点超过正负1个标准差
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 point_series = 2;
 event_num = 1;
 % Rule 1
 for i = 1:288
     if propotion(i,point_series) < -4
         event(i,point_series) = propotion(i,point_series);
%          event(event_num,point_series) = i;
%          event_num = event_num + 1;
     elseif propotion(i,point_series) < -3
         k = 1;
         effictive = 1;
         while(k <2)
             if effictive == 1                
                 if propotion(i+k,point_series) < -3
                     effictive = 1;
                 else 
                     effictive = 0;
                     break;
                 end
                 k = k+1;
             end
         end
         if effictive == 1 
             event(i,point_series) = propotion(i,point_series);
%              event(event_num,point_series) = i;
%              event_num = event_num + 1;
         end
        
     elseif propotion(i,point_series) < -2
        k = 1;
         effictive = 1;
         while(k <4)
             if effictive == 1                
                 if propotion(i+k,point_series) < -2
                     effictive = 1;
                 else 
                     effictive = 0;
                     break;
                 end
                 k = k+1;
             end
         end
         if effictive == 1 
             event(i,point_series) = propotion(i,point_series);
%              event(event_num,point_series) = i;
%              event_num = event_num + 1;
         end
     elseif propotion(i,point_series) < -1
         k = 1;
         effictive = 1;
         while(k <8)
             if effictive == 1                
                 if propotion(i+k,point_series) < -1
                     effictive = 1;
                 else 
                     effictive = 0;
                     break;
                 end
                 k = k+1;
             end
         end
         if effictive == 1 
             event(i,point_series) = propotion(i,point_series);
%              event(event_num,point_series) = i;
%              event_num = event_num + 1;
         end
     else
         event(i,point_series) = 0;
     end
 end


y = abs(event);
bar(y(:,2))
xlabel('采样频率/5min');
ylabel('最大误差/Mpa');
title('No.1监测点')

% %% 作图
% figure
% plot(Leak(:,2))
% hold on
% plot(disc_down(:,2),':r')
% legend('差异值','下边界');
% xlabel('采样频率/1min');
% ylabel('压力/Mpa');
% grid on
% title('勾乘路平江路口');






