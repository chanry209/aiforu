function [vectors, coeff, newValue0, ValueForDraw,percent_explained] = acp_zf(x,threshold,flag)
%        by zefeng @ Maris 2011
if nargin == 1
    threshold = 90;
    flag = 0;% Don't show the figure of PCA
end
if (flag~=0)&&(flag~=1)
    error('Input unkonown! Flag==1 > Show the figure of the PCA; Flag==0 > Don''t show it.')
end



% disp('The inputs must be m x n, m samples and n caracters.')
C =cov(x);
[vectors,coeff]=eig(C);
vectors = fliplr(vectors);
newValue = x*vectors;
v1 = var(newValue);
v2 = diag(coeff);
v2 = v2';
v2 = fliplr(v2);
% fprintf('The variances of the new varaibles are %f \n',v1);
% fprintf('The eigvalues of the kernel C are %f \n',v2);


%% affichage

dataset_cumsum = 100*cumsum(v2)./sum(v2);
index = find(dataset_cumsum >= threshold);
percent_explained = 100*v2/sum(v2);
if flag==1
figure;
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis of the anti-icing System of F02X ')
grid on;
end
%% 
newValue0 = newValue(:,1:index(1));

%% new values for draw - 3D

ValueForDraw = newValue(:,1:3);
