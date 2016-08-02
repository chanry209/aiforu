function resI=paddingEdge(I)
%%% padding the edges of images by the neighbor pixel
if ndims(I)==3
   I=rgb2gray(I);
end
J=I;
[m,n]=size(I);

% padding the upper and the lower edges
halfL=fix(m/2);
for i=1:m
    idxNotzero=find(J(i,:)~=0);
    a=size(idxNotzero,2);
    if a~=0
        for k=1:a
            if i<=halfL
                J(1:i-1,idxNotzero(k))=J(i,idxNotzero(k));
            else
                J(i+1:end,idxNotzero(k))=J(i,idxNotzero(k));
            end
        end
    end
end

% padding the left and the right side of edges
for j=1:fix(n/2)
    for i=1:m
        if J(i,j)==0
            J(i,j)=J(i,j+1);
        end
    end
end
for j=fix(n/2)+1:n
    for i=1:m
        if J(i,j)==0
            J(i,j)=J(i,j-1);
        end
    end
end

resI=J;

% figure;
% subplot(2,1,1);
% imshow(I);
% title('input Figure')
% subplot(2,1,2)
% imshow(J)
% title('Figure after padding edges');

end