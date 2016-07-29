%% Net BP modified by ZeFeng at 18/08/2011
%    Origine MLP2ACRVTRAIN - Bruno Gas - LIS/P&C UPMC
%
%  Apprentissage des poids d'un Percepteron MultiCouche par
%  l'algorithme de reropropagation (gradient total) et pas
%  d'apprentissage adaptatif avec cross-validation, and the momentum.   
%  ---- Use the validatation to find the best iteration and save the W B
%  ---- Increase the iteration if the system can continu recherch the goal
%  ---- Three cases to define the LR(speed of study)
%  ---- 2 hidden nets A (A T) T
%
%
%
% SYNTAXE :
%  [model Net_Together]= NetAATT_momentum(input,output,n,err_glob,option,lr,lamda)
%
% ARGUMENTS :
% Base   		: matrice des ehantillons de la base d'apprentissage
% Target 		: matrice des vecteurs sorties desirees
% n             : nombre maximum d'iterations d'apprentissage
% err_glob      : Target of error
% option        : choix of the method to calculate the nb of hidden cells
% lr     		: [optionnel] vecteur pas d'apprentissage adaptatif :
%				  lr = [lr0 lr_dec, lr_inc, delta]
%                   lr0    : pas d'apprentissage initial
%                   lr_dec : valeur d'increasent du pas
%                   lr_inc : valeur de descendent du pas
%                   err_ratio : seuil de declenchement du drément
%lamda      : proportion of the the momentum
%
% 80% data for trainning; 20% data for CV
% 
% VALEURS DE RETOUR :
%
% For Training data : Weights, Thresholds and the outputs of each layer
% model.W1
% model.B1 
% model.W2
% model.B2 
% model.V1 = V1;
% model.V2 = V2;
% model.S1 = S1;
% model.S2 = S2;
% Net_Together.W3    Net_Together.B3
% For CrossValidation : outputs of each layer
% model.V1Crv = V1Crv;
% model.V2Crv = V2Crv;
% model.S1Crv = S1Crv;
% model.S2Crv = S2Crv;
%
% Remember the data in the trainning and CV 
% model.Base = Base;
% model.BaseCrv = BaseCrv;
% model.Target = Target;
% model.TargetCrv = TargetCrv;
%
% model.LR = LR; % remember the lr
% model.BestInd = bestit; % Best Indice of the iteration

function [model Net_Together]= NetAATT_momentum(input,output,n,err_glob,option,lr,lamda,affichage)

N = size(input,2);
bestit = 0;
%-------------------------
if nargin<3
   n         = 1000;
   err_glob  = 0.001;
   lr0       = 1;
   lr_dec    = 0.9;
   lr_inc    = 1.1;
   err_ratio = 1;
   lr = [lr0 lr_dec, lr_inc, err_ratio];
   option    = 1;
   lamda = 0.5;
   affichage = 0;
end
%%  Nb of Net cells and the Weights - threshold of net 
%% calculate the weight and bias for each sub net
    Np = size(output,2);
    indices = ones(Np,1);
    [trainInd,testInd] = crossvalind('holdout',indices,0.1);
    data_goal_train = output(:,trainInd);
    data_goal_test  = output(:,testInd);
    Target          = data_goal_train;
    TargetCrv       = data_goal_test;
    No      = size(Target,1);
    Nc2     = ceil(log2(Np));
    Targ2  = ones(Nc2,10); % for aide to calculate Nc1

for i = 1:N
    Base    = input(i).AAT;
    [Ni,~]  = size(Base);
    Nc1      = cellhidden_zf(Base,Targ2,option);
    
    [W1,B1] = randweights_zf(Nc1,Ni);
    [W2,B2] = randweights_zf(Nc2,Nc1);
    
    % initialisation des meilleurs poids :     
    data_train = Base(:,trainInd);
    data_test  = Base(:,testInd);
    Base         = data_train;
    BaseCrv    = data_test;
    
        % initiation of model
         model(i).W1 = W1;
         model(i).B1 = B1;
         model(i).W2 = W2;
         model(i).B2 = B2;
         
         model(i).BW1 = W1;
         model(i).BB1 = B1;
         model(i).BW2 = W2;
         model(i).BB2 = B2;
         
         model(i).Ni = Ni;
         model(i).Nc1 = Nc1;
         
         model(i).Base = Base;
         model(i).BaseCrv = BaseCrv;
         model(i).Target = Target;
         model(i).TargetCrv = TargetCrv;
