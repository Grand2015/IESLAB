clc
clear all;
%% 获取测压点、水源数据
conn =database('points','root','12345','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/points');
ping(conn);
%% 区域4 、敦煌新村（251）、绍钦印染（437）、城东基地（439）共计3个节点。

%% 读取压力数据
% 敦煌新村（251）
sql1='select v,t from scada where t >=1417968000  and t <=1419177600 and sid = 251';
curs = exec(conn, sql1);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data1=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure1_1 = cell2mat(data1);                  %再把CELL结构转换成MATRIX结构

% 绍钦印染（437）
sql2='select v,t from scada where t >=1417968000  and t <=1419177600 and sid = 437';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure1_2 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

% 城东基地（439）
sql3='select v,t from scada where t >=1417968000  and t <=1419177600  and sid = 439';
curs = exec(conn, sql3);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data3=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure1_3 = cell2mat(data3);                  %再把CELL结构转换成MATRIX结构


%% 爆管
conn =database('points','root','12345','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/points');
ping(conn);

sql4='select * from sheet1';
curs = exec(conn, sql4);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data4=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure4 = cell2mat(data4);                  %再把CELL结构转换成MATRIX结构

Pressure_test = [Pressure4(:,1),Pressure4(:,11),Pressure4(:,13)];

for i = 1:3
    pressure_broke(:,i) = smooth(Pressure_test(:,i),30,'moving');
end

for i = 1:3
    for j = 1:1339
        pressure_broke_diff(j,i) = Pressure_test(j+1,i)-Pressure_test(j,i);
    end
end

lev = 5;
for i = 1:3
    %Broke_diff(:,i) = wden(pressure_broke_diff(:,i),'heursure','s','sln',lev,'sym8');
    Broke_diff(:,i) = smooth(pressure_broke_diff(:,i),30,'moving');
end


%% 数据预处理
t = 1417968000
% 城东基地（439）
[row,col] = size(Pressure1_1);
Pressure2_1(1,:) = Pressure1_1(1,1);
j=1;
for i = 2:row
    n = Pressure1_1(i,2) -(t+j*60);
    n = ceil(n/60);
    m = (Pressure1_1(i,1)-Pressure1_1(i-1,1))/n;
    for k = 1:n
        j=j+1;
        Pressure2_1(j,:) = Pressure1_1(i-1,1) + m*k;
    end
end
  
% 敦煌新村（251）
[row,col] = size(Pressure1_2);
Pressure2_2(1,:) = Pressure1_2(1,1);
j=1;
for i = 2:row
    n = Pressure1_2(i,2) -(t+j*60);
    n = ceil(n/60);
    m = (Pressure1_2(i,1)-Pressure1_2(i-1,1))/n;
    for k = 1:n
        j=j+1;
        Pressure2_2(j,:) = Pressure1_2(i-1,1) + m*k;
    end
end

% 绍钦印染（437）
[row,col] = size(Pressure1_3);
Pressure2_3(1,:) = Pressure1_3(1,1);
j=1;
for i = 2:row
    n = Pressure1_3(i,2) -(t+j*60);
    n = ceil(n/60);
    m = (Pressure1_3(i,1)-Pressure1_3(i-1,1))/n;
    for k = 1:n
        j=j+1;
        Pressure2_3(j,:) = Pressure1_3(i-1,1) + m*k;
    end
end


%% 数据平滑处理
point_num = 3;
interval = 1;
Pressure_1m  = [Pressure2_1,Pressure2_2,Pressure2_3];
% for i=1:point_num
%     Pressure(:,i) = downsample(Pressure_1m(:,i),interval,0);
% end
for i = 1:point_num
    Pressure(:,i) = smooth(Pressure_1m(:,i),30,'moving');
end

week = 1440*7;
day = 1440;

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







%% 第一个星期的压力特征值
% 压力平均值
for i = 1:3
    Pressure_sum(:,i) = day1(:,i)+day2(:,i)+day3(:,i)+day4(:,i)+day5(:,i)+day6(:,i)+day7(:,i)+day8(:,i)+day9(:,i)+day10(:,i)+day11(:,i)+day12(:,i)+day13(:,i)+day14(:,i);
end
pressure_average = Pressure_sum./14;

% 压力平均值差
for i = 1:3
    for j = 1:1339
        pressure_diff(j,i) = pressure_average(j+1,i)-pressure_average(j,i);
    end
end

for i = 1:point_num
    Pressure_diff(:,i) = smooth(pressure_diff(:,i),30,'moving');
end

% 均方差
% day1
for i = 1:3
    for j = 1:1339
        day1_diff(j,i) = day1(j+1,i)-day1(j,i);
    end
    %day1_diff(:,i) = smooth(day1_diff(:,i),30,'moving');
    day1_diff(:,i) = wden(day1_diff(:,i),'heursure','s','sln',lev,'sym8');
end

