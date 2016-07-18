%      clc
%      clear all;

%  %hf=figure('Color',[0,1,0],'Position',[1,1,300,150],...
%          'Name','Í¼ÐÎ´°¿ÚÊ¾Àý','NumberTitle','off','MenuBar','none',...
%          'KeyPressFcn','disp(''Hello,Keyboard Key Pressed.'')');

%   
%   screen=get(0,'ScreenSize');
%   W=screen(3);% long of figure
%   H=screen(4);% hight of figure
% hf=figure('Color',[1,1,1],'Position',[1,1,0.4*W,0.3*H],...
%           'Name','Menu Exemple','NumberTitle','off','MenuBar','none');
% hfile=uimenu(hf,'label','&File');
% hhelp=uimenu(hf,'label','&Help');
% uimenu(hfile,'label','&New','call','disp(''New Item'')');
% uimenu(hfile,'label','&Open','call','disp(''Open Item'')');
% hsave=uimenu(hfile,'label','&Save','Enable','off');
% uimenu(hsave,'label','Text file','call','k1=0;k2=1;file01;');
% uimenu(hsave,'label','Graphics file','call','k1=1;k2=0;file10;');
% uimenu(hfile,'label','Save &As','call','disp(''Save As Item'')');
% uimenu(hfile,'label','&Exit','separator','on','call','close(hf)');
% uimenu(hhelp,'label','About ...','call',...
%     ['disp(''Help Item'');','set(hsave,''Enable'',''on'')']);

clf reset

H=axes('unit','normaalized','position',[0,0,1,1],'visible','off');
set(gcf,'currentaxes',H);




