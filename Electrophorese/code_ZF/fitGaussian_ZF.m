function [ymax, mu, S, d] = fitGaussian_ZF(x,y,fig)
x = x(:);
y = y(:);

%% Fitting Gaussian parameters
% b2 = -1/S;
% b1 = 2*mu/S;
% b0 = log(ymax)-mu^2/S;
% [y,Index] = sort(y);
% x = x(Index);

Z = log(y);

X = [ones(length(x),1), x, x.^2];
B = pinv(X)*Z;


b2 = B(3);
b1 = B(2);
b0 = B(1);

S = -1/b2;
mu = b1*S/2;
ymax = exp((b0+mu^2/S));
y_test = ymax*exp(-(x-mu).^2/S);

if fig == 1
    plot(x,y_test,'-')
end
%% quadre erreur
d = sum((y-y_test).^2);


    

