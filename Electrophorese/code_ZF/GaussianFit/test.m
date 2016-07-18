function test()
x = 1:1000;
y = gaussmf(x,[30,200])+gaussmf(x,[60,600]); % function of matlab
plot(y);
% y = gaussian_distri_ZF(x,500, 10,1);

% Fitting Gaussian parameters
% z = log(y(:));
% b2 = -1/S;
% b1 = 2*mu/S;
% b0 = log(ymax)-mu^2/S;

X = [ones(length(x),1), x, x.^2];






    

