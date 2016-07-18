function [c,y,E,N]=encJacobi(t,ydemo,ETol,Nmax,plotflag)
% Build the approximation y of the target ydemo relying on the Jacobi
% polynomial approach
% The algorithm tries to achieve the given measure ETol of the relative error
% without violating the limit Nmax on the maximum number of coefficients
%
% Put Nmax=inf to exclude the constraint on number of coefficients
% Put ETol=0 and Nmax<>inf to get the approximation with N coefficients
% exactly
%
% Outputs:
%   c: vector of expansion coefficients
%   y: approximation of ydemo
%   E: relative error between y and ydemo
%   N: number of required coefficients
%
% If plotflag is true plotting commands are enabled

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology
%
% Ref.: "Simulating discrete and rhythmic multi-joint human arm
% movements by optimization of nonlinear performance indices" -
% A. Biess, M. Nagurka, T. Flash

% retrieve all the parameters
t0=min(t);y0=ydemo(1);
tf=max(t);yf=ydemo(end);
t_cap=(t-t0)/(tf-t0);

% definition of minimum jerk polynomial, which satisfies the
% non-homogeneous boundary conditions
% it stems from this choice that m=3
mj=y0+(y0-yf)*(15*t_cap.^4-6*t_cap.^5-10*t_cap.^3);

% initialization
E=inf;
if ~ETol
    N=Nmax;
else
    N=0;
end

% iterative algorithm
while (E>ETol) && (N<=Nmax)
    phi=cell(N+1,1);
    C=zeros(N+1,1);
    c=zeros(N+1,1);
    
    % normalization constant
    h=@(k)( 2^13/(2*k+13) * gamma(k+7)^2/(factorial(k)*gamma(k+13)) );

    % compute expansion coefficients
    for k=0:N
        C(k+1)=1/sqrt(h(k));
        phi{k+1}=@(tau)( C(k+1)*2^6*tau.^3.*(1-tau).^3.*P(k,2*tau-1) );
        c(k+1)=2*quadl(@(tau)(interp1(t_cap,ydemo-mj,tau).*phi{k+1}(tau)),0,1);
    end

    % resemble the approximation
    y=mj;
    for k=0:N
        y=y+c(k+1)*phi{k+1}(t_cap);
    end
    
    % compute relative error
    E=1/2*sum((ydemo-y).^2)/sum(ydemo.^2);
    N=N+1;
end
N=N-1;

% plot commands
if plotflag
    figure;
    plot(t,ydemo,'r--','linewidth',2);
    hold on,plot(t,[y mj],'linewidth',2);
    xlabel('t'),legend('y_d_e_m_o','y','min jerk','Location','NorthWest');
    grid on,title(sprintf('Jacobi polynomials: # coefs = %d +(T,xf), E_r_e_l = %.6f',length(c),E));
end



function out=P(n,x)
% compute jacobi polynomial in x (order n)

m=3;
out=0;
for k=0:n
    out=out+1/2^n*nchoosek(n+2*m,k)*nchoosek(n+2*m,n-k)*(x-1).^(n-k).*(x+1).^k;
end


