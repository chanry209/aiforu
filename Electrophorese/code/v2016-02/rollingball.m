function [baseline,y]=rollingball(x,radiusX,radiusY)
    xb=x/radiusY*radiusX;
    baseline=zeros(size(x));
    centers=zeros(size(x)+2*radiusX);
    for i=1-radiusX:length(x)+radiusX
        p=max(1,i-radiusX):min(length(x),i+radiusX);
        y=sqrt(radiusX*radiusX-(p-i).*(p-i));
        centers(i+radiusX)=min( xb(p)-y );        
        
    end
    for i=1:length(x)
        %p=max(1,i-radiusX):min(length(x),i+radiusX);
        p=i-radiusX:i+radiusX;
        baseline(i)=max(centers(p+radiusX)+sqrt(radiusX*radiusX-(p-i).*(p-i)));
    end
    baseline=baseline*radiusY/radiusX;
    y=x-baseline;
    %plot([x;baseline;centers*radiusY/radiusX]')
    
end