clc;
clear all;
%% 读取数据
load('Pressure10_smooth.mat');

%% 数据预处理
point_num = 10;
interval = 5;

for i=1:point_num
    Pressure(:,i) = downsample(Pressure10_smooth(:,i),interval);
end

% for i=1:point_num
%     Pressure(:,i) = smooth(pressure(:,i),5);
% end

week = 1440*7/interval;
day = 1440/interval;

day1 = Pressure(1:day,:);
day2 = Pressure(day+1:2*day,:);
day3 = Pressure(2*day+1:3*day,:);
day4 = Pressure(3*day+1:4*day,:);
day5 = Pressure(4*day+1:5*day,:);
day6 = Pressure(5*day+1:6*day,:);
day7 = Pressure(6*day+1:7*day,:);
day8 = Pressure(7*day+1:8*day,:);
day9 = Pressure(8*day+1:9*day,:);
day10 = Pressure(9*day+1:10*day,:);
day11 = Pressure(10*day+1:11*day,:);
day12 = Pressure(11*day+1:12*day,:);
day13 = Pressure(12*day+1:13*day,:);
day14 = Pressure(13*day+1:14*day,:);
day15 = Pressure(14*day+1:15*day,:);
day16 = Pressure(14*day+1:15*day,:);


%% VAR 模型建立

%% 区域1
region1 = [Pressure(:,2),Pressure(:,3),Pressure(:,5),Pressure(:,8),Pressure(:,10)];
nAR = 4;
simY1 = [];
for i = 1:8
    train1 = region1((i-1)*day+1:(i+7-1)*day,:);
    Spec1 = vgxset('n',5,'nAR',nAR,'Constant',true);
    [EstSpec1,EstStdErrors1,logL1,W1] = vgxvarx(Spec1,train1); 
    % 获取曲线拟合参数
    a = EstSpec1.a;
    A1 = EstSpec1.AR{1,1};
    A2 = EstSpec1.AR{2,1};
    A3 = EstSpec1.AR{3,1};
    A4 = EstSpec1.AR{4,1};
    %预测
    forecast = day;
    simy = region1((i+7-1)*day-nAR+1:(i+7)*day,:)';
    k = 1;
    for j = 1:forecast
        sim1(:,j) = A1*simy(:,k+3)+ A2*simy(:,k+2)+ A3*simy(:,k+1)+A4*simy(:,k)+a;
        k = k+1;
    end
    simY1 = [simY1,sim1];
end
SimY1 = simY1';



%% 区域2
region2 = [Pressure(:,4),Pressure(:,9),Pressure(:,7)];
nAR = 4;
simY2 = [];
for i = 1:8
    train2 = region2((i-1)*day+1:(i+7-1)*day,:);
    Spec2 = vgxset('n',3,'nAR',nAR,'Constant',true);
    [EstSpec2,EstStdErrors2,logL2,W2] = vgxvarx(Spec2,train2); 
    % 获取曲线拟合参数
    a = EstSpec2.a;
    A1 = EstSpec2.AR{1,1};
    A2 = EstSpec2.AR{2,1};
    A3 = EstSpec2.AR{3,1};
    A4 = EstSpec2.AR{4,1};
    %预测
    forecast = day;
    simy = region2((i+7-1)*day-nAR+1:(i+7)*day,:)';
    k = 1;
    for j = 1:forecast
        sim2(:,j) = A1*simy(:,k+3)+ A2*simy(:,k+2)+ A3*simy(:,k+1)+A4*simy(:,k)+a;
        k = k+1;
    end
    simY2 = [simY2,sim2];
end
SimY2 = simY2';

%% 区域3
region3 = [Pressure(:,1),Pressure(:,6)];
nAR = 4;
simY3 = [];
for i = 1:8
    train3 = region3((i-1)*day+1:(i+7-1)*day,:);
    Spec3 = vgxset('n',2,'nAR',nAR,'Constant',true);
    [EstSpec3,EstStdErrors3,logL3,W3] = vgxvarx(Spec3,train3); 
    % 获取曲线拟合参数
    a = EstSpec3.a;
    A1 = EstSpec3.AR{1,1};
    A2 = EstSpec3.AR{2,1};
    A3 = EstSpec3.AR{3,1};
    A4 = EstSpec3.AR{4,1};
    %预测
    forecast = day;
    simy = region3((i+7-1)*day-nAR+1:(i+7)*day,:)';
    k = 1;
    for j = 1:forecast
        sim3(:,j) = A1*simy(:,k+3)+ A2*simy(:,k+2)+ A3*simy(:,k+1)+A4*simy(:,k)+a;
        k = k+1;
    end
    simY3 = [simY3,sim3];
