clc;
clear;
%% ��ȡ��ѹ�㡢ˮԴ����
conn =database('yc3dma_synthetic_db','root','123\','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/yc3dma_synthetic_db');
ping(conn);
%% 
sql1='select value from points where series_id = 20122 ';
curs = exec(conn, sql1);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data1=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series11 = cell2mat(data1);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 974 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series4 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 10382 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series13 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ


sql2='select value from points where series_id = 2638 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series10 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 8081 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series5 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 154 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series7 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 934 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series1 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 1434 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series6 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 18498 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series2 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 14586 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series8 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 4110 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series9 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 10426 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series12 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 2634 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series14 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql2='select value from points where series_id = 12446 ';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.Data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Series3 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ


time = [Series1 Series2 Series3 Series4 Series5 Series6 Series7 Series8 Series9 Series10 Series11 Series12 Series13 Series14]

%Pressure_real = time.*0.01 

Pressure_real_EPA = time
figure
plot(Pressure_real_EPA(:,1))
grid on









