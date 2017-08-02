clc
clear all;
%% 获取测压点、水源数据
conn =database('points','root','12345','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/points');
ping(conn);
%% 读取压力数据
sql1='select * from sheet1';
curs = exec(conn, sql1);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data1=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure1 = cell2mat(data1);                  %再把CELL结构转换成MATRIX结构


%% 数据平滑处理
point_num = 14;

% for i=1:point_num
%     Pressure(:,i) = downsample(Pressure_1m(:,i),interval,0);
% end
for i = 1:point_num
    Pressure(:,i) = smooth(Pressure1(:,i),27,'moving');
end

%% 爆管时间设定
x1 = 556;
x2 = 563;
x3 = 569;
%
x4 = 575;
x5 = 582;
x6 = 607;
%
x7 = 633;
x8 = 640;
x9 = 644;
x10 = 649;
%

y1 = 0.26;
y2 = 0.36;


%% 节点1 
figure
plot(Pressure(:,1));
hold on 
plot([x1 x1],[y1 y2],'--b');
hold on
plot([x2 x2],[y1 y2],'--b');
hold on
plot([x3 x3],[y1 y2],'--b');
%
hold on
plot([x4 x4],[y1 y2],'--r');
hold on
plot([x5 x5],[y1 y2],'--r');
hold on
plot([x6 x6],[y1 y2],'--r');
%

title('敦煌新村');
%% 14个测点的压力值

subplot(3,5,1)
plot(Pressure(:,1));
title('敦煌新村');

subplot(3,5,2)
plot(Pressure(:,2));
title('舜江路卧龙路');

subplot(3,5,3)
plot(Pressure(:,3));
title('舜江路人民路口');

subplot(3,5,4)
plot(Pressure(:,4));
title('延安东路');

subplot(3,5,5)
plot(Pressure(:,5));
title('舜江路鲁迅路口');

subplot(3,5,6)
plot(Pressure(:,6));
title('城东体育馆南门');

subplot(3,5,7)
plot(Pressure(:,7));
title('平江路涂山路');

subplot(3,5,8)
plot(Pressure(:,8));
title('勾乘路平江路段');

subplot(3,5,9)
plot(Pressure(:,9));
title('平江路鲁迅路');

subplot(3,5,10)
plot(Pressure(:,10));
title('东山路古越龙山电子南门');

subplot(3,5,11)
plot(Pressure(:,11));
title('绍钦印染');

subplot(3,5,12)
plot(Pressure(:,12));
title('人民东路');

subplot(3,5,13)
plot(Pressure(:,13));
title('城东基地');

subplot(3,5,14)
plot(Pressure(:,14));
title('秦望路五泄路');

























