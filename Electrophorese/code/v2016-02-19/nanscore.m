function scorec=nanscore(im)
    scorec=zeros(size(im,1),1);
    for i=1:length(scorec)
        scorec(i)=mean(im(i,~isnan(im(i,:))));
    end
    for i=find(isnan(scorec(1:end-1))&~isnan(scorec(2:end)))'
        ff=min(15,size(im,1)-i);
        f=find(isnan(scorec(i+1:i+ff)),1,'first');
        if(~isempty(f) && f>1)
            scorec(i+1:i+f)=NaN;
        end
    end
    i=find(isnan(scorec),1,'first');
    while ~isempty(i)
        f=find(~isnan(scorec(i+1:end)),1,'first');
        if(isempty(f))
            scorec(i:end)=scorec(i-1);
        else
            scorec(i-1:i+f)=linspace(scorec(i-1),scorec(i+f),f+2);
        end
        i=find(isnan(scorec),1,'first');
    end
    
end