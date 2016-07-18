% model GMM avec paramètre
% I: image quantifie
% seg: 
% N: nombre de class

function [mu,sigma]=GMM_parameter(I,seg,N)

[n,d]=size(I);

mu=zeros(N,d);
sigma=zeros(d,d,N);

for i=1:N
    Im_i=I(seg==i,:);
    [sigma(:,:,i),mu(i,:)]=covmatrix(Im_i);
end

end