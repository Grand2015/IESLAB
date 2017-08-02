clc;
clear all;
load('Pressure.mat');
day = 1440;

day15 = Pressure(14*day+1:15*day,:);

Leak = [day15(:,3),day15(:,11),day15(:,4),day15(:,13),day15(:,10),day15(:,5),day15(:,7),day15(:,1),day15(:,6),day15(:,2),day15(:,8),day15(:,9),day15(:,12),day15(:,14)];
save Leak Leak;