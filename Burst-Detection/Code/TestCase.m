% clc;
% clear all;
% %% 
% load('time1.mat');
% % for i = 54:-3:3
% % 	time(1,i) = [];
% % end
% 
% time = time1;
% for i= 1:22
% 	start(1,i) = time(1,3*i-2);
%     stop(1,i) = time(1,3*i-1);
%     timeDel(1,i) = stop(1,i)-start(1,i);
% end
% 
% 
% for i= 1:22
% 	start(2,i) = floor(start(1,i)/60);
%     start(3,i) = start(1,i)-start(2,i)*60;
%     
%     start(4,i) = floor(stop(1,i)/60);
%     start(5,i) = stop(1,i)-start(4,i)*60;
%     
%     start(7,i) = timeDel(1,i);
% end
% 
% timeDel = timeDel';



% load('X.mat');
% load('Y.mat');
% load('P.mat');
% load('Q.mat');
% chazhi=[-0.721176470588236,-0.816363636363637,-0.737142857142864,-0.714285714285712,-0.821904761904768,-0.453333333333333,-0.664615384615386,-0.688571428571427,-0.954117647058816,-0.904761904761914,-0.998947368421044,-0.583809523809531,-0.942857142857145,-1.06857142857143]
% a=14;
% b=9;
% c=11;
% x=(X(a,1)*chazhi(1,a)+X(b,1)*chazhi(1,b)+X(c,1)*chazhi(1,c))/(chazhi(1,a)+chazhi(1,b)+chazhi(1,c))
% y=(Y(a,1)*chazhi(1,a)+Y(b,1)*chazhi(1,b)+Y(c,1)*chazhi(1,c))/(chazhi(1,a)+chazhi(1,b)+chazhi(1,c))
% i=10
% result(i,1)=sqrt((P(i,1)-x)^2+(Q(i,1)-y)^2)
% shuju=[57649.7 19909.5 58015.61 19831.87];
% i=1;
% 
% result(i,1)=sqrt((shuju(i,1)-shuju(i,3))^2+(shuju(i,2)-shuju(i,4))^2)
% clc;
% clear all;
% %% 载入数据
% path = 'C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\';%实验室hongwei_PC文件路径
% % path = 'C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\';%hongwei_PC文件路径
% % path = 'C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\';%张慧PC路径
% fileName= 'PressureDataAll.xls';
% sheetNameBurst='20150404';
% 
% Path = [path,fileName];%实验室路径
% 
% monitor    = 0;     %监测点编号循环基数
% monitorNum = 14;    %监测点个数
% sampleNum  = 1440;  %采样点数，即1个/分钟
% % [row,column] = size(sheetName);
% %获取爆管实验当天压力数据
% BurstTestData = xlsread(Path,sheetNameBurst,'C3:P1442');
% t=1:1:1440;
% figure;
% plot(t,BurstTestData(:,8));
% chazhiculi = LinearInterpolation(BurstTestData(:,8));
% figure;
% plot(t,chazhiculi);
% jiangzao = SmoothOrWden(chazhiculi,0);
% figure;
% plot(t,jiangzao);
% plot(t,BurstTestData(:,2),'LineWidth',2)
% % xlabel('采样')
% ylabel('Pressure')
% set(gca,'linewidth',2);
% set(gca,'FontSize',25);
% set(gca,'XTick',0:300:1500);
% % title('')
