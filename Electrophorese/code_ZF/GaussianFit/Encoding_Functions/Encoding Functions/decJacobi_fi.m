function y=decJacobi_fi(precision,t,ydemo,c)
% Build the approximation y of the target ydemo from the expansion coefs c
% with Jacobi polynomial approach, using the fixed point arithmetics 
% defined by precision=[w f], i.e. [word_lenght fraction_length]

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology

global w;
global f;

w=precision(1);
f=precision(2);

% enable logging of over/underflows
fipref('LoggingMode','On');

c=fi(c,true,w,f);

% retrieve all the parameters
t0=min(t);y0=ydemo(1);
tf=max(t);yf=ydemo(end);
t_cap=(t-t0)/(tf-t0);

% definition of minimum jerk polynomial, which satisfies the
% non-homogeneous boundary conditions
% it stems from this choice that m=3
mj=y0+(y0-yf)*(15*t_cap.^4-6*t_cap.^5-10*t_cap.^3);

% initialization
N=length(c);
y=fi(mj,true,w,f);
yy=cell(N,1);

% apply the coefficients and build the approximation
for k=0:N-1
    yy{k+1}=fi(c(k+1)*phi(k,t_cap),true,w,f);
    y=fi(y+yy{k+1},true,w,f);
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
grid on,title(sprintf('Jacobi polynomials: # coefs = %d, E_r_e_l = %.6f, [%d;%d]',N,E,w,f));
subplot(212);
plot(t,[yy{:}]);
grid on, xlabel('t');



function out=phi(k,tau)
% compute the kernel function of order k in tau

global w;
global f;

C=fi(2^6/sqrt(2^13/(2*k+13)*gamma(k+7)^2/(factorial(k)*gamma(k+13))),true,w,f);
tau=fi(tau,true,w,f);
one=fi(1,true,w,f);
two=fi(2,true,w,f);
tau1=fi(one-tau,true,w,f);
tau2=fi(two*tau,true,w,f);
tau2=fi(tau2-one,true,w,f);
out=fi(C*pow(tau,3),true,w,f);
out=fi(out.*pow(tau1,3),true,w,f);
out=fi(out.*P(k,tau2),true,w,f);



function out=P(n,x)
% compute the jacobi polynomial of order n in x

global w;
global f;

x=fi(x,true,w,f);
one=fi(1,true,w,f);
x1=fi(x-one,true,w,f);
x2=fi(x+one,true,w,f);
out=fi(0,true,w,f);
for k=0:n
    tmp1=fi(2^-n*nchoosek(n+6,k)*nchoosek(n+6,n-k),true,w,f);
    tmp2=fi(pow(x1,n-k).*pow(x2,k),true,w,f);
    tmp3=fi(tmp1*tmp2,true,w,f);
    out=fi(out+tmp3,true,w,f);
end



function out=pow(x,k)
% compute x^k

global w;
global f;

if ~k
    d=size(x);
    out=fi(reshape(ones(max(d),1),d),true,w,f);
else
    out=fi(x,true,w,f);
    for i=1:k-1
        out=fi(out.*x,true,w,f);
    end
end

