function gaussianfit_ZF(y, nW, errorDef)
close all
% multi - gaussian fitting (method small feature) 
% made by zefeng
x  = (1:length(y))/length(y);
yLimit = max(y)*2;
plot(x,y,'o');
hold on
%% Data
% x = (1:100)';
% y = gaussmf(x,[10,30])+gaussmf(x,[15,60]); % function of matlab


%% Feature
% suggestion = floor(length(x)/20);
% nW  =input(strcat(['Please define the width of windows (number of sampling points). The suggestion is ', num2str(suggestion),', if you have 10 gaussian \n']));
% errorDef = input('Please input the tolerable error for gaussian fiting. \n');
% nW  =5;
% errorDef = 0.1;

%% Iteration - method 1 - feature dependant
B_W = 1; % begin position of window
E_W = B_W+floor(nW/2-1); % End position of window, it has 50% experience of last x
n = 1; % nb of iteration
nG = 1;
d = zeros(floor(length(x)/nW*2)+1,1); % erros of each iteration

while (E_W<=length(x))&&(B_W<length(x))
   % gaussian fit
    x_temps = x(B_W:E_W);
    y_temps = y(B_W:E_W);
    [ymax_temps, mu_temps, S_temps, d_temps] = fitGaussian_ZF(x_temps, y_temps,1);
    disp(d_temps)
    % defint if needs another gaussian
    if d_temps<=errorDef;
        % B_W don't move
        E_W = E_W+floor(nW/2); % only move the E_W
        Para_temps =   [ymax_temps, mu_temps, S_temps, d_temps];
         
    else if d_temps>errorDef;
            
            ymax=Para_temps(1);
            mu = Para_temps(2);
            S = Para_temps(3);
            y_test = ymax*exp(-(x-mu).^2/S);
            y_test_max = max(y_test);
            
            %avoid the huge gaussian
            if y_test_max >= yLimit  
                B_W = E_W-floor(nW/2);
                E_W = E_W+floor(nW/2);
                
            else if y_test_max < yLimit
                    Para(nG,:)=Para_temps;
                    plot(x,y_test,'r-','linewidth',2)  
                    B_W = E_W-floor(nW/2);
                    %E_W don't move, re-test by anther gaussian;
                    nG = nG+1;
                end
            end
        end
    end
    n=n+1;
end
 if y_test_max < yLimit
    Para_temps =   [ymax_temps, mu_temps, S_temps, d_temps];
    Para(nG,:)=Para_temps;
    ymax=Para_temps(1);
    mu = Para_temps(2);         
    S = Para_temps(3);
    y_test = ymax*exp(-(x-mu).^2/S);
 else
     nG = nG-1;
 end
% plot(x,y_test,'r-','linewidth',2)  

size(Para)
formatSpec = 'In total, there are %4d gaussians to fit the cuve.\n';
fprintf(formatSpec, nG)
 

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



    

