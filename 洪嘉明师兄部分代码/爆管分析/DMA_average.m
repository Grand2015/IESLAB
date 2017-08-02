clc;
clear;
%% 取压力
load('Pressure.mat');

%%
pressure1 = Pressure(:,1);
pressure2 = Pressure(:,2);
pressure3 = Pressure(:,3);
pressure4 = Pressure(:,4);
pressure5 = Pressure(:,5);
pressure6 = Pressure(:,6);
pressure7 = Pressure(:,7);
pressure8 = Pressure(:,8);
pressure9 = Pressure(:,9);
pressure10 = Pressure(:,10);
pressure11 = Pressure(:,11);
pressure12 = Pressure(:,12); 
pressure13 = Pressure(:,13);
pressure14 = Pressure(:,14);


point_num = 10;
Pressure_sorted = [pressure3,pressure11,pressure4,pressure13,pressure10,pressure5,pressure8,pressure9,pressure12,pressure14];%7,8,9,10 pressure7,pressure1,pressure6,pressure2,

Pressure = Pressure_sorted(1:36000,:);
for i = 1:point_num
    Pressure(:,i) = smooth(Pressure(:,i),100,'sgolay');
end

%% 
day = 1440;

day1 = Pressure_sorted(1:day,:);
day2 = Pressure_sorted(day+1:2*day,:);
day3 = Pressure_sorted(2*day+1:3*day,:);
day4 = Pressure_sorted(3*day+1:4*day,:);
day5 = Pressure_sorted(4*day+1:5*day,:);
day6 = Pressure_sorted(5*day+1:6*day,:);
day7 = Pressure_sorted(6*day+1:7*day,:);

day8 = Pressure_sorted(7*day+1:8*day,:);
day9 = Pressure_sorted(8*day+1:9*day,:);
day10 = Pressure_sorted(9*day+1:10*day,:);
day11 = Pressure_sorted(10*day+1:11*day,:);
day12 = Pressure_sorted(11*day+1:12*day,:);
day13 = Pressure_sorted(12*day+1:13*day,:);
day14 = Pressure_sorted(13*day+1:14*day,:);

% day15为模拟爆管值
day15 = Pressure_sorted(14*day+1:15*day,:);
for i = 1:10
    day15(:,i) = smooth(day15(:,i),30,'moving');
end

day16 = Pressure_sorted(15*day+1:16*day,:);
for i = 1:10
    day16(:,i) = smooth(day16(:,i),30,'moving');
end

day17 = Pressure_sorted(16*day+1:17*day,:);
for i = 1:10
    day17(:,i) = smooth(day17(:,i),30,'moving');
end

day18 = Pressure_sorted(17*day+1:18*day,:);


day19 = Pressure_sorted(18*day+1:19*day,:);
day20 = Pressure_sorted(19*day+1:20*day,:);
day21 = Pressure_sorted(20*day+1:21*day,:);
day22 = Pressure_sorted(21*day+1:22*day,:);

day23 = Pressure_sorted(22*day+1:23*day,:);
day24 = Pressure_sorted(23*day+1:24*day,:);
day25 = Pressure_sorted(24*day+1:25*day,:);
% day26 = Pressure_sorted(25*day+1:26*day,:);



%% 压力特征值
% 压力平均值
for i = 1:point_num
    Pressure_sum(:,i) = day1(:,i)+day2(:,i)+day3(:,i)+day4(:,i)+day5(:,i)+day6(:,i)+day7(:,i)+day8(:,i)+day9(:,i)+day10(:,i)+day11(:,i)+day12(:,i)+day13(:,i)+day14(:,i);
end
pressure_average = Pressure_sum./14;

for i = 1:point_num
    pressure_average(:,i) = smooth(pressure_average(:,i),30,'moving');
end