% nb. total d'exemples apprendre :
%---------------------------------------
[input_nbr ex_nbr]       = size(Base);
[~, excrv_nbr] = size(BaseCrv);

% --- cohérence des arguments :
[n_cell n_in]       = size(W1);
[output_nbr ~]   = size(Target);
[outputcrv_nbr ~] = size(TargetCrv);

if input_nbr~=n_in
  error('[MLP2ACRVTRAIN] coherence dans les arguments : W1 et Data'); end;
if size(B1)~=[n_cell 1]
  error('[MLP2ACRVTRAIN]  coherence dans les arguments : W1 et B1'); end;
if size(W2)~=[output_nbr n_cell]
  error('[MLP2ACRVTRAIN] coherence dans les arguments : W2 et Class'); end;
if size(B2)~=[output_nbr 1]
  error('[MLP2ACRVTRAIN] coherence dans les arguments : W2 et B2'); end;


end
    [W3,B3] = randweights_zf(No,Nc2);
    BW3 = W3;   BB3 = B3;
    
    Net_Together.W3 = W3;   
    Net_Together.BW3 = W3;   
    Net_Together.B3 = B3;   
    Net_Together.BB3 = B3; 
    
    Net_Together.Nc2 = Nc2;   

clear W1 B1 W2 B2 W3 B3 Ni Nc1 Nc2 Base data_train data_test Base BaseCrv;
clear data_goal_train data_goal_test 
    
    
% pas adaptatif :
%----------------
lr0 = lr(1);			% valeur initiale du pas
lr_dec = lr(2);			% décrément du pas
lr_inc = lr(3);			% incrément du pas
err_ratio = lr(4);		% seuil de déclenchement du décrément

% --- fonction cout quadratique :
L = zeros(1,n);
MaxL = ex_nbr*output_nbr;
MaxLV = excrv_nbr*outputcrv_nbr; 

% Normalisations :
%-----------------
lr0 =lr0/MaxL;

% --- initialisation du pas :
lr = lr0;					
LR = zeros(1,n);

%% --- Erreur en validation :

        for j = 1:N
        W1 = model(j).W1;
        B1 = model(j).B1;
        W2 = model(j).W2;
        B2 = model(j).B2;
        
        Base    = model(j).Base;
        BaseCrv    = model(j).BaseCrv;
        
        V1Crv = W1*BaseCrv + B1*ones(1,excrv_nbr);%ex_nbr);   RB : modifified jeudi 13 mai 2004
        S1Crv = sigmo_zf(V1Crv);
        V2Crv = W2*S1Crv + B2*ones(1,excrv_nbr);%ex_nbr); RB : modifified jeudi 13 mai 200
        model(j).V1Crv = V1Crv;
        model(j).S1Crv = S1Crv;
        model(j).V2Crv = V2Crv;
     
        V1 = W1*Base + B1*ones(1,ex_nbr);
        S1 = sigmo_zf(V1);
        V2 = W2*S1 + B2*ones(1,ex_nbr);
        model(j).V1 = V1;
        model(j).S1 = S1;
        model(j).V2 = V2;       
        clear V1 S1 V2 W1 B1 W2 B2 Base BaseCrv 
        clear V1Crv S1Crv V2Crv W1Crv B1Crv W2Crv B2Crv
        end
        
        V2 = 0;
        V2Crv = 0;
        
        for j = 1:N
        V2 = V2 + model(j).V2;
        V2Crv = V2Crv + model(j).V2Crv;
        end
        Net_Together.V2 = V2;   
        Net_Together.V2Crv = V2Crv;  
        
        % --- Erreur en sortie :
        S2 = sigmo_zf(V2);
        S2Crv = sigmo_zf(V2Crv);
        W3 = Net_Together.W3;
        B3 = Net_Together.B3;
        
        Net_Together.S2 = S2;   
        Net_Together.S2Crv = S2Crv;   
        
        V3 = W3*S2 + B3*ones(1,ex_nbr);
        V3Crv = W3*S2Crv + B3*ones(1,excrv_nbr);
        S3 = sigmo_zf(V3);
        S3Crv = sigmo_zf(V3Crv);
        
        Net_Together.V3 = V3;   
        Net_Together.V3Crv = V3Crv;  
        Net_Together.S3 = S3;   
        Net_Together.S3Crv = S3Crv;          
        
        Ecrv  = TargetCrv - S3Crv;
        E = Target - S3;
        LV(1) = sumsqr_zf(Ecrv)/MaxLV;
        min_valid = LV(1);
        
        clear V2 S2 V2Crv S2Crv V3 V3Crv W3 B3  


