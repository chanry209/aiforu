%function [h, mu, sigma]=gaussianfit_ZF_scan(y,fig,errorDef)
clear
close all
errorDef = 0;
errorAltittude = 0.01;
PreciGaussian = 0; % sum of y_new
S_Limit = 0.081;% avoid the huge gaussian with a hugd S
n_fois = 1;


load('result_02-10-20151.mat')
scorefilt2 =  -scorefilt;
y = scorefilt2-min(scorefilt);
x  = (1:length(y))/length(y);

n = 10;
a = [1,ones(1,n)/n];
b =ones(1,n)/n;
y_filter = filter(b,a,y);

subplot 211 %subplot 311
plot(x,y,'og')
hold on
plot(x,y,'linewidth',3)
plot(x,y_filter,'r')
title('filtrage of data')
legend(' OriginalPoints ','Original Cuve','Cuve after filter')
hold off


% a = x(:)';
% b = y';
% values = spcrv([[a(1) a a(end)];[b(1) b b(end)]],50);
% plot(values(1,:),values(2,:), '*g');
% plot(x,y,'or')

% multi - gaussian fitting (method scan from high to low) 
% made by zefeng
% example of gaussian
% x = (1:300)';
% y = 2*gaussmf(x,[12,0])+gaussmf(x,[10,50])+1.8*gaussmf(x,[15,90])+gaussmf(x,[10,150])+1.6*gaussmf(x,[10,200])+1.2*gaussmf(x,[10,250])+1.5*gaussmf(x,[10,300]); % function of matlab
subplot 212 %subplot 311
x  = (1:length(y))/length(y);
indT = 1:length(x); % all the index of x
yLimit = max(y)*2;
Llimit = 3;
% plot(x,y,'o');
plot(x,y_filter)
hold on
plot(x,y_filter,'go')
%% Scan the highest
% initialisation
P_ini = 1;
P_end = length(y);
y_new = y_filter;
indT = 1:length(y_new);

%% The first floor
i = 1; % floor of tree

y_new(y_new<0)=0;

