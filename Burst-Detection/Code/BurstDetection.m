clc;
clear all;

%% 载入4月3日数据数据
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
% load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

%% 原始数据插值处理
lev  = 3;
monitorNum = 14;    %监测点个数
sampleNum  = 1440;  %采样点数，即1个/分钟

preSub = observe4_3;
NaNCount = numel(find(isnan(preSub)));%某天压力数据中缺省个数
if NaNCount
    for n = 1:monitorNum
        if numel(find(isnan(preSub(:,n))))
            [rowNaN,columnNaN] = find(isnan(preSub(:,n)));
            count = numel(columnNaN);
            for c = 1:count
                valNum = rowNaN(c,1);%valNum是压力数据中每个监测点的缺省压力值的纵坐标
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
%检验线性插值处理结果
NaNCountCheck = numel(find(isnan(preSub)));
if NaNCountCheck
    fprintf('压力数据中仍然存在: %d 个缺省值', NaNCountCheck);
    pause( );
end


for i = 1:monitorNum
    %作差值处理
    for j = 1:sampleNum-1
        observe4_3diff(j,i) = observe4_3(j+1,i) - observe4_3(j,i);
    end
%     observe4_3Smooth(:,i) = observe4_3diff(:,i);
    observe4_3Smooth(:,i) = smooth(observe4_3diff(:,i));
    
    % 小波降噪
%     observe4_3Wden(:,i) = wden(observe4_3diff(:,i),'heursure','s','mln',lev,'sym8');
	
    %1MPa约等于100m水柱
    %第1次爆管数据(不同流量)
    step=1;
    for row = 556:step:562
        burst1_l300(row-555,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 563:step:568
        burst1_l150(row-562,i)=(observe4_3Smooth(row,i)*100);
    end
    
    %第2次爆管数据
    for row = 575:step:581
        burst2_l300(row-574,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 582:step:606
        burst2_l200(row-581,i)=(observe4_3Smooth(row,i)*100);
    end
    
    %第3次爆管数据
    for row = 612:step:618
        burst3_l300(row-611,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 620:step:627
        burst3_l100(row-619,i)=(observe4_3Smooth(row,i)*100);
    end
    
     %第4次爆管数据
    for row = 633:step:639
        burst4_l300(row-632,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 644:step:648
        burst4_l100(row-643,i)=(observe4_3Smooth(row,i)*100);
    end
    
    %第5次爆管数据
    for row = 654:step:663
        burst5_l200(row-653,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 665:step:672
        burst5_l100(row-664,i)=(observe4_3Smooth(row,i)*100);
    end
    
    t=550:1:700;
    figure(1);
	subplot(4,4,i);
	plot(t,(observe4_3Smooth(t,i)*100));
	title(['第',num2str(i),'测点压力变化']);
end

burst1avg(1,:)=min(burst1_l300);
burst1avg(2,:)=min(burst1_l150);
burst1avg(3,:)=min(burst2_l300);
burst1avg(4,:)=min(burst2_l200);
burst1avg(5,:)=min(burst3_l300);
burst1avg(6,:)=min(burst3_l100);
burst1avg(7,:)=min(burst4_l300);
burst1avg(8,:)=min(burst4_l100);
burst1avg(9,:)=min(burst5_l200);
burst1avg(10,:)=min(burst5_l100);
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
%%  临时不用的代码
% [mu, sigma] = normfit(observe4_3Wden(:,i));
%     
% 	figure(1);
% 	subplot(4,4,i);
% 	hist(observe4_3Wden(:,i),100);
% 	title(['第',num2str(i),'测点压力变化直方图']);
% 	
% 	figure(2);	
% 	subplot(4,4,i);
% 	normplot(observe4_3Wden(:,i));
% 	title(['第',num2str(i),'测点压力变化累计概率']);
%     
%     figure(i+2);
% 	normplot(observe4_3Wden(:,i));
% 	title(['第',num2str(i),'测点压力变化累计概率']);