% --- boucle d'apprentissage :
it_valid = 2;

it  = 1;

while it<=n
%pause;
% --- Cout quadratique :	
	L(it) = sumsqr_zf(E)/MaxL;
	LR(it) = lr; % speed of study of each iteration
   

% --- Critère d'arret :
	if err_glob~=0 && L(it) <= err_glob
		L = L(1:it);
		LR = LR(1:it);
		return;
	end;	

    
% --- Adaptation du pas d'apprentissage :
    if it>1
        
        if affichage == 1
     fprintf('Iteration:%d  ; Error Train : %f  ; TL : %f  \n',it,L(it),TL)
        end
% Cas 1 --------------------------------------------
        
        if ((L(it) - TL*err_ratio)>0.00001)&&(lr>=0.00001)% if lr ==0, the study will be stop
            if affichage == 1
            fprintf('Case1 : (L(it) - TL*err_ratio)>0.00001 \n')
            end
        lr = lr*lr_dec;
        
            if affichage == 1
        fprintf('Speed of Study : %f \n',lr);
            end
% --- Fonction Co croissante au dela du seuil :

% --- Recuperation des poids :
            for j = 1:N
                W1 = model(j).TW1;
                B1 = model(j).TB1;
                W2 = model(j).TW2;
                B2 = model(j).TB2;
                D1 = model(j).D1;
                D2 = model(j).D2;
                Delta1 = model(j).Delta1;
                Delta2 = model(j).Delta2;
                dW1 = model(j).TdW1;
                dW2 = model(j).TdW2;
                dB1 = model(j).TdB1;
                dB2 = model(j).TdB2;
% --- degradentation du pas et modif. des poids :
                W1 = W1 - lr*D1+lamda*dW1;
                dW1 = -lr*D1;
            
                B1 = B1 - lr*Delta1*ones(ex_nbr,1) + lamda*dB1;
                dB1 =  - lr*Delta1*ones(ex_nbr,1);
            
            	W2 = W2 - lr*D2+lamda*dW2;
                dW2 = -lr*D2;
            
                B2 = B2 - lr*Delta2*ones(ex_nbr,1)+ lamda*dB2;
                dB2 =  - lr*Delta2*ones(ex_nbr,1);
        
                model(j).W1 = W1;
                model(j).dW1 = dW1;
                model(j).B1 = B1;
                model(j).dB1 = dB1;
                model(j).W2 = W2;
                model(j).dW2 = dW2;
                model(j).B2 = B2;        
                model(j).dB2 = dB2;
            
                clear TW1 W1 TB1 B1 TW2 W2 TB2 B2
                clear TdW1 dW1 TdB1 dB1 TdW2 dW2 TdB2 dB2
                
            end % N
         
            W3 = Net_Together.TW3;   
            B3 = Net_Together.TB3;    
            dW3 = Net_Together.TdW3;   
            dB3 = Net_Together.TdB3;    
            
            W3 = W3 - lr*D3+lamda*dW3;
            dW3 = -lr*D3;
            B3 = B3 - lr*Delta3*ones(ex_nbr,1)+ lamda*dB3;
            dB3 =  - lr*Delta3*ones(ex_nbr,1);
            
            Net_Together.W3 = W3;
            Net_Together.dW3 = dW3;
            Net_Together.B3 = B3;
            Net_Together.dB3 = dB3;
            
            clear TW3 W3 TB3 B3
            clear dW3 dW3 dTB3 dB3
            
            
