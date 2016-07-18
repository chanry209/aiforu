% function vectors to indice 
% @zefeng 29/08/2011

% update 24/12/2011 - deal with the real data whose ref all is zero - zeros(m,1)

% function ind = vec2ind_zf(vec)
% vec must be R caractors x P samples
% ind : 1 x P 
% vec_sample : R x quantity of the vectors
% nbSample   : 1 x quantity of the vectors  

function [ind,vec_sample,nbSample] = vec2ind_zf(vec)
[m,n] = size(vec);
j  = 1; % index starts with 1
%vec_sample(1:m,j) = vec(:,1);
vec_sample(1:m,j) = zeros(m,1);

% if sum(vec_sample(1:m,j) ~= vec(:,1))>0
%     vec_sample(1:m,j+1) = vec(:,1);
% end

ind = zeros(1,n);
ind(1) = 0; %
nbSample(1)=0;

for i = 1:n
    
    ind_count = 0;
    for k = 1:j
        if isequal(vec(:,i), vec_sample(:,k))==1
           ind(i)=k; 
           nbSample(k)=nbSample(k)+1;
        else
            ind_count = ind_count+1;
        end
    end
    
    if ind_count == j
       j = j+1;
       ind(i)=j;    
       vec_sample(1:m,j) = vec(:,i);
       nbSample(j)=1;
    end
 
end
end