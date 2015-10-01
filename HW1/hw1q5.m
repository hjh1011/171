Error=[];
for j=0:2
    error=hw1q5f(indv(1:300,:),indv(301:392,:),...
        mpg(1:300),mpg(301:392),j); %%indv is defined in Q4
    Error=[Error;error];
end
plot(0:2,Error(:,1),'r.-');
hold on;
plot(0:2,Error(:,2),'g*-');
hold off;
legend('trainning error','testing error')