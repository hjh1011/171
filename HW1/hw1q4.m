indv=[cylinders,displacement,horsepower,weight,acceleration, modelyear,origin];
Error=[];
error=[];
for i=1:7
    figure;
    plot(indv(:,i),mpg,'r.');
    hold on;
    for j=0:10
        [e,w,X,x]=hw1q3(indv(1:300,i),...
            indv(301:329,i),mpg(1:300),mpg(301:329),j);  %%hw1q3 is the solver coded in Q3
        error=[error;e];
        y=X*w;
        plot(x, y, '-','Color',[0.02*(j+1) 0.05*(11-j) 0.08*(j+1)]);
    end
    legend('','0','1','2','3','4','5','6','7','8','9','10');
    hold off;
    Error=[Error,error];
    error=[];
    figure;
    plot(0:10,Error(:,2*(i-1)+1),'r.-');
    hold on;
    plot(0:10,Error(:,2*i),'b+-');
    legend('trainning MSE','testing MSE');
    hold off
end