% --- Fonction Co decroissante :------------------
% Cas 2 --------------------------------------------

        elseif (L(it) - TL*err_ratio)<-0.00001	
                        if affichage == 1
        fprintf('Case2 : (L(it) - TL*err_ratio)<-0.00001 \n')
                        end
% --- incrémentation du lr :
				lr = lr*lr_inc;
                            if affichage == 1
                fprintf('Speed of Study : %f \n',lr);
                            end
            
            V3 = Net_Together.V3;
            S2 = Net_Together.S2;
            
            W3 = Net_Together.W3;
            B3 = Net_Together.B3;
            dW3 = Net_Together.dW3;
            dB3 = Net_Together.dB3;

            TW3 = W3;
            TB3  = B3;
            TdW3 = dW3;
            TdB3 = dB3;
            
            Net_Together.TW3 = TW3;
            Net_Together.TB3 = TB3;
            Net_Together.TdW3 = TdW3;
            Net_Together.TdB3 = TdB3;
            
			Delta3 = -2*E.*dsigmo_zf(V3);
			D3 = Delta3*S2';                
            
            W3 = W3 - lr*D3+lamda*dW3;
	        dW3 = -lr*D3;      
            B3 = B3 - lr*Delta3*ones(ex_nbr,1)+lamda*dB3;
            dB3 =  - lr*Delta3*ones(ex_nbr,1);

% ---------------------------------------------
            for j = 1:N
            W1 = model(j).W1;
            B1 = model(j).B1;
            W2 = model(j).W2;
            B2 = model(j).B2;
            Base    = model(j).Base;
            V1 = model(j).V1;
            S1 = model(j).S1;
            V2 = model(j).V2;
            dW1 = model(j).dW1;
            dW2 = model(j).dW2;
            dB1 = model(j).dB1;
            dB2 = model(j).dB2;
        
