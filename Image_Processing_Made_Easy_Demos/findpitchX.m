% 这个函数用于估计图像在x方向上的倾斜程度，并计算仿射变换的矩阵
% 输入    e：边缘图像
%         rect：边缘图像中数字的包围框
%         paramY： y方向的倾斜程度，用ax+by = 1 的直线表示，paramY = [a b]
% A                                           B
% _____________________________________________
% |\_______________________                   |
% | \                      ___________________| j
% |  \                                        |
% |   \                                       |
% |____\______________________________________|
% C    E                                        D
% 图中，AE直线表示y方向倾斜程度，Aj直线表示x方向倾斜程度
function [aff param] = findpitchX(e, rect, paramY)
[h w]= size(e);
a = paramY(1);
b = paramY(2);
bestj = zeros(length(rect),1);
maxh = max([rect.y1] - [rect.y]);
maxw = max([rect.x1] - [rect.x]);                                           %计算包围框的最大尺寸
mh = floor(maxh/2);
for i = 1:length(rect)
    idx = find(e(rect(i).y:rect(i).y1,rect(i).x:rect(i).x1));
    if (size(idx,1) > size(idx,2))
        idx = idx';
    end
    h = rect(i).y1 - rect(i).y + 1;                                         %矩形大小
    y = mod(idx, h);
    x = floor(idx / h) + 1;                                                 %x，y是所有边缘点的坐标
    xx = -(maxh)*b/a;                                                       %xx是E点横坐标
    l = zeros(1,2*mh + 1);
    for j = -mh:mh                                                          %尝试不同的x方向倾斜程度，即从 （0，0） 到 （w，j）的直线作为x轴
        aff = [maxw 0;0 maxh]*inv([maxw xx;j maxh]);                        %计算该去倾斜方向对应的仿射矩阵
        x_ = round(aff(1,:)*[x;y]);                                         %计算边缘点在根据aff校正后的坐标
        y_ = round(aff(2,:)*[x;y]);
        it = find(y_ == min(y_));                                           %找出校正后边缘图像的上切线和下切线
        ib = find(y_ == max(y_));
        l(j + 1 + mh) = max(max(x_(it)) - min(x_(it)),max(x_(ib)) - min(x_(ib)));  %计算校正后边缘图像的切线上，有边缘的像素的最大距离，如果这个距离最大，则说明这个切线刚好与两个数字相切，这个方向是正确的方向
    end
    [ml bj] = max(l);
    bestj(i) = bj - mh - 1;
end
aff = [maxw 0;0 maxh]*inv([maxw xx;mean(bestj) maxh]);                      %计算仿射矩阵
param = [mean(bestj) -maxw];
param = param/(param*[rect(1).x;rect(1).y]);                                %计算x方向倾斜的直线参数。