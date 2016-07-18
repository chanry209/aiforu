function [p,d2,d,l]=findpeaks(curve,res,seuils0)
    p=find(curve(2:end-1)<=curve(3:end) & curve(2:end-1)<curve(1:end-2) )+1;
    
    dt=round(res/40);
    p=p(p>dt & p<length(curve)-dt);
    bb=curve(p)<-seuils0;
    p=p(bb);
    
    i=1;
    while i<length(p)
        m=max(curve(p(i):p(i+1)));
        if m<(curve(p(i))+curve(p(i+1)))/3
            [~,q]=max([curve(p(i)),curve(p(i+1))]);
            p=p([1:i+q-2 i+q:end]);
            
        else
           i=i+1;
        end
    end
    d2=(curve(p-dt)+curve(p+dt)-2*curve(p))*40*40;
    d=zeros(size(p));l=zeros(size(p));
    for i=1:length(p)
        de=find(curve(1:p(i))<curve(p(i))/2,1,'last');
        if(isempty(de))
            de=1;
        end
        fi=find(curve(p(i)+1:end)<curve(p(i))/2,1,'last')+p(i);
        if(isempty(fi))
            fi=length(curve);
        end
        l(i)=fi-de;
        d(i)=curve(fi-1)-curve(fi)+curve(de+1)-curve(de);
    end
end