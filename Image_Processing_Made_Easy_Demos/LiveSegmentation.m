function LiveSegmentation()
% show video processing using a webcam 
clear; close all; clc; 
imaqreset; %Disconnect and delete all image acquisition objects

%% Setup Image Acquisition
% hCamera = videoinput('winvideo',1,'RGB24_640x480');
% maybe need to install supportPackageInstaller - OS Generic Video Interface
%hCamera = videoinput('winvideo',1,'YUY2_640x480');
hCamera = videoinput('winvideo',1,'MJPG_1280x720');

hCamera.ReturnedColorspace = 'rgb';
hCamera.FramesPerTrigger = 1;

% Initialization of the camera
triggerconfig(hCamera,'manual'); %Configure video input object trigger properties
start(hCamera);

% Quantize images and outputing to the screen
frames = 10000;
fh = figure(1);

for i = 1:frames
    vid_img = getsnapshot(hCamera); %Immediately return single image frame
    [candy_img, numObj] = Candy_Segmentation_Fn(vid_img);
    figure(fh), imshowpair(vid_img,candy_img,'montage');
    title(['Candy pieces = ', num2str(numObj)]);
    drawnow;
end
stop(hCamera);
delete(hCamera);