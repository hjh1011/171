function [varargout] = svmmulti(X, label, labellevel)
ncase = length(label);
nlevel = length(labellevel);
wv = [];
B = [];
for i = 1:nlevel
   isK = strcmpi(label,labellevel(i,1))*1;
   for j = 1:length(isK)
   if isK(j,1) == 0
       isK(j,1) = -1;
   else
   end
   end
H = ((X*X').*(isK*isK'));
f = -ones(ncase,1);
A = -eye(ncase);
a = zeros(ncase,1);
EQ = isK';
eq = 0;
alpha = quadprog(H+eye(ncase)*0.001, f, A, a, EQ, eq);  %%eye(ncase)*0.001 is for stability

w = (alpha.*isK)'*X;
row = find(alpha > 0.0001);
if isempty(row)*1 == 0
  b = 1/isK(row(1,1),1) - w*X(row(1,1),:)';
  
  B = [B;b];
else
  B = [B;0];  
end
  wv = [wv;w];
end


varargout = {wv,B}; %%wv and B will together define nlevel decision bounderies