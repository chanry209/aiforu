function resI = gaussian_lowpass_filter(I,fc)

[m,n]=size(I);

tf=fft2(double(I));
tf=fftshift(tf);

Ff=zeros(m,n);
for i=1:m
    for j=1:n
        dist=sqrt(abs(m/2-i)^2+abs(n/2-j)^2);
        if dist<=fc
            Ff(i,j)=1;
        else
            Ff(i,j)=0;
        end
    end
end

tempImage=tf.*Ff;

% inverser le shif de la FFT filtre

tfi=ifft2(ifftshift(tempImage));

resI=tfi;

% figure;
% subplot(2,1,1);
% colormap gray;
% imagesc(I);
% title('image originale');
% subplot(2,1,2);
% colormap gray;
% imagesc(1+log(abs(resI)));
% % imshow(uint8(resI));
% title(['image GLPF avec fc = ', num2str(fc)]); 

end