clear
clc

%% User Input

prompt = 'Type a number (1-4): \n1. IBD \n2. PDAC \n3. AML \n4. DREAM4(10) \n5. DREAM4(100) \n6. Other data\n-> ';
net =  sscanf(input(prompt, 's'), '%d');
fprintf('\n');

prompt = 'Type a number (1-2): \n1. Run PLSNET \n2. Run PLSNET and Verify GRN \n3. Run PLSNET multiple times \n4. Run MIDER \n5. Run MIDER and Verify GRN\n-> ';
method =  sscanf(input(prompt, 's'), '%d');
fprintf('\n');

switch net
    case 1
        f_name = 'data/IBD';
    case 2
        f_name = 'data/GSE15471';
    case 3
        f_name = 'data/GSE15061';
    case 4
        f_name = 'data/dream4_10';
    case 5
        f_name = 'data/dream4_100';
end

%% Load Data
if net==6
    tab_csv = readtable('data/data.csv');
else
    tab_csv = readtable(strcat(f_name,'.csv'));
end

if(method~=3)
    prompt = 'Type a value between 0 and 1 (fractions of edges to be selected): ';
    fract =  sscanf(input(prompt, 's'), '%f');
    fprintf('\n');
end

expr_matrix = table2array(tab_csv);
genes = tab_csv.Properties.VariableNames;

%% Execute Algorithms

if(method == 1)
    run('PLSNET/runPLSNET.m');
end
if(method ==2)
    run('PLSNET/runPLSNET.m');
    run('PgmGRNs/verify_grn.m');
end
if(method ==3)
    run('PLSNET/plsnet_repeated.m');
end
if(method ==4)
    run('MIDERv2/runMIDER.m');
end
if(method ==5)
    run('MIDERv2/runMIDER.m');
    run('PgmGRNs/verify_grn.m');
end
%%