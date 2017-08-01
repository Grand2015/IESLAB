clc;
clear all;

%% ����4��3����������
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

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
	
    %1MPaԼ����100mˮ��
    %��1�α�������(��ͬ����)
    step=3;
    for row = 556:step:562
        burst1_l300(row-555,i)=abs(observe4_3Smooth(row,i)*100);
    end
    for row = 563:step:568
        burst1_l150(row-562,i)=abs(observe4_3Smooth(row,i)*100);
    end
    
    %��2�α�������
    for row = 575:step:581
        burst2_l300(row-574,i)=abs(observe4_3Smooth(row,i)*100);
    end
    for row = 582:step:606
        burst2_l200(row-581,i)=abs(observe4_3Smooth(row,i)*100);
    end
    
    %��3�α�������
    for row = 612:step:618
        burst3_l300(row-611,i)=abs(observe4_3Smooth(row,i)*100);
    end
    for row = 620:step:627
        burst3_l100(row-619,i)=abs(observe4_3Smooth(row,i)*100);
    end
    
     %��4�α�������
    for row = 633:step:639
        burst4_l300(row-632,i)=abs(observe4_3Smooth(row,i)*100);
    end
    for row = 644:step:648
        burst4_l100(row-643,i)=abs(observe4_3Smooth(row,i)*100);
    end
    
    %��5�α�������
    for row = 654:step:663
        burst5_l200(row-653,i)=abs(observe4_3Smooth(row,i)*100);
    end
    for row = 665:step:672
        burst5_l100(row-664,i)=abs(observe4_3Smooth(row,i)*100);
    end
    
    t=550:1:700;
    figure(1);
	subplot(4,4,i);
	plot(t,abs(observe4_3Smooth(t,i)*100));
	title(['��',num2str(i),'���ѹ���仯']);
end

burst1avg(1,:)=max(burst1_l300);
burst1avg(2,:)=max(burst1_l150);
burst1avg(3,:)=max(burst2_l300);
burst1avg(4,:)=max(burst2_l200);
burst1avg(5,:)=max(burst3_l300);
burst1avg(6,:)=max(burst3_l100);
burst1avg(7,:)=max(burst4_l300);
burst1avg(8,:)=max(burst4_l100);
burst1avg(9,:)=max(burst5_l200);
burst1avg(10,:)=max(burst5_l100);
% burst1avg(1,:)=mean(burst1_l300);
% burst1avg(2,:)=mean(burst1_l150);
% burst1avg(3,:)=mean(burst2_l300);
% burst1avg(4,:)=mean(burst2_l200);
% burst1avg(5,:)=mean(burst3_l300);
% burst1avg(6,:)=mean(burst3_l100);
% burst1avg(7,:)=mean(burst4_l300);
% burst1avg(8,:)=mean(burst4_l100);
% burst1avg(9,:)=mean(burst5_l200);
% burst1avg(10,:)=mean(burst5_l100);


disp('End')
%%  ��ʱ���õĴ���
% [mu, sigma] = normfit(observe4_3Wden(:,i));
%     
% 	figure(1);
% 	subplot(4,4,i);
% 	hist(observe4_3Wden(:,i),100);
% 	title(['��',num2str(i),'���ѹ���仯ֱ��ͼ']);
% 	
% 	figure(2);	
% 	subplot(4,4,i);
% 	normplot(observe4_3Wden(:,i));
% 	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
%     
%     figure(i+2);
% 	normplot(observe4_3Wden(:,i));
% 	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);

