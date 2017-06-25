clc;
clear all;
%%
load('Pressure_real.mat');
load('observe4_3.mat')
load('observe4_2.mat')
load('noise.mat')



%%
day = 2870/2;
day4_2 = Pressure_real(1:day,:)
day4_3 = Pressure_real(day+1:end,:)

for i = 1:14
    obs4_3(:,i) = smooth(observe4_3(:,i),3);
    obs4_2(:,i) = smooth(observe4_2(:,i),3);
end


interval = 5;
for i = 1:14
    day4_3_15(:,i)=  downsample(day4_3(:,i),interval);
    observe4_3_15(:,i)=  downsample(observe4_3(:,i),interval);
    day4_2_15(:,i)=  downsample(day4_2(:,i),interval);
    observe4_2_15(:,i)=  downsample(observe4_2(:,i),interval);
end

%%  snr

snr1 = [];
for j = 1:14
for i = 1:287
    x = day4_3_15(i,j)
    xm = observe4_3_15(i,j)
    p1=1/length(x)*norm(x)^2;
    p2=1/length(x)*norm(x-xm)^2;
    snr1(i,j)=10*log(p1/p2)
end
end

snr2 = [];
for j = 1:14
for i = 1:287
    x = day4_2_15(i,j)
    xm = observe4_2_15(i,j)
    p1=1/length(x)*norm(x)^2;
    p2=1/length(x)*norm(x-xm)^2;
    snr2(i,j)=10*log(p1/p2)
end
end

for i = 1:14
    for j = 1:287
        diff(j,i) = snr2(j,i)-snr1(j,i);
    end
end

% %%
% k =1
% x= 1:1:287
% y(:,1) = snr1(x,k);
% % y(:,2) = snr2(x,k);
% figure
% bar3(y,0.5)
% 
% xlabel('采样频率/1min');
% ylabel('dB');
% title('No.10监测点');

