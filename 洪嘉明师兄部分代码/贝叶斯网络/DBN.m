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

% Make an HMM with discrete observations
%   X1 -> X2
%   |     | 
%   v     v
%   Y1    Y2 

% BBA为1 DBA为2 ALARM为3
intra = zeros(3);    % 先验网络结构  2表示时间片大小
intra(1,3) = 1;
intra(2,3) = 1;
inter = zeros(3);    % 转移网络结构
inter(1,1) = 1;
inter(2,2) = 1;

Q = 2; % num hidden states
O = 2; % num observable symbols

ss = 3;
ns = 2*ones(1,ss);

dnodes = 1:3;             % 隐藏节点标号   如有12个节点   onodes = 9:12; 表示第9节点到第12节点为观测节点  dnodes = 1:12; 表示隐藏节点序号
onodes = 3;             % 观测节点标号
eclass1 = 1:3;          % 为先验网络结构的节点标号
eclass2 = (1:3)+3;          % 为转移网络结构的节点标号 [X(t+1),Yt] 前者为t+1时刻状态变量节点 后者为t时刻观测变量节点
bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes, 'eclass1', eclass1, 'eclass2', eclass2, ...
	      'observed', onodes);

%rand('state', 0);
prior1 = [0.7 0.3];
prior2 = [0.8 0.2];
transmat1 = [0.8 0.2;0.4 0.6];
transmat2 = [0.7 0.3;0.2 0.8];
obsmat1 = [1 0;0.2 0.8;0.4 0.6;0 1];
% prior1 = normalise(rand(Q,1));            % 初始矩阵    Q行1列
% transmat1 = mk_stochastic(rand(Q,Q));     % 状态转移矩阵    
% obsmat1 = mk_stochastic(rand(Q,O));       % 输出矩阵
bnet.CPD{1} = tabular_CPD(bnet, 1, prior1);
bnet.CPD{2} = tabular_CPD(bnet, 2, prior2);
bnet.CPD{3} = tabular_CPD(bnet, 3, obsmat1);
bnet.CPD{4} = tabular_CPD(bnet, 4, transmat1);
bnet.CPD{5} = tabular_CPD(bnet, 5, transmat2);



T = 2; % fixed length sequences
%% DBN 推理算法
engine = {};
engine{end+1} = jtree_unrolled_dbn_inf_engine(bnet, T);     % 团树算法
% engine{end+1} = hmm_inf_engine(bnet);
% engine{end+1} = smoother_engine(hmm_2TBN_inf_engine(bnet));
%engine{end+1} = smoother_engine(jtree_2TBN_inf_engine(bnet));
% 
% 
% ev = sample_dbn(bnet, T);
% evidence = cell(ss,T);
% evidence(onodes,:) = ev(onodes, :); % all cells besides onodes are empty
% [engine, ll] = enter_evidence(engine, evidence);
% marg = marginal_nodes(engine, i, t);
% 

evidence = cell(3,T);
evidence{1,1} = BBA(1,1);
evidence{1,2} = BBA(1,2);
evidence{2,1} = DBA(1,1);
evidence{2,2} = DBA(1,2);
% 
% N=3
% 
%         evidence=cell(1,N); 
%         evidence{1}=BBA(1,1);
%         evidence{2}=DBA(1,1);
% %         evidence{4}=DBA(2,1);  
% %         evidence{5}=BBA(2,1);  
% 
% 
[engine ll]= enter_evidence(engine, evidence);
m = marginal_nodes(engine, nodes, 3);
% m.T(2)






