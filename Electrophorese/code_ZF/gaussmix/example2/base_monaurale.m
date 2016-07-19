function [Base] = base_monaurale(n)
% n : nombre de locuteur

for i = 1:10
Bases(i).mono = [];
end

for j = 1:n
for i = 1:28
temp1 = strcat('RSB0/seuil_0.02/spk_',num2str(j),'/spk_',num2str(i),'.mat');
load (temp1);
temp2 = Features;
Bases(j).mono = [Bases(j).mono temp2];
end
Bases(j).mono = Bases(j).mono';
clear Features
clear temp1
clear temp2
end
Base = Bases;