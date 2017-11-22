%Normal Distribution Test
%�����Ե��������Ĺյ����
clc;
clear all;
%% ��������
path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%ʵ����hongwei_PC�ļ�·��
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
sum = zeros(sampleNum,monitorNum);
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
    
    for k=1:monitorNum
        preSmooth(:,k) = smooth(preSub(:,k));
    end
%      preSmooth=preSub;   
    sum = sum+preSmooth;
    if i==row
        average = sum/row;
    end
end

%����ֵ����
for j = 1:monitorNum
    for k = 1:sampleNum-1
        preDiff(k,j) = average(k+1,j)-average(k,j);
    end
end

%% С�����룬ƽ������
% lev  = 3;
% for i = 1:monitorNum
%     ƽ������
%     preSmooth(:,i) = smooth(preDiff(:,i));
%     С������
%     preWden(:,i) = wden(preSmooth(:,i),'heursure','s','mln',lev,'sym8');
% end

%% У����ɢ�����Ƿ������̬�ֲ�
result = zeros(4,monitorNum);
% header = ['H' 'P' 'I' 'CV']; 
% 
% for m = 1:4
% 	result(m,1)=header(i,:);
% end
alpha=0.05;
for i = 1:monitorNum
    % ����һ��
%     temp=zscore(preDiff(:,1));
%     [mu, sigma] = normfit(temp);
%     p = normcdf(temp, mu, sigma);
%     [H,s] = kstest(temp, [temp, p], alpha);
% %     result(5,i)=s;
%     if H == 0
%         disp('������Դ������̬�ֲ���')
%     else
%         disp('������Դ��������̬�ֲ���')
%     end
% 
%     % ��������У�����ο�http://10kn.com/matlab-normality-test/
%     
% %     [H,P,LSTAT,CV] = lillietest(preWden(:,i),alpha);
%     [result(1,i),result(2,i),result(3,i),result(4,i)] = lillietest(preDiff(:,i),alpha);
%     
%     figure(1);
% 	subplot(4,4,i);
% 	hist(preDiff(:,i),100);
% 	title(['��',num2str(i),'���ѹ���仯ֱ��ͼ']);
% 	
% 	figure(2);	
% 	subplot(4,4,i);
% 	normplot(preDiff(:,i));
% 	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
    
    figure(i+2);
	normplot(preDiff(:,i))
% 	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
    
%     plot(t,BurstTestData(:,2),)
    ylabel('Probabillity')
    xlabel('Delta Pressure')
    set(gca,'linewidth',2);
    set(gca,'FontSize',25);
    
end

