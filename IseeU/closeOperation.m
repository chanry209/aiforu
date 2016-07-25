function J=closeOperation(I,SE)

%%% close morphological operation removes small holes in the foreground, 
%%% changing small islands of background into foreground.
%%% Erosion of th dilation of the image I by SE

J=imclose(I,SE);

figure;
subplot(2,1,1);
imshow(I);
title('input Figure');
subplot(2,1,2)
imshow(J);
title('Figure after closing operation');
end