%Normal Distribution Test
clc;
clear all;
%% 载入数据
path = [
'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\'%实验室hongwei_PC文件路径
''
''
];
fileName= 'PressureData.xls';
sheetName = [
 '2015-03-20'
 '2015-03-21'
 '2015-03-22' 
 '2015-03-23'
 '2015-04-04'
 '2015-04-05'
 '2015-04-08'
 '2015-04-09'
 '2015-04-10'
];
Path = [path(1,:),fileName];

monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟
sum = zeros(sampleNum-1,monitorNum);

[row,column] = size(sheetName);
for i = 1:row
    preSub  = xlsread(Path,sheetName(i,:),'C3:P1442');
    %不全数据
    %...
    [rowP,columnP] = size(preSub);
    for j = 1:columnP
        for k = 1:rowP-1
            preDiff(k,j) = preSub(k+1,j)-preSub(k,j);
        end
    end
    sum = sum+preDiff;
end


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


