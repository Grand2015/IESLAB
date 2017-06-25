clear all;
%% 载入异常事件
load('P1')
load('P3')
load('P4')
load('P5')
load('P8')
load('P10')
load('P11')
load('P12')
load('P13')
load('P14')

Event = [P1,P3,P4,P5,P8,P10,P11,P12,P13,P14];

save Event Event
x= 1:10;
y = 1:288;
z = abs(Event(y,x));
bar3(z,0.5);
% bar(y,z)
