function [IDX,T1,T2]=otus3level(I)
 
I=double(I);
[m,n]=size(I);
L=256;

% Convert to 256 levels
I = I-min(I(:));
I = round(I/max(I(:))*255);

% Probability distribution
unI = sort(unique(I));
nbr=min(length(unI),L);
% histo is the count of pixel 
% val is the value of pixel
if nbr<L
    [histo,val] = hist(I(:),unI);
else
    [histo,val] = hist(I(:),256);
end
% probability of each pixel
probas=histo/sum(histo);
clear unI;

% initialization
w=zeros(1,size(probas,2));
for i=1:size(probas,2)
    w(i)=sum(probas(1:i));
end
temp=(1:nbr).*probas;
u=zeros(1,nbr);
for j=1:nbr
    u(j)= sum(temp(1:j));
end

w0=w;
w2 = fliplr(cumsum(fliplr(probas)));% filplr: filp matrix in left/right direction
[w0,w2] = ndgrid(w0,w2);       % rectangular grid in N-D space

u0 = u./w;
u2 = fliplr(cumsum(fliplr((1:nbr).*probas))./cumsum(fliplr(probas)));
[u0,u2] = ndgrid(u0,u2);

w1 = 1-w0-w2;
w1(w1<=0) = NaN;

varB =w0.*(u0-u(end)).^2 + w2.*(u2-u(end)).^2 +...
        (w0.*(u0-u(end)) + w2.*(u2-u(end))).^2./w1;   

varB(isnan(varB))=0; % reurn 1 when NaN,thus return 0

[maxVar,k]=max(varB(:));
% returns T1,T2 containing the row,column subscripts corresponding to 
% the index matrix k and a matrix of size nbr
[T1,T2]=ind2sub([nbr nbr],k); 
% maxVar
T1
T2

%   segmented image
IDX = ones(size(I))*3;
IDX(I<=val(T1)) = 1;
IDX(I>val(T1) & I<=val(T2)) = 2;

sf = maxVar/sum(((1:nbr)-u(end)).^2.*probas);
sf
end

 

