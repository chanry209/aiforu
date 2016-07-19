%% Critère 23second
function Taux_Reco_23ms = Taux_Reco_23s(a)

for i = 1:30000
    m(i)=find(a(i,:)==max(a(i,:)));
end
    
Target = 1:10;
Target = repmat(Target,3000,[]);
Target = Target(:);
Target = Target';
Taux_Reco_23ms = numel(find(m == Target))/length(Target);