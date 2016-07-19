%% Critère 1second
function Taux_Reco_1s = Taux_Reco_1s(a)

for i = 1:1000;
    b = mean(a((((i-1)*30+1):i*30),:));
    y(i)=find(b==max(b));
end

Target = 1:10;
Target = repmat(Target,100,[]);
Target = Target(:);
Target = Target';
Taux_Reco_1s = numel(find(y == Target))/length(Target);
