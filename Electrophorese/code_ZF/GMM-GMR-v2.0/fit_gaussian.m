clear all
clc

% the original data
X=[402.5,0,0,0,1,0,0,0,0,0,0;
   397.5,0,0,0,0,0,0,0,0,0,0;
   392.5,0,0,0,0,0,0,0,0,0,0;
   387.5,0,0,0,0,0,0,0,0,0,0;
   382.5,1,0,0,1,3,0,0,0,0,0;
   377.5,2,0,0,1,0,1,0,0,0,0;
   372.5,2,0,0,1,7,0,0,0,0,0;
   367.5,9,0,0,5,11,3,0,0,0,0;
   362.5,5,0,0,10,31,5,0,0,7,1;
   357.5,14,0,0,16,38,11,1,2,12,0;
   352.5,25,0,0,26,68,16,0,3,19,4;
   347.5,32,0,0,27,105,17,1,6,36,6;
   342.5,49,0,0,27,139,42,1,9,71,11;
   337.5,69,1,1,54,149,67,9,8,92,16;
   332.5,98,5,1,57,184,91,12,19,174,35;
   327.5,127,14,3,70,136,128,16,20,199,59;
   322.5,112,18,2,70,150,147,20,22,199,100;
   317.5,162,33,8,69,167,160,17,21,201,135;
   312.5,160,49,19,76,138,189,27,27,177,141;
   307.5,153,94,34,69,90,160,50,27,139,161;
   302.5,149,113,53,51,83,163,40,20,117,186;
   297.5,131,146,69,65,51,122,57,26,99,164;
   292.5,112,166,83,64,47,89,57,29,59,162;
   287.5,73,191,94,68,48,52,72,46,60,149;
   282.5,80,193,118,92,37,55,88,63,45,154;
   277.5,63,197,150,122,42,29,89,108,37,120;
   272.5,65,195,106,109,35,26,101,123,26,120;
   267.5,51,155,129,108,27,19,91,164,32,77;
   262.50,49,130,138,122,24,18,96,163,26,64;
   257.5,47,100,158,99,29,25,137,174,25,46;
   252.50,36,50,117,104,37,32,123,164,19,33;
   247.50,39,49,146,59,18,38,145,150,19,26;
   242.5,29,31,128,63,32,39,136,122,21,14;
   237.50,25,20,125,55,27,45,124,99,24,8;
   232.50,13,15,93,43,19,39,112,87,15,6;
   227.50,10,14,69,40,12,38,82,74,12,0;
   222.50,4,7,54,34,4,39,80,63,8,2;
   217.50,4,6,33,32,7,35,64,51,10,0;
   212.50,0,6,28,24,3,16,42,33,7,0;
   207.500,0,1,16,25,1,16,29,34,7,0;
   202.50,0,1,7,20,1,9,22,20,5,0;
   197.50,0,0,4,5,0,6,17,11,0,0;
   192.50,7,8,0,3,15,6,1,0,0,0;
   187.5,0,0,2,4,0,2,12,4,0,0;
   182.50,0,0,2,4,0,3,7,1,0,0;
   177.5000,0,0,0,0,0,3,3,1,0,0;
   172.5000,0,0,0,0,0,0,2,0,0,0;
   167.50,0,0,1,0,0,2,3,0,0,0;
   162.50,0,0,2,0,0,0,0,0,0,0];

load('data/scorec.mat');
% xx= (1:length(scorec))/length(scorec);
% Data = [xx; scorec'];
% X = Data';
X = scorec';

% define the original function
fx=@(b,x)b(1)*exp(-b(2)*(x-b(3)).^2)+b(4)*exp(-b(5)*(x-b(6)).^2)+b(7);

% the x value and the initial value
x=X(:,1);x1=linspace(min(x),max(x),350);
b0=[157.537585690536,0.00119930312813457,311.668458204896,...
    42.2693739293743,0.00153241227479562,258.791004295193,1];

% to store the parameters
B=zeros(10,7);
figure(1),clf,hold on
col1(1,:)='bo';col1(2,:)='go';col1(3,:)='co';col1(4,:)='ro';col1(5,:) ='mo';
col1(6,:)='yo';col1(7,:)='kp';col1(8,:)='bp';col1(9,:)='gp';col1(10,:)='cp';
col2(1,:)='b-';col2(2,:)='g-';col2(3,:)='c-';col2(4,:)='r-';col2(5,:) ='m-';
col2(6,:)='y-';col2(7,:)='k.';col2(8,:)='b.';col2(9,:)='g.';col2(10,:)='c.';

for i=1:10 % to fit each line
    figure(2),clf,hold on
    y=X(:,i+1);
    b=b0;
    
    for l=1:10;
        % Solve nonlinear curve-fitting problems in least-squares sense.
        % just a guess.
        b=lsqcurvefit(fx,b,x,y);
        % Nonlinear regression, 
        b=nlinfit(x,y,fx,b);
        % plot the line
        figure(2)
        text(200,max(y)-5,['y',num2str(i)],'fontsize',15)
        plot(x,y,col1(i,:),'markersize',5+i/4)
        y1=fx(b,x1);
        plot(x1,y1,col2(i,:),'linewidth',2.5)
        pause(1)
    end
    % plot all lines in one figure.
    figure(1)
    plot(x,y,col1(i,:),'markersize',5+i/4)
    y1=fx(b,x1);
    plot(x1,y1,col2(i,:),'linewidth',.5+i/4)
    B(i,:)=b;   
end
legend('sj1','fit1','sj2','fit2','sj3','fit3','sj4','fit4','sj5','fit5',...
       'sj6','fit6','sj7','fit7','sj8','fit8','sj9','fit9','sj10','fit10')
B

%% logs
% thanks to 'youyouyou','stats01','zzz700',and all the users who check this
% post.
% the roiginal post is at :
% http://www.ilovematlab.cn/thread-201168-1-1.html
% it aims to fit a set of data in normal distribution.
% modified on : 13:57 2012/7/17
% typed by    : mm
