clc
close 
clear all
name = 'sensibiliteSebia074-1';
% name = 'test10022016';
namePic = strcat(name,'.png');
nameMat = strcat(name,'.mat');
A = imread(namePic);
A = rgb2gray(A);
subplot 211
imshow(A)

a = 185;
B = A;
B(B<a)=0;
B(B>a)=255;
subplot 212
imshow(B)