%Normal Distribution Test
clc;
clear all;
%% ��������
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%ʵ ����hongwei_PC�ļ�·��
% path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC�ļ�·��
% path = 'C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\';%�Ż�PC·��
fileName= 'PressureData.xls';
sheetName = [
 '2015-04-04'
 '2015-04-05'
 '2015-04-08'
 '2015-04-09'
 '2015-04-10'
];
Path = [path,fileName];%ʵ����·��

monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
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
    for j = 1:monitorNum
        for k = 1:sampleNum-1
            bigDiffMatrix(k,monitorNum*(i-1)+j)  = preSub(k+1,j)-preSub(k,j);
        end
    end       
end

[rowB,columnB] = size(bigDiffMatrix);
for r = 1:columnB
     preSmooth(:,r) = smooth(bigDiffMatrix(:,r));
end

%������ʷ���ݵ�ƽ��ֵ�ͱ�׼��
for i = 1:monitorNum
    for j = 1:sampleNum-1
        temp = [preSmooth(j,i) preSmooth(j,i+monitorNum) preSmooth(j,i+2*monitorNum) preSmooth(j,i+3*monitorNum) preSmooth(j,i+4*monitorNum)];
        average(j,i) = mean(temp);
        standardDeviation(j,i) = std(temp);
    end
end

save average average;
save standardDeviation standardDeviation;
disp('End')
%% С�����룬ƽ������(�費��Ҫ�أ�)
% lev  = 3;
% for i = 1:monitorNum
%     %ƽ������
%     preSmooth(:,i) = smooth(preDiff(:,i));
%     % С������
%     preWden(:,i) = wden(preSmooth(:,i),'heursure','s','mln',lev,'sym8');
% end


