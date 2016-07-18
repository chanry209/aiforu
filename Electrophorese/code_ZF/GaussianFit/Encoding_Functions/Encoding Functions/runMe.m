function runMe

fin='motion_data_01.mat';
i=4;
j=2;

q=load(fin);
q=q.q;

fprintf('In file %s the four joint trajectories are stored\n',fin);
disp('according to the following notation:');
disp(' ');
disp('q{i,j} is the trajectory of joint i [1..4] in its jth recording;');
disp('j=1,3,5 for outward movements,');
disp('j=2,4,6 for innward movements.');
disp(' ');
fprintf('Application of the four different approaches to q{%d,%d} follows\n',i,j);
disp(' ');

t=q{i,j}.t;
ydemo=q{i,j}.ydemo;
Dydemo=q{i,j}.Dydemo;

encCubspline(t,ydemo,1e-4,inf,true);

encNonlinDyn(t,ydemo,Dydemo,1e-4,inf,true);

encJacobi(t,ydemo,1e-4,inf,true);

encWavelet(t,ydemo,'db4',2.3,true);

