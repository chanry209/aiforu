function [C,mat]=covmatrix(I)

[m,n]=size(I);
I=double(I);

if m==1
    C=0;
    mat=I;
else
    mat=sum(I,1)/m;
    I=I-mat(ones(m,1),:);
    C=(I'*I)/(m-1);
    mat=mat';
end
    
end