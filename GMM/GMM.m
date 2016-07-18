% Clustering by Gaussian Mixture Model
% Author : T. N. Vikram
% Place: International School of Information Management
% Reference :  Algorithm Collections For Digital Signal Processing
% Applications Using Matlab -  E.S. Gopi  , Kluwer 2007
% Email: vikram@isim.ac.in

% GMM Example
% x1 = 10 + sqrt(3) * randn(5,3);
% x2 = 20 + sqrt(5) * randn(5,3);
% x3 = 25 + sqrt(2) * randn(5,3);
% Input = [x1 x2 x3];
% No_of_Clusters = 2;
% No_of_Iterations = 5;
% [INDEX,Mu, Variances] = GMM(Input, No_of_Clusters,No_of_Iterations);



function [INDEX, Mu, Variances] = GMM(Input, No_of_Clusters,Limit)

% Initialize_the_Cluster_Centroid
[IDX, Initial_Centroids] = kmeans(Input',No_of_Clusters);

Mu = Initial_Centroids';
Limit = 10;
for Iterations = 1:Limit
[No_of_Features_within_Data,No_of_Data_Points] = size(Input);
Probability_of_Cluster_given_Point(1:No_of_Clusters,1:No_of_Data_Points) = 0.0;
[PC,INDEX] = Cluster_Probability(Input,Mu);

%Initialize Cluster Covariances
COVAR(1:No_of_Features_within_Data,1:No_of_Clusters) = 0.0;
for i=1:No_of_Clusters 
  COVAR(:,i) = Cluster_Covariance(Input(:,IDX==i));
end
    
%Initialize the probability matrix P(Cluster/Point)
Variances = COVAR;
for i=1:No_of_Clusters
for j=1:No_of_Data_Points
Probability_of_Cluster_given_Point(i,j) = Probability_of_Cluster_given_X(Input(:,j),Mu,Variances,PC,i);
end;
end;

% New Means
Mu1(1:No_of_Clusters,1:No_of_Features_within_Data) = 0.0;
for i=1:No_of_Clusters
Mu1(i,:) = Compute_Mean_for_Cluster(Input,Mu,Variances,PC,i);
end;
%disp(Iterations);
%disp(Mu1);
Mu = Mu1';
end;
















