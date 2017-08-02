clc;
clear all;
%% 
load('Pressure.mat');

day =1440;

day1 = Pressure(1:day,:);
day2 = Pressure(1+1*day:2*day,:);
day3 = Pressure(1+2*day:3*day,:);
day4 = Pressure(1+3*day:4*day,:);
day5 = Pressure(1+4*day:5*day,:);
day6 = Pressure(1+5*day:6*day,:);
day7 = Pressure(1+6*day:7*day,:);
day8 = Pressure(1+7*day:8*day,:);
day9 = Pressure(1+8*day:9*day,:);
day10 = Pressure(1+9*day:10*day,:);
day11 = Pressure(1+10*day:11*day,:);
day12 = Pressure(1+11*day:12*day,:);
day13 = Pressure(1+12*day:13*day,:);
day14 = Pressure(1+13*day:14*day,:);
day15 = Pressure(1+14*day:15*day,:);
day16 = Pressure(1+15*day:16*day,:);
day17 = Pressure(1+16*day:17*day,:);
day18 = Pressure(1+17*day:18*day,:);
day19 = Pressure(1+18*day:19*day,:);
day20 = Pressure(1+19*day:20*day,:);
day21 = Pressure(1+20*day:21*day,:);
day22 = Pressure(1+21*day:22*day,:);
day23 = Pressure(1+22*day:23*day,:);
day24 = Pressure(1+23*day:24*day,:);
day25 = Pressure(1+24*day:25*day,:);

%% ����1��  ȴ��4��3�գ�4��8�գ�4��11�գ�4��12�գ�4��13�գ�4��14�� ����
point1 = [day1(:,1),day2(:,1),day3(:,1),day4(:,1),day5(:,1),day6(:,1),day7(:,1),day8(:,1),day9(:,1),day10(:,1),day11(:,1),day12(:,1),day13(:,1),day14(:,1),day16(:,1),day17(:,1),day19(:,1),day20(:,1),day21(:,1)];

%% ����2��  ȴ��3��23��~4��2�գ�4��3�� 4��6�� ʮһ��
point2 = [day1(:,2),day2(:,2),day3(:,2),day16(:,2),day17(:,2),day19(:,2),day20(:,2),day21(:,2),day22(:,2),day23(:,2),day24(:,2),day25(:,2)];

%% ����3��  ȴ��4��3�� 4��6�ն���
k=3
point3 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];
%% ����4��  ȴ��4��3�� 4��6�ն���
k=4
point4 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����5��  ȴ��4��3�� 4��6�ն���
k=5
point5 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����6��  ȴ��3��20��~4��2��,4��3�� 4��6��ʮ����
k=6
point6 = [day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����7��  ȴ��3��26��~4��2�� 4��3�� 4��6��ʮ��
k=7
point7 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����8��  ȴ��4��3�� 4��6�ն���
k=8
point8 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����9��  ȴ��3��23�գ�3��27�գ�3��28�գ�4��3�� 4��6������
k=9
point9 = [day1(:,k),day2(:,k),day3(:,k),day5(:,k),day6(:,k),day7(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����5��  ȴ��4��3�� 4��6�ն���
k=10
point10 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����11��  ȴ��4��3�� 4��6�� 4��13�� 4��14������
k=11
point11 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k)];

%% ����12��  ȴ��4��3�� 4��6�ն���
k=12
point12 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����13��  ȴ��4��3�� 4��6�ն���
k=13
point13 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];

%% ����14��  ȴ��4��3�� 4��6�ն���
k=14
point14 = [day1(:,k),day2(:,k),day3(:,k),day4(:,k),day5(:,k),day6(:,k),day7(:,k),day8(:,k),day9(:,k),day10(:,k),day11(:,k),day12(:,k),day13(:,k),day14(:,k),day16(:,k),day17(:,k),day19(:,k),day20(:,k),day21(:,k),day22(:,k),day23(:,k),day24(:,k),day25(:,k)];


leak= day15;
save leak leak
