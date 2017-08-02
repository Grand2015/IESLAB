clc
clear all;
%% 获取测压点、水源数据
conn =database('points','root','12345','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/points');
ping(conn);
%% 读取压力数据
%
sql1='select * from day1';
curs = exec(conn, sql1);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data1=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure1 = cell2mat(data1);                  %再把CELL结构转换成MATRIX结构
%
sql2='select * from day2';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure2 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql3='select * from day3';
curs = exec(conn, sql3);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data3=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure3 = cell2mat(data3);                  %再把CELL结构转换成MATRIX结构
%
sql4='select * from day4';
curs = exec(conn, sql4);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data4=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure4 = cell2mat(data4);                  %再把CELL结构转换成MATRIX结构
%
sql5='select * from day5';
curs = exec(conn, sql5);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data5=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure5 = cell2mat(data5);                  %再把CELL结构转换成MATRIX结构
%
sql6='select * from day6';
curs = exec(conn, sql6);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data6=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure6 = cell2mat(data6);                  %再把CELL结构转换成MATRIX结构
%
sql7='select * from day7';
curs = exec(conn, sql7);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data7=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure7 = cell2mat(data7);                  %再把CELL结构转换成MATRIX结构
%
sql8='select * from day8';
curs = exec(conn, sql8);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data8=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure8 = cell2mat(data8);                  %再把CELL结构转换成MATRIX结构
%
sql9='select * from day9';
curs = exec(conn, sql9);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data9=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure9 = cell2mat(data9);                  %再把CELL结构转换成MATRIX结构
%
sql10='select * from day10';
curs = exec(conn, sql10);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data10=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure10 = cell2mat(data10);                  %再把CELL结构转换成MATRIX结构

sql11='select * from day11';
curs = exec(conn, sql11);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data11=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure11 = cell2mat(data11);                  %再把CELL结构转换成MATRIX结构
%
sql12='select * from day12';
curs = exec(conn, sql12);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data12=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure12 = cell2mat(data12);                  %再把CELL结构转换成MATRIX结构
%
sql13='select * from day13';
curs = exec(conn, sql13);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data13=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure13 = cell2mat(data13);                  %再把CELL结构转换成MATRIX结构
%
sql14='select * from day14';
curs = exec(conn, sql14);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data14=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure14 = cell2mat(data14);                  %再把CELL结构转换成MATRIX结构
%
sql15='select * from day15';
curs = exec(conn, sql15);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data15=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure15 = cell2mat(data15);                  %再把CELL结构转换成MATRIX结构
%
sql16='select * from day16';
curs = exec(conn, sql16);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data16=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure16 = cell2mat(data16);                  %再把CELL结构转换成MATRIX结构

sql17='select * from day17';
curs = exec(conn, sql17);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data17=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure17 = cell2mat(data17);                  %再把CELL结构转换成MATRIX结构
%
sql18='select * from day18';
curs = exec(conn, sql18);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data18=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure18 = cell2mat(data18);                  %再把CELL结构转换成MATRIX结构
%
sql19='select * from day19';
curs = exec(conn, sql19);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data19=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure19 = cell2mat(data19);                  %再把CELL结构转换成MATRIX结构
%
sql20='select * from day20';
curs = exec(conn, sql20);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data20=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure20 = cell2mat(data20);                  %再把CELL结构转换成MATRIX结构
%
sql21='select * from day21';
curs = exec(conn, sql21);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data21=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure21 = cell2mat(data21);                  %再把CELL结构转换成MATRIX结构
%
sql22='select * from day22';
curs = exec(conn, sql22);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data22=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure22 = cell2mat(data22);                  %再把CELL结构转换成MATRIX结构
%
sql23='select * from day23';
curs = exec(conn, sql23);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data23=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure23 = cell2mat(data23);                  %再把CELL结构转换成MATRIX结构
%
sql24='select * from day24';
curs = exec(conn, sql24);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data24=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure24 = cell2mat(data24);                  %再把CELL结构转换成MATRIX结构
%
sql25='select * from day25';
curs = exec(conn, sql25);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data25=curs.data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Pressure25 = cell2mat(data25);                  %再把CELL结构转换成MATRIX结构

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
























