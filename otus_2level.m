
function [T1, T2] = otus_2level(I)

I=double(I);
[m,n]=size(I);
L=256;

T1=otus(I);
c1=I(I<T1);
c2=I(I>=T1);

% calculer les moyennes et les variance
[u1,u2,w1,w2,var1,var2,varB] = calcul_var(I,T1);

if var1>var2
    new_class=c1;
    new_u=u1;
    new_w=w1;
    new_varT=var1;
    rest_var=var2;
else
    new_class=c2;
    new_u=u2;
    new_w=w2;
    new_varT=var2;
    rest_var=var1;
end

new_class=double(new_class);

T2=otus(new_class);

seuils=sort([T1,T2]);

IDX = ones(size(I))*3;
IDX(I<=seuils(1)) = 1;
IDX(I>seuils(1) & I<=seuils(2)) = 2;
IDX(I>seuils(2)) = 3;
end
