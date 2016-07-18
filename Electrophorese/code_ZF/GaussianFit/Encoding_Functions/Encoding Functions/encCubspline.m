function [pp,y,E,I]=encCubspline(t,ydemo,ETol,Imax,plotflag)
% Build the piecewise polynomial approximation (cubic spline) y of the target ydemo
% The algorithm tries to achieve the given measure ETol of the relative error
% without violating the limit Imax on the maximum number of intervals
%
% Put Imax=inf to exclude the constraint on number of intervals
% Put ETol=0 and Imax<>inf to get the approximation with I intervals
% exactly
%
% Outputs:
%   pp: list of piecewise coefficients
%    y: cubic spline approximation
%    E: relative error between y and ydemo
%    I: number of required intervals
%
% If plotflag is true plotting commands are enabled

% Author: Ugo Pattacini
% Date:   February 2008
% Italian Institute of Technology

% retrieve all the parameters
t0=min(t);
tf=max(t);
t_cap=(t-t0)/(tf-t0);

% initialization
E=inf;
if ~ETol
    I=Imax;
else
    I=2;
end

% iterative algorithm
while (E>ETol) && (I-1<=Imax)
    xi=linspace(t_cap(1),t_cap(end),I+1);
    yi=interp1(t_cap,ydemo,xi);
    pp=csape(xi,[0 yi 0],[1 1]);
    y=fnval(pp,t_cap);
    E=1/2*sum((ydemo-y).^2)/sum(ydemo.^2);
    I=I+1;
end
I=length(pp.breaks)-1;

% plot commands
if plotflag
    figure;
    plot(t,ydemo,'r--','linewidth',2);
    hold on,plot(t,y,'linewidth',2),plot(xi*(tf-t0)+t0,yi,'o')
    xlabel('t'),legend('y_d_e_m_o','y','Location','NorthWest');
    grid on,title(sprintf('Cubic splines: # intervals = %d +(T), E_r_e_l = %.6f',I,E));
end

