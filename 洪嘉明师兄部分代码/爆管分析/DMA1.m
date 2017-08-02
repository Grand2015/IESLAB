clc
clear all;
%% ��ȡ��ѹ�㡢ˮԴ����
conn =database('points','root','12345','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/points');
ping(conn);
%% ��ȡѹ������
sql1='select * from sheet1';
curs = exec(conn, sql1);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data1=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure1 = cell2mat(data1);                  %�ٰ�CELL�ṹת����MATRIX�ṹ


%% ����ƽ������
point_num = 14;

% for i=1:point_num
%     Pressure(:,i) = downsample(Pressure_1m(:,i),interval,0);
% end
for i = 1:point_num
    Pressure(:,i) = smooth(Pressure1(:,i),27,'moving');
end

%% ����ʱ���趨
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


%% �ڵ�1 
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

title('�ػ��´�');
%% 14������ѹ��ֵ

subplot(3,5,1)
plot(Pressure(:,1));
title('�ػ��´�');

subplot(3,5,2)
plot(Pressure(:,2));
title('˴��·����·');

subplot(3,5,3)
plot(Pressure(:,3));
title('˴��·����·��');

subplot(3,5,4)
plot(Pressure(:,4));
title('�Ӱ���·');

subplot(3,5,5)
plot(Pressure(:,5));
title('˴��·³Ѹ·��');

subplot(3,5,6)
plot(Pressure(:,6));
title('�Ƕ�����������');

subplot(3,5,7)
plot(Pressure(:,7));
title('ƽ��·Ϳɽ·');

subplot(3,5,8)
plot(Pressure(:,8));
title('����·ƽ��·��');

subplot(3,5,9)
plot(Pressure(:,9));
title('ƽ��·³Ѹ·');

subplot(3,5,10)
plot(Pressure(:,10));
title('��ɽ·��Խ��ɽ��������');

subplot(3,5,11)
plot(Pressure(:,11));
title('����ӡȾ');

subplot(3,5,12)
plot(Pressure(:,12));
title('����·');

subplot(3,5,13)
plot(Pressure(:,13));
title('�Ƕ�����');

subplot(3,5,14)
plot(Pressure(:,14));
title('����·��й·');

























