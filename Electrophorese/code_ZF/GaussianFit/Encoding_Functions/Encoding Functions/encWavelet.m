function [c,y,E,yy]=encWavelet(t,ydemo,wavetype,j,plotflag,varargin)
% Build the approximation y of the target ydemo at resolution 2^j
% using the Multiresolution transform
%
% Outputs:
%    c: vector of expansion coefficients
%    y: approximation at resolution 2^j
%    E: relative error between y and ydemo
%   yy: cell array containing the used father wavelets
%
% The used wavetype is 'db4', normally.
% If plotflag is true plotting commands are enabled

% Alternatively, also wavelet(t,ydemo,wavetype,j,plotflag,iter)
% If iter is given, then the father wavelet of type wavetype
% is computed with the higher precision iter (=2, default)

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology
%
% Ref.: "A Theory for Multiresolution Signal Decomposition: The Wavelet
% Representation" - Stephane G. Mallat

if isempty(varargin)
    iter=2;
else
    iter=varargin{1};
end

% retrieve all the parameters
A=2^j;
t0=min(t);
tf=max(t);
t_cap=(t-t0)/(tf-t0);
y0=ydemo(1);
n=0:floor(A);
N=length(n);
c=zeros(N,1);
yy=cell(N,1);
ydemo__=ydemo-y0;
y=y0;

% get the father wavelet phi of type wavetype per points (29 points for
% iter=2)
[phival,psival,tval]=wavefun(wavetype,iter);

% scaling and translation of father wavelet phi
phi_jn=@(n_,tau)(A*calcfcn(tval,phival,A*tau-n_));

% compute expansion coefficients with integration
for i=1:N
    tau1=(tval(1)+n(i))/A;
    tau2=(tval(end)+n(i))/A;
    c(i)=quadl(@(tau)(calcfcn(t_cap,ydemo__,tau).*phi_jn(n(i),tau)),tau1,tau2);
    yy{i}=(c(i)/A)*phi_jn(n(i),t_cap);
    y=y+yy{i};
end

% compute the relative error
E=1/2*sum((ydemo-y).^2)/sum(ydemo.^2);

% plot commands
if plotflag
    figure;
    plot(t,ydemo,'r--','linewidth',2);
    hold on,plot(t,y,'linewidth',2);plot(t,y0+[yy{:}]);
    xlabel('t'),legend('y_d_e_m_o','y','Location','NorthWest');
    grid on,title(sprintf('Multiresolution transform: Resolut. = %g, # coefs = %d +(T), E_r_e_l = %.6f [phi=%s,ITER=%d]',...
                  j,N,E,wavetype,iter));
end



function out=calcfcn(t,y,tau)
% interpolation of the father wavelet within the definition interval tval
% outside tval, out is held to the last useful value

L=length(tau);
out=reshape(zeros(L,1),size(tau));
idx=1:L;
idx1=find(tau<=t(1));
idx=setdiff(idx,idx1);
idx2=find(tau>=t(end));
idx=setdiff(idx,idx2);

out(idx1)=y(1);
out(idx2)=y(end);
out(idx)=interp1(t,y,tau(idx));

