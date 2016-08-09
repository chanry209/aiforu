function [y, numObjects] = Candy_Segmentation_Fn(Im)

% 2-2 Color Space
rmat = Im(:,:,1);
gmat = Im(:,:,2);
bmat = Im(:,:,3);

% treat each channel
levelr = 0.63;
levelg = 0.5;
levelb = 0.7;
i1 = im2bw(rmat,levelr);
i2 = im2bw(gmat,levelg);
i3 = im2bw(bmat,levelb);
Isum = (i1&i2&i3); % sum of the three channels results 

% Complement Image and Fill in holes
Icomp = imcomplement(Isum); %In the complement of a binary image, 
% zeros become ones and ones become zeros; black and white are reversed.
% In the complement of an intensity or RGB image, each pixel value is subtracted 
% from the maximum pixel value supported by the class (or 1.0 for double-precision images) 
% and the difference is used as the pixel value in the output image. In the output image, 
% dark areas become lighter and light areas become darker.
Ifilled = imfill(Icomp,'holes');

% 2-3 clear the noise
se = strel('disk',10);
%se = strel('rectangle',[10,12]); %Create morphological structuring element 
Iopenned = imopen(Ifilled,se); % performs morphological opening on 
% the grayscale or binary image IM with the structuring element SE

% 2-4 Extract features
% Iregion = regionprops(Iopenned, 'centroid'); %Measure properties of image regions
[labeled,numObjects] = bwlabel(Iopenned,4); % Label connected components in 2-D binary image, 
y = labeled;
% returns a label matrix, where the variable n specifies the connectivity.
% stats = regionprops(labeled,'Eccentricity','Area','BoundingBox');
% areas = [stats.Area];
% eccentricities = [stats.Eccentricity];

% % 2-5 Use feature analysis to count skittles objects
% idxOfSkittles = find(eccentricities);
% statsDefects = stats(idxOfSkittles);

% figure, imshow(I);
% hold on;
% for idx = 1 : length(idxOfSkittles)
%         h = rectangle('Position',statsDefects(idx).BoundingBox,'LineWidth',2);
%         set(h,'EdgeColor',[.75 0 0]);
%         hold on;
% end
% title(['There are ', num2str(numObjects), ' objects in the image!']);
% hold off;