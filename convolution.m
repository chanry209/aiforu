%%% cette fonction est pour effectuer une convolution linéaire

function FiltreConv = convolution(I,h)

  Icadree = imagePad(I,h);
  hcopy = h;
  
  % masque de convolution h miroire

  u = size(h, 1);
  for i=1:u
      for j=1:u
          h(i,j) = hcopy(u - i + 1, u - j + 1);
      end;
  end;
  
  %padding = (u-1)/2;
  
  [ui,vi] =  size(I);
  
  FiltreConv = zeros(ui,vi);
  
  for i=1:ui
      for j=1:vi
          FiltreConv(i,j) = sum(sum(Icadree(i:i+u-1, j:j+u-1) .* h));
      end
  end
  
end