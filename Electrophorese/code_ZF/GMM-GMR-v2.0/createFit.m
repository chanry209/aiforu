function [fitresult, gof] = createFit(xx, X)
%CREATEFIT(XX,X)
%  Create a fit.
%
%  Data for 'fit1' fit:
%      X Input : xx
%      Y Output: X
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 11-Dec-2015 14:00:31


%% Fit: 'fit1'.
[xData, yData] = prepareCurveData( xx, X );

% Set up fittype and options.
ft = fittype( 'gauss8' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [0.606855707990344 1 0.0681306571328733 0.598765032068656 0.0611620795107034 0.0430034345961552 0.501071687315507 0.175840978593272 0.0481360386978067 0.499962130415739 0.00152905198776758 0.0777533991608525 0.490083385006665 0.348623853211009 0.039225612965721 0.468423366013477 0.434250764525994 0.0376914353056297 0.445520609220094 0.282874617737003 0.0599374999119064 0.408809444203403 0.516819571865443 0.0497100727377893];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'fit1' );
h = plot( fitresult, xData, yData );
legend( h, 'X vs. xx', 'fit1', 'Location', 'NorthEast' );
% Label axes
xlabel xx
ylabel X
grid on

