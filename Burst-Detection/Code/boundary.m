%对洪嘉明师兄代码优化，主要考虑增大采样频率，在保证准确爆管
%的前提下，降低误报率
clc;
clear all;
%% 载入数据
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\BoundaryTestData\';
fileName= 'point';
suffix='.mat';
for i = 1:monitorNum
    Path = [path,fileName,num2str(i),suffix];%实验室路径
    load(Path);
end
%载入4月3日爆管实验数据
day43='leak.mat';
Path = [path,day43];
load(Path);
%%
for i = 1:19
    Point1(:,i) = smooth(point1(:,i),5);
end
%
point1Sum = Point1(:,1);
for j =2:19
    point1Sum = point1Sum+Point1(:,j);
end
point1Average = point1Sum./19;%

%%
for i = 1:12
    Point2(:,i) = smooth(point2(:,i),5);
end
%
point2Sum = Point2(:,1);
for j =2:12
    point2Sum = point2Sum+Point2(:,j);
end
point2Average = point2Sum./12;%

%%
for i = 1:23
    Point3(:,i) = smooth(point3(:,i),5);
end
%
point3Sum = Point3(:,1);
for j =2:23
    point3Sum = point3Sum+Point3(:,j);
end
point3Average = point3Sum./23;%

%%
for i = 1:23
    Point4(:,i) = smooth(point4(:,i),5);
end
%
point4Sum = Point4(:,1);
for j =2:23
    point4Sum = point4Sum+Point4(:,j);
end
point4Average = point4Sum./23;

%%
for i = 1:23
    Point5(:,i) = smooth(point5(:,i),5);
end
%
point5Sum = Point5(:,1);
for j =2:23
    point5Sum = point5Sum+Point5(:,j);
end
point5Average = point5Sum./23;%

%%
for i = 1:9
    Point6(:,i) = smooth(point6(:,i),5);
end
%
point6Sum = Point6(:,1);
for j =2:9
    point6Sum = point6Sum+Point6(:,j);
end
point6Average = point6Sum./9;%

%%
for i = 1:15
    Point7(:,i) = smooth(point7(:,i),5);
end
%
point7Sum = Point7(:,1);
for j =2:15
    point7Sum = point7Sum+Point7(:,j);
end
point7Average = point7Sum./15;%

%%
for i = 1:23
    Point8(:,i) = smooth(point8(:,i),5);
end
%
point8Sum = Point8(:,1);
for j =2:23
    point8Sum =point8Sum+Point8(:,j);
end
point8Average = point8Sum./23;%

%%
for i = 1:20
    Point9(:,i) = smooth(point9(:,i),5);
end
%
point9Sum = Point9(:,1);
for j =2:20
    point9Sum = point9Sum+Point9(:,j);
end
point9Average = point9Sum./20;%

%%
for i = 1:23
    Point10(:,i) = smooth(point10(:,i),5);
end
%
point10Sum = Point10(:,1);
for j =2:23
    point10Sum = point10Sum+Point10(:,j);
end
point10Average = point10Sum./23;%

%%
for i = 1:21
    Point11(:,i) = smooth(point11(:,i),5);
end
%
point11Sum = Point11(:,1);
for j =2:21
    point11Sum = point11Sum+Point11(:,j);
end
point11Average = point11Sum./21;%

%%
for i = 1:23
    Point12(:,i) = smooth(point12(:,i),5);
end
%
point12Sum = Point12(:,1);
for j =2:23
    point12Sum = point12Sum+Point12(:,j);
end
point12Average = point12Sum./23;%

%%
for i = 1:23
    Point13(:,i) = smooth(point13(:,i),5);
end
%
point13Sum = Point13(:,1);
for j =2:23
    point13Sum = point13Sum+Point13(:,j);
end
point13Average = point13Sum./23;%

%%
for i = 1:23
    Point14(:,i) = smooth(point14(:,i),5);
end
%
point14Sum = Point14(:,1);
for j =2:23
    point14Sum =point14Sum+Point14(:,j);
end
point14Average = point14Sum./23;%

%% 压力特征值

