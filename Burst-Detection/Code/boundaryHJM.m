%��HJM�������õ�ͳһ������

clc;
clear all;
%% ��������
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
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
    
    %��ƽ������
    for j = 1:monitorNum
        preSmooth(:,j) = smooth(preSub(:,j));
        bigDiffMatrix(:,monitorNum*(i-1)+j) = preSmooth(:,j);
    end       
end

%������ʷ���ݵ�ƽ��ֵ�ͱ�׼��
for i = 1:monitorNum
    for j = 1:sampleNum
        temp = [bigDiffMatrix(j,i) bigDiffMatrix(j,i+monitorNum) bigDiffMatrix(j,i+2*monitorNum) bigDiffMatrix(j,i+3*monitorNum) bigDiffMatrix(j,i+4*monitorNum)];
        average(j,i) = mean(temp);
        standardDeviation(j,i) = std(temp);
    end
end

%��4��3�����ݽ��д�����ֵ��ƽ����
preSub = observe4_3;
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
for i = 1:monitorNum
    observe4_3Smooth(:,i) = smooth(preSub(:,i));
end 

multiple = 2;%Delta�ı���
step = 4;%�������ֳ���step�����ݣ��ж�Ϊ�����¼�
burstCount = 0;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;

for i = 1:monitorNum
    for j = 1:sampleNum 
        upperLimit(j,i) = average(j,i)+multiple*standardDeviation(j,i);
        lowerLimit(j,i) = average(j,i)-multiple*standardDeviation(j,i);
     end
end 

for i = 1:monitorNum
    for j = 1:sampleNum
        if(observe4_3Smooth(j,i)<lowerLimit(j,i))
            %�о��ж�����Ƿ������һ�����ݼ�������ȽϺ���
            if(j<sampleNum)
                if(flag==0)
                    burstBegin = j;
                end
                burstEnd = 0;
                flag = 1;
                count = count+1;
            elseif(j==sampleNum)
                if(0==flag)
                    count=1;
                else
                    count=count+1;
                end
                if(count>=step)
                    burstCount = burstCount+1;
                    burstEnd = j;
                    burstTime(i,indexTime) = burstBegin;
                    burstTime(i,indexTime+1) = burstEnd;
                    burstBegin = 0;
                    burstEnd = 0;
                end
                flag = 0;
                count = 0;
            end
        elseif((observe4_3Smooth(j,i)>lowerLimit(j,i)) && (1==flag))
            if(count>=step)
                burstCount = burstCount+1;
                burstEnd = j-1;
                burstTime(i,indexTime) = burstBegin;
                burstTime(i,indexTime+1) = burstEnd;
                indexTime = indexTime+3;
                burstBegin = 0;
                burstEnd = 0;
            end
            flag = 0;
            count = 0;
        end
    end
    burstCountMatrix(1,i) = burstCount;
    burstCount = 0;
    indexTime=1;
end

% save average average;
% save standardDeviation standardDeviation;
disp('End')











