n = length(expr_matrix(1,:));
idx = ones(1,n);
T = 1000;
k = round(sqrt(n));
vim = plsnet(expr_matrix,idx,4,k,T);

vec = vim(:);
tot_ed = n^2-n;
s_vec = sort(vec,'desc');
s_vec = s_vec(1:tot_ed);
ind = uint8(tot_ed*fract);
thresh = s_vec(ind);
Ecoli_dag = double(vim>thresh);

view(biograph(Ecoli_dag, genes, 'LayoutType','hierarchical')); % radial, equilibrium, hierarchical

dlmwrite('../output/GRN.txt',Ecoli_dag);
filePh = fopen('../output/Genes.txt','w');
fprintf(filePh,'%s\n',genes{:});
fclose(filePh);