clear all;
%%
load('DBA');
load('BBA');
load('burst');

%% 
for i = 1:10
    for j = 1:288
        if DBA(j,i) ~= 0
            DBA(j,i) = 2;  %2 ��ʾtrue
        else
            DBA(j,i) = 1;  %1 ��ʾfalse
        end            
    end
end

for i = 1:10
    for j = 1:288
        if BBA(j,i) ~= 0
            BBA(j,i) = 2;  %2 ��ʾtrue
        else
            BBA(j,i) = 1;  %1 ��ʾfalse
        end            
    end
end

% Make an HMM with discrete observations
%   X1 -> X2
%   |     | 
%   v     v
%   Y1    Y2 

% BBAΪ1 DBAΪ2 ALARMΪ3
intra = zeros(3);    % ��������ṹ  2��ʾʱ��Ƭ��С
intra(1,3) = 1;
intra(2,3) = 1;
inter = zeros(3);    % ת������ṹ
inter(1,1) = 1;
inter(2,2) = 1;

Q = 2; % num hidden states
O = 2; % num observable symbols

ss = 3;
ns = 2*ones(1,ss);

dnodes = 1:3;             % ���ؽڵ���   ����12���ڵ�   onodes = 9:12; ��ʾ��9�ڵ㵽��12�ڵ�Ϊ�۲�ڵ�  dnodes = 1:12; ��ʾ���ؽڵ����
onodes = 3;             % �۲�ڵ���
eclass1 = 1:3;          % Ϊ��������ṹ�Ľڵ���
eclass2 = [4:5 3];          % Ϊת������ṹ�Ľڵ��� [X(t+1),Yt] ǰ��Ϊt+1ʱ��״̬�����ڵ� ����Ϊtʱ�̹۲�����ڵ�
bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes, 'eclass1', eclass1, 'eclass2', eclass2);

%rand('state', 0);
prior1 = [0.7 0.3];
prior2 = [0.8 0.2];
transmat1 = [0.8 0.2;0.4 0.6];
transmat2 = [0.7 0.3;0.2 0.8];
obsmat1 = [1 0;0.2 0.8;0.4 0.6;0 1];
% prior1 = normalise(rand(Q,1));            % ��ʼ����    Q��1��
% transmat1 = mk_stochastic(rand(Q,Q));     % ״̬ת�ƾ���    
% obsmat1 = mk_stochastic(rand(Q,O));       % �������
bnet.CPD{1} = tabular_CPD(bnet, 1, prior1);
bnet.CPD{2} = tabular_CPD(bnet, 2, prior2);
bnet.CPD{3} = tabular_CPD(bnet, 3, obsmat1);
bnet.CPD{4} = tabular_CPD(bnet, 4, transmat1);
bnet.CPD{5} = tabular_CPD(bnet, 5, transmat2);



T = 2; % fixed length sequences
%% DBN �����㷨

engine = jtree_unrolled_dbn_inf_engine(bnet, T);     % �����㷨
% engine{end+1} = hmm_inf_engine(bnet);
% engine{end+1} = smoother_engine(hmm_2TBN_inf_engine(bnet));
% engine{end+1} = smoother_engine(jtree_2TBN_inf_engine(bnet));
% 
% 
% ev = sample_dbn(bnet, T);
% evidence = cell(ss,T);
% evidence(onodes,:) = ev(onodes, :); % all cells besides onodes are empty
% [engine, ll] = enter_evidence(engine, evidence);
% marg = marginal_nodes(engine, i, t);
% 
ss = 3;

evidence = cell(ss,T);

evidence(1,1) = num2cell(BBA(1,1));

for i = 1:10
    for j = 1:287
        evidence(1,1) = num2cell(BBA(j,i));
        %evidence(1,2) = num2cell(BBA(j+1,i));
        evidence(2,1) = num2cell(DBA(j,i));
        %evidence(2,2) = num2cell(DBA(j+1,i));
        [engine, ll] = enter_evidence(engine, evidence);
        marg = marginal_nodes(engine, 3, 1);
        prob1(j,i) = marg.T(2)
        marg = marginal_nodes(engine, 3, 2);
        prob2(j,i) = marg.T(2)
    end
end
% all cells besides onodes are empty





