function ssq = peakfitmin(par,sp,v)
%this is main function that controls how ssq is minimised;
%   
    fit=mCDHO(v,par(1,:),par(2,:),par(3,:),par(4,:));
    ssq=sum((fit-sp).^2);
   
    % constrain peaks to be within spectral range
    pptst=min(par(1,:))<min(v)|| max(par(1,:))>max(v);
    ssq=ssq*(1+pptst*1e20);
    
    % constrain widths to be positive
    pww=1e20*(par(3,:)<0);
    ssq=ssq*(1+sum((par(3,:).^2).*pww));
    
    % constrain intensities to be positive;
    piw=1e20*(par(2,1:end)<0);
    ssq=ssq*(1+sum((par(2,1:end).^2).*piw));
   
    % Constrain assymetry parameter a to be between 0 and 0.3
    pgf=1e20*(par(4,:)<0 );
    glf=1e20*(par(4,:)>0.3);
    ssq=ssq*(1+sum((par(4,:).^2).*(pgf+glf)));

end

