%%%%%%% Test Script of CE_MVGM %%%%%%%%%%
%                                       %
% sebastien.paris@lsis.org              %
%                                       %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




K                 = 350;
d                 = 2;

%%%%%%% Draw Mixture of Gaussian %%%%%%%

option.Mt         = cat(3 , [0.6 ; 6] , [1 ; -10] ,[10 ; -1] , [ 0 ; 10] , [1 ; -3] , [5 ; 5]);                                       %(d x 1 x L)
option.St         = corr2cov(cat(3 , [1 0.9 ; 0.9 1] , [1 -0.9 ; -0.9 1] , [2 0 ; 0 2] , [2 0 ; 0 2] , [2 0 ; 0 2] , [2 0 ; 0 2]  )); %(d x d x L)
option.pt         = cat(3 , [0.1] , [0.1]  , [0.2] , [0.2] , [0.2] , [0.2] );                                                         %(1 x 1 x L)
Z                 = sample_mvgm(K , option.Mt , option.St , option.pt);
% 


% option.Mt         = cat(3 , [0.6 ; 6] , [1 ; -10] ,[10 ; -1] );                                       %(d x 1 x L)
% option.St         = corr2cov(cat(3 , [1 0.9 ; 0.9 1] , [1 -0.9 ; -0.9 1] , [2 0 ; 0 2])); %(d x d x L)
% option.pt         = cat(3 , [0.7] , [0.1]  , [0.2] );                                                         %(1 x 1 x L)
% Z                 = sample_mvgm(K , option.Mt , option.St , option.pt);



option.L          = size(option.Mt , 3);
option.Ma         = [];
option.Mb         = [];
option.Mmin       = [];
option.Mmax       = [];
option.Ra         = [];
option.Rb         = [];
option.Rvarmin    = 0.8;
option.Rvarmax    = [];
option.Rcorrmin   = -0.95;
option.Rcorrmax   = 0.95;
option.delta      = [];
option.N          = 300;
option.rho        = 6*10e-3;
option.alpha      = 0.95;
option.beta0      = 0.95;
option.q          = 7;
option.epsi       = 10e-3;
option.h          = 10;
option.cons       = 5;
option.T_max      = 1500;
option.verbose    = 1;


out                                 = ce_mvgm(Z , option);


logl_true                           = -loglike_mvgm(Z , option.Mt , option.St , option.pt);
[xt , yt]                           = ndellipse(option.Mt , option.St);
[x , y]                             = ndellipse(out.M_opt , out.S_opt);
T                                   = length(out.loglt);

figure(1)
plot(Z(1 , :) , Z(2 , :) , '+' ,  xt , yt , 'r' , x , y , 'g' , 'linewidth' , 2 , 'markersize', 2);

grid on
figure(2)
plot((1:T) , out.loglt , (1:T) , logl_true(: , ones(1 , T)) , 'g' , 'linewidth' , 2)
grid on
axis([1 , T , 0.8*logl_true , 1.2*max(out.loglt) ])
legend(['Logl(t)'] , ['Logl_{true}'],1)






pdf_Z       = mvgmmpdf(Z , option.Mt , option.St , option.pt);


support     = (-15:0.3:15);
[X , Y]     = meshgrid(support);
data        = [X(:) , Y(:)]';
pdf         = mvgmmpdf(data ,  out.M_opt , out.S_opt , out.p_opt);


figure(3)

h           = surfc(X , Y , reshape(pdf , length(support) , length(support)));
hold on
stem3(Z(1 , :) , Z(2 , :) , pdf_Z);
alpha(h , 0.7);
hold off
shading interp
lighting phong
light


