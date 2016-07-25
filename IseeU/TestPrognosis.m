%% Test of Prognosis
clc
clear all
close all

load('dataTestPrognosis.mat')
Data = LDA_ZF.DataNew;
Goal = LDA_ZF.Goal;
xmin = min(Data(:,1));
xmax = max(Data(:,1));
ymin = min(Data(:,2));
ymax = max(Data(:,2));
zmin = min(Data(:,3));
zmax = max(Data(:,3));

dataSphere1 = LDA_ZF.DataNew(Goal==2,:);
dataSphere2 = LDA_ZF.DataNew(Goal==3,:);

sphere1 = mean(dataSphere1);
sphere2 = mean(dataSphere2);

plotsphere_zf(sphere1(1),sphere1(2),sphere1(3),0.1);
%axis([xmin xmax ymin ymax zmin zmax])

hold on
plotsphere_zf(sphere2(1),sphere2(2),sphere2(3),0.1);
axis([xmin xmax ymin ymax zmin zmax])



sizeData = length(Data);
k=1;
while k<sizeData-599
a = plot3(Data(k:k+599,1),Data(k:k+599,2),Data(k:k+599,3),'*','markerSize',10);
axis([xmin xmax ymin ymax zmin zmax])
strTemp = strcat(['During ',num2str(k),'th second and ',num2str(k+599),'th second']);
title(strTemp);
k = k+600;
pause(0.5)
delete(a)
end
