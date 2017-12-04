%% Ŀ�꣺����ʵʱ����
clear all;
clc;
errcode=0;
nodenum=0;                                                          %nodenum���ܽڵ���Ŀ�����Ը�������ֵ�����Ը�������ֵ
file='YC3DMA.inp';                                                    %ָ�����������ļ�  
% StartSimMin=4;%��ʼ����ķ��ӣ����磬��Ϊ2����ӵ�2��scada���ݷ�����浽���һ�����ݣ�����StopSimBoosterMin-StartSimMin+1�Σ�
% StopSimBoosterMin=7;%���Ը���Ч����̬�趨
%���ܷ�����StopSimBoosterMin�� BoosterTime=BoosterTime+StopSimBoosterMin*60;
EN_JUNCTION=0;
EN_RESERVOIR=1;
%% ����Ԫ�ر�ţ���ѯ���ݿ�  
%��Ϊ����Ĳ����� 
    %���
FB_BigDemandJunctionsID={'55648','25459','13477','23769','24434','25134','25173','25464','25570','26857','28394','33952','40465','41588','42104','42189','49690'};%����û������ڵ���
    %ˮ����
FB_ReservoirID={'41922'};%
    %��ˮ�ڽڵ���
FB_InletJunctionsID={'41541','26124','26125'};                                                           
    %��ˮ�ڽڵ���
FB_OutletJunctionsID={'41249','49767','41974','40526','5079','23388','1240'};
%xxf,ѹ�����
Validator_PressureJunctionsID={{'25727','40084','23770'};{'1244','5604','32048'};{'40084','25555','27115','32048'};{'23770','850','28211'};{'3487','28211','1193','605'}};
    %3����ˮ�ڹܵ�������
Validator_SupplyPipesID={'147930','102894','102896'};
    %2���м��м�ܵ�������
Validator_InternalPipesID={'173356','166752'};                             %DMA�ڲ������ܵ�ģ�ͱ��,�߼���ѧ��Ϳɽ��·
    %7����ˮ�ڹܵ�������
Validator_OutPipesID={'138122','163728','140878','149920','145700','172308','173360'};

%�ܵ��ڵ�ӳ�����һ�д���ܵ���ţ��ڶ��д����Ӧ���ӽڵ���
PipeMappingTable=[Validator_SupplyPipesID,Validator_OutPipesID;FB_InletJunctionsID,FB_OutletJunctionsID];
PipeMappingTable=PipeMappingTable';

%% ����epanet����
%��ȡ������δ���ڵ��������������Ϊ�Ա�������ˮ�⣬��ˮ�ڸ���ˮ���ڵ㣬��ˮ�ڽڵ㣬���ڵ㣬�м�У��ܵ�����
                                                                    %���Ƚ�epanetnext.dll epanetnext.h�ŵ���ǰ����Ŀ¼����ͬʱ������������ļ�
errcode=loadlibrary('epanetnext.dll','epanetnext.h');                     %  ��loadlibrary������ ����epanetnext.h�еĺ������壬����epanetnext.dll
libfunctions epanetnext -full                                          %  �鿴epanetnext.dll֧�ֵĺ����ӿ�
errcode=calllib('epanetnext','ENopen',file,'','');                         %  ��calllib��������EPANET�������е�ENopen����
while (errcode>0)
        errcode=calllib('epanetnext','ENopen',file,'','');                         %  ��calllib��������EPANET�������е�ENopen��������ҪУ�˵Ĺ���ģ��
        if(errcode)  
            calllib('epanetnext','ENclose');                                       %  �����ʧ�ܣ���ر�
            errcode=loadlibrary('epanetnext.dll','epanetnext.h');                     % ��loadlibrary������ ����epanetnext.h�еĺ������壬����epanetnext.dll
        end
end
%��ȡ�ڵ���Ŀ
[errcode,nodenum]=calllib('epanetnext','ENgetcount',0,nodenum);        %  ��ȡ�ܽڵ���Ŀ��ע���ȡ��ֵ�ķ�ʽ������Ҫ����ͬ�Ĳ���nodenum��Ҳ���Բ�ͬ
                                       
