function [difference] = diffnoinf(x,y)

difference = x(find(isfinite(x)==1))-y(find(isfinite(x)==1));
