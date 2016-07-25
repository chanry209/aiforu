function name = FaultName(x);
name{size(x,2)} = [];
for i = 1:size(x,2)
    temp = x(:,i);
    [y,z]=find(temp==1);
    
    if sum(temp)==0
        name{i} = 'REF';
    else
        ind1 = y(1);
        ind2 = y(end);
        ind3 = y(1):y(end);
        name{i} = strcat('F',num2str(ind1),'_',num2str(ind2),'_',num2str(ind3));
    end    
end