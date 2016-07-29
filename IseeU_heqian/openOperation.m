function J=openOperation(I,a,b)

%%% open morphological operation removes small objects from the foreground.
% dilation of th erosion of the image I by th structuring element SE

%J=imclose(G,strel('rectangle',[a,b]));
SE=strel('rectangle',[a,b]);
J=imopen(I,SE);

% figure;
% subplot(2,1,1);
% imshow(I);
% title('input Figure');
% subplot(2,1,2)
% imshow(J);
% title('Figure after openning operation');
end