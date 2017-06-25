clear all;

clear all;
%%
load('DBA');
load('BBA');
load('burst');

%% 
for i = 1:10
    for j = 1:288
        if DBA(j,i) ~= 0
            DBA(j,i) = 2;  %2 表示true
        else
            DBA(j,i) = 1;  %1 表示false
        end            
    end
end

for i = 1:10
    for j = 1:288
        if BBA(j,i) ~= 0
            BBA(j,i) = 2;  %2 表示true
        else
            BBA(j,i) = 1;  %1 表示false
        end            
    end
end
N=7;  
dag=zeros(N,N);  
M11=1;M21=2;A1=3;M12=4;M22=5;A2=6;W1=7
dag(M11,A1)=1;  
dag(M21,A1)=1;  
dag(M12,A2)=1;  
dag(M22,A2)=1; 
dag([A1 A2],W1)=1;  
 
discrete_nodes=1:N;  
node_sizes=2*ones(1,N);  
bnet=mk_bnet(dag,node_sizes,'names',{'M11','M21','A1','M12','M22','A2','W1'},'discrete',discrete_nodes);  
bnet.CPD{M11}=tabular_CPD(bnet,M11,[0.5,0.5]);  
bnet.CPD{M21}=tabular_CPD(bnet,M21,[0.5,0.5]);  
bnet.CPD{A1}=tabular_CPD(bnet,A1,[1,0.40,0.2,0,0,0.60,0.8,1]);  
bnet.CPD{M12}=tabular_CPD(bnet,M12,[0.5,0.5]);  
bnet.CPD{M22}=tabular_CPD(bnet,M22,[0.5,0.5]);  
bnet.CPD{A2}=tabular_CPD(bnet,A2,[1,0.4,0.2,0,0,0.60,0.8,1]);  
bnet.CPD{W1}=tabular_CPD(bnet,W1,[1,0.60,0.4,0,0,0.4,0.6,1]);  

%draw_graph(dag)  
engine=jtree_inf_engine(bnet);  
for i = 1:10
    for j = 2:288
        evidence=cell(1,N); 
        evidence{M11} =BBA(j-1,i); 
        evidence{M21} =DBA(j-1,i); 
        evidence{M12} =BBA(j,i);
        evidence{M22} =DBA(j,i); 
        [engine,loglik]=enter_evidence(engine,evidence);  
        m=marginal_nodes(engine,W1);  
        pro(j,i) = m.T(2)  
    end
end


% 
% engine=jtree_inf_engine(bnet);  
% evidence=cell(1,N);  
% evidence{M11} =2; 
% evidence{M21} =2;   
% evidence{M12} =1;
% evidence{M22} =1; 
% [engine,loglik]=enter_evidence(engine,evidence);  
% m=marginal_nodes(engine,W1);  
% m.T(2)  