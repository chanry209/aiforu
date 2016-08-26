function [r idx idx1] = findsimularrect(rect,thred)
thred = thred^2;
c = [rect.x ;rect.y] + [rect.x1; rect.y1];                                  %计算每个矩形的中心
c = c./2;
rsz = [rect.x1;rect.y1]-[rect.x;rect.y];                                    %计算每个矩形的大小
err = zeros(1,30);
sel = zeros(2,30);
for i=1:30                                                                  %迭代30次
    i1 = floor(rand()*length(rect)) + 1;
    i2 = i1;
    while(i2 == i1)
        i1 = floor(rand()*length(rect)) + 1;        
    end                                                                     %随机从中取出两个不同的矩形
    sz0 = mean(rsz(:,[i1 i2]),2);                                           %计算矩形大小的均值
    err(i) = sum(dist2(rsz',sz0') > sz0'*sz0*thred);                        %与其它所有矩形计算大小的差
    sel(:,i) = [i1;i2];
end
[min_ besti] = min(err);                                                    %选出以上30次中与所有矩形大小误差最小的一次
sz0 = mean(rsz(:,sel(:,besti)),2);                                          %计算那一次的矩形大小
idx = find(dist2(rsz',sz0') < sz0'*sz0*thred);                              %找出与该大小相差小于一个阈值的矩形（要保留的矩形）
idx1 = find(dist2(rsz',sz0') >= sz0'*sz0*thred);                            %找出与该大小相差超过一个阈值的矩形（要去掉的矩形）
r = rect(idx);