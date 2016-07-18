
%y = gaussian_distri_ZF(x, 50, 10,1);

%% Fitting Gaussian parameters
Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sampling period
L = 1000;                     % Length of signal
t = (0:L-1)*T;                % Time vector
y = gaussmf(t,[0.05,0.3])+gaussmf(t,[0.06,0.8]); % function of matlab
plot(t,y);
% Create a matrix where each row represents a cosine wave with scaled frequency. The result, X, is a 3-by-1000 matrix. The first row has a wave frequency of 50, the second row has a wave frequency of 150, and the third row has a wave frequency of 300.

%For algorithm performance purposes, fft allows you to pad the input with trailing zeros. In this case, pad each row of X with zeros so that the length of each row is the next higher power of 2 from the current length. Define the new length using the nextpow2 function.

n = 2^nextpow2(L);
%Specify the dim argument to use fft along the rows of X, that is, for each signal.

dim = 2;
%Compute the Fourier transform of the signals.

Y = fft(y,n,dim);
%Calculate the double-sided spectrum and single-sided spectrum of each signal.

P2 = abs(Y/n);
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
%In the frequency domain, plot the single-sided amplitude spectrum for each row in a single figure.
figure
plot(0:(Fs/n):(Fs/2-Fs/n),P1(1,1:n/2))
