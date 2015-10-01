function [varargout] = getlevel(textdata)
levels = textdata(1,1);
for i = 2:length(textdata)
    if sum(strcmpi(levels, textdata(i,1))) == 1
    else
    levels = [levels; textdata(i,1)];
    end    
end
varargout = {levels}