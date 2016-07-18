function y=decJacobi(t,ydemo,c)
% Build the approximation y of the target ydemo from the expansion coefs c
% with Jacobi polynomial approach

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology

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
y=mj;
yy=cell(N,1);

% apply the coefficients and build the approximation
for k=0:N-1
    yy{k+1}=c(k+1)*phi(k,t_cap);
    y=y+yy{k+1};
end

% compute the relative error
E=1/2*sum((ydemo-y).^2)/sum(ydemo.^2);

% plot commands
figure;
subplot(211);
plot(t,ydemo,'r--','linewidth',2);
hold on,plot(t,y,'linewidth',2);
legend('y_d_e_m_o','y','Location','NorthWest');
grid on,title(sprintf('Jacobi polynomials: # coefs = %d, E_r_e_l = %.6f',N,E));
subplot(212);
plot(t,[yy{:}]);
grid on, xlabel('x');



function out=phi(k,tau)
% compute the kernel function of order k in tau

C=2^6/sqrt(2^13/(2*k+13)*gamma(k+7)^2/(factorial(k)*gamma(k+13)));
tau1=1-tau;
tau2=2*tau-1;
out=C*pow(tau,3);
out=out.*pow(tau1,3);
out=out.*P(k,tau2);



function out=P(n,x)
% compute the jacobi polynomial of order n in x

x1=x-1;
x2=x+1;
out=0;
for k=0:n
    tmp=nchoosek(n+6,k)*nchoosek(n+6,n-k);
    tmp=tmp*pow(x1,n-k);
    tmp=tmp.*pow(x2,k);
    out=out+tmp;
end
out=out*2^-n;



function out=pow(x,k)
% compute x^k

if ~k
    d=size(x);
    out=reshape(ones(max(d),1),d);
else
    out=x;
    for i=1:k-1
        out=out.*x;
    end
end

