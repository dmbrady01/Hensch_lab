function [x] = SEM(x)

n = length(x);
s = std(x);

x = s./(n.^.5);