function rect = findrect(e)
[h w] = size(e);                                                            %图像的大小
v = find(e,1,'first');                                                      %找到图像中第一个为1的点
rect = [];
lw = 2;                                                                     %设定矩形边缘的大小
while (~isempty(v))
    j = floor(v/h) + 1;
    i = mod(v,h);
    x = j - 1;
    y = i - 1;
    x1 = j + 1;
    y1 = i + 1;                                                             %设定矩形的初始位置和大小
    while(x > 0 && y > 0 && x1 < w  && y1 < h && (sum(sum(e(max(y-lw,1):y,x:x1))) > 0 || sum(sum(e(y1:min(y1+lw,h),x:x1)))> 0 || sum(sum(e(y:y1,max(x-lw,1):x)))> 0 || sum(sum(e(y:y1,x1:min(x1+lw,w))))> 0) )
                                                                            %当矩形的边缘上还有像素的值大于0的时候
        while(y > lw && sum(sum(e(max(y-lw,1):y,x:x1)))> 0 )                %如果矩形上沿上有像素的值大于0，则矩形上沿向上移动一个像素，知道矩形上沿上的像素值都为0
            y = y - 1;
        end
        while(y1 < h - lw && sum(sum(e(y1:min(y1+lw,h),x:x1)))> 0 )         %同上，寻找矩形的下沿
            y1 = y1 + 1;
        end
        while(x > lw && sum(sum(e(y:y1,max(x-lw,1):x)))> 0)                 %同上，寻找矩形的左沿
            x = x - 1;
        end
        while(x1 < w - lw && sum(sum(e(y:y1,x1:min(x1+lw,w))))> 0)          %同上，寻找矩形的右沿
            x1 = x1 + 1;
        end
    end
    if (x1 - x > 5 && y1 - y > 5)                                           %如果矩形的大小大于5*5
        rect = [rect struct('x',x,'y',y,'x1',x1,'y1',y1)];                  %将矩形存储下来
    end
    y = max(y,1);
    y1 = min(y1,h);
    x = max(x,1);
    x1 = min(x1,w);
    e(y:y1,x:x1) = 0;                                                       %将图像上矩形覆盖的区域置0，便于寻找下一个矩形
    v = find(e,1,'first');                                                  %寻找图像中第一个值为1的像素
end


