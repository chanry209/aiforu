%% Critère 1second
function Taux_Reco_1s = Taux_Reco(a)
    % a = likelihood;
for i = 1:2000;
    b = mean(a((((i-1)*50+1):i*50),:));
    y(i)=find(b==max(b));
end

Target = 1:10;
Target = repmat(Target,200,[]);
Target = Target(:);
Target = Target';
Taux_Reco_1s = numel(find(y == Target))/length(Target);


%% Critère de 4second
% b = [];
% for i = 1:2000;
%     b(i,:) = sum(a((((i-1)*50+1):i*50),:));
% end
% 
% d = [];
% for i = 1:200
%     d = sum(c(((i-1)*10+1):10*i,:));
%     y2(i)=find(d==max(d));
% end
% 
% 
% Target = 1:10;
% Target = repmat(Target,20,[]);
% Target = Target(:);
% Target = Target';
% Taux_Reco_4s = numel(find(y2 == Target))/length(Target);