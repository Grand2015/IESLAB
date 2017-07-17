clc;
clear all;

%% ����4��3����������
% load('C:\Users\hongwei\Desktop\IESLAB\SCADA-Data\observe4_3.mat');   
% load('C:\Users\hongwei_lab\Desktop\IESLAB\SCADA-Data\observe4_3.mat');
load('C:\Users\zh\Desktop\hongweili\IESLAB\SCADA-Data\observe4_3.mat');

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
	
	figure(1);
	subplot(4,4,i);
	hist(observe4_3Wden(:,i),100);
	title(['��',num2str(i),'���ѹ���仯ֱ��ͼ']);
	
	figure(2);	
	subplot(4,4,i);
	normplot(observe4_3Wden(:,i));
	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
    
    figure(i+2);
%     subplot(4,4,1);
% 	hist(observe4_3Wden(:,i),100);
% 	title(['��',num2str(i),'���ѹ���仯ֱ��ͼ']);
%     subplot(4,4,i);
	normplot(observe4_3Wden(:,i));
	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
    
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

