%function J=adjustContrast(I,[Low_in; High_in],[Low_out; High_out]) 
function J=adjustContrast(I)
%%% increse th contrast of image by adjust image intensity values
%%% [low_in,high_in], [low_out,high_out] defalts to [O 1]

% if isempty([Low_in,High_in])
%     [Low_in,Hifht_in] = [O,1]
% end
% if isempty([Low_out,High_out])
%     [Low_out,Hifht_out] = [O,1]
% end

if ndims(I)==3
    I=rgb2gray(I)
end

J1=imadjust(I);
J=histeq(J1);

% figure;
% subplot(3,1,1);
% imshow(I);
% title('input Figure');
% subplot(3,1,2)
% imshow(J1);
% title('Figure after increase contrast');
% subplot(3,1,3);
% imshow(J);
% title('figure after histogram equalization');

end