end
SimY3 = simY3';

%% 差异分析
test1 = region1(7*day+1:15*day,:);
test2 = region2(7*day+1:15*day,:);
test3 = region3(7*day+1:15*day,:);

diff1 = SimY1-test1;
diff2 = SimY2-test2;
diff3 = SimY3-test3;

disc1 = diff1(1:7*day,:);
disc2 = diff2(1:7*day,:);
disc3 = diff3(1:7*day,:);

Test1 = diff1(7*day+1:8*day,:)
Test2 = diff2(7*day+1:8*day,:)
Test3 = diff3(7*day+1:8*day,:)

%% 区域1
disc1_day1 = disc1(1:day,:);
disc1_day2 = disc1(1+day:2*day,:);
disc1_day3 = disc1(1+2*day:3*day,:);
disc1_day4 = disc1(1+3*day:4*day,:);
disc1_day5 = disc1(1+4*day:5*day,:);
disc1_day6 = disc1(1+5*day:6*day,:);
disc1_day7 = disc1(1+6*day:7*day,:);

for i = 1:5
    disc1_mean(:,i) = (disc1_day1(:,i)+disc1_day2(:,i)+disc1_day3(:,i)+disc1_day4(:,i)+disc1_day5(:,i)+disc1_day6(:,i)+disc1_day7(:,i))./7;%平均值
end

%标准差
k = 1; 
disc1_std1 =[ disc1_day1(:,k),disc1_day2(:,k),disc1_day3(:,k),disc1_day4(:,k),disc1_day5(:,k),disc1_day6(:,k),disc1_day7(:,k)]';
k = 2;
disc1_std2 =[ disc1_day1(:,k),disc1_day2(:,k),disc1_day3(:,k),disc1_day4(:,k),disc1_day5(:,k),disc1_day6(:,k),disc1_day7(:,k)]';
k = 3;
disc1_std3 =[ disc1_day1(:,k),disc1_day2(:,k),disc1_day3(:,k),disc1_day4(:,k),disc1_day5(:,k),disc1_day6(:,k),disc1_day7(:,k)]';
k = 4;
disc1_std4 =[ disc1_day1(:,k),disc1_day2(:,k),disc1_day3(:,k),disc1_day4(:,k),disc1_day5(:,k),disc1_day6(:,k),disc1_day7(:,k)]';
k = 5;
disc1_std5 =[ disc1_day1(:,k),disc1_day2(:,k),disc1_day3(:,k),disc1_day4(:,k),disc1_day5(:,k),disc1_day6(:,k),disc1_day7(:,k)]';

std1 = std(disc1_std1,1)';
std2 = std(disc1_std2,1)';
std3 = std(disc1_std3,1)';
std4 = std(disc1_std4,1)';
std5 = std(disc1_std5,1)';
disc1_std  = [std1,std2,std3,std4,std5];

