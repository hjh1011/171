function [varargout] = sigmoid(input, target, n, alpha, tstinput, tsttarget)
  m = size(input);
  m = m(1);   %%number of training samples
  l = size(tstinput);
  l = l(1);   %%number of testing samples
  input = [ones(m,1), input];
  tstinput = [ones(l,1), tstinput];
  With = unifrnd(-0.3,0.3,[9,3]);
  Whto = unifrnd(-0.3,0.3,[4,10]);
  %With = zeros(9, 3);
  %Whto = zeros(4, 10);
  TestW=[];
  for j = 1:n
      for i = 1:m
        node = [1, 1./(1+exp(-input(i,:)*With))];
        output = 1./(1+exp(-node*Whto));
        errorop = output.*(1-output).*(target(:,i)'-output);
        errorhd = node.*(1-node).*(errorop*Whto');
        Whto = Whto + alpha*node'*errorop;
        With = With + alpha*input(i,:)'*errorhd(2:4);
      end;
      TestW = [TestW;With(2,:)];
      Node = [ones(l,1), 1./(1+exp(-tstinput*With))];
      Output = 1./(1+exp(-Node*Whto))';
      error = sum(sum(abs(tsttarget-Output)))/l;
      E(j) = error;
      for k =1:l
          Output(:,k) = Output(:,k)==max(Output(:,k));
      end;
      rate = 1 - length(find(sum(abs(tsttarget - Output))==0))/l;
      rr(j)=rate;
  end;
  
  varargout = {With; Whto;TestW; E; rr};
end