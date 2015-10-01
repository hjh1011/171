%%We will only use the features with absolute coefficient bigger than 1e-3
W = rr(stdata(:,2:4496), stdata(:,1), 25.7);
Ftobeused = abs(W) > 1e-3;

gene = data(:,2:4496);
gene = gene(:,Ftobeused);

%%%%Cross-Validation
indices = crossvalind('Kfold', 222, 10); %%create indices of 10-fold CV

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Strain as an example
%%To be succinct, the following only shows the code for Stress
%%To construct the rest of 3, you only have to change the Input
Input = textdata(2:223,4);
Nmiss = 0;
for j = 1:10
    test = (indices == j);
    train = ~test;
    levels = getlevel(Input(train,:));
[wInput,bInput] = svmmulti(gene(train,:),Input(train,:),levels);

%%Predict
Pred = gene(test,:)*wInput' + repmat(bInput',sum(test),1);

P = []; %%prediction
for i = 1:sum(test)
   p = find(Pred(i,:)'==max(Pred(i,:)));
   P = [P; p];
end

Ob = zeros(sum(test),1);
for k = 1:length(levels)
   ob = strcmpi(Input(test,:),levels(k,1))*k;
   Ob = Ob + ob;
end

%% AUC
Err = P - Ob;
nmiss = sum(Err~=0);
Nmiss = Nmiss + nmiss;
end
1-Nmiss/222; %%accuracy








