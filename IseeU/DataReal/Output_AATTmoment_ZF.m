
%% Output of the net ATT
%  @ zefeng 15/09/2011
%  Syntax : [output Result]  = Output_AATTmoment_ZF(model,Net_Together,Base,Target)

% Output            : V1 S1 V2 for each subnet
% Result.S2         : Outputs of the final net before the threshold
% Result.V2         : Outputs of the final net after the threshold
% Result.Proba      : Probability of outputs
% Result.NumFinal   : Outputs with 0 1
% Result.CM         : Matrix conf


function [output Result]  = Output_AATTmoment_ZF(model,Net_Together,base,Target)

%Sortie couche cachée :
N = size(base,2);
ex_nbr = size(Target,2);
    for j = 1:N
        W1 = model(j).BW1;
        B1 = model(j).BB1;
        W2 = model(j).BW2;
        B2 = model(j).BB2;
        Base = base(j).AAT;

% --- erreur en sortie :
        V1 = W1*Base+B1*ones(1,ex_nbr);
        S1 = sigmo_zf(V1);

        V2 = W2*S1+B2*ones(1,ex_nbr);
        
        result(j).V1 = V1;%!!!
        result(j).V2 = V2;
        result(j).S1 = S1;
        
        clear V2 V1 S1
    end
    
    V2 = 0;
    for j = 1:N
        V2 = V2 + result(j).V2;
    end
	S2 = sigmo_zf(V2);  
    
    W3 = Net_Together.BW3;
    B3 = Net_Together.BB3;
    
    
    V3 = W3*S2+B3*ones(1,ex_nbr);
	S3 = sigmo_zf(V3);
   
    Result.Proba = softmax(S3);
    Result.NumPrimaire = S3;  
    % confusion        
        for i = 1:ex_nbr
        temp = S3(:,i);
        temp(temp ~= max(temp))=0;
        temp(temp == max(temp))=1;
        S3(:,i)=temp;
        clear temp        
        end
        
        Result.NumFinal = S3;
        Goal = vec2ind_zf_option(Target,2);
        output = vec2ind_zf_option(S3,2);
        CM = MatrixConf_ZF(Goal,output);
        Result.CM = CM;

        
        