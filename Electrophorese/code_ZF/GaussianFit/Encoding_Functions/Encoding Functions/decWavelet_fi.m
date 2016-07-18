function y=decWavelet_fi(precision,t,ydemo,wavetype,j,c,varargin)
% Build the approximation y of the target ydemo
% from the expansion coefs c at resolution 2^j, using the fixed point
% arithmetics defined by precision=[w f], i.e. [word_lenght
% fraction_length]
% The used wavetype is 'db4', normally.

% Alternatively, also y=exec_wavelet(precision,t,ydemo,wavetype,j,c,iter)
% If iter is given, then the father wavelet of type wavetype
% is computed with the higher precision iter (=2, default)

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology

global w;
global f;
global T;

w=precision(1);
f=precision(2);
T=numerictype(true,w,f);

% enable logging of over/underflows
fipref('LoggingMode','On');

if isempty(varargin)
    iter=2;
else
    iter=varargin{1};
end

% retrieve all the parameters
c=fi(c,true,w,f);
A=2^j;
n=0:floor(A);
N=length(n);
j=fi(j,true,w,f);
A=fi(A,true,w,f);
t0=min(t);
tf=max(t);
t_cap=(t-t0)/(tf-t0);
y0=ydemo(1);
y=fi(y0,true,w,f);

% get the father wavelet phi of type wavetype per points (29 points for
% iter=2)
[phival,psival,tval]=wavefun(wavetype,iter);

% scaling and translation of father wavelet phi
phi_jn=@(n_,tau)(calcfcn(tval,phival,fi(fi(A*tau,true,w,f)-n_,true,w,f)));

% compute the linear combination
yy=cell(N,1);
for i=1:N
    yy{i}=fi(c(i)*phi_jn(n(i),t_cap),true,w,f);
    y=fi(y+yy{i},true,w,f);
end

% disable logging
fipref('LoggingMode','Off');

% compute the relative error
E=1/2*sum((ydemo-double(y)).^2)/sum(ydemo.^2);

% plot commands
figure;
subplot(211);
plot(t,ydemo,'r--','linewidth',2);
hold on,plot(t,y,'linewidth',2);
legend('y_d_e_m_o','y','Location','NorthWest');
grid on,title(sprintf('Multiresolution transform: Resolut. = %g, # coefs = %d +(T), E_r_e_l = %.6f [phi=%s,ITER=%d], [%d;%d]',...
              double(j),N,E,wavetype,iter,w,f));
subplot(212);
plot(t,[yy{:}]);
grid on, xlabel('x');



function out=calcfcn(t,y,tau)
% interpolation of the father wavelet within the definition interval tval
% outside tval, out is held to the last useful value

global w;
global f;
global T;

t=fi(t,true,w,f);
y=fi(y,true,w,f);
tau=fi(tau,true,w,f);

L=length(tau);
out=fi(reshape(zeros(L,1),size(tau)),true,w,f);
idx=1:L;
idx1=find(tau<=t(1));
idx=setdiff(idx,idx1);
idx2=find(tau>=t(end));
idx=setdiff(idx,idx2);

out(idx1)=y(1);
out(idx2)=y(end);

% interp1 is replaced by the following code
for i=idx
    j=find(t<=tau(i),1,'last');
    tmp1=fi(tau(i)-t(j),true,w,f);
    tmp2=fi(y(j+1)-y(j),true,w,f);
    tmp3=fi(t(j+1)-t(j),true,w,f);
    tmp=fi(tmp1*tmp2,true,w,f);
    tmp=T.divide(tmp,tmp3);
    out(i)=fi(tmp+y(j),true,w,f);
end

