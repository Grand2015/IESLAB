clc;
clear all;

%% ��������
load('timeSeries.mat');    %EPAģ����
load('Pressure_real.mat');    %EPAģ����
load('Day4_4.mat');    %ƽ����4��4������
load('Day4_3.mat');    %ƽ����4��3������
load('Day4_2.mat');    %ƽ����4��2������
real = [Pressure_real(:,1) Pressure_real(:,3) Pressure_real(:,4) Pressure_real(:,5) Pressure_real(:,8) Pressure_real(:,10) Pressure_real(:,11) Pressure_real(:,12) Pressure_real(:,13) Pressure_real(:,14)]
%% ԭʼ���ݲ�ֵ����
for i = 1:10
    Day4_2Smooth(:,i)= smooth(Day4_2(:,i),3);
    Day4_3Smooth(:,i)= smooth(Day4_3(:,i),3);
    Day4_4Smooth(:,i)= smooth(Day4_4(:,i),3);

end

d4_2 = real(1:1435,:)
d4_3 = real(1436:2870,:)

day = 1440/15;
EPA4_2 = timeSeries(1:day,:).*0.01;
EPA4_3 = timeSeries(day+1:2*day,:).*0.01;
EPA4_4 = timeSeries(2*day+1:3*day,:).*0.01;
%% С������
lev = 3;
for i = 1:10
   pre4_2(:,i) = wden(Day4_2Smooth(:,i),'heursure','s','mln',lev,'sym8');
   pre4_3(:,i) = wden(Day4_3Smooth(:,i),'heursure','s','mln',lev,'sym8');
   pre4_4(:,i) = wden(Day4_4Smooth(:,i),'heursure','s','mln',lev,'sym8');
end

noise = pre4_3-Day4_3Smooth;
%% �����ز���
interval =15;


for i = 1:10
    Pressure4_2(:,i)= downsample(Day4_2Smooth(:,i),interval);  %�۲�ֵ
    Pressure4_3(:,i)= downsample(Day4_3Smooth(:,i),interval);
    
    Pre4_3(:,i)= downsample(pre4_3(:,i),interval);
    Pre4_2(:,i)= downsample(pre4_2(:,i),interval);
    Pre4_4(:,i)= downsample(pre4_4(:,i),interval);
    
    Real4_2(:,i)= downsample(d4_2(:,i),interval);  % RTX
    Real4_3(:,i)= downsample(d4_3(:,i),interval); 
    
    Noise4_3(:,i)= downsample(noise(:,i),interval); 
end
%% ͻ���ź�+����
s = EPA4_3-Pressure4_3;
n = Pre4_3-Pressure4_3;

for i=1:2870
    if Pressure_real(i,1)==0.2890
        nu=i;
    end
end

figure
plot(s)
legend('No.1����','No.3����','No.4����','No.5����','No.8����','No.10����','No.11����','No.12����','No.13����','No.14����')
xlabel('����Ƶ��/15min');
ylabel('ѹ��/Mpa');
grid on


% %%  snr
% snr1 = [];
% for j = 1:10
% for i = 1:96
%     x  = EPA4_3(i,j)
%     xm =  Pressure4_3(i,j)
%     p1=1/length(x)*norm(x)^2;
%     p2=1/length(x)*norm(x-xm)^2;
%     snr1(i,j)=10*log(p1/p2)
% end
% end
% figure
% bar(snr1(:,1))
% xlabel('����Ƶ��/15min');
% ylabel('dB');
% grid on
% title('No.1����')
%%
% x1 = 111
% x2 = 115
% x3 = 123
% x4 = 127
% x5 = 135
% x6 = 156
% x7 = 244
% z = 50:1:120
%  figure
% plot(snr1(:,2))
%  hold on
% plot(x1,z)
% hold on
% plot(x2,z)
% hold on
% plot(x3,z)
% hold on
% plot(x4,z)
% hold on
% plot(x5,z)
% hold on
% plot(x6,z)
% hold on
% plot(x7,z)
%%
% x1 = 37
% x2 = 38
% x3 = 41
% x4 = 44
% x5 = 50
% x6 = 52
% x7 = 81
% z = 40:1:130
% 
% figure
% 
% plot(x1,z)
% hold on
% plot(x2,z)
% hold on
% plot(x3,z)
% hold on
% plot(x4,z)
% hold on
% plot(x5,z)
% hold on
% plot(x6,z)
% hold on
% plot(x7,z)
% hold on
% bar(snr1(:,2))











