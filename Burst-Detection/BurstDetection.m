clc;
clear all;

%% ����4��3����������
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat')

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
	if flag == 1
		figure(1);
		%title('ֱ��ͼ');
		flag = flag+1;
	end
	subplot(4,4,i);
	hist(observe4_3Wden(:,i),100);
	title(['��',num2str(i),'���ѹ����ֱ��ͼ'])��
	
	if flag ==2
		figure(2);
		flag = flag+1;
	end
	subplot(4,4,i);
	normplot(temp1);
	title(['��',num2str(i),'���ѹ�����ۼƸ���'])��
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

%% ֱ��ͼ����̬�ۼƸ���
%figure(1);
%title('ֱ��ͼ')
%hist(temp1,100);   %��Ƶ��ֱ��ͼ 
%figure(2);
%title('�ֲ�����̬�Լ��� ')
%normplot(temp1);  %�ֲ�����̬�Լ���



%% ����
% hist(observe4_3Wden(:,1),100); hold on;
% [b, x]=hist(observe4_3Wden(:,1),100);
% num=numel(observe4_3Wden(:,1));
% 
% miu=observe4_3average(1,1);
% sigma=observe4_3std(1,1);
% y1=normpdf(x,miu,sigma);
% y2=normcdf(x,miu,sigma);

% [f,xi] = ksdensity(observe4_3Wden(:,1));
% plot(xi,f);


% figure(1);
% subplot 211;
% plot(x,b/num);   %�����ܶ�
% title('4��3�յ�һ�����ѹ���仯��̬�ֲ��ĸ����ܶ�')
% c=cumsum(b/num);        %�ۻ��ֲ�
% % figure; 
% subplot 212;
% plot(x,c,'+',x,y2,'--');
% title('4��3�յ�һ�����ѹ���仯��̬�ֲ����ۻ��ֲ�');
% figure(2);
% plot(x,c,'+',x,y2,'--');
% title('4��3�յ�һ�����ѹ���仯��̬�ֲ����ۻ��ֲ�');
% xlabel('');ylabel('����');

% figure(1)  
% subplot 211
% plot(x,y1)
% title('4��3�յ�һ�����ѹ���仯��̬�ֲ��ĸ����ܶ�')
% subplot 212
% plot(x,y2)
% title('4��3�յ�һ�����ѹ���仯��̬�ֲ����ۻ��ֲ�')


%% ��̬�ֲ��ۼƸ���
% clear
% x=-4:0.01:4;
% miu=0;sigma=1;
% y1=normpdf(x,miu,sigma);
% y2=normcdf(x,miu,sigma);
% figure(1) 
% subplot 221
% plot(x,y1)
% title('��̬�ֲ��ĸ����ܶ�')
% subplot 222
% plot(x,y2)
% title('��̬�ֲ����ۻ��ֲ�')

 %% point1 ��������
% load('observe4_3.mat');
% t=1:1:1440;
% plot(t,observe4_3(:,1));





