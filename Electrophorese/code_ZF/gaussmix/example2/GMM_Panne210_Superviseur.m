%% Avec superviseurs - Panne 210
%  06-10-2010 by ZeFeng
clc
clear all;
close all;

if exist('GaussianMixture')~=2
   pathtool;
   error('the directory containing the Cluster program must be added to the search path');
end

disp('generating data...');
load data_input_output
indices = ones(length(num_ref),1);
[train,test] = crossvalind('holdout',indices,0.2);
traindata1 = num_ref(train,:);
data_test1 = num_ref(test,:);
Labeltest1=ones(size(data_test1,1),1);

indices = ones(size(num_panne,1),1);
[train,test] = crossvalind('holdout',indices,0.2);
traindata2 = num_panne(train,:);
data_test2 = num_panne(test,:);
Labeltest2=ones(size(data_test2,1),1)*2;

Labeltest = [Labeltest1;Labeltest2];
testdata = [data_test1;data_test2];
% mkdata;
% clear all;
% traindata1 = load('TrainingData1');
% traindata2 = load('TrainingData2');
% testdata = load('TestingData');
% input('press <Enter> to continue...');
disp(' ');
Kinit  = input('Input the Kinit  = ...\n');
Kfinal = input('Input the Kfinal =  ...\n');

% [mtrs, omtr] = GaussianMixture(pixels, initK, finalK, verbose)
% - pixels is a NxM matrix, containing N training vectors, each of M-dimensional
% - start with initK=20 initial clusters
% - finalK=0 means estimate the optimal order
% - verbose=true displays clustering information
% - mtrs is an array of structures, each containing the cluster parameters of the
%   mixture of a particular order
% - omtr is a structure containing the cluster parameters of the mixture with
%   the estimated optimal order
disp('clustering class 1...');
[mtrs,class1] = GaussianMixture(traindata1, Kinit, Kfinal, false);

disp(sprintf('\toptimal order K*: %d', class1.K));
for i=1:class1.K
   disp(sprintf('\tCluster %d:', i));
   disp(sprintf('\t\tpi: %f', class1.cluster(i).pb));
   disp([sprintf('\t\tmean: '), mat2str(class1.cluster(i).mu',6)]);
   disp([sprintf('\t\tcovar: '), mat2str(class1.cluster(i).R,6)]);
end
input('press <Enter> to continue...');
disp(' ');

disp('clustering class 2...');
[mtrs,class2] = GaussianMixture(traindata2, Kinit, Kfinal, false);
disp(sprintf('\toptimal order K*: %d', class2.K));
for i=1:class2.K
   disp(sprintf('\tCluster %d:', i));
   disp(sprintf('\t\tpi: %f', class2.cluster(i).pb));
   disp([sprintf('\t\tmean: '), mat2str(class2.cluster(i).mu',6)]);
   disp([sprintf('\t\tcovar: '), mat2str(class2.cluster(i).R,6)]);
end
input('press <Enter> to continue...');
disp(' ');

disp('performing maximum likelihood classification...');
disp('for each test vector, the following calculates the log-likelihood given each of the two classes, and classify');
disp('the first half of the samples are generated from class 1, the remaining half from class 2');
disp(' ');
likelihood=zeros(size(testdata,1), 2);
likelihood(:,1) = GMClassLikelihood(class1, testdata);
likelihood(:,2) = GMClassLikelihood(class2, testdata);
class=ones(size(testdata,1),1);
class(find(likelihood(:,1)<=likelihood(:,2)))=2;
for n=1:size(testdata,1)
   disp([mat2str(testdata(n,:),4), sprintf('\tlikelihood: '), mat2str(likelihood(n,:),4), sprintf('\tclass: %d',  class(n))]);
end

Taux_Rec = numel(find(Labeltest==class))/length(Labeltest)*100;
str = sprintf('Le taux de reconnaissace par GMM est %g%%',Taux_Rec);
disp(str)

