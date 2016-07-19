%% See the results of network directly
%% 
clc
clear

%% 1) Loading
choiseInd = input('Real data == 1 or Simulation data == 2 ? \n');
if choiseInd == 2
        load dataAdaboost20120307

    else if choiseInd == 1
            
        load F02Data4Faults
 
        end
end
     
%% 2) Network PNN Matlab

Kinit = 30;
Kfinal = 0;

if choiseInd== 1
    
        [m1,n1] = size(InputRef);
        p1 = randperm(n1);
        Data2 = zeros(m1,1000);
        for i = 1:1000
            Data2(:,i) = InputRef(:,p1(i));
        end
        
        %data_temp = [Data2 InputFault1 InputFault2 InputNoise];
        %[data1,ps] = norma_zf(data_temp);
        
        %data(1).Test = data_temp(:,1:1000)';
        data(1).Test = Data2'; 
        
        data(1).Test(:,1:3)=[];
        indice = size(data(1).Test,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(1).Test = data(1).Test(trainInd,:);
        dataTest(1).Test = data(1).Test(testInd,:);
        label1 = ones(size(dataTest(1).Test),1);
        
        %data(2).Test = data_temp(:,1000+1:1000+length(InputFault1))';
        data(2).Test = InputFault1';
        data(2).Test(:,1:3)=[];
        indice = size(data(2).Test,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(2).Test = data(2).Test(trainInd,:);
        dataTest(2).Test = data(2).Test(testInd,:);
        label2 = ones(size(dataTest(2).Test),1)*2;
        
        %data(3).Test = data_temp(:,1000+length(InputFault1)+1:1000+length(InputFault1)+length(InputFault2))';
        data(3).Test = InputFault2';
        data(3).Test(:,1:3)=[];
        indice = size(data(3).Test,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(3).Test = data(3).Test(trainInd,:);
        dataTest(3).Test = data(3).Test(testInd,:);
        label3 = ones(size(dataTest(3).Test),1)*3;
        
        %data(4).Test = data_temp(:,1000+length(InputFault1)+length(InputFault2)+1:1000+length(InputFault1)+length(InputFault2)+length(InputNoise))';
        data(4).Test = InputNoise';
        data(4).Test(:,1:3)=[];
        indice = size(data(4).Test,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(4).Test = data(4).Test(trainInd,:);
        dataTest(4).Test = data(4).Test(testInd,:);
        label4 = ones(size(dataTest(4).Test),1)*4;
                        
        dataTestTotal = [];
        labelTest = [label1; label2; label3; label4];
        
        for i = 1:4
        [mtrs(i).Test,class(i).Test] = GaussianMixture(dataTrain(i).Test, Kinit, Kfinal, false);   
        dataTestTotal = [dataTestTotal; dataTest(i).Test];
        end
        
        L = Kinit;
        Taux_Rec = zeros(L,1);
        
        for i = 1:L
            likelihoodTest=zeros(size(dataTestTotal,1), 4);            
            for j = 1 : 4
                CLASS = mtrs(j).Test(i);
                likelihoodTest(:,j) = GMClassLikelihood(CLASS, dataTestTotal);
            end
            classTest=ones(size(dataTestTotal,1),1);
            
            for k = 1:size(dataTestTotal,1)
            index = (find(likelihoodTest(k,:) == max(likelihoodTest(k,:))));
            classTest(k)=index;
            end
            
            Taux_Rec(i) = numel(find(labelTest==classTest))/length(labelTest)*100;
            str = sprintf('Le taux de reconnaissace par GMM est %g%% en K = %g \n',Taux_Rec(i),i);
            disp(str)
            clear str
        end
        
        plot(1:L,Taux_Rec,'r*');
        hold on
        plot(1:L,Taux_Rec,'b-.');
        title('Le Taux de reconnaissance en fonction de K')
        ylabel('Pourcentage du taux de reconnaissance')
        xlabel('Nombre des mixtures : K')
    
    
else if choiseInd == 2

        data(1).Simu = dataIORef;
        indice = size(data(1).Simu,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(1).Simu = data(1).Simu(trainInd,:);
        dataTest(1).Simu = data(1).Simu(testInd,:);
        label1 = ones(size(dataTest(1).Simu),1);
        
        data(2).Simu = dataIOFault2101;
        indice = size(data(2).Simu,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(2).Simu = data(2).Simu(trainInd,:);
        dataTest(2).Simu = data(2).Simu(testInd,:);
        label2 = ones(size(dataTest(2).Simu),1);
        
        data(3).Simu = dataIOFault2102;
        indice = size(data(3).Simu,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(3).Simu = data(3).Simu(trainInd,:);
        dataTest(3).Simu = data(3).Simu(testInd,:);
        label3 = ones(size(dataTest(3).Simu),1);
        
        data(4).Simu = dataIOFault2103;
        indice = size(data(4).Simu,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(4).Simu = data(4).Simu(trainInd,:);
        dataTest(4).Simu = data(4).Simu(testInd,:);
        label4 = ones(size(dataTest(4).Simu),1);
                
        data(5).Simu = dataIOFault2104;
        indice = size(data(5).Simu,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(5).Simu = data(5).Simu(trainInd,:);
        dataTest(5).Simu = data(5).Simu(testInd,:);
        label5 = ones(size(dataTest(5).Simu),1);
                
        data(6).Simu = dataIOFault2105;
        indice = size(data(6).Simu,1);
        [trainInd,testInd] = crossvalind('holdout',indice,0.2);
        dataTrain(6).Simu = data(6).Simu(trainInd,:);
        dataTest(6).Simu = data(6).Simu(testInd,:);
        label6 = ones(size(dataTest(6).Simu),1);
        
        dataTestTotal = [];
        labelTest = [label1; label2; label3; label4; label5; label6];
        
        for i = 1:6
        [mtrs(i).Simu,class(i).Simu] = GaussianMixture(dataTrain(i).Simu, Kinit, Kfinal, false);   
        dataTestTotal = [dataTestTotal; dataTest(i).Simu];
        end
        
        L = Kinit;
        Taux_Rec = zeros(L,1);
        
        for i = 1:L
            likelihoodTest=zeros(size(dataTestTotal,1), 6);            
            for j = 1 : 6
                likelihoodTest(:,j) = GMClassLikelihood(class(j).Simu, dataTestTotal);
            end
            classTest=ones(size(dataTestTotal,1),1);
            
            for k = 1:size(dataTestTotal,1)
            index = (find(likelihoodTest(k,:) == max(likelihoodTest(k,:))));
            classTest(k)=index;
            end
            
            Taux_Rec(i) = numel(find(labelTest==classTest))/length(labelTest)*100;
            str = sprintf('Le taux de reconnaissace par GMM est %g%% en K = %g \n',Taux_Rec(i),i);
            disp(str)
            clear str
        end
        
        plot(1:L,Taux_Rec,'r*');
        hold on
        plot(1:L,Taux_Rec,'b-.');
        title('Le Taux de reconnaissance en fonction de K')
        ylabel('Pourcentage du taux de reconnaissance')
        xlabel('Nombre des mixtures : K')
        
        
     end
end

