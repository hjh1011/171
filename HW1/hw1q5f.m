function [varargout] = regr(xtrn, xtst, ytrn, ytst,n) %%n is desired polynomial order, xtrn is independent variable for trainning and xtst is for testing
ntrn=size(xtrn,1);  %%number of observations in trainning set
ntst=size(xtst,1);  %%number of observations in testing set
nv=size(xtrn,2);    %%number of independent variables
Xtrn=ones(ntrn,1);
Xtst=ones(ntst,1);
if n~=0
for i=1:n
    Xtrn=[Xtrn,xtrn.^i];
    Xtst=[Xtst,xtst.^i];
end
else
end
Wols=inv(Xtrn'*Xtrn)*Xtrn'*ytrn;
trnmse=sum((ytrn-Xtrn*Wols).^2/length(ytrn));
tstmse=sum((ytst-Xtst*Wols).^2/length(ytst));
MSE=[trnmse,tstmse];
varargout={MSE,Wols,Xtrn};