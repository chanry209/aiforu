save('Test22032012Simu','Data','Goal')
LDA_ZF = LDA_ZF_29112011(Data,Goal);
n = max(unique(LDA_ZF.Goal));
for i=1:n
    y(i).data = LDA_ZF.DataNew(Goal==i,:);
    Name{i} = strcat('Situation ',num2str(i));
end
typemarker = {'+','o','*','h','x','s','d','^','v','+','o','h','x','s'};
typecolor = [0 0 1;0 1 1;1 0 0;0 1 0;1 0 1; 0 0 0;1 1 0;1 0.5 0.5;0.7 0.5 0.2;0.3 0.5 0.8;0.4 0.2 0.9;0.6 0.1 0.3;0.9 0.4 0.1;0.2 0.9 0.3];
% 2D
   newFig = figure('Visible','on');
   for i = 1:n
    plot(y(i).data(:,1),y(i).data(:,2),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
    hold on 
   end
   legend(Name,'location','SE','fontsize',8)
    %legend('Ref','Fault210','Fault3','Fault4','Fault7','location','SE')
    title('New Data with LDA on 2D');
    ylabel('Vector 2');
    xlabel('Vector 1')
    print(newFig,'-dpng','figure131');
    hold off
   
    axes(handles.axes31)
    for i = 1:n
    plot(y(i).data(:,1),y(i).data(:,2),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
    hold on 
   end
   legend(Name,'location','SE','fontsize',8)
   legend(handles.axes31,'boxoff');
    title('New Data with LDA on 2D');
    ylabel('Vector 2');
    xlabel('Vector 1')
    hold off
%     print(f,'-dpng',fpath31);
%     hold off
%     h1=handles.axes31;
%     tmpaxes=findobj(h,'Type','axes');
%     figure(2);
%     destaxes=axes('Parent',2)
%     copyobj(allchild(tmpaxes),destaxes);
% newFig = figure('Visible','off');%����ֱ�ӱ���axes1�ϵ�ͼ�������ѣ����Ա������½���figure�е���ͼ
% set(newFig,'Visible','off')%�����½���figureΪ���ɼ�
% newAxes = copyobj(handles.LDA,newFig);   %��axes1�е�ͼ���Ƶ��½���figure��
% [filename,pathname] = uiputfile({ '*.jpg','figure type(*.jpg)'}, '����ԭʼ����');
% if isequal(filename,0)||isequal(pathname,0)%����û�ѡ��ȡ���������˳�
%     return;
% else
%     fpath31=fullfile(pathname,filename);
% end
%imwrite(newFig,fpath);%����û�ѡ��ȡ���������˳�

% 3D
    newFig = figure('Visible','off');
    for i = 1:n
     plot3(y(i).data(:,1),y(i).data(:,2),y(i).data(:,3),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
     hold on 
    end
    legend(Name,'location','NE','fontsize',8)
    legend(handles.axes32,'boxoff');
    title('New Data with LDA on 3D');
    ylabel('Vector 2');
    xlabel('Vector 1');
    zlabel('Vector 3');
    print(newFig,'-dpng','figure132');
    hold off

  axes(handles.axes32);
   for i = 1:n
     plot3(y(i).data(:,1),y(i).data(:,2),y(i).data(:,3),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
     hold on 
   end
    legend(Name,'location','NE','fontsize',8)
    legend(handles.axes32,'boxoff');
    title('New Data with LDA on 3D');
    ylabel('Vector 2');
    xlabel('Vector 1');
    zlabel('Vector 3');
hold off