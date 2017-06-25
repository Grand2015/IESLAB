clc;
clear;
%% 获取测压点、水源数据
conn =database('yc3dma_synthetic_db','root','123\','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/yc3dma_synthetic_db');
ping(conn);
%% 
sql1='select value from points where series_id = 20122 ';
curs = exec(conn, sql1);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data1=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series11 = cell2mat(data1);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 974 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series4 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 10382 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series13 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构


sql2='select value from points where series_id = 2638 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series10 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 8081 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series5 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 154 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series7 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 934 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series1 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 1434 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series6 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 18498 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series2 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 14586 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series8 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 4110 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series9 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 10426 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series12 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 2634 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series14 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构

sql2='select value from points where series_id = 12446 ';
curs = exec(conn, sql2);                       %用exec函数执行sql语句，第二个参数就是sql命令字符串
curs = fetch(curs);                            %执行完查询后，还要将查询结果从开放cursor对象导入到对象curs中，该功能是用函数cursor.fetch实现的
data2=curs.Data;                               %使用curs.Data来显示数据，curs.Data返回一个CELL结构，可以先把CELL结构转换成MATRIX结构再取值：
Series3 = cell2mat(data2);                  %再把CELL结构转换成MATRIX结构


time = [Series1 Series2 Series3 Series4 Series5 Series6 Series7 Series8 Series9 Series10 Series11 Series12 Series13 Series14]

%Pressure_real = time.*0.01 

Pressure_real_EPA = time
figure
plot(Pressure_real_EPA(:,1))
grid on









