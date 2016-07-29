%% Simplifie the image
% 1 Image Processing Toolbox : enhancement; contrast adjustement;
% 2
% 3


%% 1 Enhancement
% Goal: Import and visualize the image; Correct for poor contrast and
% 1-1 unblanced colors
I = imread('03-03-2016-1.tif');
imshow(I);
imagesc(I);
%区别：imshow将图像以原始尺寸显示，image和imagesc则会对图像进行适当的缩放
imtool(I);

% 1-2 Read the Image
% X = multibandread(filename, size, precision, offset, interleave, byteorder) 
truecolor = multibandread('paris.lan',[512 512 7],'uint8=>uint8',128,'bil','ieee-le',{'Band','Direct',[3 2 1]});
figure
imshow(truecolor);
title('TrueColor Composite (Un-enhanced)');
text(size(truecolor,2),size(truecolor,1)+15,'Image Couteresy of Space Imaging, LLC', 'FontSize',7,'HorizontalAlignment','right')

% 1-3 Use histograms to explore a canal of image
figure
imhist(truecolor(:,:,1)) %calculates the histogram for the intensity image I and displays a plot of the histogram. The number of bins in the histogram is determined by the image type.
title('Histogram of the red Band')

% 1-4 histogram of three colors
r = truecolor(:,:,1);
g = truecolor(:,:,2);
b = truecolor(:,:,3);
figure
plot3(r(:),g(:),b(:),'.')
grid on
xlabel('Red')
ylabel('Green')
zlabel('Blue')
title('Scatterplot of the visible bands')

% 1-5 Enhance TrueColor composite with a contrast stretch
% Adjust image intensity values or colormap
stretched_truecolor = imadjust(truecolor, stretchlim(truecolor)); % stretchlim : Find limits to contrast stretch image
figure
imshow(stretched_truecolor)
title('Truecolor composite after contrast stretch')

figure
imhist(stretched_truecolor(:,:,1)) %calculates the histogram for the intensity image I and displays a plot of the histogram. The number of bins in the histogram is determined by the image type.
title('Histogram of the red Band after contrast stretch')

% 1-6 Enhance Truecolor composite with a decorrelation stretch
% Another way to enhance the truecolor composite is to use a decorrelation
% stretch, which enhances color separation across hightly correlated
% channels.
decorrstretched_truecolor = decorrstretch(truecolor,'Tol',0.01); % Apply decorrelation stretch to multichannel image, 'Tol' linear contrast stretch 
figure
imshow(decorrstretched_truecolor)
title('Truecolor composite after decorrelation stretch')

%% 2 Segmentation
% 2-1 
I  = imread('couverture.jpeg');
imshow(I);
Igray = rgb2gray(I);
imshow(Igray);
% Problem: illumination doesn't allow for easy segmentation
level = 0.67;
Ithresh = im2bw(Igray,level); % Convert image to binary image, based on threshold, specify level in the range [0,1]
imshowpair(I,Ithresh,'montage'); %Compare differences between images

% Color Space
rmat = I(:,:,1);
gmat = I(:,:,2);
bmat = I(:,:,3);

figure
subplot 221
imshow(rmat)
title('Red Plane')
subplot 222
imshow(gmat)
title('Green Plane')
subplot 223
imshow(bmat)
title('Blue Plane')
subplot 224
imshow(I)
title('Original Image')

levelr = 0.63;
levelg = 0.5;
levelb = 0.4;
i1 = im2bw(rmat,levelr);
i2 = im2bw(gmat,levelg);
i3 = im2bw(bmat,levelb);





