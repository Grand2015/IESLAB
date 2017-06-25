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

hour = 60/interval;
windows = 4*hour;

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
day16 = Pressure(15*day+1:16*day,:);

for i = 1:10
    for j = 1:6
        mean_day1(j,i)  = mean(day1((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day2(j,i)  = mean(day2((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day3(j,i)  = mean(day3((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day4(j,i)  = mean(day4((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day5(j,i)  = mean(day5((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day6(j,i)  = mean(day6((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day7(j,i)  = mean(day7((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day8(j,i)  = mean(day8((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day9(j,i)  = mean(day9((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day10(j,i)  = mean(day10((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day11(j,i)  = mean(day11((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day12(j,i)  = mean(day12((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day13(j,i)  = mean(day13((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day14(j,i)  = mean(day14((j-1)*windows+1:j*windows,i));
    end
end

for i = 1:10
    for j = 1:6
        mean_day15(j,i)  = mean(day15((j-1)*windows+1:j*windows,i));
    end
end

trend1 = [mean_day1(:,3),mean_day2(:,3),mean_day3(:,3),mean_day4(:,3),mean_day5(:,3),mean_day6(:,3),mean_day7(:,3),mean_day8(:,3),mean_day9(:,3),mean_day10(:,3),mean_day11(:,3),mean_day12(:,3),mean_day13(:,3),mean_day14(:,3),mean_day15(:,3)];


figure
plot(trend1(3:3,:));






