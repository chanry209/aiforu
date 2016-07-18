function auc=roc(c1,c2)

c=[c1 c2];
mi=min(c);ma=max(c);

t=linspace(mi,ma,1000);
x=zeros(length(t),1);
y=zeros(length(t),1);
for i=1:length(t)
    x(i)=sum(c1>t(i))/length(c1);
    y(i)=sum(c2>t(i))/length(c2);
end

figure;
plot(x,y,[0 1],[0 1])
plot3(x,y,t)

auc=sum((y(2:end)+y(1:end-1)).*(x(2:end)-x(1:end-1))/2);