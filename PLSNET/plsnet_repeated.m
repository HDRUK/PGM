n = length(expr_matrix(1,:));
tot_ed = n^2-n;
idx = ones(1,n);
T = 1000;

fract = [0.02 0.05 0.1 0.15 0.20];
m = length(fract);
vec_reg = zeros(n,m);
vec_int = zeros(n,m);
vec_tar = zeros(n,m);

prompt = 'Type the number of times you want to execute PLSNET: ';
ntimes =  sscanf(input(prompt, 's'), '%f');
fprintf('\n');

i = 0;

while i<ntimes
    try
        vim = plsnet(expr_matrix,idx,4,5,T);
    catch
        disp(i);
        disp('continute');
        continue;
        
    end
    i = i+1;
    vec = vim(:);
    s_vec = sort(vec,'desc');
    s_vec = s_vec(1:tot_ed);
    for j=1:m
        ind = uint8(tot_ed*fract(j));
        thresh = s_vec(ind);
        gr = double(vim>thresh);
        d1 = sum(gr,1)>0;
        d1 = d1';
        d2 = sum(gr,2)>0;
        d3 = (d1+d2)>1;
        d1 = d1-d3;
        d2 = d2-d3;
        vec_tar(:,j) = vec_tar(:,j) + d1;
        vec_reg(:,j) = vec_reg(:,j) + d2;
        vec_int(:,j) = vec_int(:,j) + d3;
    end
    disp(strcat('I = ',num2str(i)));
end
vec = zeros(n,m*3);
for i=1:m
    ind = (i-1)*3;
    vec(:,ind+1) = vec_reg(:,i);
    vec(:,ind+2) = vec_tar(:,i);
    vec(:,ind+3) = vec_int(:,i);
end

dlmwrite('../output/frequencies.txt',vec);
filePh = fopen('../output/Genes.txt','w');
fprintf(filePh,'%s\n',genes{:});
fclose(filePh);