% --- repropropagation :
            

			Delta2 = (W3'*Delta3).*dsigmo_zf(V2);
			D2 = Delta2*S1';

			Delta1 = (W2'*Delta2).*dsigmo_zf(V1);
			D1 = Delta1*Base';

% --- Sauvegarde des poids courants et modif. des poids :
			TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;
			TdW1 = dW1; TdB1 = dB1; TdW2 = dW2; TdB2 = dB2;
            TL = L(it);

	  		W1 = W1 - lr*D1+lamda*dW1;
            dW1 = -lr*D1;
            
		 	B1 = B1 - lr*Delta1*ones(ex_nbr,1)+lamda*dB1;
            dB1 =  - lr*Delta1*ones(ex_nbr,1);
            
		  	W2 = W2 - lr*D2+lamda*dW2;
		 	dW2 = -lr*D2;
            
	 		B2 = B2 - lr*Delta2*ones(ex_nbr,1)+lamda*dB2;
            dB2 =  - lr*Delta2*ones(ex_nbr,1);
        
            model(j).W1 = W1;
            model(j).dW1 = dW1;
            model(j).B1 = B1;
            model(j).dB1 = dB1;
            model(j).W2 = W2;
            model(j).dW2 = dW2;
            model(j).B2 = B2;        
            model(j).dB2 = dB2;
            model(j).TW1 = TW1;
            model(j).TW2 = TW2;
            model(j).TB1 = TB1;
            model(j).TB2 = TB2;
            
            model(j).TdW1 = TdW1;
            model(j).TdW2 = TdW2;
            model(j).TdB1 = TdB1;
            model(j).TdB2 = TdB2;
            
            clear TW1 W1 TB1 B1 TW2 W2 TB2 B2
            clear TdW1 dW1 TdB1 dB1 TdW2 dW2 TdB2 dB2
            end % N
            
            clear TW3 W3 TB3 B3
            clear dW3 dW3 dTB3 dB3
            
        % Case 3 -------------------------------------     
        else %abs(L(it) - TL*err_ratio)<0.00001;
                        if affichage == 1
                    fprintf('Case3 : abs(L(it) - TL*err_ratio)<0.00001 \n')
                        end
% --- incrémentation du lr :
                    lr = lr*2*lr_inc;
                                if affichage == 1
                    fprintf('Speed of Study : %f \n',lr);
                                end
                    
            V3 = Net_Together.V3;
            S2 = Net_Together.S2;
            
            W3 = Net_Together.W3;
            B3 = Net_Together.B3;
            dW3 = Net_Together.dW3;
            dB3 = Net_Together.dB3;

            TW3 = W3;
            TB3  = B3;
            TdW3 = dW3;
            TdB3 = dB3;
            
            Net_Together.TW3 = TW3;
            Net_Together.TB3 = TB3;
            Net_Together.TdW3 = TdW3;
            Net_Together.TdB3 = TdB3;
            
			Delta3 = -2*E.*dsigmo_zf(V3);
			D3 = Delta3*S2';                
            
            W3 = W3 - lr*D3+lamda*dW3;
	        dW3 = -lr*D3;      
            B3 = B3 - lr*Delta3*ones(ex_nbr,1)+lamda*dB3;
            dB3 =  - lr*Delta3*ones(ex_nbr,1);

% ---------------------------------------------
            for j = 1:N
            W1 = model(j).W1;
            B1 = model(j).B1;
            W2 = model(j).W2;
            B2 = model(j).B2;
            Base    = model(j).Base;
            V1 = model(j).V1;
            S1 = model(j).S1;
            V2 = model(j).V2;
            dW1 = model(j).dW1;
            dW2 = model(j).dW2;
            dB1 = model(j).dB1;
            dB2 = model(j).dB2;
        
% --- repropropagation :
            

			Delta2 = (W3'*Delta3).*dsigmo_zf(V2);
			D2 = Delta2*S1';

			Delta1 = (W2'*Delta2).*dsigmo_zf(V1);
			D1 = Delta1*Base';

% --- Sauvegarde des poids courants et modif. des poids :
			TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;
			TdW1 = dW1; TdB1 = dB1; TdW2 = dW2; TdB2 = dB2;
            TL = L(it);

	  		W1 = W1 - lr*D1+lamda*dW1;
            dW1 = -lr*D1;
            
		 	B1 = B1 - lr*Delta1*ones(ex_nbr,1)+lamda*dB1;
            dB1 =  - lr*Delta1*ones(ex_nbr,1);
            
		  	W2 = W2 - lr*D2+lamda*dW2;
		 	dW2 = -lr*D2;
            
	 		B2 = B2 - lr*Delta2*ones(ex_nbr,1)+lamda*dB2;
            dB2 =  - lr*Delta2*ones(ex_nbr,1);
        
            model(j).W1 = W1;
            model(j).dW1 = dW1;
            model(j).B1 = B1;
            model(j).dB1 = dB1;
            model(j).W2 = W2;
            model(j).dW2 = dW2;
            model(j).B2 = B2;        
            model(j).dB2 = dB2;
            model(j).TW1 = TW1;
            model(j).TW2 = TW2;
            model(j).TB1 = TB1;
            model(j).TB2 = TB2;
            
            model(j).TdW1 = TdW1;
            model(j).TdW2 = TdW2;
            model(j).TdB1 = TdB1;
            model(j).TdB2 = TdB2;
            
            clear TW1 W1 TB1 B1 TW2 W2 TB2 B2
            clear TdW1 dW1 TdB1 dB1 TdW2 dW2 TdB2 dB2
            end % N
            
            clear TW3 W3 TB3 B3
            clear dW3 dW3 dTB3 dB3
        end              
        
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
     %--- Erreur cross-validation :    
     
     for j = 1:N
        W1 = model(j).W1;
        B1 = model(j).B1;
        W2 = model(j).W2;
        B2 = model(j).B2;
        BaseCrv    = model(j).BaseCrv;
     
        V1Crv = W1*BaseCrv + B1*ones(1,excrv_nbr);
        S1Crv = sigmo_zf(V1Crv);
        V2Crv = W2*S1Crv + B2*ones(1,excrv_nbr);
        model(j).V1Crv = V1Crv;
        model(j).V2Crv = V2Crv;
        model(j).S1Crv = S1Crv;
        
        clear V1Crv S1Crv V2Crv
     end
     
     V2Crv = 0;
     for j = 1:N
         V2Crv = V2Crv + model(j).V2Crv;
     end
     
     W3 = Net_Together.W3;
     B3 = Net_Together.B3;
        
     S2Crv = sigmo_zf(V2Crv);
     V3Crv = W3*S2Crv + B3*ones(1,excrv_nbr);
     S3Crv = sigmo_zf(V3Crv);
     
     Ecrv  = TargetCrv - S3Crv;
     LV(it_valid) = sumsqr_zf(Ecrv)/MaxLV; 
     
     Net_Together.S2Crv = S2Crv;  
     Net_Together.V3Crv = V3Crv; 
     Net_Together.S3Crv = S3Crv; 
     
     clear S2Crv V3Crv S3Crv W3 B3
     
    %--- sauvegarde des meilleurs poids :
     if LV(it_valid) < min_valid
        for j = 1:N 
            model(j).BW1=model(j).W1;
            model(j).BW2=model(j).W2;
            model(j).BB1=model(j).B1;
            model(j).BB2=model(j).B2;
        end
        Net_Together.BW3 = Net_Together.W3;
        Net_Together.BB3 = Net_Together.B3;
        min_valid = LV(it_valid);   
        bestit = it_valid;
     end;
     
                 if affichage == 1
     fprintf('Error CV:%f \n',LV(it))
                 end

    
     it_valid = it_valid + 1;  
          
      % If it needs increase the iteration - bestit = n
      if bestit==n
          n = n + 500;
                      if affichage == 1
          fprintf('Because of bestit == n, the system increase the iteration + 500 time = %d \n',n);
                      end
      end

    else
        
        
%% --- 1st iteration : pas de modification du lr :
        V3 = Net_Together.V3;
        S2 = Net_Together.S2;
        W3 = Net_Together.W3;
        B3 = Net_Together.B3;
        TW3 = W3;   TB3 = B3;       
        
        Delta3 = -2*E.*dsigmo_zf(V3);
        D3 = Delta3*S2'; %%%!!!!!!!!!!!      

        W3 = W3 - lr*D3;
        dW3 = - lr*D3;
        B3 = B3 - lr*Delta3*ones(ex_nbr,1);
        dB3 =  - lr*Delta3*ones(ex_nbr,1);
        
        TdW3 = W3;   TdB3 = B3;   
        
        TL = L(it);
        
        for j = 1:N
            W1 = model(j).W1;
            B1 = model(j).B1;
            W2 = model(j).W2;
            B2 = model(j).B2;
            Base    = model(j).Base;
            V1 = model(j).V1;
            S1 = model(j).S1;
            V2 = model(j).V2;
% --- repropropagation :
            Delta2 = (W3'*Delta3).*dsigmo_zf(V2);
            D2 = Delta2*S1';

            Delta1 = (W2'*Delta2).*dsigmo_zf(V1);
            D1 = Delta1*Base';

% --- Sauvegarde des poids courants :
            TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;

% --- Modif. des poids :
            W1 = W1 - lr*D1;
            dW1=- lr*D1;
            B1 = B1 - lr*Delta1*ones(ex_nbr,1);
            dB1 =  - lr*Delta1*ones(ex_nbr,1);
            W2 = W2 - lr*D2;
            dW2 = - lr*D2;
            B2 = B2 - lr*Delta2*ones(ex_nbr,1);
            dB2 =  - lr*Delta2*ones(ex_nbr,1);

% --- Sauvegarde des poids courants :
            TdW1 = dW1; TdB1 = dB1; TdW2 = dW2; TdB2 = dB2;
            
            model(j).W1 = W1;
            model(j).dW1 = dW1;
            model(j).B1 = B1;
            model(j).dB1 = dB1;
            model(j).W2 = W2;
            model(j).dW2 = dW2;
            model(j).B2 = B2;        
            model(j).dB2 = dB2;
            model(j).TW1 = TW1;
            model(j).TW2 = TW2;
            model(j).TB1 = TB1;
            model(j).TB2 = TB2;
            model(j).TdW1 = TdW1;
            model(j).TdW2 = TdW2;
            model(j).TdB1 = TdB1;
            model(j).TdB2 = TdB2;
                    
            model(j).D1 = D1;
            model(j).D2 = D2;
            model(j).Delta1 = Delta1;
            model(j).Delta2 = Delta2;
                    
        clear W1 B1 W2 B2 V1 S1 V2 Delta2 D2 Delta1 D1
        clear dW1 dW2 dB1 dB2 TW1 TW2 TB1 TB2
        end
        
        Net_Together.W3 = W3;
        Net_Together.dW3 = dW3;
        Net_Together.B3 = B3;
        Net_Together.dB3 = dB3;
        Net_Together.TW3 = TW3;
        Net_Together.TdW3 = TdW3;
        Net_Together.TB3 = TB3;
        Net_Together.TdB3 = TdB3;
        
        Net_Together.D3 = D3;
        Net_Together.Delta3 = Delta3;                   
    end
    
    
%% ---------------------------------------------------
   % Calculate the output of the system
    
    for j = 1:N
        W1 = model(j).W1;
        B1 = model(j).B1;
        W2 = model(j).W2;
        B2 = model(j).B2;
        Base = model(j).Base;

% --- erreur en sortie :
        V1 = W1*Base+B1*ones(1,ex_nbr);
        S1 = sigmo_zf(V1);

        V2 = W2*S1+B2*ones(1,ex_nbr);
        model(j).V1 = V1;
        model(j).V2 = V2;
        model(j).S1 = S1;
    end
    
    V2 = 0;
    for j = 1:N
        V2 = V2 + model(j).V2;
    end
	S2 = sigmo_zf(V2);
    
    W3 = Net_Together.W3;
    B3 = Net_Together.B3;
    
    
    V3 = W3*S2+B3*ones(1,ex_nbr);
	S3 = sigmo_zf(V3);
    E = Target - S3;			
    Net_Together.S2 = S2;
    Net_Together.V3 = V3;
    Net_Together.S3 = S3;
    
% ---------------------------------------------------    
     it = it+1;
end; %it

% Results
%------------------
LR = LR*MaxL;
BestInd = bestit;
            if affichage == 1
figure
plot(1:n,LV,'-.');
hold on
plot(1:n,L,'r-.')
title('Result of the crossvalidation')
xlabel('Iteration')
ylabel('Quadratic Error')
plot(bestit,min_valid,'bo','markersize',16)
legend('CV - 20%','Train - 80%')
hold off
            else
    newFig = figure('Visible','off');
    plot(1:n,LV,'-.');
    hold on
    plot(1:n,L,'r-.')
    title('Result of the crossvalidation_NetATT')
    xlabel('Iteration')
    ylabel('Quadratic Error')
    plot(bestit,min_valid,'bo','markersize',16)
    legend('CV - 20%','Train - 80%')    
    c=num2str(fix(clock));
    c(find(isspace(c)))=[]; 
    cmd = strcat('.\ANN\AATT_', c);
    print(newFig,'-dpng',cmd);
    hold off
            end







