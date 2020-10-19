%We have used two levels of quantization
k=2;

full_daG = Ecoli_dag + eye(size(Ecoli_dag)); % full network matrix
[data_len, N] = size(expr_matrix);

[dEcoli, class_proportions] = discretization(expr_matrix,k, net); % discretization of the expression data
X = class_proportions(:);
pos_comb = truth_table(Ecoli_dag,k);
node_fun = prob_cpd(Ecoli_dag, dEcoli, k);  % regulation function of the node (CPT-distribution)

% initialize FGN msg updates
var_msg = cell(N,N);  % variable node messages
idx_init = find(full_daG == 1);
for i = 1:length(idx_init)
    var_msg{idx_init(i)} = ones(1,k);
    %     var_msg{idx_init(i)} = normalization(rand(1,k));
end

% update the network
count = 0;
error = ones(N,1);
tmp1 = zeros(N,1);
corr_r = [];


while  count < 100 && 1e-4 < max(error)
    % Message Passing updates
    % fact_msg: msgs from factor nodes to variable edges f12 = msg f2 --> x1
    % var_msg: msgs from variable nodes to factor edges  x12 = msg x1 --> f2
    % marginals: posterior distribution of the nodes
    
    fact_msg = f_node_update(node_fun,pos_comb,full_daG,var_msg,k);
    [var_msg, marginals] = v_node_update(full_daG,fact_msg,k);
    
    tmp2 = cell2mat(marginals);
    error = tmp2(:,1) - tmp1;
    tmp1 = tmp2(:,1);
    count = count + 1;

end


beliefs = cell2mat(marginals);
Y = beliefs(:);
[r, p] = corrcoef(X,Y,'alpha',0.01);
corr_coef = r(1,2);
p_value = p(1,2);
iterations = count;
disp(strcat('No. of Iterations: ',num2str(count)));
% genes = genes';
Tab = table(genes', beliefs, class_proportions);
disp(Tab)

% Correlation plots
figure(2);
axis square;
axis([0 1 0 1]);
scatter(X,Y, 'ob');
lsline;
ylabel('loopy belief');
xlabel('node proportions');

str = ['r= ',num2str(corr_coef)];
T = text(min(get(gca, 'xlim')), max(get(gca, 'ylim')), str);
set(T, 'verticalalignment', 'top', 'horizontalalignment', 'left');

