clc;
clear all;
%% ��������
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

%% �趨����
lev = 3;
interval =1;

%% 4��3�ձ��ܵ������ݴ���
for i = 1:14
    L(:,i)= smooth(leak(:,i),5);
end
for i = 1:14
    ll(:,i) = wden(L(:,i),'heursure','s','mln',lev,'sym8');
    Leak(:,i) = downsample(ll(:,i),interval);
end

%% ����1�� һ��9��
point1Sum = Point1(:,1);
for j =2:9
    point1Sum =point1Sum+Point1(:,j);
end
point1Average = point1Sum./9;%

%% ����2�� һ��7��
point2Sum = Point2(:,1);
for j =2:7
    point2Sum =point2Sum+Point2(:,j);
end
point2Average = point2Sum./7;%

%% ����3�� һ��10��
point3Sum = Point3(:,1);
for j =2:10
    point3Sum =point3Sum+Point3(:,j);
end
point3Average = point3Sum./10;%

%% ����4�� һ��16��
point4Sum = Point4(:,1);
for j =2:16
    point4Sum =point4Sum+Point4(:,j);
end
point4Average = point4Sum./16;%

%% ����5�� һ��9��
point5Sum = Point5(:,1);
for j =2:9
    point5Sum =point5Sum+Point5(:,j);
end
point5Average = point5Sum./9;%

%% ����6�� һ��7��
point6Sum = Point6(:,1);
for j =2:7
    point6Sum =point6Sum+Point6(:,j);
end
point6Average = point6Sum./7;%

%% ����7�� һ��9��
point7Sum = Point7(:,1);
for j =2:9
    point7Sum =point7Sum+Point7(:,j);
end
point7Average = point7Sum./9;%

%% ����8�� һ��11��
point8Sum = Point8(:,1);
for j =2:11
    point8Sum =point8Sum+Point8(:,j);
end
point8Average = point8Sum./11;%

%% ����9�� һ��12��
point9Sum = Point9(:,1);
for j =2:12
    point9Sum =point9Sum+Point9(:,j);
end
point9Average = point9Sum./12;%

%% ����10�� һ��10��
point10Sum = Point10(:,1);
for j =2:10
    point10Sum =point10Sum+Point10(:,j);
end
point10Average = point10Sum./10;%

%% ����11�� һ��8��
point11Sum = Point11(:,1);
for j =2:8
    point11Sum =point11Sum+Point11(:,j);
end
point11Average = point11Sum./8;%

%% ����12�� һ��13��
point12Sum = Point12(:,1);
for j =2:13
    point12Sum =point12Sum+Point12(:,j);
end
point12Average = point12Sum./13;%

%% ����13�� һ��14��
point13Sum = Point13(:,1);
for j =2:14
    point13Sum =point13Sum+Point13(:,j);
end
point13Average = point13Sum./14;%

%% ����14�� һ��8��
point14Sum = Point14(:,1);
for j =2:8
    point14Sum =point14Sum+Point14(:,j);
end
point14Average = point14Sum./8;%




%% ѹ������ֵ

% ������
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


%% ȷ�����±߽�ֵ
for i = 1:14
    boundary_down(:,i) = pointAverage(:,i)-3*std(:,i);
end

for i = 1:14
    boundary_up(:,i) = pointAverage(:,i)+3*std(:,i);
end

%% ȷ��ÿ������ռ��׼��ı�ֵ
% difference = Leak - pointAverage;
% prop_num = 1;
% for i = 1:14
%     for j = 1:288
%         propotion(prop_num,i) = difference(j,i)/std(j,i);
%         prop_num = prop_num+1;
%     end
%     prop_num = 1;
% end

%% ͳ�Ƴ����߽緶Χ���� 
begin = 0;
for i = 1:14
    k = 0;
    for j = 1:1440
        if(boundary_down(j,i)-Leak(j,i) > 0)
            begin =1;
        end
        if begin == 1
            if(Leak(j,i)-boundary_down(j,i) > 0)
                k = k+1;
                begin = 0;
            end
        end    
    end
    exceedNumber(:,i) = k;
end

%% ͳ��ÿ�γ��������߽�ʱ��ε������ϵ�ÿ��ֵռ��׼��ı���
ptNumber = 14;
diff = 0;
n = 1;
i = 1
begin =0;

    for j = 1:1440
        if(boundary_down(j,ptNumber)-Leak(j,ptNumber) > 0)
            begin =1;
            diff = boundary_down(j,ptNumber)-Leak(j,ptNumber);
            proportion(n,i) = diff/std(j,ptNumber);
            n= n+1;
        end
        if begin == 1
            if(Leak(j,ptNumber)-boundary_down(j,ptNumber) > 0)
                begin = 0;
                n = 1;
                i = i+1
            end
        end    
    end

% % ͳ��ÿ������ ���ܵ���ÿ�γ����߽緶Χʱ����ʼʱ��ͽ���ʱ�䣬�Լ�������
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
for i = 1:1440
    if (boundary_down(i,ptNumber)-Leak(i,ptNumber) > 0)
  
        eventRecord(i,1) = (boundary_down(i,ptNumber)-Leak(i,ptNumber))/std(i,ptNumber);
    end       
    
    if (Leak(i,ptNumber)-boundary_down(i,ptNumber) > 0)
        eventRecord(i,1)=0;
    end
    
end
% begin = 0;
% %ptNumber =1;
% eventRecord = [];
% r = 1;
% maxDiff = 0;
% firstExceed = 1;
% for i = 1:1440
%     if (boundary_down(i,ptNumber)-Leak(i,ptNumber) > 0)
%         begin = 1;
%         if firstExceed == 1;
%             eventRecord(r,1) = i;
%             firstExceed =0;
%         end
%         if(boundary_down(i,ptNumber)-Leak(i,ptNumber) > maxDiff)
%             maxDiff = boundary_down(i,ptNumber)-Leak(i,ptNumber);
%             
%         end
%     end
%         
%     
%     if begin == 1
%         if(Leak(i,ptNumber)-boundary_down(i,ptNumber) > 0)  
%             eventRecord(r,2) = i;
%             eventRecord(r,3) = maxDiff/std(i,ptNumber);
%             r = r+1;
%             maxDiff = 0;
%             begin = 0;;
%             firstExceed = 1;
%         end
%     end
%     
% end
%% ��ͼ
% 
figure
plot(Leak(:,1))
hold on
plot(boundary_down(:,1),':r')
legend('�۲�ֵ','�±߽�');
xlabel('����Ƶ��/1min');
ylabel('ѹ��/Mpa');
grid on
title('No.1����');


% y = abs(eventRecord(:,1));
% 
% bar(y(:,1))
% xlabel('����Ƶ��/1min');
% ylabel('������/Mpa');
% title('No.14����')





