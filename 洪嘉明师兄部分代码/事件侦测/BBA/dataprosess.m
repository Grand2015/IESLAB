clc;
clear all;
%% 导入数据

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
load('leak.mat');

%% 设定参数
lev = 4;
interval =1;
%% 监测点1 降噪预处理 共19天
%平滑做插值处理
for i = 1:19
    p1(:,i) = smooth(point1(:,i),5);
end


for i = 1:19
    point_1(:,i) = wden(p1(:,i),'heursure','s','mln',lev,'sym8');
    Point1(:,i) = downsample(point_1(:,i),interval);
end
point1(isnan(point1)) = 0

point = point1
for i = 1:19
    for j = 1:1440
        if (point1(j,i) == 0)
            line_begin = j;
            k = 1;
            y = j+1;
            while (point1(y,i) == 0)
                y = y+1;
                k = k+1;
            end
            line_end = y;
            diff = (point1(y,i)-point1(j-1,i))/(k+1);
            for l = 1:k
                point1(j,i) = point1(line_begin-1,i)+(l*diff)/(k+1);
                j = j+1;
            end
            j=j-1;
        else
            point1(j,i) = point1(j,i);
        end
    end   
end

for i = 1:19
    poin(:,i) = wden(point1(:,i),'heursure','s','mln',lev,'sym8');
   
end
figure
plot(poin(:,17))
hold on 
plot(point1(:,17),':r')