while sum(y_new)>PreciGaussian

    % find the max  ----------------------------------

    [y_max_ini, ind] = max(y_new); % matlab find only one max if there are two same max
    strdisp = strcat(['This is ', num2str(i),' interation.']);
    disp(strdisp)
    
    % Avoid the first pic is on frontier --------
    if ind==1
        d_Left = y_new(2:end) - y_new(1 : end-1);
        P_ini =  find(d_Left>0, 1, 'first'); % left frontier move to first valley on left
        y_new(1:P_ini-1) = 0; %y_new = y(P_ini:end);
    else if ind==length(x)
        d_Right = y_new(2:end) - y_new(1 : end-1);
        P_end =  find(d_Right>0, 1, 'last'); % left frontier move to first valley on left
        y_new(P_end-1:end) = 0;% y_new = y(1:P_end);
        end
    end

    %% beginning of the tree ------------        

        tree(i).P_ini = P_ini; % Tree
        tree(i).P_end = P_end;
        tree(i).y_new = y_new;
        % jStop = 1; % normal j = 2^(i)

        % find the max of y_new
        [y_new_max, ind] = max(y_new);
        plot(x(ind),y_new_max,'bo')
        % ind = ind+P_ini-1; % attestion of P_ini
                     
        tree(i).pic = y_new_max; % Tree
        tree(i).ind = ind; % Tree

        %% left --------------------------------------------
        ind_Left = indT(indT<ind); % all the indices < max(y)
        if length(ind_Left)<2
            y_new(ind:ind_Left)=0;% avoid the frontier max
            disp('The Pic of this iteration is too fuzzy, retry otheris pics.')
            disp('Raison: The left points are too few (<2 points) to support the gaussian.')
            strdisp1 = strcat(['This pic is located at  ', num2str(ind), ', X = ', num2str(x(ind)),  ', Value = ', num2str(y_max_ini)]);
            disp(strdisp1);
            continue;
        end
        
        
        d_Left = y_new(2:ind_Left(end)) - y_new(1 : ind_Left(end)-1); % calculation of all the differences
        P_Left_Group = find(d_Left<=errorDef, Llimit, 'last')+1; % find the first indice which value < 0
        
        if ~isempty(P_Left_Group)
        
            if  P_Left_Group(end)-P_Left_Group(1)>Llimit-1
                P_Left = P_Left_Group(1);
            else
                P_Left = P_Left_Group(end)+1;%%%%%%%%%%%%%%%%%%%
            end
            
        else
            P_Left = P_ini;
        end
        
        %% right -----------------------------------------
        ind_Right =indT(indT>ind);
        if length(ind_Right)<2 % % % % % % % % % % % % % % % % % % % %%%%%%5
            y_new(ind:ind_Right)=0; % avoid the frontier max
            disp('The Pic of this iteration is too fuzzy, retry otheris pics.')
            disp('Raison: The Right points are too few (<2 points) to support the gaussian.')
            strdisp1 = strcat(['This pic is located at  ', num2str(ind), ', X = ', num2str(x(ind)), ', Value = ', num2str(y_max_ini)]);
            disp(strdisp1);
            continue;
        end  
            
        d_Right = y_new(ind_Right(1):end-1) - y_new(ind_Right(2):end); % calculation of all the differences
        P_Right_Group =ind+ find(d_Right<=errorDef, Llimit, 'first')-1; % find the first indice which value < 0
        
    if ~isempty(P_Right_Group)
        if P_Right_Group(end)-P_Right_Group(1)>Llimit-1
            P_Right = P_Right_Group(end)-1;
        else
            P_Right = P_Right_Group(1);
        end
        
    else
        P_Right = P_end;
    end
        %% plot the gaussian fitre
        
        % avoid the max locate at the local froniter
        if abs(max(y_new)-y_new(P_Left))<errorAltittude || abs(max(y_new)-y_new(P_Right))<errorAltittude
            y_new(P_Left : P_Right)=0;
            disp('The Pic of this iteration is too fuzzy, retry otheris pics.')
            strdisp1 = strcat(['This pic is located at  ', num2str(ind), ', X = ', num2str(x(ind)),  ', Value = ', num2str(y_max_ini)]);
            disp('Raison: The pic is not steep, the Altittude is not clear (<errorAltitude).')
            disp(strdisp1);            
            continue;
        end
        
        plot(x(P_Left),y_new(P_Left),'ro')
        plot(x(P_Right),y_new(P_Right),'ro')
        
        % tree(i).XL_next(j) = x(P_ini: P_Left); % Tree x for the next analysis 
        % tree(i).XR_next(j) = x(P_Right:P_end); % Tree
        
        % Take the same quantity of points at left and at right
        nbLeft = numel(P_Left:ind)-1;
        nbRight = numel(ind:P_Right)-1;
        
        P_Left_F = P_Left;
        P_Right_F = P_Right;
            
        if nbLeft*n_fois<nbRight
            P_Right_F=P_Right-floor((nbRight-nbLeft)/n_fois);
        end
            
        if nbLeft>nbRight*n_fois
            P_Left_F=P_Left+floor((nbLeft-nbRight)/n_fois);
        end
              
        x_temps = x(P_Left_F : P_Right_F);
        x_temps = x_temps(:);
               
        if y_new(P_Left) >y_new(P_Right)
            y_temps = y_new(P_Left : P_Right)-y_new(P_Right)+0.01;
        else if y_new(P_Left) < y_new(P_Right)
            y_temps = y_new(P_Left : P_Right)-y_new(P_Left)+0.01;
            end
        end

        tree(i).x_temps =  x_temps; % Tree x_temps for this floor
        tree(i).y_temps =  y_temps; % Tree y_temps for this floor
        
        y_temps = y_new(P_Left_F : P_Right_F);
        
        [ymax_temps, mu_temps, S_temps, d_temps] = fitGaussian_ZF(x_temps, y_temps,0);
        if isnan(ymax_temps)
            disp('Couldn''t find the gaussian by the data of this iteration')
            y_new(P_Left : P_Right)=0;
            continue;
        end
        
        % Avoid the the hug S
        S_width = 2.355*sqrt(S_temps/2);%half width of gaussian 2.355*sigma
        if S_width > S_Limit
            y_new(P_Left : P_Right)=0;
            disp('The Pic of this iteration is too fuzzy, retry otheris pics.')
            strdisp1 = strcat(['This pic is located at  ', num2str(ind), ', X = ', num2str(x(ind)),  ', Value = ', num2str(y_max_ini)]);
            disp('Raison: The variance is too huge (>S_Limit).')
            disp(strdisp1);
            continue;
        end
        
        tree(i).gaussian = [ymax_temps, mu_temps, S_temps, d_temps] ;

        % figure
        Para_temps =   [ymax_temps, mu_temps, S_temps, d_temps];
        ymax=Para_temps(1);

        mu = Para_temps(2);
        S = Para_temps(3);
        
        yhighest = max(ymax*exp(-(x-mu).^2/S));
        
        if yhighest > y_new_max
            y_test = ymax*exp(-(x-mu).^2/S)/yhighest*y_new_max;
        else
            y_test = ymax*exp(-(x-mu).^2/S);
