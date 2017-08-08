%% ͨ��ѹ��
clc;
clear all;

%% ����4��3����������
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%����14�����Ĺյ�����
load('CriticalPre');
%% ԭʼ���ݲ�ֵ����
lev  = 3;
monitorNum = 14;    %�������
sampleNum  = 1440;  %������������1��/����
for i = 1:monitorNum
    %����ֵ����
    for j = 1:sampleNum-1
        observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
    end
    observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
    % С������
    observe4_3Wden(:,i) = wden(observe4_3diff(:,i),'heursure','s','mln',lev,'sym8');
end
%1MPaԼ����100mˮ��
%��1�α�������(��ͬ����)
observe4_3Smooth = observe4_3Smooth*100;

burstCount = 0;
step            = 3;
count          = 0;
flag             = 0;
burstBegin = 0;
burstEnd    = 0;
indexTime  = 1;
%�ж��Ƿ�������
for i = 1:monitorNum
    for j = 1:sampleNum-1
        if(observe4_3Smooth(j,i)>CriticalPre(1,i))
            %�о��ж�����Ƿ������һ�����ݼ�������ȽϺ���
            burstEnd  = 0;
            flag = 1;
            burstBegin = j;
            count = count+1;
        elseif((observe4_3Smooth(j,i)<=CriticalPre(1,i)) && (1==flag) && (j<sampleNum-1))
            if(count>=step)
                burstCount = burstCount+1;
                burstEnd = j;
                burstTime(i,indexTime) = burstBegin;
                burstTime(i,indexTime+1) = burstEnd;
                indexTime = indexTime+3;
                burstBegin = 0;
                burstEnd = 0;
            end
            flag = 0;
            count = 0;
%         elseif((observe4_3Smooth(j,i)>CriticalPre(1,i)) && (1==flag) && (j==sampleNum-1))
%              if(count>=step)
%                 burstCount = burstCount+1;
%                 burstEnd = j;
%                 burstTime(i,indexTime) = burstBegin;
%                 burstTime(i,indexTime+1) = burstEnd;
%                 indexTime = indexTime+3;
%                 burstBegin = 0;
%                 burstEnd = 0;
%             end
%             flag = 0;
%             count = 0;
        end
    end
    burstCountMatrix(1,i) = burstCount;
    burstCount = 0;
    
end



t=1:1:sampleNum-1;
for i = 1:monitorNum
    figure(i);
	plot(t,abs(observe4_3Smooth(t,i)),'-b',t,abs(CriticalPre(1,i)),'.r');
	title(['��',num2str(i),'���ѹ���仯']);
end


disp('End')


