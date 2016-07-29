function [IDX,T1,T2,T3]=otus4level(I)
 
I=double(I);
[m,n]=size(I);
L=256;

T1=otus(I);
% calculer les moyennes et les variance
c1=I(I<T1);
c2=I(I>T1);
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

T2=otus(new_class);
c3=new_class(new_class>T2);
c4=new_class(new_class<T2);

[u3,u4,w3,w4,var3,var4,varB2] = calcul_var(new_class,T2);

maxVar=max(max(rest_var,var3),var4);
maxVar

if var1==maxVar
    T3=otus(c1);
elseif var2==maxVar
    T3=otus(c2);
elseif var3==maxVar
    T3=otus(c3);
else 
    T3=otus(c4);
end

T1
T2
T3

seuils=sort([T1,T2,T3]);

IDX = ones(size(I))*4;
IDX(I<=seuils(1)) = 1;
IDX(I>seuils(1) & I<=seuils(2)) = 2;
IDX(I>seuils(2) & I<=seuils(3)) = 3;
IDX(I>seuils(3)) = 4;
end
