function [Y]=medgliss(X,win,c)

midwin=(win-1)/2;

Y=zeros(size(X));


for i=1:length(X)
    if(i-1<midwin)
        mwm=i-1;
        mwp=min(max(mwm, floor((midwin-mwm)/2)), length(X)-i);
    elseif(length(X)-i<midwin)
        mwp=length(X)-i;
        mwm=min(max(mwp, floor((midwin-mwp)/2)), i-1);
    else
        mwm=midwin;
        mwp=midwin;
    end
    
    S=sort(X(i-mwm:i+mwp));
    Y(i)=S(round(c*length(S)));

end


