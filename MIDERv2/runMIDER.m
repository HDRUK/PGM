fprintf(1,'\n \n Running MIDER...');
tStart = tic;

npoints = size(expr_matrix,1); % number of data points
ntotal  = size(expr_matrix,2); % number of variables

%--------------------------------------------------------------------------
% OPTIONS 

options.useStatistics = 0;
options.correctOutliers = 0; % correct outliers (=1) or not (=0)
options.q = 1; % q = 1 (Boltzmann-Gibbs entropy) | q > 1 (Tsallis entropy) 
options.MItype = 'MI'; %'MI' | 'MImichaels' | 'MIlinfoot' | 'MIstudholme'  
options.fraction  = 0.1*(log10(npoints)-1); 
if options.fraction < 0.01, options.fraction = 0.01; end %lower bound=0.01

% Maximum time lag considered (>= 0):
options.taumax = 10;
if options.taumax > (npoints/2 -1)
    options.taumax = floor(npoints/2);
    fprintf(1,'\n Warning: the maximum time lag you have requested is too large for the number of data points.'); 
    fprintf(1,'\n => Setting the max. time lag to %d',options.taumax); 
end

% Number of entropy reduction (ERT) rounds to carry out (0, 1, 2):
options.ert_crit = 2;  
% Entropy reduction threshold. Enter a number between 0.0 and 0.2 to fix it
% manually, or enter 1 to use a value obtained from the data:
options.threshold = 1;

% Plot MI arrays (=1) or not (=0):
options.plotMI = 0;


%--------------------------------------------------------------------------
% RUN MIDER

Output = mider(expr_matrix,options);

%--------------------------------------------------------------------------
% TIME

fprintf(1,'\n Total wall clock time taken for MIDER: %d seconds.\n ',toc(tStart)); 


vec = Output.con_array(:);
s_vec = sort(vec,'desc');
s_vec = s_vec(s_vec~=0);
tot_ed = length(s_vec);
ind = uint8(tot_ed*fract);
thresh = s_vec(ind);
Ecoli_dag = double(Output.con_array'>=thresh);

view(biograph(Ecoli_dag, genes, 'LayoutType','hierarchical'));

dlmwrite('../output/GRN.txt',Ecoli_dag);
filePh = fopen('../output/Genes.txt','w');
fprintf(filePh,'%s\n',genes{:});
fclose(filePh);