rgb = imread('d:/temp/PA080030.jpg');           %����ͼ��
thred = [0.26 0.6];                             %canny��Ե���ӵ���ֵ

e = (edge(rgb(:,:,1),'canny',thred) + edge(rgb(:,:,2),'canny',thred) + edge(rgb(:,:,3),'canny',thred)) > 1;     %������ͼ���ȡ��Ե
[h w] = size(e);                                                                                                %���ͼ��Ĵ�С
rect = findrect(e);                                                                                             %Ѱ�ұ�Եͼ����������Ե�İ�Χ��ͨ�������ִ���
[r idx idx1] = findsimularrect(rect,0.07);                                                                      %Ѱ�����д�С����İ�Χ��
rect1 = rect(idx1);                                                                                             %rect1�����а�Χ�򣨾��Σ��У���С��󲿷־��β��ϴ�ľ���
for i = 1:length(rect1)                                                                                         %����С���ϴ�ľ����еı�Եֵ��0
    e(rect1(i).y:rect1(i).y1,rect1(i).x:rect1(i).x1) = 0;
end
rect = r;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = ([rect.x;rect.y] + [rect.x1;rect.y1])/2;                                                                    %����ͼ����ͨ�������������ĵ�ֱ�ߵĲ���ax+by=1
param = inv(c*c')*c*ones(length(idx),1);                                                                        %param=[a b]

[aff paramx] = findpitchX(e, rect, param);                                                                      %����ͼ��ķ���任����aff
                                                                                                                %ԭͼ���ϵ������[x y] -> У����ͼ��������[X Y] [x y]' = aff*[X Y]'


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
X4 = [rect(1).x - (h - rect(1).y)*b/a; h];                                                                      %�����������ֲ���ͼ��İ�Χ��
% line([X1(1,:) X2(1,:) X3(1,:) X4(1,:) X1(1,:)],[X1(2,:) X2(2,:) X3(2,:) X4(2,:) X1(2,:)],'Color',[1 0 0 ]);
X_ = aff*[X1 X2 X3 X4];                                                                                         %����У����ͼ��İ�Χ��
% line(X_(1,:),X_(2,:),'color',[1 1 0]);

l = min(X_(1,[1 4]));                                                                                           
r = max(X_(1,[2 3]));
t = min(X_(2,[1 2]));
b = min(X_(2,[3 4]));
sw = r - l;
sh = b - t;
l = l - sw/6;
r = r + sw;
sw = r - l;                                                                                                      %�趨У����ͼ��Ĵ�С������
XX = [l r r l l;t t b b t];
XX_ = inv(aff)*XX;
% line(XX_(1,:),XX_(2,:),'color',[0 1 1]);                                                                          

idx = 1:round(sw)*round(sh);                                                                                     %����У����ͼ��ľ����±� idx�������±�
n = length(idx);
[sub_y sub_x] = ind2sub([sh sw],idx);                                                                            %sub_y,sub_x�Ƕ�ά�±꣬Ҳ��ͼ������
cord_o = round(inv(aff)*[sub_x + l - 1;sub_y + t - 1]);                                                          %����У��ͼ��������ԭͼ���е�����
o_x = cord_o(1,:);
o_y = cord_o(2,:);
o_x(o_x < 1) = 1;
o_x(o_x > w) = w;
o_y(o_y < 1) = 1;
o_y(o_y > h) = h;                                                                                                %������곬��ͼ��߽�����Ϊͼ��߽��ϵĵ�
ind_o_e = sub2ind([h w], o_y, o_x);                                                                              %ת��Ϊ�����е������±�
ee = reshape(e(ind_o_e), round([sh sw]));                                                                        %У����Եͼ��

o_c = [ones(1,n) 2*ones(1,n) 3*ones(1,n)];
o_xc = repmat(o_x,[1 3]);
o_yc = repmat(o_y,[1 3]);                                                                                       %����rgbͼ��������ά����
ind_o_c = sub2ind([h w 3], o_yc, o_xc, o_c);                                                                    %ת��Ϊ��������
rgb1 = reshape(rgb(ind_o_c), round([sh sw 3]));                                                                 %У����ɫͼ��




rect1 = findrect(ee);
rect1 = findsimularrect(rect1,0.1);                                                                             %Ѱ��У�����Եͼ���е����ֵİ�Χ��

lr = [rect1.y];
[lr idx] = sort(lr);
rect1 = rect1(idx);
rect2 = []; 
if (length(rect1) > 1)
    cy = (rect1(1).y + rect1(1).y1)/2;
    if (cy <= rect1(2).y1 && cy >= rect1(2).y)                                                                  %�����ͬһ�������������Σ���˵��һ���е����������ڲ�ͬ�ľ�����
        rect2 = rect1;
    else                                                                                                        %���������ֵİ�Χ����ηֳ�ͬ�е�������ʹ�������ַֿ�
        rect2 = [rect1 rect1];
        for i = 1:length(rect1)
            cx = (rect1(i).x + rect1(i).x1)/2;
            rect2(2*i - 1) = struct('x',rect1(i).x, 'y', rect1(i).y, 'x1', cx, 'y1', rect1(i).y1);
            rect2(2*i) = struct('x',cx, 'y', rect1(i).y, 'x1', rect1(i).x1, 'y1', rect1(i).y1);
        end
    end
end
nn = numel(rect2);                                                                                              %���ֵĸ���
rgbdig = cell(1,length(rect2));
digit = zeros(1,nn);                                                                                            %���Դ洢ʶ�����������
for i = 1:nn
    rgbdig{i} = rgb1(round(rect2(i).y:rect2(i).y1),round(rect2(i).x:rect2(i).x1),:);                            %��ȡͼ�����ֵ�ͼ��
end







rgb = imread('d:/temp/PA080031.jpg');           %����ͼ��
thred = [0.26 0.6];                             %canny��Ե���ӵ���ֵ

e = (edge(rgb(:,:,1),'canny',thred) + edge(rgb(:,:,2),'canny',thred) + edge(rgb(:,:,3),'canny',thred)) > 1;     %������ͼ���ȡ��Ե
[h w] = size(e);                                                                                                %���ͼ��Ĵ�С
rect = findrect(e);                                                                                             %Ѱ�ұ�Եͼ����������Ե�İ�Χ��ͨ�������ִ���
[r idx idx1] = findsimularrect(rect,0.07);                                                                      %Ѱ�����д�С����İ�Χ��
rect1 = rect(idx1);                                                                                             %rect1�����а�Χ�򣨾��Σ��У���С��󲿷־��β��ϴ�ľ���
for i = 1:length(rect1)                                                                                         %����С���ϴ�ľ����еı�Եֵ��0
    e(rect1(i).y:rect1(i).y1,rect1(i).x:rect1(i).x1) = 0;
end


rect = r;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = ([rect.x;rect.y] + [rect.x1;rect.y1])/2;                                                                    %����ͼ����ͨ�������������ĵ�ֱ�ߵĲ���ax+by=1
param = inv(c*c')*c*ones(length(idx),1);                                                                        %param=[a b]

[aff paramx] = findpitchX(e, rect, param);                                                                      %����ͼ��ķ���任����aff
                                                                                                                %ԭͼ���ϵ������[x y] -> У����ͼ��������[X Y] [x y]' = aff*[X Y]'


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
X4 = [rect(1).x - (h - rect(1).y)*b/a; h];                                                                      %�����������ֲ���ͼ��İ�Χ��
% line([X1(1,:) X2(1,:) X3(1,:) X4(1,:) X1(1,:)],[X1(2,:) X2(2,:) X3(2,:) X4(2,:) X1(2,:)],'Color',[1 0 0 ]);
X_ = aff*[X1 X2 X3 X4];                                                                                         %����У����ͼ��İ�Χ��
% line(X_(1,:),X_(2,:),'color',[1 1 0]);

l = min(X_(1,[1 4]));                                                                                           
r = max(X_(1,[2 3]));
t = min(X_(2,[1 2]));
b = min(X_(2,[3 4]));
sw = r - l;
sh = b - t;
l = l - sw/6;
r = r + sw;
sw = r - l;                                                                                                      %�趨У����ͼ��Ĵ�С������
XX = [l r r l l;t t b b t];
XX_ = inv(aff)*XX;
% line(XX_(1,:),XX_(2,:),'color',[0 1 1]);                                                                          

idx = 1:round(sw)*round(sh);                                                                                     %����У����ͼ��ľ����±� idx�������±�
n = length(idx);
[sub_y sub_x] = ind2sub([sh sw],idx);                                                                            %sub_y,sub_x�Ƕ�ά�±꣬Ҳ��ͼ������
cord_o = round(inv(aff)*[sub_x + l - 1;sub_y + t - 1]);                                                          %����У��ͼ��������ԭͼ���е�����
o_x = cord_o(1,:);
o_y = cord_o(2,:);
o_x(o_x < 1) = 1;
o_x(o_x > w) = w;
o_y(o_y < 1) = 1;
o_y(o_y > h) = h;                                                                                                %������곬��ͼ��߽�����Ϊͼ��߽��ϵĵ�
ind_o_e = sub2ind([h w], o_y, o_x);                                                                              %ת��Ϊ�����е������±�
ee = reshape(e(ind_o_e), round([sh sw]));                                                                        %У����Եͼ��

o_c = [ones(1,n) 2*ones(1,n) 3*ones(1,n)];
o_xc = repmat(o_x,[1 3]);
o_yc = repmat(o_y,[1 3]);                                                                                       %����rgbͼ��������ά����
ind_o_c = sub2ind([h w 3], o_yc, o_xc, o_c);                                                                    %ת��Ϊ��������
rgb1 = reshape(rgb(ind_o_c), round([sh sw 3]));                                                                 %У����ɫͼ��

hold on


rect1 = findrect(ee);
rect1 = findsimularrect(rect1,0.1);                                                                             %Ѱ��У�����Եͼ���е����ֵİ�Χ��

lr = [rect1.y];
[lr idx] = sort(lr);
rect1 = rect1(idx);
rect2 = []; 
if (length(rect1) > 1)
    cy = (rect1(1).y + rect1(1).y1)/2;
    if (cy <= rect1(2).y1 && cy >= rect1(2).y)                                                                  %�����ͬһ�������������Σ���˵��һ���е����������ڲ�ͬ�ľ�����
        rect2 = rect1;
    else                                                                                                        %���������ֵİ�Χ����ηֳ�ͬ�е�������ʹ�������ַֿ�
        rect2 = [rect1 rect1];
        for i = 1:length(rect1)
            cx = (rect1(i).x + rect1(i).x1)/2;
            rect2(2*i - 1) = struct('x',rect1(i).x, 'y', rect1(i).y, 'x1', cx, 'y1', rect1(i).y1);
            rect2(2*i) = struct('x',cx, 'y', rect1(i).y, 'x1', rect1(i).x1, 'y1', rect1(i).y1);
        end
    end
end
nn = numel(rect2);                                                                                              %���ֵĸ���
rgbdig1 = cell(1,length(rect2));
digit = zeros(1,nn);                                                                                            %���Դ洢ʶ�����������
for i = 1:nn
    rgbdig1{i} = rgb1(round(rect2(i).y:rect2(i).y1),round(rect2(i).x:rect2(i).x1),:);                            %��ȡͼ�����ֵ�ͼ��
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
    label = input('�밴˳������ͼ���е����֣��Կո��������������������[x1 x2 x3 ...xn]:');
end

l = unique(label);
m = [];
for i = 1:numel(l)
    m = [m; mean(mu(find(label == l(i)),:),1)];
end
save 'model.mat' 'm' 'lb'