
%% Output of the net ATT
%  @ zefeng 18/18/2011
%  Syntax : [output Result]  = Output_mlp_ZF(model,Base,Target)

% Output            : V1 S1 V2 for each subnet
% Result.S2         : Outputs of the final net before the threshold
% Result.V2         : Outputs of the final net after the threshold
% Result.Proba      : Probability of outputs
% Result.NumFinal   : Outputs with 0 1
% Result.CM         : Matrix conf


function [output Result]  = Output_mlp_ZF(model,Base,Target)

%Sortie couche cachée :
        W1 = model.W1;
        B1 = model.B1;
        W2 = model.W2;
        B2 = model.B2;
        
        ex_nbr = size(Base,2);
        V1 = W1*Base+B1*ones(1,ex_nbr);
        S1 = sigmo(V1);

        %Sortie couche de sortie : 
        V2 = W2*S1+B2*ones(1,ex_nbr);    
        S2 = sigmo(V2);

        
        % confusion        
        for i = 1:ex_nbr
        temp = S2(:,i);
        temp(temp ~= max(temp))=0;
        temp(temp == max(temp))=1;
        S2(:,i)=temp;
        clear temp        
        end
        Result.NumFinal = S2;
        Result.Proba = softmax(S2);
        
        Goal = vec2ind(Target);
        output = vec2ind(S2);
        CM = MatrixConf_ZF(Goal,output);
        Result.CM = CM;

        
        