% 均方差
pressure_std1 =[ day1(:,1),day2(:,1),day3(:,1),day4(:,1),day5(:,1),day6(:,1),day7(:,1),day8(:,1),day9(:,1),day10(:,1),day11(:,1),day12(:,1),day13(:,1),day14(:,1)]';
pressure_std2 =[ day1(:,2),day2(:,2),day3(:,2),day4(:,2),day5(:,2),day6(:,2),day7(:,2),day8(:,2),day9(:,2),day10(:,2),day11(:,2),day12(:,2),day13(:,2),day14(:,2)]';
pressure_std3 =[ day1(:,3),day2(:,3),day3(:,3),day4(:,3),day5(:,3),day6(:,3),day7(:,3),day8(:,3),day9(:,3),day10(:,3),day11(:,3),day12(:,3),day13(:,3),day14(:,3)]';
pressure_std4 =[ day1(:,4),day2(:,4),day3(:,4),day4(:,4),day5(:,4),day6(:,4),day7(:,4),day8(:,4),day9(:,4),day10(:,4),day11(:,4),day12(:,4),day13(:,4),day14(:,4)]';
pressure_std5 =[ day1(:,5),day2(:,5),day3(:,5),day4(:,5),day5(:,5),day6(:,5),day7(:,5),day8(:,5),day9(:,5),day10(:,5),day11(:,5),day12(:,5),day13(:,5),day14(:,5)]';
pressure_std6 =[ day1(:,6),day2(:,6),day3(:,6),day4(:,6),day5(:,6),day6(:,6),day7(:,6),day8(:,6),day9(:,6),day10(:,6),day11(:,6),day12(:,6),day13(:,6),day14(:,6)]';
pressure_std7 =[ day1(:,7),day2(:,7),day3(:,7),day4(:,7),day5(:,7),day6(:,7),day7(:,7),day8(:,7),day9(:,7),day10(:,7),day11(:,7),day12(:,7),day13(:,7),day14(:,7)]';
pressure_std8 =[ day1(:,8),day2(:,8),day3(:,8),day4(:,8),day5(:,8),day6(:,8),day7(:,8),day8(:,8),day9(:,8),day10(:,8),day11(:,8),day12(:,8),day13(:,8),day14(:,8)]';
pressure_std9 =[ day1(:,9),day2(:,9),day3(:,9),day4(:,9),day5(:,9),day6(:,9),day7(:,9),day8(:,9),day9(:,9),day10(:,9),day11(:,9),day12(:,9),day13(:,9),day14(:,9)]';
pressure_std10 =[ day1(:,10),day2(:,10),day3(:,10),day4(:,10),day5(:,10),day6(:,10),day7(:,10),day8(:,10),day9(:,10),day10(:,10),day11(:,10),day12(:,10),day13(:,10),day14(:,10)]';


std1 = std(pressure_std1,1)';
std2 = std(pressure_std2,1)';
std3 = std(pressure_std3,1)';
std4 = std(pressure_std4,1)';
std5 = std(pressure_std5,1)';
std6 = std(pressure_std6,1)';
std7 = std(pressure_std7,1)';
std8 = std(pressure_std8,1)';
std9 = std(pressure_std9,1)';
std10 = std(pressure_std10,1)';


std  = [std1,std2,std3,std4,std5,std6,std7,std8,std9,std10];

for i = 1:point_num
    for j = 1:1440
        pressure_upline(j,i) = pressure_average(j,i)+2*std(j,i);
    end
     pressure_upline(:,i) = smooth(pressure_upline(:,i),30,'moving');
end


for i = 1:point_num
    for j = 1:1440
        pressure_downline(j,i) = pressure_average(j,i)-2*std(j,i);
    end
     pressure_downline(:,i) = smooth( pressure_downline(:,i),30,'moving');
end

