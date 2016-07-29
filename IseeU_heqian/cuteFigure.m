I = imread('log1.jpg')
[I2, rect] = imcrop(I);
imshow(I2)