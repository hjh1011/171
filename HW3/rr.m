function [varargout] = rr(X, Y, lambda)  %%X and Y here are standardized
[ncase, nvariables] = size(X);  %%number of input cases and variables
W = inv(X'*X + lambda*eye(nvariables))*X'*Y;
varargout = {W};               %%output estimated coefficients