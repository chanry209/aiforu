function Nc = cellhidden_zf(input,output,option)
% 5 rules for calculate the nb of hidden cells for net
% @ zefeng 09082011
% option = 1 - 3 : rule zarader 3 6 9
% option = 4 : rule double - Nc = 2*Ni
% option = 5 : rule sqrt : Nc = ceil(sqrt(Ni+No))+a
% option = 6 : rule sqrt : Nc =ceil(sqrt(Ni*Np)+No/2);
% option = 7 : rule log  : Nc = ceil(log2(Np));


if nargin<3
   option = 1;
end

[Ni,Np] = size(input);
No = size(output,1);


%% rule zarader
if option == 1    
Nc = ceil(Np/3/(Ni+No));
%disp('Rule for calculate the hidden cell is [Nc = ceil(Np/3/(Ni+No))]')
end

if option == 2    
Nc = ceil(Np/6/(Ni+No));
%disp('Rule for calculate the hidden cell is [Nc = ceil(Np/6/(Ni+No))]')
end

if option == 3   
Nc = ceil(Np/9/(Ni+No));
%disp('Rule for calculate the hidden cell is [Nc = ceil(Np/9/(Ni+No))]')
end

%% rule double
if option == 4   
Nc = 2*Ni;
%disp('Rule for calculate the hidden cell is [Nc = 2*Ni]')
end

%% rule sqrt
if option == 5  
a = 3; % a : 1-10    
Nc = ceil(sqrt(Ni+No))+a;
%disp('Rule for calculate the hidden cell is [Nc = sqrt(Ni+No)+a]')
end

if option == 6  
Nc =ceil(sqrt(Ni*Np)+No/2);
%disp('Rule for calculate the hidden cell is [Nc = ceil(sqrt(Ni*Np))+No/2]')
end

%% rule log
if option == 7     
Nc = ceil(log2(Np));
%disp('Rule for calculate the hidden cell is [log2(Np)]')
end

end