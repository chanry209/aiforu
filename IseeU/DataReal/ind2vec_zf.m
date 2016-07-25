% function indice to vector 
% @zefeng 29/08/2011
% function ind = ind2vec_zf(ind)
% vec must be R caractors x P samples
% ind : 1 x P or P x 1 

function [vec,option]= ind2vec_zf(ind)
m = length(ind);
if min(ind)~=1
ind=ind-1;
    option = 0;%'No Ref in the data';
else 
    option = 1;%'There is data of Ref'; 
end

maxInd = max(ind);
vec = zeros(maxInd,m);

for i = 1:m
    vec(ind(i),i)=1;
end
end