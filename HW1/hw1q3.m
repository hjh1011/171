function [varargout] = regr(xtrn, xtst, ytrn, ytst, n) %%n is desired polynomial order, xtrn is independent variable for trainning and xtst is for testing
Xtrn=[];
Xtst=[];
X=[];
x=linspace(min([xtrn;xtst]),max([xtrn;xtst]),100)';   %%for plotting purpose
for i=0:n
   Xtrn=[Xtrn, xtrn.^i];
   Xtst=[Xtst, xtst.^i];
   X=[X,x.^i];
end
Wols=inv(Xtrn'*Xtrn)*Xtrn'*ytrn;
trnmse=sum((ytrn-Xtrn*Wols).^2/length(ytrn));
tstmse=sum((ytst-Xtst*Wols).^2/length(ytst));
MSE=[trnmse,tstmse];
varargout={MSE,Wols,X,x};