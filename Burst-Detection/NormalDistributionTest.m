%Normal Distribution Test
clc;
clear all;
%% ��������
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%ʵ����hongwei_PC�ļ�·��
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC�ļ�·��
fileName= 'PressureData.xls';
sheetName = [
 '2015-03-20'
 '2015-03-21'
 '2015-03-22'
 '2015-04-04'
 '2015-04-05'
 '2015-04-08'
 '2015-04-09'
 '2015-04-10'
];
Path = [path,fileName];%ʵ����·��

monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
sum = zeros(sampleNum-1,monitorNum);
[row,column] = size(sheetName);
for i = 1:row
    preSub  = xlsread(Path,sheetName(i,:),'C3:P1442');
%     preSub = xlsread(Path,sheetName(4,:),'C3:P1442');
    %����������Ƿ����ȱʡֵ��NaN��
    NaNCount = numel(find(isnan(preSub)));%ĳ��ѹ��������ȱʡ����
    if NaNCount
        for n = 1:monitorNum
            if numel(find(isnan(preSub(:,n))))
                [rowNaN,columnNaN] = find(isnan(preSub(:,n)));
                count = numel(columnNaN);
                for c = 1:count
                    valNum = rowNaN(c,1);%valNum��ѹ��������ÿ�������ȱʡѹ��ֵ��������
                    valNext = valNum+1;
                    while (isnan(preSub(valNext,n)))
                        valNext = valNext+1;
                    end
                    a = 1/(valNext-valNum+1);
                    preSub(valNum,n) = preSub(valNum-1,n)+a*(preSub(valNext,n)-preSub(valNum-1,n));
                end
            end
        end
    end
    %�������Բ�ֵ������
    NaNCountCheck = numel(find(isnan(preSub)));
    if NaNCountCheck
        fprintf('ѹ����������Ȼ����: %d ��ȱʡֵ', NaNCountCheck);
        pause( );
    end
    
    %����ֵ����
%     [rowPre,columnPre] = size(preSub);
    for j = 1:monitorNum
        for k = 1:sampleNum-1
            preDiff(k,j) = preSub(k+1,j)-preSub(k,j);
        end
    end
    sum = sum+preDiff;
%     NaNCountCheckSum = numel(find(isnan(sum)));
    if i==row
        average = sum/row;
    end
end

%% С�����룬ƽ������
lev  = 3;
for i = 1:monitorNum
    %ƽ������
    preSmooth(:,i) = smooth(average(:,i));
    % С������
    preWden(:,i) = wden(preSmooth(:,i),'heursure','s','mln',lev,'sym8');
end
%% У����ɢ�����Ƿ������̬�ֲ�

for i=1:monitorNum
    % ����һ��
%     temp1=observe4_3Wden(:,1);
%     alpha = 0.05;
%     [mu, sigma] = normfit(temp1);
%     p1 = normcdf(temp1, mu, sigma);
%     [H1,s1] = kstest(temp1, [temp1, p1], alpha);
%     if H1 == 0
%         disp('������Դ������̬�ֲ���')
%     else
%         disp('������Դ��������̬�ֲ���')
%     end

    % ��������У�����ο�http://10kn.com/matlab-normality-test/
    [H,P,LSTAT,CV] = lillietest(preWden(:,i),alpha);
    normplot(preWden(:,i));
end