% %% 区域2
% disc2_day1 = disc2(1:day,:);
% disc2_day2 = disc2(1+1*day:2*day,:);
% disc2_day3 = disc2(1+2*day:3*day,:);
% disc2_day4 = disc2(1+3*day:4*day,:);
% disc2_day5 = disc2(1+4*day:5*day,:);
% disc2_day6 = disc2(1+5*day:6*day,:);
% disc2_day7 = disc2(1+6*day:7*day,:);
% 
% for i = 1:3
%     disc2_mean(:,i) = (disc2_day1(:,i)+disc2_day2(:,i)+disc2_day3(:,i)+disc2_day4(:,i)+disc2_day5(:,i)+disc2_day6(:,i)+disc2_day7(:,i))./7;%平均值
% end
% 
% %标准差
% k = 1; 
% disc2_std1 =[ disc2_day1(:,k),disc2_day2(:,k),disc2_day3(:,k),disc2_day4(:,k),disc2_day5(:,k),disc2_day6(:,k),disc2_day7(:,k)]';
% k = 2;
% disc2_std2 =[ disc2_day1(:,k),disc2_day2(:,k),disc2_day3(:,k),disc2_day4(:,k),disc2_day5(:,k),disc2_day6(:,k),disc2_day7(:,k)]';
% k = 3;
% disc2_std3 =[ disc2_day1(:,k),disc2_day2(:,k),disc2_day3(:,k),disc2_day4(:,k),disc2_day5(:,k),disc2_day6(:,k),disc2_day7(:,k)]';
% 
% std1 = std(disc2_std1,1)';
% std2 = std(disc2_std2,1)';
% std3 = std(disc2_std3,1)';
% 
% disc2_std  = [std1,std2,std3];
% %% 区域3
% disc3_day1 = disc3(1:day,:);
% disc3_day2 = disc3(1+1*day:2*day,:);
% disc3_day3 = disc3(1+2*day:3*day,:);
% disc3_day4 = disc3(1+3*day:4*day,:);
% disc3_day5 = disc3(1+4*day:5*day,:);
% disc3_day6 = disc3(1+5*day:6*day,:);
% disc3_day7 = disc3(1+6*day:7*day,:);
% 
% for i = 1:2
%     disc3_mean(:,i) = (disc3_day1(:,i)+disc3_day2(:,i)+disc3_day3(:,i)+disc3_day4(:,i)+disc3_day5(:,i)+disc3_day6(:,i)+disc3_day7(:,i))./7;%平均值
% end
% 
% %标准差
% k = 1; 
% disc3_std1 =[ disc3_day1(:,k),disc3_day2(:,k),disc3_day3(:,k),disc3_day4(:,k),disc3_day5(:,k),disc3_day6(:,k),disc3_day7(:,k)]';
% k = 2;
% disc3_std2 =[ disc3_day1(:,k),disc3_day2(:,k),disc3_day3(:,k),disc3_day4(:,k),disc3_day5(:,k),disc3_day6(:,k),disc3_day7(:,k)]';
% 
% 
% std1 = std(disc3_std1,1)';
% std2 = std(disc3_std2,1)';
% 
% 
% disc3_std  = [std1,std2];

%% 作图
start = 0;
final = 960;

%%

broke1_start = (556-start)/interval;
broke1_end = (569-start)/interval;

broke2_start = (575-start)/interval;
broke2_end = (607-start)/interval;

broke3_start = (633-start)/interval;
broke3_end = (649-start)/interval;

broke4_start = (612-start)/interval;
broke4_end = (628-start)/interval;

broke5_start = (654-start)/interval;
broke5_end = (673-start)/interval;


%区域1  （2,3,5,8,10）
for i = 1:5
    for j =1:day
        disc1_upline(j,i) = disc1_mean(j,i)+2*disc1_std(j,i);
    end
end

for i = 1:5
    for j =1:day
        disc1_downline(j,i) = disc1_mean(j,i)-2*disc1_std(j,i);
    end
end

k =1;
figure  
plot(Test1(:,k),'r');
hold on
plot(disc1_mean(:,k));
hold on
plot(disc1_downline(:,k),'--g')
hold on
plot([broke1_start,broke1_start],[-0.02,0.02],'--r');
hold on
plot([broke1_end,broke1_end],[-0.02,0.02],'--r');
hold on
plot([broke2_start,broke2_start],[-0.02,0.02],'--b');
hold on
plot([broke2_end,broke2_end],[-0.02,0.02],'--b');
hold on
plot([broke3_start,broke3_start],[-0.02,0.02],'--b');
hold on
plot([broke3_end,broke3_end],[-0.02,0.02],'--b');
hold on
plot([broke4_start,broke4_start],[-0.02,0.02],'--r');
hold on
plot([broke4_end,broke4_end],[-0.02,0.02],'--r');
hold on
plot([broke5_start,broke5_start],[-0.02,0.02],'--r');
hold on
plot([broke5_end,broke5_end],[-0.02,0.02],'--r');
grid on
legend('红线 预测当天误差值','蓝线 预测误差均值','虚线 边界值');
title('2号节点');
% %区域2  （4,9,7）
% for i = 1:3
%     for j =1:day
%         disc2_upline(j,i) = disc2_mean(j,i)+2*disc2_std(j,i);
%     end
% end
% 
% for i = 1:3
%     for j =1:day
%         disc2_downline(j,i) = disc2_mean(j,i)-2*disc2_std(j,i);
%     end
% end
% 
% %区域3  （1,6）
% for i = 1:2
%     for j =1:day
%         disc3_upline(j,i) = disc3_mean(j,i)+2*disc3_std(j,i);
%     end
% end
% 
% for i = 1:2
%     for j =1:day
%         disc3_downline(j,i) = disc3_mean(j,i)-2*disc3_std(j,i);
%     end
% end



