for i=1:length(mpg)
   if mpg(i) > quantile1 && mpg(i)<=quantile2  %%%quantile1 and quantile2 is defined in Q1
    ismedium(i) = 1;
    islow(i)=0;
    ishigh(i)=0;
   elseif mpg(i) > quantile2
    ismedium(i) = 0;
    islow(i)=0;
    ishigh(i)=1;
   else
    ismedium(i) = 0;
    islow(i)=1;
    ishigh(i)=0;
   end 
end
islow=islow';
ismedium=ismedium';
ishigh=ishigh';
%%%%%%%%%%%%%%% threshold is set to be 0.65
z_low=[ones(92,1),indv(301:392,:)]*GDlogit(indv(1:300,:),islow(1:300),120000,0.0001);
yhat_low=1./(1+exp(-z_low));
for j=1:92
if yhat_low(j)>0.65
    ilow(j)=1;
else
    ilow(j)=0;
end
end
sum((islow(301:392)-ilow').^2)/92

z_medium=[ones(92,1),indv(301:392,:)]*GDlogit(indv(1:300,:),ismedium(1:300),120000,0.0001);
yhat_medium=1./(1+exp(-z_medium));
for j=1:92
if yhat_medium(j)>0.65
    imedium(j)=1;
else
    imedium(j)=0;
end
end
sum((ismedium(301:392)-imedium').^2)/92

z_high=[ones(92,1),indv(301:392,:)]*GDlogit(indv(1:300,:),ishigh(1:300),120000,0.0001);
yhat_high=1./(1+exp(-z_high));
for j=1:92
if yhat_high(j)>0.65
    ihigh(j)=1;
else
    ihigh(j)=0;
end
end
sum((ishigh(301:392)-ihigh').^2)/92
