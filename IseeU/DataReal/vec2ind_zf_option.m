% function vectors to indice 
% @zefeng 29/08/2011
% function ind = vec2ind_zf(vec)
% vec must be R caractors x P samples
% ind : 1 x P 
% vec_sample : R x quantity of the vectors
% nbSample   : 1 x quantity of the vectors  
% option == 1; we don't care the forme of vecteur
% option == 2; the vection is in the forme 0 & 1, ex: 0 0 1 = 1: 0 1 0 = 2

function [ind,vec_sample,nbSample] = vec2ind_zf_option(vec,option)

if option==1
[m,n] = size(vec);
j  = 1; % index starts with 1
vec_sample(1:m,j) = vec(:,1);
ind = zeros(1,n);
ind(1) = 1; %
nbSample(1)=1;

for i = 2:n
    
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

%% Option == 2, all the vector is as 0 0 1 ; 0 1 0 ; 0 0 1 
if option==2
[m,n] = size(vec);
ind = zeros(1,n);
Sample = zeros(m,m);
vec_sample = zeros(1,m);
for j = 1:m
    tempSample = zeros(m,1);
    tempSample(j,1) = 1;
    Sample(:,j) = tempSample;
end

for i = 1:n
    for j = 1:m
        if isequal(vec(:,i),Sample(:,j))
            ind(i)=j;
            vec_sample(j)=vec_sample(j)+1;
        end
    end
end
vec_sample = Sample;
end
end