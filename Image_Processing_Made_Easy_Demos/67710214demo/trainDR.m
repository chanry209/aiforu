rgb = imread('d:/temp/PA080030.jpg');           %读入图像
thred = [0.26 0.6];                             %canny边缘算子的阈值

e = (edge(rgb(:,:,1),'canny',thred) + edge(rgb(:,:,2),'canny',thred) + edge(rgb(:,:,3),'canny',thred)) > 1;     %对整幅图像抽取边缘
[h w] = size(e);                                                                                                %获得图像的大小
rect = findrect(e);                                                                                             %寻找边缘图像中连续边缘的包围框（通常在数字处）
[r idx idx1] = findsimularrect(rect,0.07);                                                                      %寻找其中大小相近的包围框
rect1 = rect(idx1);                                                                                             %rect1是所有包围框（矩形）中，大小与大部分矩形差别较大的矩形
for i = 1:length(rect1)                                                                                         %将大小差别较大的矩形中的边缘值置0
    e(rect1(i).y:rect1(i).y1,rect1(i).x:rect1(i).x1) = 0;
end
rect = r;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = ([rect.x;rect.y] + [rect.x1;rect.y1])/2;                                                                    %根据图像中通过数字区域中心的直线的参数ax+by=1
param = inv(c*c')*c*ones(length(idx),1);                                                                        %param=[a b]

[aff paramx] = findpitchX(e, rect, param);                                                                      %计算图像的仿射变换参数aff
                                                                                                                %原图像上的坐标点[x y] -> 校正后图像的坐标点[X Y] [x y]' = aff*[X Y]'


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a = paramx(1);
% b = paramx(2);
% x = [0 1/a w (1-b*h)/a];
% y = [1/b 0 (1-a*w)/b h];
% line(x,y,'Color',[0 0 1]);

a = param(1);
b = param(2);
x = [0 1/a w (1-b*h)/a];
y = [1/b 0 (1-a*w)/b h];
% line(x,y,'Color',[0 0 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X1 = [rect(1).x;rect(1).y];
X2 = [rect(1).x1;rect(1).y];
X3 = [rect(1).x1 - (h - rect(1).y)*b/a; h];
X4 = [rect(1).x - (h - rect(1).y)*b/a; h];                                                                      %计算所有数字部分图像的包围框
% line([X1(1,:) X2(1,:) X3(1,:) X4(1,:) X1(1,:)],[X1(2,:) X2(2,:) X3(2,:) X4(2,:) X1(2,:)],'Color',[1 0 0 ]);
X_ = aff*[X1 X2 X3 X4];                                                                                         %计算校正后图像的包围框
% line(X_(1,:),X_(2,:),'color',[1 1 0]);

l = min(X_(1,[1 4]));                                                                                           
r = max(X_(1,[2 3]));
t = min(X_(2,[1 2]));
b = min(X_(2,[3 4]));
sw = r - l;
sh = b - t;
l = l - sw/6;
r = r + sw;
sw = r - l;                                                                                                      %设定校正后图像的大小，区域
XX = [l r r l l;t t b b t];
XX_ = inv(aff)*XX;
% line(XX_(1,:),XX_(2,:),'color',[0 1 1]);                                                                          

idx = 1:round(sw)*round(sh);                                                                                     %生成校正后图像的矩阵下标 idx是线性下标
n = length(idx);
[sub_y sub_x] = ind2sub([sh sw],idx);                                                                            %sub_y,sub_x是二维下标，也是图像坐标
cord_o = round(inv(aff)*[sub_x + l - 1;sub_y + t - 1]);                                                          %计算校正图像像素在原图像中的坐标
o_x = cord_o(1,:);
o_y = cord_o(2,:);
o_x(o_x < 1) = 1;
o_x(o_x > w) = w;
o_y(o_y < 1) = 1;
o_y(o_y > h) = h;                                                                                                %如果坐标超过图像边界则设为图像边界上的点
ind_o_e = sub2ind([h w], o_y, o_x);                                                                              %转换为矩阵中的线性下标
ee = reshape(e(ind_o_e), round([sh sw]));                                                                        %校正边缘图像

o_c = [ones(1,n) 2*ones(1,n) 3*ones(1,n)];
o_xc = repmat(o_x,[1 3]);
o_yc = repmat(o_y,[1 3]);                                                                                       %设置rgb图像矩阵的三维坐标
ind_o_c = sub2ind([h w 3], o_yc, o_xc, o_c);                                                                    %转换为线性坐标
rgb1 = reshape(rgb(ind_o_c), round([sh sw 3]));                                                                 %校正彩色图像




rect1 = findrect(ee);
rect1 = findsimularrect(rect1,0.1);                                                                             %寻找校正后边缘图像中的数字的包围框

lr = [rect1.y];
[lr idx] = sort(lr);
rect1 = rect1(idx);
rect2 = []; 
if (length(rect1) > 1)
    cy = (rect1(1).y + rect1(1).y1)/2;
    if (cy <= rect1(2).y1 && cy >= rect1(2).y)                                                                  %如果在同一行中有两个矩形，则说明一行中的两个数字在不同的矩形内
        rect2 = rect1;
    else                                                                                                        %否则，则将数字的包围框矩形分成同行的两个，使两个数字分开
        rect2 = [rect1 rect1];
        for i = 1:length(rect1)
            cx = (rect1(i).x + rect1(i).x1)/2;
            rect2(2*i - 1) = struct('x',rect1(i).x, 'y', rect1(i).y, 'x1', cx, 'y1', rect1(i).y1);
            rect2(2*i) = struct('x',cx, 'y', rect1(i).y, 'x1', rect1(i).x1, 'y1', rect1(i).y1);
        end
    end
end
nn = numel(rect2);                                                                                              %数字的个数
rgbdig = cell(1,length(rect2));
digit = zeros(1,nn);                                                                                            %用以存储识别出来的数字
for i = 1:nn
    rgbdig{i} = rgb1(round(rect2(i).y:rect2(i).y1),round(rect2(i).x:rect2(i).x1),:);                            %提取图中数字的图像
end







rgb = imread('d:/temp/PA080031.jpg');           %读入图像
thred = [0.26 0.6];                             %canny边缘算子的阈值

e = (edge(rgb(:,:,1),'canny',thred) + edge(rgb(:,:,2),'canny',thred) + edge(rgb(:,:,3),'canny',thred)) > 1;     %对整幅图像抽取边缘
[h w] = size(e);                                                                                                %获得图像的大小
rect = findrect(e);                                                                                             %寻找边缘图像中连续边缘的包围框（通常在数字处）
[r idx idx1] = findsimularrect(rect,0.07);                                                                      %寻找其中大小相近的包围框
rect1 = rect(idx1);                                                                                             %rect1是所有包围框（矩形）中，大小与大部分矩形差别较大的矩形
for i = 1:length(rect1)                                                                                         %将大小差别较大的矩形中的边缘值置0
    e(rect1(i).y:rect1(i).y1,rect1(i).x:rect1(i).x1) = 0;
end


rect = r;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = ([rect.x;rect.y] + [rect.x1;rect.y1])/2;                                                                    %根据图像中通过数字区域中心的直线的参数ax+by=1
param = inv(c*c')*c*ones(length(idx),1);                                                                        %param=[a b]

[aff paramx] = findpitchX(e, rect, param);                                                                      %计算图像的仿射变换参数aff
                                                                                                                %原图像上的坐标点[x y] -> 校正后图像的坐标点[X Y] [x y]' = aff*[X Y]'


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a = paramx(1);
% b = paramx(2);
% x = [0 1/a w (1-b*h)/a];
% y = [1/b 0 (1-a*w)/b h];
% line(x,y,'Color',[0 0 1]);

a = param(1);
b = param(2);
x = [0 1/a w (1-b*h)/a];
y = [1/b 0 (1-a*w)/b h];
% line(x,y,'Color',[0 0 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X1 = [rect(1).x;rect(1).y];
X2 = [rect(1).x1;rect(1).y];
X3 = [rect(1).x1 - (h - rect(1).y)*b/a; h];
X4 = [rect(1).x - (h - rect(1).y)*b/a; h];                                                                      %计算所有数字部分图像的包围框
% line([X1(1,:) X2(1,:) X3(1,:) X4(1,:) X1(1,:)],[X1(2,:) X2(2,:) X3(2,:) X4(2,:) X1(2,:)],'Color',[1 0 0 ]);
X_ = aff*[X1 X2 X3 X4];                                                                                         %计算校正后图像的包围框
% line(X_(1,:),X_(2,:),'color',[1 1 0]);

l = min(X_(1,[1 4]));                                                                                           
r = max(X_(1,[2 3]));
t = min(X_(2,[1 2]));
b = min(X_(2,[3 4]));
sw = r - l;
sh = b - t;
l = l - sw/6;
r = r + sw;
sw = r - l;                                                                                                      %设定校正后图像的大小，区域
XX = [l r r l l;t t b b t];
XX_ = inv(aff)*XX;
% line(XX_(1,:),XX_(2,:),'color',[0 1 1]);                                                                          

idx = 1:round(sw)*round(sh);                                                                                     %生成校正后图像的矩阵下标 idx是线性下标
n = length(idx);
[sub_y sub_x] = ind2sub([sh sw],idx);                                                                            %sub_y,sub_x是二维下标，也是图像坐标
cord_o = round(inv(aff)*[sub_x + l - 1;sub_y + t - 1]);                                                          %计算校正图像像素在原图像中的坐标
o_x = cord_o(1,:);
o_y = cord_o(2,:);
o_x(o_x < 1) = 1;
o_x(o_x > w) = w;
o_y(o_y < 1) = 1;
o_y(o_y > h) = h;                                                                                                %如果坐标超过图像边界则设为图像边界上的点
ind_o_e = sub2ind([h w], o_y, o_x);                                                                              %转换为矩阵中的线性下标
ee = reshape(e(ind_o_e), round([sh sw]));                                                                        %校正边缘图像

o_c = [ones(1,n) 2*ones(1,n) 3*ones(1,n)];
o_xc = repmat(o_x,[1 3]);
o_yc = repmat(o_y,[1 3]);                                                                                       %设置rgb图像矩阵的三维坐标
ind_o_c = sub2ind([h w 3], o_yc, o_xc, o_c);                                                                    %转换为线性坐标
rgb1 = reshape(rgb(ind_o_c), round([sh sw 3]));                                                                 %校正彩色图像

hold on


rect1 = findrect(ee);
rect1 = findsimularrect(rect1,0.1);                                                                             %寻找校正后边缘图像中的数字的包围框

lr = [rect1.y];
[lr idx] = sort(lr);
rect1 = rect1(idx);
rect2 = []; 
if (length(rect1) > 1)
    cy = (rect1(1).y + rect1(1).y1)/2;
    if (cy <= rect1(2).y1 && cy >= rect1(2).y)                                                                  %如果在同一行中有两个矩形，则说明一行中的两个数字在不同的矩形内
        rect2 = rect1;
    else                                                                                                        %否则，则将数字的包围框矩形分成同行的两个，使两个数字分开
        rect2 = [rect1 rect1];
        for i = 1:length(rect1)
            cx = (rect1(i).x + rect1(i).x1)/2;
            rect2(2*i - 1) = struct('x',rect1(i).x, 'y', rect1(i).y, 'x1', cx, 'y1', rect1(i).y1);
            rect2(2*i) = struct('x',cx, 'y', rect1(i).y, 'x1', rect1(i).x1, 'y1', rect1(i).y1);
        end
    end
end
nn = numel(rect2);                                                                                              %数字的个数
rgbdig1 = cell(1,length(rect2));
digit = zeros(1,nn);                                                                                            %用以存储识别出来的数字
for i = 1:nn
    rgbdig1{i} = rgb1(round(rect2(i).y:rect2(i).y1),round(rect2(i).x:rect2(i).x1),:);                            %提取图中数字的图像
end

sample = [rgbdig rgbdig1];
samplesz = zeros(numel(sample),2);
mu = [];
for i = 1:numel(sample)
    mu = [mu; getHOG(sample{i})];
    samplesz(i,:) = [size(sample{i},1) size(sample{i},2)];
end
sz = max(samplesz);
rgbsample = uint8(zeros(sz(2),sz(1)*numel(sample),3));
for i = 1:numel(sample)
    rgbsample(1:size(sample{i},1),[1:size(sample{i},2)] + (i-1)*sz(2), :) = sample{i};
end
label = [];

while (numel(label) ~= numel(sample))
    imshow(rgbsample);
    label = input('请按顺序输入图像中的数字，以空格隔开，用中括号括起来[x1 x2 x3 ...xn]:');
end

l = unique(label);
m = [];
for i = 1:numel(l)
    m = [m; mean(mu(find(label == l(i)),:),1)];
end
save 'model.mat' 'm' 'lb'