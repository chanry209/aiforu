function [r idx idx1] = findsimularrect(rect,thred)
thred = thred^2;
c = [rect.x ;rect.y] + [rect.x1; rect.y1];                                  %����ÿ�����ε�����
c = c./2;
rsz = [rect.x1;rect.y1]-[rect.x;rect.y];                                    %����ÿ�����εĴ�С
err = zeros(1,30);
sel = zeros(2,30);
for i=1:30                                                                  %����30��
    i1 = floor(rand()*length(rect)) + 1;
    i2 = i1;
    while(i2 == i1)
        i1 = floor(rand()*length(rect)) + 1;        
    end                                                                     %�������ȡ��������ͬ�ľ���
    sz0 = mean(rsz(:,[i1 i2]),2);                                           %������δ�С�ľ�ֵ
    err(i) = sum(dist2(rsz',sz0') > sz0'*sz0*thred);                        %���������о��μ����С�Ĳ�
    sel(:,i) = [i1;i2];
end
[min_ besti] = min(err);                                                    %ѡ������30���������о��δ�С�����С��һ��
sz0 = mean(rsz(:,sel(:,besti)),2);                                          %������һ�εľ��δ�С
idx = find(dist2(rsz',sz0') < sz0'*sz0*thred);                              %�ҳ���ô�С���С��һ����ֵ�ľ��Σ�Ҫ�����ľ��Σ�
idx1 = find(dist2(rsz',sz0') >= sz0'*sz0*thred);                            %�ҳ���ô�С����һ����ֵ�ľ��Σ�Ҫȥ���ľ��Σ�
r = rect(idx);