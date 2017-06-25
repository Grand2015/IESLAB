clc;
clear all;
%% 导入数据
load('Point1.mat');
load('Point2.mat');
load('Point3.mat');
load('Point4.mat');
load('Point5.mat');
load('Point6.mat');
load('Point7.mat');
load('Point8.mat');
load('Point9.mat');
load('Point10.mat');
load('Point11.mat');
load('Point12.mat');
load('Point13.mat');
load('Point14.mat');
load('leak.mat');

%% 设定参数
lev = 3;
interval =5;

%% 4月3日爆管当天数据处理
for i = 1:14
    L(:,i)= smooth(leak(:,i),5);
end
for i = 1:14
    ll(:,i) = wden(L(:,i),'heursure','s','mln',lev,'sym8');
    Leak(:,i) = downsample(ll(:,i),interval);
end
%% 监测点1号 一共9天
for i = 1:9
    point1(:,i) = downsample(Point1(:,i),interval);
end

point1Sum = point1(:,1);
for j =2:9
    point1Sum =point1Sum+point1(:,j);
end

point1Average = point1Sum./9;%

%% 监测点2号 一共7天
for i = 1:7
    point2(:,i) = downsample(Point2(:,i),interval);
end

point2Sum = point2(:,1);
for j =2:7
    point2Sum =point2Sum+point2(:,j);
end

point2Average = point2Sum./7;%

%% 监测点3号 一共10天
for i = 1:10
    point3(:,i) = downsample(Point3(:,i),interval);
end

point3Sum = point3(:,1);
for j =2:10
    point3Sum =point3Sum+point3(:,j);
end

point3Average = point3Sum./10;%

%% 监测点4号 一共16天
for i = 1:16
    point4(:,i) = downsample(Point4(:,i),interval);
end

point4Sum = point4(:,1);
for j =2:16
    point4Sum =point4Sum+point4(:,j);
end

point4Average = point4Sum./16;%


%% 监测点5号 一共9天
for i = 1:9
    point5(:,i) = downsample(Point5(:,i),interval);
end

point5Sum = point5(:,1);
for j =2:9
    point5Sum =point5Sum+point5(:,j);
end

point5Average = point5Sum./9;%


%% 监测点6号 一共7天
for i = 1:7
    point6(:,i) = downsample(Point6(:,i),interval);
end

point6Sum = point6(:,1);
for j =2:7
    point6Sum =point6Sum+point6(:,j);
end

point6Average = point6Sum./7;%


%% 监测点7号 一共9天
for i = 1:9
    point7(:,i) = downsample(Point7(:,i),interval);
end

point7Sum = point7(:,1);
for j =2:9
    point7Sum =point7Sum+point7(:,j);
end

point7Average = point7Sum./9;%


%% 监测点8号 一共11天
for i = 1:11
    point8(:,i) = downsample(Point8(:,i),interval);
end

point8Sum = point8(:,1);
for j =2:11
    point8Sum =point8Sum+point8(:,j);
end

point8Average = point8Sum./11;%


%% 监测点9号 一共12天
for i = 1:12
    point9(:,i) = downsample(Point9(:,i),interval);
end

point9Sum = point9(:,1);
for j =2:12
    point9Sum =point9Sum+point9(:,j);
end

point9Average = point9Sum./12;%


%% 监测点10号 一共10天
for i = 1:10
    point10(:,i) = downsample(Point10(:,i),interval);
end

point10Sum = point10(:,1);
for j =2:10
    point10Sum =point10Sum+point10(:,j);
end

point10Average = point10Sum./10;%


%% 监测点11号 一共8天
for i = 1:8
    point11(:,i) = downsample(Point11(:,i),interval);
end

point11Sum = point11(:,1);
for j =2:8
    point11Sum =point11Sum+point11(:,j);
end

point11Average = point11Sum./8;%


%% 监测点12号 一共13天
for i = 1:13
    point12(:,i) = downsample(Point12(:,i),interval);
end

point12Sum = point12(:,1);
for j =2:13
    point12Sum =point12Sum+point12(:,j);
end

point12Average = point12Sum./13;%

%% 监测点13号 一共14天
for i = 1:14
    point13(:,i) = downsample(Point13(:,i),interval);
end

point13Sum = point13(:,1);
for j =2:14
    point13Sum =point13Sum+point13(:,j);
end

point13Average = point13Sum./14;%

%% 监测点14号 一共8天
for i = 1:8
    point14(:,i) = downsample(Point14(:,i),interval);
end

point14Sum = point14(:,1);
for j =2:8
    point14Sum =point14Sum+point14(:,j);
end

point14Average = point14Sum./8;%


%% 压力特征值

% 均方差
point_std1 =point1';
point_std2 =point2';
point_std3 =point3';
point_std4 =point4';
point_std5 =point5';
point_std6 =point6';
point_std7 =point7';
point_std8 =point8';
point_std9 =point9';
point_std10 =point10';
point_std11 =point11';
point_std12 =point12';
point_std13 =point13';
point_std14 =point14';

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


%% 确定每个差异占标准差的比值
difference = Leak - pointAverage;
prop_num = 1;
for i = 1:14
    for j = 1:288
        propotion(prop_num,i) = difference(j,i)/std(j,i);
        prop_num = prop_num+1;
    end
    prop_num = 1;
end
%% 关于编写确定爆管事件发生的规则
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    任何一个时间点超过正负4个标准差
%    连续2个时间点超过正负3个标准差
%    连续4个时间点超过正负2个标准差
%    连续5个时间点超过正负1个标准差
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for  point_series =1:14
     event_num = 1;
     % Rule 1
     for i = 1:288
         if propotion(i,point_series) < -4
             event(i,point_series) = propotion(i,point_series);
             %event(event_num,point_series) = i;
             %event_num = event_num + 1;
         elseif propotion(i,point_series) < -3
             k = 1;
             effictive = 1;
             while(k <2)
                  if effictive == 1  
                      if (i+k) <288
                          if propotion(i+k,point_series) < -3
                              effictive = 1;
                          else 
                              effictive = 0;
                              break;
                          end
                      end
                      k = k+1;
                  end
             end
             if effictive == 1 
                 event(i,point_series) = propotion(i,point_series);
                 %event(event_num,point_series) = i;
                 %event_num = event_num + 1;
             end

         elseif propotion(i,point_series) < -2
            k = 1;
             effictive = 1;
             while(k <4)             
                     if effictive == 1    
                         if (i+k)<288           
                             if propotion(i+k,point_series) < -2
                                 effictive = 1;
                             else 
                                 effictive = 0;
                                 break;
                             end
                         end
                         k = k+1;
                     end
             end
             if effictive == 1 
                 event(i,point_series) = propotion(i,point_series);
                 %event(event_num,point_series) = i;
                 %event_num = event_num + 1;
             end
         elseif propotion(i,point_series) < -1
             k = 1;
             effictive = 1;
             while(k <5)
                     if effictive == 1      
                         if (i+k)<288
                             if propotion(i+k,point_series) < -1
                                 effictive = 1;
                             else 
                                 effictive = 0;
                                 break;
                             end
                         end
                         k = k+1;
                     end
             end
             if effictive == 1 
                 event(i,point_series) = propotion(i,point_series);
                 %event(event_num,point_series) = i;
                 %event_num = event_num + 1;
             end

         end
     end
end

y = abs(event);

bar(y(:,1))
xlabel('采样频率/1min');
ylabel('最大误差/Mpa');
title('绍钦印染')
