%Normal Distribution Test
clc;
clear all;
%% ��������
path = [
'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\'%ʵ����hongwei_PC�ļ�·��
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

monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
sum = zeros(sampleNum-1,monitorNum);

[row,column] = size(sheetName);
for i = 1:row
    preSub  = xlsread(Path,sheetName(i,:),'C3:P1442');
    %��ȫ����
    %...
    [rowP,columnP] = size(preSub);
    for j = 1:columnP
        for k = 1:rowP-1
            preDiff(k,j) = preSub(k+1,j)-preSub(k,j);
        end
    end
    sum = sum+preDiff;
end


%% ԭʼ���ݲ�ֵ����
lev  = 3;
flag = 1;
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
for i = 1:monitorNum
    %����ֵ����
    for j = 1:sampleNum-1
        observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
    end
    observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
    % С������
    observe4_3Wden(:,i) = wden(observe4_3Smooth(:,i),'heursure','s','mln',lev,'sym8');

end
%% У����ɢ�����Ƿ������̬�ֲ������4��2��ѹ�����У�飩
%����һ��
%temp1=observe4_3Wden(:,1);
%alpha = 0.05;
%[mu, sigma] = normfit(temp1);
% p1 = normcdf(temp1, mu, sigma);
% [H1,s1] = kstest(temp1, [temp1, p1], alpha);
% if H1 == 0
%     disp('������Դ������̬�ֲ���')
% else
%     disp('������Դ��������̬�ֲ���')
% end

%��������У�����ο�http://10kn.com/matlab-normality-test/
%[H,P,LSTAT,CV] = lillietest(temp1,alpha);


