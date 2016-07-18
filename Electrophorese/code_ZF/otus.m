function [ output_args ] = otus( IM )
%OTUS Summary of this function goes here
%   Detailed explanation goes here
[m,n,h]=size(IM);
GIM=rgb2gray(IM);%GIM为灰度图像
his=zeros(256,1);%定义一个256行1列的灰度直方图his
var=zeros(256,1);

%记录每一灰度值的点的个数
for i=1:m
    for j=1:n
        gray=GIM(i,j)+1;
        his(gray,1)=his(gray,1)+1;
    end
end

    
    
for yu=1:255
    left=0;%左边平均数
    left_num=0;%左边总数
    left_var=0;%左边方差
    
    right=0;%右边平均数
    right_num=0;%右边总数
    right_var=0;%右边方差
    
    for i=1:yu
        left=his(i,1)*i+left;
        left_num=left_num+his(i,1);
    end
     if left_num==0
            left=0;
        else
    left=left/left_num;
     end
    
    for j=yu+1:255
        right=his(j,1)*j+right;
        right_num=right_num+his(j,1);
    end
     if right_num==0
            right=0;
        else
    right=right/right_num;
     end
    
    %计算左右两边方差
    for i=1:yu
        if left_num==0
            left_var=0;
        else
        left_var=((i-left)*his(i,1)/left_num).^2+left_var;
        end
    end
    
    for j=yu+1:255
        if right_num==0
            right_var=0;
        else
        right_var=((j-right)*his(j,1)/right_num).^2+right_var;
        end
    end
    
    var(yu,1)=abs(right_var-left_var);
end

yu_max=find(var==max(max(var)));

for i=1:m
    for j=1:n
        if GIM(i,j)+1>yu_max
        GIM(i,j)=255;
        else
            GIM(i,j)=0;
        end
    end
end

imshow(GIM);

end