%% 作图
figure
plot(pressure_average(:,2));
hold on 
plot(pressure_upline(:,2),'g');
hold on 
plot(pressure_downline(:,2),'g');
hold on
plot(day15(:,2),'r');
hold on
plot([633,633],[0.27,0.36],'--r');
hold on
plot([644,644],[0.27,0.36],'--r');
title('point2');
% 
% figure
% plot(pressure_average(:,2));
% hold on 
% plot(pressure_upline(:,2),'g');
% hold on 
% plot(pressure_downline(:,2),'g');
% hold on
% plot(pressure_broke(:,2),'r');
% title('舜江路卧龙路');
% 
% figure
% plot(pressure_average(:,3));
% hold on 
% plot(pressure_upline(:,3),'g');
% hold on 
% plot(pressure_downline(:,3),'g');
% hold on
% plot(pressure_broke(:,3),'r');
% title('舜江路人民路口');
% 
% figure
% plot(pressure_average(:,4));
% hold on 
% plot(pressure_upline(:,4),'g');
% hold on 
% plot(pressure_downline(:,4),'g');
% hold on
% plot(pressure_broke(:,4),'r');
% title('延安东路');
% 
% figure
% plot(pressure_average(:,5));
% hold on 
% plot(pressure_upline(:,5),'g');
% hold on 
% plot(pressure_downline(:,5),'g');
% hold on
% plot(pressure_broke(:,5),'r');
% title('舜江路鲁迅路口');
% 
% figure
% plot(pressure_average(:,6));
% hold on 
% plot(pressure_upline(:,6),'g');
% hold on 
% plot(pressure_downline(:,6),'g');
% hold on
% plot(pressure_broke(:,6),'r');
% title('城东体育馆南门');
% 
% figure
% plot(pressure_average(:,7));
% hold on 
% plot(pressure_upline(:,7),'g');
% hold on 
% plot(pressure_downline(:,7),'g');
% hold on
% plot(pressure_broke(:,11),'r');
% title('绍钦印染');
% 
% figure
% plot(pressure_average(:,8));
% hold on 
% plot(pressure_upline(:,8),'g');
% hold on 
% plot(pressure_downline(:,8),'g');
% hold on
% plot(pressure_broke(:,12),'r');
% title('人民东路');
% 
% figure
% plot(pressure_average(:,9));
% hold on 
% plot(pressure_upline(:,9),'g');
% hold on 
% plot(pressure_downline(:,9),'g');
% hold on
% plot(pressure_broke(:,13),'r');
% title('城东基地');
% 
% figure
% plot(pressure_average(:,10));
% hold on 
% plot(pressure_upline(:,10),'g');
% hold on 
% plot(pressure_downline(:,10),'g');
% hold on
% plot(pressure_broke(:,14),'r');
% title('秦望路五泄路');


% k =2;
% h = 2;
% figure
% plot(day1(:,k));
% hold on 
% plot(day2(:,k));
% hold on 
% plot(day3(:,k));
% hold on 
% plot(day4(:,k));
% hold on 
% plot(day5(:,k));
% hold on 
% plot(day6(:,k));
% hold on 
% plot(day7(:,k));
% hold on 
% plot(day8(:,k));
% hold on 
% plot(day9(:,k));
% hold on 
% plot(day10(:,k));
% hold on 
% plot(day11(:,k));
% hold on 
% plot(day12(:,k));
% hold on 
% plot(day13(:,k));
% hold on 
% plot(day14(:,k));
% hold on 
% plot(pressure_broke(:,h),'r');


% subplot(3,4,1)
% plot(day15(:,2));
% hold on
% plot(day16(:,1),'r');
% hold on
% plot(day17(:,1),'g');
% 
% subplot(3,4,2)
% plot(day15(:,2));
% hold on
% plot(day16(:,2),'r');
% hold on
% plot(day17(:,2),'g');
% 
% subplot(3,4,3)
% plot(day15(:,3));
% hold on
% plot(day16(:,3),'r');
% hold on
% plot(day17(:,3),'g');
% 
% subplot(3,4,4)
% plot(day15(:,4));
% hold on
% plot(day16(:,4),'r');
% hold on
% plot(day17(:,4),'g');
% 
% subplot(3,4,5)
% plot(day15(:,5));
% hold on
% plot(day16(:,5),'r');
% hold on
% plot(day17(:,5),'g');
% 
% subplot(3,4,6)
% plot(day15(:,6));
% hold on
% plot(day16(:,6),'r');
% hold on
% plot(day17(:,6),'g');
% 
% subplot(3,4,7)
% plot(day15(:,7));
% hold on
% plot(day16(:,7),'r');
% hold on
% plot(day17(:,7),'g');
% 
% subplot(3,4,8)
% plot(day15(:,8));
% hold on
% plot(day16(:,8),'r');
% hold on
% plot(day17(:,8),'g');
% 
% subplot(3,4,9)
% plot(day15(:,9));
% hold on
% plot(day16(:,9),'r');
% hold on
% plot(day17(:,9),'g');
% 
% subplot(3,4,10)
% plot(day15(:,10));
% hold on
% plot(day16(:,10),'r');
% hold on
% plot(day17(:,10),'g');



