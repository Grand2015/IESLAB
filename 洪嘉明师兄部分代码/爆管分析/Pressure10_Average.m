clc;
clear all;
%% ¶ÁÈ¡Êı¾İ
load('Pres.mat');

pressure = Pressure1(1:23040,:);

Pressure10 = [pressure(:,1),pressure(:,2),pressure(:,3),pressure(:,4),pressure(:,5),pressure(:,6),pressure(:,8),pressure(:,11),pressure(:,13),pressure(:,14)];
num = 10;
for i = 1:num
    Pressure10_smooth(:,i) = smooth(Pressure10(:,i),5);
end

