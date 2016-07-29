function S = sigmo_zf(V)

if (nargin ~= 1), error('[SIGMO] erreur d''usage : S = sigmo(V)'); end;
  
S = 1./(1+exp(-V));

i = find(isnan(S));
j = length(i);
if length(i) > 0
  S(i) = ones(1,j);
end
  

