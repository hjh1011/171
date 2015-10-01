stdata = [];
SD = [];
AVG = [];
for i = 1:4496    %%to apply ridge regression, we need to standardize the data first
    avg = mean(data(:, i));
    sd = sqrt(var(data(:, i)));
    SD = [SD; sd];  %%standard deviation of each variable
    AVG = [AVG; avg];  %% mean of each variable
    if sd ~= 0
       stdata = [stdata,(data(:, i) - avg)/sd];
    else
        stdata = [stdata, data(:, i)];
    end;
    
end;

%% to find the optimal lambda by MSE with cross-validation
indices = crossvalind('Kfold', 222, 10); %%create indices of 10-fold CV

LMD = 1:1:50;
error = [];

for k = 1:length(LMD) %%this for loop will take relatively long time!!!
    MSE = 0;
for j = 1:10
    test = (indices == j);
    train = ~test;
    w = rr(stdata(train,2:4496), stdata(train, 1), LMD(1,k));
    estimate = stdata(test, 2:4496)*w;
    mse = sum((stdata(test, 1) - estimate).^2)/22.2;
    MSE = MSE + mse*0.1;
end;
error = [error; MSE];
end;
plot(LMD, error);

LMD = 25:0.1:27;
error = [];   %%then run line21 to line33

%%we decide to set lambda to be 25.7, which has the least MSE
%% using all the data
W = rr(stdata(:,2:4496), stdata(:,1), 25.7);
sum(W==0)
sum(abs(W) < 1e-4)
sum(abs(W) < 1e-3)

%%to get the estimation of y, first we need to transform the coefficient
%%back to the original scale

Wo = [];
for l = 2:4496
    if SD(l,1) ~= 0
      Wo = [Wo; W(l-1,1)*SD(1,1)/SD(l,1)];
    else
      Wo = [Wo; W(l-1,1)];
    end
end
Wo = [AVG(1,1)-AVG(2:4496,1)'*Wo; Wo];

Prediction = Wo(1,1) + AVG(2:4496,1)'*Wo(2:4496,1)
