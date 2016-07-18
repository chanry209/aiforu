function lshape= mCDHO(V,V0,Vp,sigma,a0)
% modified classical damped harmonic oscillator model 
% see A.B.Djurisic,T.Fritz and K.Leo, J.Opt.A:Pure Appl.Opt.2(2000) 458-464
%   input: v wavelength range,vo and sigma are peak positions and damping
%          constants, respectively.
%          a0 is lineshape factor,a0=0 is pure CDHO;a0=0.3 is pure Gausian
%          a0>0.3 is assymmetric lineshapes
%   output: lineshape
% V is column matrix, Vo,Vp,sigma and a0 is row matrix

% vectorise 
v=V*ones(1,length(V0));vj=ones(length(V),1)*V0;vp=ones(length(V),1)*Vp; % vectorise
sigma=ones(length(V),1)*sigma;       % vectorise
a=ones(length(V),1)*a0;
sigma=sigma.*exp(-a.*(((v-vj)./sigma).^2));
aj=(vp.*sigma.*v)./((vj.^2-v.^2).^2+(sigma.*v).^2);
lshape=sum(aj,2);
end

