%% Image Registration of an Infrared and Webcam Image
% This example aligns an Infrared image with an webcam image in order
% locate the proper location to measure body temperature near the eyes.

% Copyright 2012-2014 The MathWorks, Inc.

%% Read in the image pair
Fixed = imread('IR_image.png');
Moving = imread('Webcam_image.png');
Moving = rgb2gray(Moving);

%% View the 2 images 
imshow(Moving);
% Use imtool to view the IR image (click "Adjust Contrast" button)
imtool(Fixed);

%% View the images side by side in a montage
imshowpair(Fixed,Moving,'montage');

%% Configure parameters in imregconfig
[optimizer,metric] = imregconfig('Multimodal'); %creates optimizer and metric configurations 
% that you pass to imregister to perform intensity-based image registration. 

%% Default registration
registered = imregister(Moving,Fixed,'translation',optimizer,metric); % Intensity-based image registration
figure;
imshowpair(registered,Fixed);
title('falsecolor');

%% Change visualization in imshowpair
figure;
imshowpair(registered,Fixed,'blend');

%% Change transformType in imregister
registered = imregister(Moving, Fixed,'affine',optimizer,metric); 
% Afine transformation consisting of translation, rotation, scale, and shear.
figure;
imshowpair(registered,Fixed);
title('Intermediate Registration');

%% Final registration
registered = imregister(Moving, Fixed,'Similarity',optimizer,metric);
% Nonreflective similarity transformation consisting of translation, rotation, and scale.
figure;
imshowpair(registered,Fixed);title('Final Registration');

%% Detect the eyes in the RGB image
eyesDet = vision.CascadeObjectDetector('EyePairSmall');
bbox = step(eyesDet, Moving);% Step response plot of dynamic system 
drawBox = vision.ShapeInserter('BorderColor','Black');
image = step(drawBox, registered, int32(bbox));
hold on; rectangle('Position',bbox,'EdgeColor',[1 1 0]);
subsIR = int32(bbox(:,1:2)+bbox(:,3:4)/2);

%% Compute temperature near the eyes
value = mean2(imcrop(registered,bbox)); % Average or mean of matrix elements
foreheadTemperature = value/10 - 272; % In Celcius ???
foreheadTemperature =  (foreheadTemperature*9/5) + 32; % Convert to Farenheit

%% Embed temperature on IR image and display
ti = vision.TextInserter('Color',[255 0 0]);
ti.Location = int32(bbox(:,1:2)+bbox(:,3:4)/2);
ti.Text = sprintf('%3d F', int8(foreheadTemperature));
contAdj = vision.ContrastAdjuster('CustomProductInputDataType',numerictype([],32,8));
% Adjust image contrast by linear scaling
imageContrastAdjusted = step(contAdj, Fixed);
textAdded = step(ti, imageContrastAdjusted);
text(320, 180,'98 \circ F ','Color',[1 1 0])

