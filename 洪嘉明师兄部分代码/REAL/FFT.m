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
    Pressure4_4(:,i)= downsample(Day4_4Smooth(:,i),interval);
    
    Pre4_3(:,i)= downsample(pre4_3(:,i),interval);
    Pre4_2(:,i)= downsample(pre4_2(:,i),interval);
    Pre4_4(:,i)= downsample(pre4_4(:,i),interval);
    
    Real4_2(:,i)= downsample(d4_2(:,i),interval);  % RTX
    Real4_3(:,i)= downsample(d4_3(:,i),interval); 
    
    Noise4_3(:,i)= downsample(noise(:,i),interval); 
end

%% �������� 
noise2 = Pressure4_2-Pre4_2;
noise3 = Pressure4_3-Pre4_3;
noise4 = Pressure4_4-Pre4_4;

%% ��Ч��ֵ����
N = 96;
for i = 1:10
    y2(:,i) = CalcuRMS(noise2(:,i),N)
    y3(:,i) = CalcuRMS(noise3(:,i),N)
    y4(:,i) = CalcuRMS(noise4(:,i),N)
end



