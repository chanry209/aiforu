function y = gaussian_distri_ZF(x, mu, sigma, heigth, fig)
    y1 = 1/(sqrt(2*pi)*sigma)*exp(-(x-mu).^2/2/sigma^2);
    y2 = heigth*exp(-(x-mu).^2/2/sigma^2);
    y1 = y1(:);
    y2 = y2(:);
    y = [y1,y2];
    if fig ==1
        figure
        title('Distribution of Gaussian')
        plot(x,y(:,1),'-r')
        hold on
        plot(x,y(:,2),'-y')
        legend('Standard Distribution',' Distribution with the defined pic')
    end