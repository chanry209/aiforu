%% Net BP modified by ZeFeng at 18/08/2011
%    Origine MLP2ACRVTRAIN - Bruno Gas - LIS/P&C UPMC
%     Modified by ZEFENG @09 08 2011
%     ---- Use the validatation to find the best iteration and save the W B
%     ---- Increase the iteration if the system can continu recherch the goal
%     ---- 3 situations (if) to change the speed of learning
%  Apprentissage des poids d'un Percepteron MultiCouche par
%  l'algorithme de reropropagation (gradient total) et pas
%  d'apprentissage adaptatif avec cross-validation, and the momentum.   
%
% SYNTAXE :
% model = mlp_ZF(Base,Target,n,err_glob,option,lr,lamda)
%
% ARGUMENTS :
% Base   		: matrice des ehantillons de la base d'apprentissage
% Target 		: matrice des vecteurs sorties desirees
% n             : nombre maximum d'iterations d'apprentissage
% err_glob      : Target of error
% option        : choix of the method to calculate the nb of hidden cells
% lr     		: [optionnel] vecteur pas d'apprentissage adaptatif :
%				lr = [lr0 lr_dec, lr_inc, delta]
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
% model.W1 = TW1;
% model.B1 = TB1;
% model.W2 = TW2;
% model.B2 = TB2;
% model.V1 = V1;
% model.V2 = V2;
% model.S1 = S1;
% model.S2 = S2;

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

function model = mlp_ZF_momentum(Base,Target,n,err_glob,option,lr,lamda,affichage)
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

    [Ni,Np] = size(Base);
    No      = size(Target,1);
    Nc      = cellhidden_zf(Base,Target,option);
    
    [W1,B1] = randweights_zf(Nc,Ni);
    [W2,B2] = randweights_zf(No,Nc);
      
    indices = ones(Np,1);
    [trainInd,testInd] = crossvalind('holdout',indices,0.2);
    data_train = Base(:,trainInd);
    data_test  = Base(:,testInd);
    Base       = data_train;
    BaseCrv    = data_test;
    
    data_goal_train = Target(:,trainInd);
    data_goal_test  = Target(:,testInd);
    Target          = data_goal_train;
    TargetCrv       = data_goal_test;
    BestitInitial = 1;
% nb. total d'exemples apprendre :
%---------------------------------------
[input_nbr ex_nbr]       = size(Base);
[~, excrv_nbr] = size(BaseCrv);

% --- cohérence des arguments :
[n_cell n_in]       = size(W1);
[output_nbr ~]   = size(Target);
[outputcrv_nbr ~] = size(TargetCrv);

if input_nbr~=n_in
  error('[MLP2ACRVTRAIN] Défaut de cohérence dans les arguments : W1 et Data'); end;
if size(B1)~=[n_cell 1]
  error('[MLP2ACRVTRAIN] Défaut de cohérence dans les arguments : W1 et B1'); end;
if size(W2)~=[output_nbr n_cell]
  error('[MLP2ACRVTRAIN] Défaut de cohérence dans les arguments : W2 et Class'); end;
if size(B2)~=[output_nbr 1]
  error('[MLP2ACRVTRAIN] Défaut de cohérence dans les arguments : W2 et B2'); end;


% pas adaptatif :
%----------------
lr0 = lr(1);			% valeur initiale du pas
lr_dec = lr(2);			% décrément du pas
lr_inc = lr(3);			% incrément du pas
err_ratio = lr(4);		% seuil de déclenchement du décrément

% --- fonction cout quadratique :
L = zeros(1,output_nbr);
MaxL = ex_nbr*output_nbr;
MaxLV = excrv_nbr*outputcrv_nbr; 

% Normalisations :
%-----------------
lr0 =lr0/MaxL;

% --- initialisation du pas :
lr = lr0;					
LR = zeros(1,n);

% initialisation des meilleurs poids :
%-------------------------------------
BW1 = W1; BB1 = B1; BW2 = W2; BB2 = B2;

%--- Erreur en validation :

V1Crv = W1*BaseCrv + B1*ones(1,excrv_nbr);%ex_nbr);   RB : modifified jeudi 13 mai 2004
S1Crv = sigmo_zf(V1Crv);

