function [theta] = GDlogit(x,y,n,alpha)
nv=size(x,2);
no=size(x,1);
theta=zeros(nv+1,1);
x0=ones(no,1);
X=[x0,x];
for i=1:n
   prd=1./(1+exp(-X*theta));
   e= prd-y;
   for j=1:(nv+1)
       theta(j)=theta(j)-alpha*sum(e.*X(:,j))/no;  %%Batch GD
   end
end