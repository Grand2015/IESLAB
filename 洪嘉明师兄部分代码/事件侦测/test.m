clear all;
intra = zeros(2);
intra(1,2) = 1; % node 1 in slice t connects to node 2 in slice t

inter = zeros(2);
inter(1,1) = 1; % node 1 in slice t-1 connects to node 1 in slice t

Q = 2; % num hidden states
O = 2; % num observable symbols

ns = [Q O];
dnodes = 1:2;
onodes = 2;
eclass1 = [1 2];
eclass2 = [3 2];
eclass = [eclass1 eclass2];

bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes, 'eclass1', eclass1, 'eclass2', eclass2);
prior0 = normalise(rand(Q,1));
transmat0 = mk_stochastic(rand(Q,Q));
obsmat0 = mk_stochastic(rand(Q,O));
bnet.CPD{1} = tabular_CPD(bnet, 1, prior0);
bnet.CPD{2} = tabular_CPD(bnet, 2, obsmat0);
bnet.CPD{3} = tabular_CPD(bnet, 3, transmat0);


T =2;
ss = 2;
engine = jtree_unrolled_dbn_inf_engine(bnet, T); 
ev = sample_dbn(bnet, T);
evidence = cell(ss,T);
evidence(onodes,:) = ev(onodes, :); % all cells besides onodes are empty
[engine, ll] = enter_evidence(engine, evidence);
marg = marginal_nodes(engine, 1, 2);
