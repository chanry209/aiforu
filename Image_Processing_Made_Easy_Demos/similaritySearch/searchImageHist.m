function SimilarRank=searchImageHist(I, test_modelName, nResult)

% function searchImageHist(imageName, modelName, nResults)
% Image retrieval m-file

% load train model:
load(test_modelName);

% compute 3-D image histograms (HSV color space):
fprintf('Computing 3-D (HSV) histogram for query image...\n');
[Hist, Iq] = getImageHists(I);

% number of training samples:
Nfiles = length(Hists);

% decision thresholds:
t = 0.010;
t2 = 0.8;

fprintf('Searching...\n');

range = 0.0:0.1:1.0;
rangeNew = 0.0:0.05:1.0;
[x,y,z]    = meshgrid(range);
[x2,y2,z2] = meshgrid(rangeNew);

Hist = interp3(x,y,z,Hist,x2,y2,z2);

Similarity = zeros(Nfiles, 1);

for i=1:Nfiles % for each file in database:
    
    % compute (normalized) eucledean distance for all hist bins:
    HistT = interp3(x,y,z,Hists{i},x2,y2,z2);
    DIFF = abs(Hist-HistT) ./ Hist;
    
    % keep distance values for which the corresponding query image's values
    % are larger than the predefined threshold:    
    DIFF = DIFF(Hist>t);
    
    % keep error values which are smaller than 1:
    DIFF2 = DIFF(DIFF<t2);
    L2 = length(DIFF2);
    
    % compute the similarity meaasure:
    Similarity(i) = length(DIFF) * mean(DIFF2) / (L2^2);
    
end

% find the nResult "closest" images:
% Sorted is the value of similarity and ISorted is the index corresponding
[Sorted, ISorted] = sort(Similarity);
SimilarRank=[Sorted,ISorted];
% subplot(4,4,1);
% imshow(Iq); 
% title('target image');

% save and show similar images:

% if nResult<1
%     fprintf('please entre a positive integer \n');
%     return;
% elseif nResult <=4
%     for i=1:nResult
%         I=imread(files{ISorted(i)});
%         str = sprintf('I%d similarity: %.3f',i,100*Sorted(i));
%         subplot(1,nResult,i);
%         imshow(I);
%         title(str);
%     end
% elseif nResult<=8
%     for i=1:nResult
%         I=imread(files{ISorted(i)});
%         str = sprintf('I%d similarity: %.3f',i,100*Sorted(i));
%         subplot(2,4,i);
%         imshow(I);
%         title(str);
%     end
% elseif nResult<=12
%     for i=1:nResult
%         I=imread(files{ISorted(i)});
%         str = sprintf('I%d similarity: %.3f',i,100*Sorted(i));
%         subplot(3,4,i);
%         imshow(I);
%         title(str);
%     end
% else
%     fprintf('Search number can not be greater than 12 \n ');
% end
%     
%     
%     
    
    
%     
% for i=1:4
%     I = imread(files{ISorted(i)});
% 	%str = sprintf('Image %d with similarity: %.3f',i,100*Sorted(i));
%     str = sprintf('I%d similarity: %.3f',i,100*Sorted(i));
%     subplot(4,4,i); 
%     imshow(I);  
%     title(str);
% end
% for i=5:7
%     I = imread(files{ISorted(i)});
% 	str = sprintf('Im %d: %.3f',i-1,100*Sorted(i));
%     subplot(5,4,i+1); 
%     imshow(I);  
%     title(str);
% end
% for i=9:11
%     I = imread(files{ISorted(i)});
% 	str = sprintf('Im %d: %.3f',i-2,100*Sorted(i));
%     subplot(5,4,i+1); 
%     imshow(I);
%     title(str);
% end
% for i=13:15
%     I = imread(files{ISorted(i)});
% 	str = sprintf('Im %d: %.3f',i-3,100*Sorted(i));
%     subplot(5,4,i+1);
%     imshow(I);
%     title(str);
% end

fprintf('Done\n');
end

