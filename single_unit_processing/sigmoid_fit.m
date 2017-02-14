function y = sigmoid_fit(x,beta)
%Fits a sigmoid to any data. beta

if nargin > 2
    disp('Too many arguments');
elseif nargin < 2
    beta = [1 1];
end

y = 1./(1+exp(-(x-beta(1))./beta(2)));
end