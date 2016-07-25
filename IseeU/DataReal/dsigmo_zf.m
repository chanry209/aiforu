function S = dsigmo_zf(V)

if (nargin ~= 1),	error('[SIGMOP] erreur d''usage : S = sigmop(V)'); end;
  
S = exp(-V)./((1+exp(-V)).^2);

