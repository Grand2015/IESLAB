%% 目标：管网实时运行
clear all;
clc;
errcode=0;
nodenum=0;                                                          %nodenum是总节点数目，可以赋予任意值，可以赋予任意值
file='YC3DMA.inp';                                                    %指定管网输入文件  
% StartSimMin=4;%开始仿真的分钟，比如，若为2，则从第2个scada数据仿真仿真到最后一个数据（仿真StopSimBoosterMin-StartSimMin+1次）
% StopSimBoosterMin=7;%可以根据效果动态设定
%爆管发生后StopSimBoosterMin， BoosterTime=BoosterTime+StopSimBoosterMin*60;
EN_JUNCTION=0;
EN_RESERVOIR=1;
%% 建立元素标号，查询数据库  
%作为输入的测量点 
    %大表
FB_BigDemandJunctionsID={'55648','25459','13477','23769','24434','25134','25173','25464','25570','26857','28394','33952','40465','41588','42104','42189','49690'};%大表用户测量节点标号
    %水库标号
FB_ReservoirID={'41922'};%
    %入水口节点标号
FB_InletJunctionsID={'41541','26124','26125'};                                                           
    %出水口节点标号
FB_OutletJunctionsID={'41249','49767','41974','40526','5079','23388','1240'};
%xxf,压力测点
Validator_PressureJunctionsID={{'25727','40084','23770'};{'1244','5604','32048'};{'40084','25555','27115','32048'};{'23770','850','28211'};{'3487','28211','1193','605'}};
    %3个入水口管道流量点
Validator_SupplyPipesID={'147930','102894','102896'};
    %2个中间中间管道流量点
Validator_InternalPipesID={'173356','166752'};                             %DMA内部测量管道模型标号,高级中学，涂山东路
    %7个出水口管道流量点
Validator_OutPipesID={'138122','163728','140878','149920','145700','172308','173360'};

%管道节点映射表，第一列存入管道标号，第二列存入对应连接节点标号
PipeMappingTable=[Validator_SupplyPipesID,Validator_OutPipesID;FB_InletJunctionsID,FB_OutletJunctionsID];
PipeMappingTable=PipeMappingTable';

%% 加载epanet引擎
%获取并建立未监测节点的连续索引（作为自变量），水库，入水口负需水量节点，出水口节点，大表节点，中间校验管道索引
                                                                    %首先将epanetnext.dll epanetnext.h放到当前工作目录，并同时放入管网输入文件
errcode=loadlibrary('epanetnext.dll','epanetnext.h');                     %  用loadlibrary函数， 根据epanetnext.h中的函数定义，加载epanetnext.dll
libfunctions epanetnext -full                                          %  查看epanetnext.dll支持的函数接口
errcode=calllib('epanetnext','ENopen',file,'','');                         %  用calllib函数调用EPANET函数库中的ENopen函数
while (errcode>0)
        errcode=calllib('epanetnext','ENopen',file,'','');                         %  用calllib函数调用EPANET函数库中的ENopen函数打开需要校核的管网模型
        if(errcode)  
            calllib('epanetnext','ENclose');                                       %  如果打开失败，则关闭
            errcode=loadlibrary('epanetnext.dll','epanetnext.h');                     % 用loadlibrary函数， 根据epanetnext.h中的函数定义，加载epanetnext.dll
        end
end
%获取节点数目
[errcode,nodenum]=calllib('epanetnext','ENgetcount',0,nodenum);        %  获取总节点数目，注意获取数值的方式，两边要有相同的参数nodenum，也可以不同
                                       
%% 存储反馈节点索引和无效节点索引        
%使调节需水量的节点不包含水源，出水点，负需水量节点，大表用户节点
%排除的点也要进行存储，用户仿真参数设置，如设定水库水头，出水口测量需水量，大表测量流量           
NeedAdjDemJuncsIndex=0;
    %建立水库节点索引集合（仅仅一个水库）
ReservoirIndex=0;
[errcode,~,ReservoirIndex]=calllib('epanetnext','ENgetnodeindex',FB_ReservoirID{1},ReservoirIndex);
    % 建立大表节点索引集合
[row_big,col_big]=size(FB_BigDemandJunctionsID);
BigDemandJuncsIndex=cell(row_big,col_big);
for i=1:col_big
    indexvalue=0;
    [errcode,~,indexvalue]=calllib('epanetnext','ENgetnodeindex',FB_BigDemandJunctionsID{i}(1,:),indexvalue); 
    BigDemandJuncsIndex{i}=indexvalue;
end
    %建立入水口节点索引
[row_inlet,col_inlet]=size(FB_InletJunctionsID);
InletJuncsIndex=cell(row_inlet,col_inlet);
for i=1:col_inlet
    indexvalue=0;
    [errcode,Tempb,indexvalue]=calllib('epanetnext','ENgetnodeindex',FB_InletJunctionsID{i},indexvalue);
    InletJuncsIndex{i}=indexvalue;
end
    %建立出水口节点索引
[row_outlet,col_outlet]=size(FB_OutletJunctionsID);
OutletJuncsIndex=cell(row_outlet,col_outlet);
for i=1:col_outlet
    indexvalue=0;
    [errcode,Tempb,indexvalue]=calllib('epanetnext','ENgetnodeindex',FB_OutletJunctionsID{i},indexvalue);
    OutletJuncsIndex{i}=indexvalue;
end


   %存储所有反馈节点索引无效节点索引
AllFBJuncsIndex={ReservoirIndex,BigDemandJuncsIndex{:},InletJuncsIndex{:},OutletJuncsIndex{:}};
clear row_big;clear col_big;
clear row_inlet;clear col_inlet;
clear row_outlet;clear col_outlet;
clear row_Nonvalid;
clear ReservoirIndex;
clear BigDemandJuncsIndex;
clear InletJuncsIndex;
clear OutletJuncsIndex;


  

%% 执行水力模拟
% tStep=15;
% time=0;
errcode=calllib('epanetnext','ENopenH');%打开水力分析系统

errcode=calllib('epanetnext','ENinitH',0);%初始化贮水池水位，管道状态和设置以及模拟时间，0表示不存储二进制水力结果

time=0;%初始化工况时间，可以是任意值

number=0;%number为水力步长进行到的阶段数

pressure=0;

tstep=15;%初始化水力分析的步数，可以是任意非零值

while (tstep && ~errcode)

[errcode,time]=calllib('epanetnext','ENrunH',time);%执行在time 时刻的水力分析

number=time/3600;

if (number==11)%获取第11步水力分析的水力数据

for i=1:junctionnum

[errcode,pressure]=calllib('epanetnext','ENgetnodevalue',i,11,pressure);

pressurevalue(i,1)=pressure;

end

end

[errcode,tstep]=calllib('epanetnext','ENnextH',tstep);

end

% errcode=calllib('epanet2','ENcloseH');%关闭水力分析系统，释放内存

errCode=calllib('epanetnext','ENcloseH');%关闭水力分析系统
errCode=calllib('epanetnext','ENclose');%关闭toolkit系统
unloadlibrary('epanetnext');