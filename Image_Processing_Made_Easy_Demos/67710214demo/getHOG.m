% 这个函数只要用于提取图像的HOG特征
% 所谓HOG特征，就是Histogram of gradient
% 即是图像中梯度的直方图
% 我们这里统计图像中梯度幅值大于一定阈值的梯度方向
% 往往图像中像素上的梯度方向也等价于边缘的方向

function HOG = getHOG(rgb)

hsv = rgb2hsv(rgb);
v = hsv(:,:,3);                                                             %提取图像的V分量（hsv色彩空间）
N = numel(v);
fx = fspecial('sobel');                                                     %生成计算梯度的模板
fy = fx';
dx = imfilter(v,fx,'replicate');                            
dy = imfilter(v,fy,'replicate');                                            %分别计算图像中x，y方向上的导数
dx(dy<0) = dx(dy<0)*-1;                                                     %如果梯度处于第3，4象限则取反（将梯度方向限制在0~pi之间）
d = sqrt(dx.*dx + dy.*dy);                                                  %计算梯度的幅值
angle = acos(dx./d);                                                        %计算梯度的夹角
[h w] = size(d);
d = d > (max(max(d)) / 10);                                                 
angle = angle(d);                                                           %选取梯度幅值大于阈值的像素
HOG = hist(reshape(angle,[1 numel(angle)]),18)./N;                          %统计这些像素上梯度的直方图