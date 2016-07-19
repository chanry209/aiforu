clear all;
clc;

I=imread('image.jpg');
if (ndims(I)==3)  
    I_gray=rgb2gray(I);
else
    I_gray=I;
end
I=I_gray;


%% Detection des contours par filtre canny
[m,n]=size(I);
Inew=edge(I,'canny');

figure;
imshow(Inew);
title('image after filtre canny');

%% correction inclinaison par Hough Transform
% hough(I): calculer le Transforme Hough standard
% H: resultat apres le THS
% T: THETA is an NTHETA-element vector containing the angle (in
%   degrees) corresponding to each column of H.  RHO is an
%   NRHO-element vector containing the value of rho corresponding to
%   each row of H. 
% R: rhosolution: rho=x*cos(theta)+y*sin(theta)

[H,T,R]=hough(Inew);

figure,
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'),ylabel('\rho');
axis on,
axis normal,
hold on;

% Identify peaks in Hough transform
% 'Threshold' Nonnegative scalar. Default: 0.5*max(H(:))
% Values of H below 'Threshold' will not be considered to be peaks. Threshold can vary from 0 to Inf.
          
P=houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));

x=T(P(:,2)); 
y = R(P(:,1));

plot(x,y,'s','color','white');

%  houghlines Extract line segments based on Hough transform.
lines=houghlines(Inew,T,R,P,'FillGap',10,'MinLength',7);
figure,
imshow(Inew),
title('image lines');

max_len = 0;
hold on;

for k=1:length(lines)
    xy=[lines(k).point1;lines(k).point2];
   
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    % marked the lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
     len=norm(lines(k).point1-lines(k).point2);
    Len(k)=len;
    if (len>max_len)
        max_len=len;
        xy_long=xy;
    end
end

% the longest line
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
[L1 Index1]=max(Len(:));

% the start and the end point of the longest line
x1=[lines(Index1).point1(1) lines(Index1).point2(1)];
y1=[lines(Index1).point1(2) lines(Index1).point2(2)];

% obliquite

K1=-(lines(Index1).point1(2)-lines(Index1).point2(2))/...
    (lines(Index1).point1(1)-lines(Index1).point2(1))

angle=atan(K1)*180/pi

A = imrotate(I,-angle,'bilinear');
figure;
imshow(A);









