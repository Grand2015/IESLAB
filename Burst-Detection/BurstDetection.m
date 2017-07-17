clc;
clear all;

%% 载入4月3日数据数据
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
% load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%% 原始数据插值处理
lev  = 3;
flag = 1;
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
for i = 1:monitorNum
    %作差值处理
    for j = 1:sampleNum-1
        observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
    end
    observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
    % 小波降噪
    observe4_3Wden(:,i) = wden(observe4_3Smooth(:,i),'heursure','s','mln',lev,'sym8');
	
	figure(1);
	subplot(4,4,i);
	hist(observe4_3Wden(:,i),100);
	title(['第',num2str(i),'测点压力变化直方图']);
	
	figure(2);	
	subplot(4,4,i);
	normplot(observe4_3Wden(:,i));
	title(['第',num2str(i),'测点压力变化累计概率']);
    
    figure(i+2);
%     subplot(4,4,1);
% 	hist(observe4_3Wden(:,i),100);
% 	title(['第',num2str(i),'测点压力变化直方图']);
%     subplot(4,4,i);
	normplot(observe4_3Wden(:,i));
	title(['第',num2str(i),'测点压力变化累计概率']);
    
end

%% 校验离散数据是否符合正态分布（针对4月2日压力差的校验）
%方法一：
%temp1=observe4_3Wden(:,1);
%alpha = 0.05;
%[mu, sigma] = normfit(temp1);
% p1 = normcdf(temp1, mu, sigma);
% [H1,s1] = kstest(temp1, [temp1, p1], alpha);
% if H1 == 0
%     disp('该数据源服从正态分布。')
% else
%     disp('该数据源不服从正态分布。')
% end

%方法二，校验结果参考http://10kn.com/matlab-normality-test/
%[H,P,LSTAT,CV] = lillietest(temp1,alpha);

%% 直方图和正态累计概率
%figure(1);
%title('直方图')
%hist(temp1,100);   %作频数直方图 
%figure(2);
%title('分布的正态性检验 ')
%normplot(temp1);  %分布的正态性检验