V2Crv = W2*S1Crv + B2*ones(1,excrv_nbr);%ex_nbr); RB : modifified jeudi 13 mai 200
S2Crv = sigmo_zf(V2Crv);

Ecrv  = TargetCrv - S2Crv;
LV(1) = sumsqr_zf(Ecrv)/MaxLV;
min_valid = LV(1);

% --- Erreur en sortie :

V1 = W1*Base + B1*ones(1,ex_nbr);
S1 = sigmo_zf(V1);

V2 = W2*S1 + B2*ones(1,ex_nbr);
S2 = sigmo_zf(V2);

E = Target - S2;


% --- boucle d'apprentissage :
it_valid = 2;

it  = 1;
while it<=n

% --- Cout quadratique :	
	L(it) = sumsqr_zf(E)/MaxL;
	LR(it) = lr;
   

% --- Critère d'arret :
	if err_glob~=0 && L(it) <= err_glob
		L = L(1:it);
		LR = LR(1:it);
		return;
	end;	


% --- Adaptation du pas d'apprentissage :
    if it>1
        if affichage==1
         fprintf('Iteration:%d  ; Error Train : %f  ; TL : %f  \n',it,L(it),TL)
        end
% Cas 1 --------------------------------------------
    
        if ((L(it) - TL*err_ratio)>0.00001)&&(lr>=0.00001)% if lr ==0, the study will be stop
        
            if affichage==1
            fprintf('Case1 : (L(it) - TL*err_ratio)>0.00001 \n')
            end
            if affichage==1
            lr = lr*lr_dec;
            fprintf('Speed of Study : %f \n',lr);
            end
% --- Fonction Coût croissante au dela du seuil :

% --- Récupération des poids :
			W1 = TW1; B1 = TB1; W2 = TW2; B2 = TB2;

% --- décrémentation du pas et modif. des poids :
			lr = lr*lr_dec;

			W1 = W1 - lr*D1+lamda*dW1;
            dW1 = -lr*D1;
            
	 		B1 = B1 - lr*Delta1*ones(ex_nbr,1) + lamda*dB1;
            dB1 =  - lr*Delta1*ones(ex_nbr,1);
            
		  	W2 = W2 - lr*D2+lamda*dW2;
		 	dW2 = -lr*D2;
            
            B2 = B2 - lr*Delta2*ones(ex_nbr,1)+ lamda*dB2;
            dB2 =  - lr*Delta2*ones(ex_nbr,1);

% --- Fonction Coût décroissante :	
% Cas 2 --------------------------------------------
      elseif (L(it) - TL*err_ratio)<-0.00001	
        if affichage==1
        fprintf('Case2 : (L(it) - TL*err_ratio)<-0.00001 \n')
        end
% --- incrémentation du lr :
				lr = lr*lr_inc;
                if affichage==1
                fprintf('Speed of Study : %f \n',lr);
                end
