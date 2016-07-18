function y=decWavelet(t,ydemo,wavetype,j,c,varargin)
% Build the approximation y of the target ydemo
% from the expansion coefs c at resolution 2^j.
% The used wavetype is 'db4', normally.

% Alternatively, also y=exec_wavelet(t,ydemo,wavetype,j,c,iter)
% If iter is given, then the father wavelet of type wavetype
% is computed with the higher precision iter (=2, default)

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology

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
y=y0;

% get the father wavelet phi of type wavetype per points (29 points for iter=2)
[phival,psival,tval]=wavefun(wavetype,iter);

% scaling and translation of father wavelet phi
phi_jn=@(n_,tau)(calcfcn(tval,phival,A*tau-n_));

% compute the linear combination
yy=cell(N,1);
for i=1:N
    yy{i}=c(i)*phi_jn(n(i),t_cap);
    y=y+yy{i};
end

% compute the relative error
E=1/2*sum((ydemo-y).^2)/sum(ydemo.^2);

% plot commands
figure;
subplot(211);
plot(t,ydemo,'r--','linewidth',2);
hold on,plot(t,y,'linewidth',2);
xlabel('t'),legend('y_d_e_m_o','y','Location','NorthWest');
grid on,title(sprintf('Multiresolution transform: Resolut. = %g, # coefs = %d +(T), E_r_e_l = %.6f [phi=%s,ITER=%d]',...
              j,N,E,wavetype,iter));
subplot(212);
plot(t,[yy{:}]);
grid on, xlabel('x');



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