% 均方差
point_std1 =Point1';
point_std2 =Point2';
point_std3 =Point3';
point_std4 =Point4';
point_std5 =Point5';
point_std6 =Point6';
point_std7 =Point7';
point_std8 =Point8';
point_std9 =Point9';
point_std10 =Point10';
point_std11 =Point11';
point_std12 =Point12';
point_std13 =Point13';
point_std14 =Point14';

std1 = std(point_std1,1)';
std2 = std(point_std2,1)';
std3 = std(point_std3,1)';
std4 = std(point_std4,1)';
std5 = std(point_std5,1)';
std6 = std(point_std6,1)';
std7 = std(point_std7,1)';
std8 = std(point_std8,1)';
std9 = std(point_std9,1)';
std10 = std(point_std10,1)';
std11 = std(point_std11,1)';
std12 = std(point_std12,1)';
std13 = std(point_std13,1)';
std14 = std(point_std14,1)';


std  = [std1,std2,std3,std4,std5,std6,std7,std8,std9,std10,std11,std12,std13,std14];
pointAverage = [point1Average,point2Average,point3Average,point4Average,point5Average,point6Average,point7Average,point8Average,point9Average,point10Average,point11Average,point12Average,point13Average,point14Average];

sumStd = 0;
for i = 1:14
    for j =1:1440
        sumStd = sumStd +std(j,i);
    end
end
averageStd = sumStd/(1440*14);
%% 确定上下边界值
for i = 1:14
    boundary_down(:,i) = pointAverage(:,i)-2*std(:,i);
end

for i = 1:14
    boundary_up(:,i) = pointAverage(:,i)+2*std(:,i);
end

for i = 1:14
    Leak(:,i) = smooth(leak(:,i),5);
end
start = 0;
final = 960;

%% 统计超出边界范围次数
% boundary——down leak 
begin = 0;
finish = 0;
for i = 1:14
    k = 0;
    for j = 1:1440
        if(boundary_down(j,i)-Leak(j,i) > 0)
            begin =1;
        end
        if begin == 1
            if(Leak(j,i)-boundary_down(j,i) > 0)
            	finish = 1;
                k = k+1;
                begin = 0;
                finish = 0;  
            end
        end    
    end
    time(:,i) = k;
end
%% 统计每个监测点 爆管当天每次超出边界范围时的起始时间和结束时间，以此最大误差
begin = 0;
finish = 1;
point =13;
table = [];
max = 0;
h = 1;
first = 0;
for i = 1:1440

        if(boundary_down(i,point)-Leak(i,point) > 0)
            begin =1;
            
            value = 0;
            if first == 0           
                table(h,1) = i;
                first = 1;
            end
            value = boundary_down(i,point)-Leak(i,point)
            if (value > max)
                max = value;
            end  
        end

    if begin == 1
        if(Leak(i,point)-boundary_down(i,point) > 0)            
            table(h,2) = i;
            begin = 0;
            
            first = 0;
            table(h,3) = max;
            max = 0;
            h = h+1;
        end
    end          
end
%作图
interval = 1;
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

%
k =13;
figure
plot(pointAverage(:,k));
hold on
plot(Leak(:,k),'r');
hold on
plot(boundary_up(:,k),'--g');
hold on
plot(boundary_down(:,k),'--g');
hold on
plot([broke1_start,broke1_start],[0.31,0.34],'--r');
hold on
plot([broke1_end,broke1_end],[0.31,0.34],'--r');
hold on
plot([broke2_start,broke2_start],[0.31,0.34],'--b');
hold on
plot([broke2_end,broke2_end],[0.31,0.34],'--b');
hold on
plot([broke3_start,broke3_start],[0.31,0.34],'b');
hold on
plot([broke3_end,broke3_end],[0.31,0.34],'b');
hold on
plot([broke4_start,broke4_start],[0.31,0.34],'--r');
hold on
plot([broke4_end,broke4_end],[0.31,0.34],'--r');
hold on
plot([broke5_start,broke5_start],[0.31,0.34],'--r');
hold on
plot([broke5_end,broke5_end],[0.31,0.34],'--r');
grid on
legend('蓝线 平均值','红线 真实值','虚线 边界');
title('8号节点');