%         y_test_max = max(y_test);
        end
        plot(x,y_test,'r-','linewidth',2)  
        
        y_new(P_Left : P_Right)=0;
        % verify the conditions of stop and the jStop
        i = i+1;
%         pause
end
%% i-1 gaussian models fit
title(strcat([num2str(i-1),' Gaussian models to fit this cuve']))
hold off

nameSave = strcat(name,'.jpg');
saveas(gcf,nameSave);








%% Feature
% suggestion = floor(length(x)/20);
% nW  =input(strcat(['Please define the width of windows (number of sampling points). The suggestion is ', num2str(suggestion),', if you have 10 gaussian \n']));
% errorDef = input('Please input the tolerable error for gaussian fiting. \n');
% nW  =5;
% errorDef = 0.1;

%% Iteration - method 1 - feature dependant
% B_W = 1; % begin position of window
% E_W = B_W+floor(nW/2-1); % End position of window, it has 50% experience of last x
% n = 1; % nb of iteration
% nG = 1;
% d = zeros(floor(length(x)/nW*2)+1,1); % erros of each iteration
% 
% while (E_W<=length(x))&&(B_W<length(x))
%    % gaussian fit
%     x_temps = x(B_W:E_W);
%     y_temps = y(B_W:E_W);
%     [ymax_temps, mu_temps, S_temps, d_temps] = fitGaussian_ZF(x_temps, y_temps,1);
%     disp(d_temps)
%     % defint if needs another gaussian
%     if d_temps<=errorDef;
%         % B_W don't move
%         E_W = E_W+floor(nW/2); % only move the E_W
%         Para_temps =   [ymax_temps, mu_temps, S_temps, d_temps];
%          
%     else if d_temps>errorDef;
%             
%             ymax=Para_temps(1);
%             mu = Para_temps(2);
%             S = Para_temps(3);
%             y_test = ymax*exp(-(x-mu).^2/S);
%             y_test_max = max(y_test);
%             
%             %avoid the huge gaussian
%             if y_test_max >= yLimit  
%                 B_W = E_W-floor(nW/2);
%                 E_W = E_W+floor(nW/2);
%                 
%             else if y_test_max < yLimit
%                     Para(nG,:)=Para_temps;
%                     plot(x,y_test,'r-','linewidth',2)  
%                     B_W = E_W-floor(nW/2);
%                     %E_W don't move, re-test by anther gaussian;
%                     nG = nG+1;
%                 end
%             end
%         end
%     end
%     n=n+1;
% end
%  if y_test_max < yLimit
%     Para_temps =   [ymax_temps, mu_temps, S_temps, d_temps];
%     Para(nG,:)=Para_temps;
%     ymax=Para_temps(1);
%     mu = Para_temps(2);         
%     S = Para_temps(3);
%     y_test = ymax*exp(-(x-mu).^2/S);
%  else
%      nG = nG-1;
%  end
% % plot(x,y_test,'r-','linewidth',2)  
% 
% size(Para)
% formatSpec = 'In total, there are %4d gaussians to fit the cuve.\n';
% fprintf(formatSpec, nG)
 

% %% Iteration - method 2 - feature independant
% B_W = 1; % begin position of window
% E_W = 1; % End position of window
% n = 1; % nb of iteration
% d = zeros(floor(length(x)/nW*2)+1,1); % erros of each iteration
% 
% while (E_W<=length(x))&&(B_W<length(x))
%     E_W = B_W+floor(nW/2-1); % windows have 50% experience of last x
%     x_temps = x(B_W:E_W);
%     y_temps = y(B_W:E_W);
%     [ymax_temps, mu_temps, S_temps, d_temps] = fitGaussian_ZF(x_temps, y_temps);
%     B_W = E_W+1;
%     d(n) = d_temps;
%     n=n+1;
%  end



%y = gaussian_distri_ZF(x, 50, 10,1);



    