% --- rétropropagation :
			Delta2 = -2*E.*dsigmo_zf(V2);
			D2 = Delta2*S1';

			Delta1 = (W2'*Delta2).*dsigmo_zf(V1);
			D1 = Delta1*Base';

% --- Sauvegarde des poids courants et modif. des poids :
			TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;
			TL = L(it);

	  		W1 = W1 - lr*D1+lamda*dW1;
            dW1 = -lr*D1;
            
		 	B1 = B1 - lr*Delta1*ones(ex_nbr,1)+lamda*dB1;
            dB1 =  - lr*Delta1*ones(ex_nbr,1);
            
		  	W2 = W2 - lr*D2+lamda*dW2;
		 	dW2 = -lr*D2;
            
	 		B2 = B2 - lr*Delta2*ones(ex_nbr,1)+lamda*dB2;
            dB2 =  - lr*Delta2*ones(ex_nbr,1);
            
         % Case 3 -------------------------------------     
        else %abs(L(it) - TL*err_ratio)<0.00001;
            if affichage==1
                    fprintf('Case3 : abs(L(it) - TL*err_ratio)<0.00001 \n')
                    fprintf('Speed of Study : %f \n',lr);
            end
                    % --- incrémentation du lr :
                    lr = lr*lr_inc*10;

% --- rétropropagation :
			Delta2 = -2*E.*dsigmo_zf(V2);
			D2 = Delta2*S1';

			Delta1 = (W2'*Delta2).*dsigmo_zf(V1);
			D1 = Delta1*Base';

% --- Sauvegarde des poids courants et modif. des poids :
			TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;
			TL = L(it);

	  		W1 = W1 - lr*D1+lamda*dW1;
            dW1 = -lr*D1;
            
		 	B1 = B1 - lr*Delta1*ones(ex_nbr,1)+lamda*dB1;
            dB1 =  - lr*Delta1*ones(ex_nbr,1);
            
		  	W2 = W2 - lr*D2+lamda*dW2;
		 	dW2 = -lr*D2;
            
	 		B2 = B2 - lr*Delta2*ones(ex_nbr,1)+lamda*dB2;
            dB2 =  - lr*Delta2*ones(ex_nbr,1);
            
            
        end
        
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
     %--- Erreur cross-validation :                             
     V1Crv = W1*BaseCrv + B1*ones(1,excrv_nbr);
     S1Crv = sigmo_zf(V1Crv);
     V2Crv = W2*S1Crv + B2*ones(1,excrv_nbr);
     S2Crv = sigmo_zf(V2Crv);
     Ecrv  = TargetCrv - S2Crv;
     LV(it_valid) = sumsqr_zf(Ecrv)/MaxLV; 
              
    %--- sauvegarde des meilleurs poids :
     if LV(it_valid) < min_valid
        BW1 = W1; BB1 = B1; BW2 = W2; BB2 = B2;
        min_valid = LV(it_valid);   
        bestit = it_valid;
        BestitInitial = it_valid;
     else
         bestit = BestitInitial;
     end;
     if affichage==1
     fprintf('Iteration:%d  ; Error Train:%f  ; Error CV:%f \n',it,L(it),LV(it))
     end
          it_valid = it_valid + 1;  
          
      % If it needs increase the iteration - bestit = n
      if bestit==n
          n = n + 500;
          if affichage==1
          fprintf('Because of bestit == n, the system increase the iteration + 500 time = %d \n',n);
          end
      end

  else

% --- 1st iteration : pas de modification du lr :

% --- repropropagation :
		Delta2 = -2*E.*dsigmo_zf(V2);
		D2 = Delta2*S1';

		Delta1 = (W2'*Delta2).*dsigmo_zf(V1);
		D1 = Delta1*Base';

% --- Sauvegarde des poids courants :
		TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;
		TL = L(it);

% --- Modif. des poids :
	  	W1 = W1 - lr*D1;
        dW1=- lr*D1;
	 	B1 = B1 - lr*Delta1*ones(ex_nbr,1);
        dB1 =  - lr*Delta1*ones(ex_nbr,1);
	  	W2 = W2 - lr*D2;
        dW2 = - lr*D2;
	 	B2 = B2 - lr*Delta2*ones(ex_nbr,1);
        dB2 =  - lr*Delta2*ones(ex_nbr,1);

    end
    it = it+1;

% --- erreur en sortie :
	V1 = W1*Base+B1*ones(1,ex_nbr);
	S1 = sigmo_zf(V1);

	V2 = W2*S1+B2*ones(1,ex_nbr);
	S2 = sigmo_zf(V2);

	E = Target - S2;			
    
end; %it

% Results
%------------------
LR = LR*MaxL;

model.W1 = TW1;
model.B1 = TB1;
model.W2 = TW2;
model.B2 = TB2;
model.V1 = V1;
model.V2 = V2;
model.S1 = S1;
model.S2 = S2;
model.V1Crv = V1Crv;
model.V2Crv = V2Crv;
model.S1Crv = S1Crv;
model.S2Crv = S2Crv;
model.Base = Base;
model.BaseCrv = BaseCrv;
model.Target = Target;
model.TargetCrv = TargetCrv;
model.LR = LR;
model.BestInd = bestit;

if affichage==1
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
    title('Result of the crossvalidation_NetMomentum')
    xlabel('Iteration')
    ylabel('Quadratic Error')
    plot(bestit,min_valid,'bo','markersize',16)
    legend('CV - 20%','Train - 80%')    
    c=num2str(fix(clock));
    c(find(isspace(c)))=[]; 
    cmd = strcat('.\ANN\MLP_', c);
    print(newFig,'-dpng',cmd);
    hold off
end