%% �洢�����ڵ���������Ч�ڵ�����        
%ʹ������ˮ���Ľڵ㲻����ˮԴ����ˮ�㣬����ˮ���ڵ㣬����û��ڵ�
%�ų��ĵ�ҲҪ���д洢���û�����������ã����趨ˮ��ˮͷ����ˮ�ڲ�����ˮ��������������           
NeedAdjDemJuncsIndex=0;
    %����ˮ��ڵ��������ϣ�����һ��ˮ�⣩
ReservoirIndex=0;
[errcode,~,ReservoirIndex]=calllib('epanetnext','ENgetnodeindex',FB_ReservoirID{1},ReservoirIndex);
    % �������ڵ���������
[row_big,col_big]=size(FB_BigDemandJunctionsID);
BigDemandJuncsIndex=cell(row_big,col_big);
for i=1:col_big
    indexvalue=0;
    [errcode,~,indexvalue]=calllib('epanetnext','ENgetnodeindex',FB_BigDemandJunctionsID{i}(1,:),indexvalue); 
    BigDemandJuncsIndex{i}=indexvalue;
end
    %������ˮ�ڽڵ�����
[row_inlet,col_inlet]=size(FB_InletJunctionsID);
InletJuncsIndex=cell(row_inlet,col_inlet);
for i=1:col_inlet
    indexvalue=0;
    [errcode,Tempb,indexvalue]=calllib('epanetnext','ENgetnodeindex',FB_InletJunctionsID{i},indexvalue);
    InletJuncsIndex{i}=indexvalue;
end
    %������ˮ�ڽڵ�����
[row_outlet,col_outlet]=size(FB_OutletJunctionsID);
OutletJuncsIndex=cell(row_outlet,col_outlet);
for i=1:col_outlet
    indexvalue=0;
    [errcode,Tempb,indexvalue]=calllib('epanetnext','ENgetnodeindex',FB_OutletJunctionsID{i},indexvalue);
    OutletJuncsIndex{i}=indexvalue;
end


   %�洢���з����ڵ�������Ч�ڵ�����
AllFBJuncsIndex={ReservoirIndex,BigDemandJuncsIndex{:},InletJuncsIndex{:},OutletJuncsIndex{:}};
clear row_big;clear col_big;
clear row_inlet;clear col_inlet;
clear row_outlet;clear col_outlet;
clear row_Nonvalid;
clear ReservoirIndex;
clear BigDemandJuncsIndex;
clear InletJuncsIndex;
clear OutletJuncsIndex;


  

%% ִ��ˮ��ģ��
% tStep=15;
% time=0;
errcode=calllib('epanetnext','ENopenH');%��ˮ������ϵͳ

errcode=calllib('epanetnext','ENinitH',0);%��ʼ����ˮ��ˮλ���ܵ�״̬�������Լ�ģ��ʱ�䣬0��ʾ���洢������ˮ�����

time=0;%��ʼ������ʱ�䣬����������ֵ

number=0;%numberΪˮ���������е��Ľ׶���

pressure=0;

tstep=15;%��ʼ��ˮ�������Ĳ������������������ֵ

while (tstep && ~errcode)

[errcode,time]=calllib('epanetnext','ENrunH',time);%ִ����time ʱ�̵�ˮ������

number=time/3600;

if (number==11)%��ȡ��11��ˮ��������ˮ������

for i=1:junctionnum

[errcode,pressure]=calllib('epanetnext','ENgetnodevalue',i,11,pressure);

pressurevalue(i,1)=pressure;

end

end

[errcode,tstep]=calllib('epanetnext','ENnextH',tstep);

end

% errcode=calllib('epanet2','ENcloseH');%�ر�ˮ������ϵͳ���ͷ��ڴ�

errCode=calllib('epanetnext','ENcloseH');%�ر�ˮ������ϵͳ
errCode=calllib('epanetnext','ENclose');%�ر�toolkitϵͳ
unloadlibrary('epanetnext');