features=[mcg, gvh, alm, mit, erl, pox, vac, nuc];
clty = {'CYT'; 'NUC'; 'MIT'; 'ME3'; 'ME2'; 'ME1'; 'EXC'; 'VAC'; 'POX'; 'ERL'};
Target=[];
for i = 1:1484
    t = strcmpi(class(i),clty);
    Target=[Target,t];    %%need to be improved
end;

%%%Manipulate data before we train our ANN
%%split the data into two groups, with identical class distribution.
[trnset,tstset] = crossvalind('HoldOut',class, 0.25);
trnfeatures = features(trnset,:);
tstfeatures = features(tstset,:);
trnTarget = Target(:,trnset);
tstTarget = Target(:,tstset);

%%%%training the network
[With,Whto,tw, E, rr] = sigmoid(trnfeatures, trnTarget, 3000, 0.1, tstfeatures, tstTarget);

%%%%retrain NN with all the samples
[With,Whto,tw, E, rr] = sigmoid(features, Target, 3000, 0.1, features, Target);

%%Q3.
%%%%Calculate the weights update for the first sample
[With, Whto] = sigmoid(features(1,:), Target(:,1), 1, 0.1, features(1,:), Target(:,1));


%%Q4
%%%%%%%%%%%
net = feedforwardnet([10,10,10])
net = train(net,features',Target);
y=net(features');
mse = norm(Target - y)/14840;



%%Q5
%%%%%%%%%%%
q5sample = [0.50 0.52 0.52 0.20 0.60 0.00 0.50 0.29];
[With,Whto] = sigmoid(features, Target, 1000, 0.1, features, Target);
node = 1./exp(-[1,q5sample]*With);
output = 1./exp(-[1,node]*Whto);
find(output==max(output))




