clc
clear all;
%% ��ȡ��ѹ�㡢ˮԴ����
conn =database('points','root','12345','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/points');
ping(conn);
%% ��ȡѹ������
%
sql1='select * from day1';
curs = exec(conn, sql1);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data1=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure1 = cell2mat(data1);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql2='select * from day2';
curs = exec(conn, sql2);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data2=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure2 = cell2mat(data2);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql3='select * from day3';
curs = exec(conn, sql3);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data3=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure3 = cell2mat(data3);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql4='select * from day4';
curs = exec(conn, sql4);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data4=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure4 = cell2mat(data4);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql5='select * from day5';
curs = exec(conn, sql5);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data5=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure5 = cell2mat(data5);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql6='select * from day6';
curs = exec(conn, sql6);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data6=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure6 = cell2mat(data6);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql7='select * from day7';
curs = exec(conn, sql7);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data7=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure7 = cell2mat(data7);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql8='select * from day8';
curs = exec(conn, sql8);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data8=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure8 = cell2mat(data8);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql9='select * from day9';
curs = exec(conn, sql9);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data9=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure9 = cell2mat(data9);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql10='select * from day10';
curs = exec(conn, sql10);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data10=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure10 = cell2mat(data10);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql11='select * from day11';
curs = exec(conn, sql11);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data11=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure11 = cell2mat(data11);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql12='select * from day12';
curs = exec(conn, sql12);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data12=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure12 = cell2mat(data12);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql13='select * from day13';
curs = exec(conn, sql13);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data13=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure13 = cell2mat(data13);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql14='select * from day14';
curs = exec(conn, sql14);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data14=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure14 = cell2mat(data14);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql15='select * from day15';
curs = exec(conn, sql15);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data15=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure15 = cell2mat(data15);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql16='select * from day16';
curs = exec(conn, sql16);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data16=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure16 = cell2mat(data16);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

sql17='select * from day17';
curs = exec(conn, sql17);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data17=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure17 = cell2mat(data17);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql18='select * from day18';
curs = exec(conn, sql18);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data18=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure18 = cell2mat(data18);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql19='select * from day19';
curs = exec(conn, sql19);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data19=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure19 = cell2mat(data19);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql20='select * from day20';
curs = exec(conn, sql20);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data20=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure20 = cell2mat(data20);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql21='select * from day21';
curs = exec(conn, sql21);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data21=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure21 = cell2mat(data21);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql22='select * from day22';
curs = exec(conn, sql22);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data22=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure22 = cell2mat(data22);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql23='select * from day23';
curs = exec(conn, sql23);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data23=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure23 = cell2mat(data23);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql24='select * from day24';
curs = exec(conn, sql24);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data24=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure24 = cell2mat(data24);                  %�ٰ�CELL�ṹת����MATRIX�ṹ
%
sql25='select * from day25';
curs = exec(conn, sql25);                       %��exec����ִ��sql��䣬�ڶ�����������sql�����ַ���
curs = fetch(curs);                            %ִ�����ѯ�󣬻�Ҫ����ѯ����ӿ���cursor�����뵽����curs�У��ù������ú���cursor.fetchʵ�ֵ�
data25=curs.data;                               %ʹ��curs.Data����ʾ���ݣ�curs.Data����һ��CELL�ṹ�������Ȱ�CELL�ṹת����MATRIX�ṹ��ȡֵ��
Pressure25 = cell2mat(data25);                  %�ٰ�CELL�ṹת����MATRIX�ṹ

%%
pressure1 = Pressure1';
pressure2 = Pressure2';
pressure3 = Pressure3';
pressure4 = Pressure4';
pressure5 = Pressure5';
pressure6 = Pressure6';
pressure7 = Pressure7';
pressure8 = Pressure8';
pressure9 = Pressure9';
pressure10 = Pressure10';
pressure11 = Pressure11';
pressure12= Pressure12';
pressure13= Pressure13';
pressure14= Pressure14';
pressure15= Pressure15';
pressure16= Pressure16';
pressure17= Pressure17';
pressure18= Pressure18';
pressure19 = Pressure19';
pressure20 = Pressure20';
pressure21 = Pressure21';
pressure22 = Pressure22';
pressure23 = Pressure23';
pressure24 = Pressure24';
pressure25 = Pressure25';

pressure = [pressure1,pressure2,pressure3,pressure4,pressure5,pressure6,pressure7,pressure8,pressure9,pressure10,pressure11,pressure12,pressure13,pressure14,pressure15,pressure16,pressure17,pressure18,pressure19,pressure20,pressure21,pressure22,pressure23,pressure24,pressure25];

Pressure = pressure';
























