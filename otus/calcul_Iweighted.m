function resI=calcul_Iweighted(I,w)
[m,n]=size(I);
%sumW=sum(weight);
l=fix(m/10);
Iweighted=zeros(m,n);
for i=1:m
    for j=1:n
        if i<l
            Iweighted(i,j)=I(i,j).*w(1);
        elseif  l<=i&&i<4*l
            Iweighted(i,j)=I(i,j).*w(2);
        elseif  4*l<=i&&i<6*l
            Iweighted(i,j)=I(i,j).*w(3);
        elseif  6*l<=i&&i<9*l
            Iweighted(i,j)=I(i,j)*w(4);
        else
            Iweighted(i,j)=I(i,j).*w(5);
        end
    end        
end
resI=Iweighted;
end