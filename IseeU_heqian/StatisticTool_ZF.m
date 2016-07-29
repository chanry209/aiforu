%% Statistic Tools
%    @ZeFeng 30/11/2011
function StatisticResult = StatisticTool_ZF(data)
% Size : row (samples) x column(properties)
[n,m] = size(data);
StatisticResult.Count = n;
%---------------------------------------------------
Mean = mean(data);
StatisticResult.Mean = Mean;
%---------------------------------------------------
SD = sqrt(sum(((data-repmat(Mean,n,1)).^2)/n)); %std(data)
StatisticResult.StandardDeviation = SD;
%---------------------------------------------------
SE = SD./sqrt(n-1);
StatisticResult.StandardError = SE;
%---------------------------------------------------
Mode = mode(data);
StatisticResult.Mode = Mode;
% ---------------------------------------------------
Median = median(data);
StatisticResult.Median = Median;
%---------------------------------------------------
SV = sum((data-repmat(Mean,n,1)).^2)/(n-1);% var(data)
StatisticResult.SampleVariance = SV;
%---------------------------------------------------
Kur = kurtosis(data);
StatisticResult.Kurtosis = Kur;
% ---------------------------------------------------
Ske = skewness(data);
StatisticResult.Skewness = Ske;
% ---------------------------------------------------
Min = min(data);
StatisticResult.Min = Min;
% ---------------------------------------------------
Max = max(data);
StatisticResult.Max = Max;
% ---------------------------------------------------
Sum = sum(data);
StatisticResult.Sum = Sum;
% ---------------------------------------------------
Range = Max - Min;
StatisticResult.Range = Range;
% ---------------------------------------------------
alpha = 0.05;          % significance level 
mu = Mean;           % mean 
sigma = SD;             % std 
cutoff1 = norminv(alpha, mu, sigma); 
cutoff2 = norminv(1-alpha, mu, sigma); 
% Figure
% x = [linspace(mu-4*sigma,cutoff1), ...     
%     linspace(cutoff1,cutoff2), ...     
%     linspace(cutoff2,mu+4*sigma)]; 
% y = normpdf(x, mu, sigma); 
% plot(x,y)  
% xlo = [x(x<=cutoff1) cutoff1]; 
% ylo = [y(x<=cutoff1) 0]; patch(xlo, ylo, 'b')  
% xhi = [cutoff2 x(x>=cutoff2)]; 
% yhi = [0 y(x>=cutoff2)]; 
% patch(xhi, yhi, 'b')
StatisticResult.ConfidenceLevel  = [cutoff1;cutoff2];










