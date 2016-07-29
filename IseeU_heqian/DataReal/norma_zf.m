function [normal,ps] = norma_zf(x,kind,ymin,ymax)
% by ZF
% last modified 2009.2.24
%
if nargin < 2
    disp('Attention! We normalize the data by row! (one row == one property)');
    disp('If you didn''t chose the kind, we will normalize you data by z score');

    kind = 1;%kind = 1 or 2 
end

if nargin ==3
  disp(' Please define the max of data');
end


if sum(kind~=[1,2,3,4,5,6,7])>=8
    error('You inputed a kind unknown, it must be a value between 1 and 6');
end
 
    
[m,n]  = size(x);
normal = zeros(m,n);

%% Z score 
if kind == 1
    for i = 1:m
        mea = mean( x(i,:) );
        ps.mean(i)=mea;
        ps.std(i) = std(x(i,:));
        normal(i,:) = ( x(i,:)-mea )/std(x(i,:));
    end
end
%% Valeur centrees
if kind == 2
    for i = 1:m
        mea = mean( x(i,:) );
        normal(i,:) =  x(i,:)-mea ;
        ps.mea(i)=mea;
    end
end
%% normalize the data x to [-1,1]
if kind == 3 
    for i = 1:m
        mea = mean( x(i,:) );
        ma = max( x(i,:) );
        mi = min( x(i,:) );
        ps.ma(i) =ma;
        ps.mi(i) = mi;
        ps.mea(i) = mea;
        normal(i,:) = ( x(i,:)-mea)./( ma-mi );
    end
end

%% normalize the data x to [ymin,ymax]
if kind==4
    for i = 1:m    
        mea = mean(x(i,:));
        ma = max(x(i,:));
        mi = min(x(i,:));
        ps.ma(i) =ma;
        ps.mi(i) = mi;
        ps.mea(i) = mea;
        ps.ymin = ymin;
        ps.ymax = ymax;
        normal(i,:) = (ymax-ymin)*( x(i,:)-mi)./( ma-mi )+ymin;
    end
end
%% Normalization logistic
if kind == 5
        normal = 1./(1+exp(-x));    
end
%% Fuzzy
if kind == 6
    for i = 1:m
        normal(i,:) = 1/2+1/2*sin(pi./(max(x(i,:))-min(x(i,:)))*(x(i,:)-(max(x(i,:))-min(x(i,:)))/2));
    end
end
%% Atan
if kind == 7
    normal = atan(x)*2/pi;
end   

%% Lionel
if kind == 8
    for i = 1:m
        mea = mean( x(i,:) );
        ps.mean(i)=mea;
        ps.std(i) = std(x(i,:));
        normal(i,:) = ( x(i,:)-mea )/3/std(x(i,:));
    end
end
end
