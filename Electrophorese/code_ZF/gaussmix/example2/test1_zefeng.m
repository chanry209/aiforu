clear all
close all
clc
format compact

%% Bases
n = 10; %10 locuteurs
% disp('There are 10 speaks to recognize. We load their data... \n');
% input('press <Enter> to continue...');

[Base] = base_monaurale(n);

for i = 1:10
traindata(i).mono = Base(i).mono(1:15000,:); % 10 groupes de 20000 data par chaque locuteur
end


Basetest = [];
for i = 1:10
testdata = [Basetest;Base(i).mono(15001:18000,:)];
Basetest = testdata;
end

% n = input('How many of the mixtures initales? \n');

for j = 1:10
[mtrs,class(j).mono] = GaussianMixture(traindata(j).mono, 40, 0, false);
% disp(sprintf('\toptimal order K*: %d', class(j).mono.K));
% for i=1:class(j).mono.K
%    disp(sprintf('\tCluster %d:', i));
%    disp(sprintf('\t\tpi: %f', class(j).mono.cluster(i).pb));
%    disp([sprintf('\t\tmean: '), mat2str(class(j).mono.cluster(i).mu',6)]);
%    disp([sprintf('\t\tcovar: '), mat2str(class(j).mono.cluster(i).R,6)]);
% end
% temp = strcat('press <Enter> to continue ( The ',num2str(j), 'st group on training)...');
% input(temp);
% disp(' ');
end

% disp('clustering class 2...');
% [mtrs,class2] = GaussianMixture(traindata2, 20, 0, false);
% disp(sprintf('\toptimal order K*: %d', class2.K));
% for i=1:class2.K
%    disp(sprintf('\tCluster %d:', i));
%    disp(sprintf('\t\tpi: %f', class2.cluster(i).pb));
%    disp([sprintf('\t\tmean: '), mat2str(class2.cluster(i).mu',6)]);
%    disp([sprintf('\t\tcovar: '), mat2str(class2.cluster(i).R,6)]);
% end

% disp('performing maximum likelihood classification...');
% disp('for each test vector, the following calculates the log-likelihood given each of the two classes, and classify');
% disp('the first half of the samples are generated from class 1, the remaining half from class 2');
% disp(' ');



for i = 1:10
likelihood(:,i) = GMClassLikelihood(class(i).mono, testdata);
end
%%

a = likelihood;
Taux_Reco_23ms = Taux_Reco_23s(a);
    
% %% Critère 1 : 23ms
% for i = 1:50000
%     m(i)=find(likelihood(i,:)==max(likelihood(i,:)));
% end
%     
% Target = 1:10;
% Target = repmat(Target,5000,[]);
% Target = Target(:);
% Target = Target';
% Taux_Reco_23ms = numel(find(m == Target))/length(Target);
    
%% Critère 1second
Taux_1s = Taux_Reco_1s(a);

for i = 1:1000;
    a = likelihood;
    b = mean(a((((i-1)*30+1):i*30),:));
    y(i)=find(b==max(b));
end

Target = 1:10;
Target = repmat(Target,100,[]);
Target = Target(:);
Target = Target';
Taux_Reco_1s = numel(find(y == Target))/length(Target);

%% matrice de conffision
fusion1 = zeros(10,10); % matrice de fusion
for i = 1:1000;
    x1 = y(i);
    y1 = Target(i);
    fusion1(x1,y1) = fusion1(x1,y1)+1;
end

%% Critère de vote
for i = 1:30000
    m(i)=find(a(i,:)==max(a(i,:)));
end
m_modifier = reshape(m,30,[]);

for i = 1:length(m_modifier); % 1 : 1000
    for j = 1:10
        nomb(j)=numel(find(m_modifier(:,i)==j)); 
    end
    
    if numel(nomb==max(nomb))>=2
        y_temp = find(nomb==max(nomb)); 
        y_vote(i) = y_temp(1);
    else
    y_vote(i) = find(nomb==max(nomb));
    end
end

Target = 1:10;
Target = repmat(Target,100,[]);
Target = Target(:);
Target = Target';
Taux_Reco_1s_vote = numel(find(y_vote == Target))/length(Target);


% % for n=1:size(testdata,1)
% %    disp([mat2str(testdata(n,:),4), sprintf('\tlikelihood: '), mat2str(likelihood(n,:),4), sprintf('\tclass: %d',  class(n))]);
% % end
% % 
% % class_labels = [1 2];
% % class_labels = repmat(class_labels,100,[]);
% % class_labels = class_labels(:);
% % error = numel(find(class_labels~=test_label'));