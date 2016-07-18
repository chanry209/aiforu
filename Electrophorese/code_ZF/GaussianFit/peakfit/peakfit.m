% peakfit
% fits peaks to modified Classical Damped Harmonic Oscillator model, for
% detail see A.B.Djurisic,T.Fritz and K.Leo, J.Opt.A:Pure Appl.Opt.2(2000) 458-464
close all; clear;clc;
data=load('spectra.dpt');
[~,ii]=sort(data(:,1));      % sort wavenumber in increasing order
dat=data(ii,:);
%% define spectra range

% high frq noisy region
v4=1800;
a4=find(abs(dat(:,1)-v4)< 1,1);        % find index of the point around
% low frq noisy region
v1=680;
a1=find(abs(dat(:,1)-v1)< 1,1);        % find index of the point around 
% only fit from v1 to v4
v=dat(a1:a4,1);                               
dt=smooth(dat(a1:a4,1),dat(a1:a4,2),5,'sgolay'); % smooth
sp=dt-min(dt);
%% fit
par=load('peakpar.txt');

%% optimisation
tic;
options=optimset('Display','final','TolFun',1e-4,'TolX',1e-5,...
        'MaxFunEvals',5e4,'MaxIter',1e3);
Niter=0;ssq=100;
 while Niter<50 && ssq>0.001
        Niter=Niter+1;
        [parmin,fval,exitflag]=fminsearch(@ssqmin,par,options,sp,v);
        par=parmin;
        fit=mCDHO(v,par(1,:),par(2,:),par(3,:),par(4,:));
        ssq=sum((fit-sp).^2);
        t1=toc;
        disp(['iteration ',num2str(Niter),',time ',num2str(t1),' secs,ssq ',num2str(ssq)])
 end
 
 [~,ii]=sort(parmin(1,:));               % sort wavenumber in increasing order
 parmin=parmin(:,ii);
 
 %%
 plot(v,sp,'b',v,fit,'r');
 
 %%
%  save('peakpar.txt','parmin','-ascii','-tabs');