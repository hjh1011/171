MPG=[mpg,cylinders,displacement,horsepower,weight,acceleration, modelyear,origin];
names = char('mpg','cylinders','displacement','horsepower','weight','acceleration',...
    'modelyear','origin');
cg=ones(length(mpg),1);

for i=1:length(mpg)
if mpg(i) > quantile1 && mpg(i)<=quantile2  %%%quantile1 and quantile2 is defined in Q1
    cg(i) = 2
elseif mpg(i) > quantile2
    cg(i) = 3
else
end
end

gplotmatrix(MPG,[],cg,[],'o+*',[3],'on','',names,names);