% day2
for i = 1:3
    for j = 1:1339
        day2_diff(j,i) = day2(j+1,i)-day2(j,i);
    end
    day2_diff(:,i) = wden(day2_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day3
for i = 1:3
    for j = 1:1339
        day3_diff(j,i) = day3(j+1,i)-day3(j,i);
    end
    day3_diff(:,i) = wden(day3_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day4
for i = 1:3
    for j = 1:1339
        day4_diff(j,i) = day4(j+1,i)-day4(j,i);
    end
    day4_diff(:,i) = wden(day4_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day5
for i = 1:3
    for j = 1:1339
        day5_diff(j,i) = day5(j+1,i)-day5(j,i);
    end
    day5_diff(:,i) = wden(day5_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day6
for i = 1:3
    for j = 1:1339
        day6_diff(j,i) = day6(j+1,i)-day6(j,i);
    end
    day6_diff(:,i) = wden(day6_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day7
for i = 1:3
    for j = 1:1339
        day7_diff(j,i) = day7(j+1,i)-day7(j,i);
    end
    day7_diff(:,i) = wden(day7_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day8
for i = 1:3
    for j = 1:1339
        day8_diff(j,i) = day8(j+1,i)-day8(j,i);
    end
    day8_diff(:,i) = wden(day8_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day9
for i = 1:3
    for j = 1:1339
        day9_diff(j,i) = day9(j+1,i)-day9(j,i);
    end
    day9_diff(:,i) = wden(day9_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day10
for i = 1:3
    for j = 1:1339
        day10_diff(j,i) = day10(j+1,i)-day10(j,i);
    end
    day10_diff(:,i) = wden(day10_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day11
for i = 1:3
    for j = 1:1339
        day11_diff(j,i) = day11(j+1,i)-day11(j,i);
    end
    day11_diff(:,i) = wden(day11_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day12
for i = 1:3
    for j = 1:1339
        day12_diff(j,i) = day12(j+1,i)-day12(j,i);
    end
    day12_diff(:,i) = wden(day12_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day13
for i = 1:3
    for j = 1:1339
        day13_diff(j,i) = day13(j+1,i)-day13(j,i);
    end
    day13_diff(:,i) = wden(day13_diff(:,i),'heursure','s','sln',lev,'sym8');
end
% day14
for i = 1:3
    for j = 1:1339
        day14_diff(j,i) = day14(j+1,i)-day14(j,i);
    end
    day14_diff(:,i) = wden(day14_diff(:,i),'heursure','s','sln',lev,'sym8');
end



pressure_std1 =[ day1_diff(:,1),day2_diff(:,1),day3_diff(:,1),day4_diff(:,1),day5_diff(:,1),day6_diff(:,1),day7_diff(:,1),day8_diff(:,1),day9_diff(:,1),day10_diff(:,1),day11_diff(:,1),day12_diff(:,1),day13_diff(:,1),day14_diff(:,1)]';
pressure_std2 =[ day1_diff(:,2),day2_diff(:,2),day3_diff(:,2),day4_diff(:,2),day5_diff(:,2),day6_diff(:,2),day7_diff(:,2),day8_diff(:,2),day9_diff(:,2),day10_diff(:,2),day11_diff(:,2),day12_diff(:,2),day13_diff(:,2),day14_diff(:,2)]';
pressure_std3 =[ day1_diff(:,3),day2_diff(:,3),day3_diff(:,3),day4_diff(:,3),day5_diff(:,3),day6_diff(:,3),day7_diff(:,3),day8_diff(:,3),day9_diff(:,3),day10_diff(:,3),day11_diff(:,3),day12_diff(:,3),day13_diff(:,3),day14_diff(:,3)]';


std1 = std(pressure_std1,1)';
std2 = std(pressure_std2,1)';
std3 = std(pressure_std3,1)';


std  = [std1,std2,std3];

for i = 1:point_num
    for j = 1:1339
        pressure_diff_upline(j,i) = Pressure_diff(j,i)+2*std(j,i);
    end
    %pressure_diff_upline(:,i) = wden(pressure_diff_upline(:,i),'heursure','s','sln',lev,'sym8');
    %pressure_diff_upline(:,i) = smooth(pressure_diff_upline(:,i),30,'moving');
end


for i = 1:point_num
    for j = 1:1339
        pressure_diff_downline(j,i) = Pressure_diff(j,i)-2*std(j,i);
    end
     %pressure_diff_downline(:,i) = wden(pressure_diff_downline(:,i),'heursure','s','sln',lev,'sym8');
     %pressure_diff_downline(:,i) = smooth(pressure_diff_downline(:,i),30,'moving');
end

%% 作图
figure
plot(Pressure_diff(:,1));
hold on 
plot(pressure_diff_upline(:,1),'g');
hold on 
plot(pressure_diff_downline(:,1),'g');
hold on
plot(Broke_diff(:,1),'r');
title('敦煌新村');

figure
plot(Pressure_diff(:,2));
hold on 
plot(pressure_diff_upline(:,2),'g');
hold on 
plot(pressure_diff_downline(:,2),'g');
hold on
plot(Broke_diff(:,2),'r');
title('绍钦印染');

figure
plot(Pressure_diff(:,3));
hold on 
plot(pressure_diff_upline(:,3),'g');
hold on 
plot(pressure_diff_downline(:,3),'g');
hold on
plot(Broke_diff(:,3),'r');
title('城东基地');























