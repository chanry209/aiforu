function [w,a,y,E,N]=encNonlinDyn(t,ydemo,Dydemo,ETol,Nmax,plotflag)
% Build the approximation y of the target ydemo relying on the nonlinear
% dynamic systems description
% The algorithm tries to achieve the given measure ETol of the relative error
% without violating the limit Nmax on the maximum number of coefficients
%
% Put Nmax=inf to exclude the constraint on number of coefficients
% Put ETol=0 and Nmax<>inf to get the approximation with N coefficients
% exactly
%
% Note: also the derivative Dydemo must be provided!
%
% Outputs:
%   w: vector of expansion coefficients
%   a: time constant alpha
%   y: approximation of ydemo
%   E: relative error between y and ydemo
%   N: number of required coefficients
%
% If plotflag is true plotting commands are enabled

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology
%
% Based on the paper "Movement Imitation with Nonlinear Dynamical Systems
% in Humanoid Robots" - Auke J. Ijspeert, J. Nakanishi, S. Schaal

x0=ydemo(1);        % starting position
v0=Dydemo(1);       % starting velocity
g=ydemo(end);       % goal position
t=t-t(1);T=t(end);  % 0 starting time (for lsim command)

% It stems from the second system dynamics that
% x(t)=exp(-a/2*t)*(A*t+B)+g
% v(t)=exp(-a/2*t)*(-a*A/2*t-a*B/2+A)
% where alpha_v=a and beta_v=alpha_v/4;
%
% From x(0)=x0 it stems that B=x0-g
% From v(T)=p it stems that a^2/4*abs(B)*T*exp(-a/2*T)=p
% From v(0)=0 it stems that A=a*B/2
B=x0-g;
p=.1;
f=@(a)((a.^2/4*abs(B)*T.*exp(-a/2*T)-p).^2);
a=fminbnd(f,1,30);
A=a*B/2;
x=exp(-a/2*t).*(A*t+B)+g;
v=exp(-a/2*t).*(-a*A/2*t-a*B/2+A);

% solve z dynamic with ydemo:
% alpha_z=alpha_v=a; beta_z=beta_v=a/4;
sys1=ss(-a,a^2/4,1,0);
z=lsim(sys1,g-ydemo,t,v0);

% solve locally weighted regression
% initialization
udes=Dydemo-z;
E=inf;
if ~ETol
    N=Nmax;
else
    N=1;
end

% iterative algorithm
while (E>ETol) && (N<=Nmax)
    c=linspace(0,1,N);
    var=.001;
    w=zeros(N,1);
    L1=0;
    L2=0;
    for i=1:N
        psi=exp(-1/(2*var)*((x-x0)/(g-x0)-c(i)).^2);
        J=@(w)(sum(psi.*(udes-w*v).^2));
        w(i)=fminbnd(J,-100,100);
        L1=L1+w(i)*psi;
        L2=L2+psi;
    end

    % solve y dynamic with known wi
    A=[[-a -a^2/4]; [1 0]];
    B=eye(2);
    C=eye(2);
    D=zeros(2,2);
    sys2=ss(A,B,C,D);
    u1=a^2/4*g*ones(length(t),1);
    u2=(L1.*v./L2);
    out=lsim(sys2,[u1 u2],t,[v0 x0]);
    z=out(:,1);
    y=out(:,2);
    
    E=1/2*sum((ydemo-y).^2)/sum(ydemo.^2);
    N=N+1;
end
N=length(c);

% plot commands
if plotflag
    figure;
    subplot(211),plot(t,ydemo,'r--','linewidth',2),xlabel('t');
    hold on,plot(t,[x y],'linewidth',2);legend('y_d_e_m_o','x','y','Location','NorthWest'),grid on;
    title(sprintf('Nonlinear differential systems: # coefs = %d +(a,g), E_r_e_l = %.6f',N,E));
    subplot(212),plot(t,[v z],'linewidth',2),legend('v','z','Location','NorthWest'),grid on;
    xlabel('t');
end

