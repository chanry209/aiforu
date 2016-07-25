function varargout = Main1_2(varargin)
% MAIN1_2 MATLAB code for Main1_2.fig
%      MAIN1_2, by itself, creates a new MAIN1_2 or raises the existing
%      singleton*.
%
%      H = MAIN1_2 returns the handle to a new MAIN1_2 or the handle to
%      the existing singleton*.
%
%      MAIN1_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN1_2.M with the given input arguments.
%
%      MAIN1_2('Property','Value',...) creates a new MAIN1_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main1_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main1_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main1_2

% Last Modified by GUIDE v2.5 11-May-2012 13:03:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main1_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Main1_2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Main1_2 is made visible.
function Main1_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main1_2 (see VARARGIN)

% Choose default command line output for Main1_2
handles.output = hObject;

handles.datauser.indData = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main1_2 wait for user response (see UIRESUME)
% uiwait(handles.main1_2);


% --- Outputs from this function are returned to the command line.
function varargout = Main1_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
TableContents;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str1 = pwd;
str2 = strcat(str1,'\results\Result_',date,'.xls');
filespec_user = str2;

try
    Excel = actxGetRunningServer('Excel.Application');  
catch
    Excel = actxserver('Excel.Application');
end
Excel.Visible = 1;

if exist(filespec_user,'file')
    Workbook = Excel.Workbooks.Open(filespec_user);
else
    Workbook = Excel.Workbooks.Add;
    Workbook.SaveAs(filespec_user);
end

Sheets = Excel.ActiveWorkbook.Sheets;
Sheet1 = Sheets.Item(2);
Sheet1.Activate;
set(Excel,'StandardFont','Times New Roman')

Sheet1.Range('A1:A2').RowHeight = [28,24];
Sheet1.Range('A1:C1').ColumnWidth = [28,12,12];

Sheet1.PageSetup.TopMargin = 60;
Sheet1.PageSetup.BottomMargin = 45;
Sheet1.PageSetup.LeftMargin = 45;
Sheet1.PageSetup.RightMargin = 45;

Sheet1.Range('A1:AB500').HorizontalAlignment=3;

Sheet1.Range('A1:F1').MergeCells = 1;
Sheet1.Range('A2:F2').MergeCells = 1;
Sheet1.Range('A1').Value = ' 1-2  LDA and PCA ';
str = date;
Sheet1.Range('A2').Value = str;
Sheet1.Range('A1:A2').Font.Size = 24;
Sheet1.Range('A1:A2').Font.Bold =2; 
% --------------------------------------------------
% 1 LDA
Sheet1.Range('A4:C4').MergeCells = 1;
Sheet1.Range('A5:F5').MergeCells = 1;
Sheet1.Range('A4').Value = ' 1 - LDA ';
Sheet1.Range('A4').Font.Bold =2; 

indLoad = handles.datauser.indLoad;
if indLoad == 0
    path = handles.datauser.strLDA;
else
    path = handles.datauser.strLDAPCA;
end

Sheet1.Range('A5').Value = path;

tableLDA = handles.datauser.vecLDA;
[str,col,raw] = tableWrtieInExcel(tableLDA ,'B','7');
Sheet1.Range(str).Value = tableLDA;

% % ---------------------------------------------------
% % 2 - PCA
raw = str2double(raw);
raw = raw + 2;

str = strcat('A',num2str(raw),':','F',num2str(raw));
Sheet1.Range(str).MergeCells = 1;
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' 2 - PCA ';
Sheet1.Range(str).Font.Bold =2; 

if indLoad == 1
    path = handles.datauser.strPCA;
else
    path = handles.datauser.strLDAPCA;
end

raw = raw + 1;
str = strcat('A',num2str(raw),':','F',num2str(raw));
Sheet1.Range(str).MergeCells = 1;
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = path;

raw = raw + 1;
tablePCA = handles.datauser.vecPCA;
[str,col,raw] = tableWrtieInExcel(tablePCA ,'B',num2str(raw));
Sheet1.Range(str).Value = tablePCA;

% Sheet1.Range('A19:C19').MergeCells = 1;
% Sheet1.Range('A19').Value = ' 3 Curve of Linear Discirminant Analysis - (LDA) ';
% Sheet1.Range('A19').Font.Bold =2; 
% PicturePath = strcat(str1,'\','figures\',date,'\','figure131.png');
% h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,310,460,320);
% PicturePath = strcat(str1,'\','figures\',date,'\','figure132.png');
% h2 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,640,460,320);
% 
% % ---------------------------------------------------
% % 4 - PCA
% Sheet1.Range('A66:C66').MergeCells = 1;
% Sheet1.Range('A66').Value = ' 4 - Principal Component Analysis - (PCA) ';
% Sheet1.Range('A66').Font.Bold =2; 
% PicturePath = strcat(str1,'\','figures\',date,'\','figure141.png');
% h3 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1020,460,320);
% PicturePath = strcat(str1,'\','figures\',date,'\','figure142.png');
% h4 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1360,460,320);
Workbook.Save

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = handles.datauser.indData;
if a==0
     msgbox('There isn''t any data uploaded!')
    return
end

Data = handles.datauser.data;
Goal = handles.datauser.goal;
%save('test','Data','Goal')
LDA_ZF = LDA_ZF_29112011(Data,Goal);
tableVector1 = LDA_ZF.V;

n = max(unique(LDA_ZF.Goal));
for i=1:n
    y(i).data = LDA_ZF.DataNew(Goal==i,:);
    Name{i} = strcat('Situation ',num2str(i));
end
typemarker = {'+','o','*','h','x','s','d','^','v','+','o','h','x','s'};
typecolor = [0 0 1;0 1 1;1 0 0;0 1 0;1 0 1; 0 0 0;1 1 0;1 0.5 0.5;0.7 0.5 0.2;0.3 0.5 0.8;0.4 0.2 0.9;0.6 0.1 0.3;0.9 0.4 0.1;0.2 0.9 0.3];
% 2D
newFig = figure('Visible','off');
for i = 1:n
    plot(y(i).data(:,1),y(i).data(:,2),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
    hold on 
end
legend(Name,'location','SE','fontsize',8)
legend(handles.axes31,'boxoff');
%legend('Ref','Fault210','Fault3','Fault4','Fault7','location','SE')
title('New Data with LDA on 2D');
ylabel('Vector 2');
xlabel('Vector 1')
pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');

% make a folder named date to place the figures 
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
    return
end

% save figure
name131 = strcat(pathFig,date,'\LDA2D');

saveas(gcf,name131);
print(newFig,'-dpng',name131);
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
% newFig = figure('Visible','off');%由于直接保存axes1上的图像有困难，所以保存在新建的figure中的谱图
% set(newFig,'Visible','off')%设置新建的figure为不可见
% newAxes = copyobj(handles.LDA,newFig);   %将axes1中的图复制到新建的figure中
% [filename,pathname] = uiputfile({ '*.jpg','figure type(*.jpg)'}, '保存原始波形');
% if isequal(filename,0)||isequal(pathname,0)%如果用户选择“取消”，则退出
%     return;
% else
%     fpath31=fullfile(pathname,filename);
% end
%imwrite(newFig,fpath);%如果用户选择“取消”，则退出

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

name132 = strcat(pathFig,date,'\LDA3D');
saveas(gcf,name132);
print(newFig,'-dpng',name132);
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

set(handles.uitable2,'data',tableVector1');
handles.datauser.vecLDA = tableVector1';
guidata(hObject,handles)

% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = handles.datauser.indData;
if a==0
     msgbox('There isn''t any data uploaded!')
    return
end

yy = handles.datauser.data;
Goal_ACP = handles.datauser.goal;
%save('Test11JAn','yy','Goal_ACP')
%Goal_ACP = vec2ind_zf(Goal);
pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
    return
end

[vectors, coeff, newValue0, ValueForDraw,percent_explained] = acp_zf(yy,99,0);
% Figure of Percent Explained
newFig = figure('visible','off');
bar(percent_explained(1:size(newValue0,2)));
axis([0 size(newValue0,2)+1 0 100]);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis')

name141 = strcat(pathFig,date,'\PCAHist');
print(newFig,'-dpng',name141)
saveas(gcf,name141);

axes(handles.axes41)

bar(percent_explained(1:size(newValue0,2)));
axis([0 size(newValue0,2)+1 0 100]);
%set(gca,'XLim',[0 size(newValue0,2)+1]);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis (Threshould = 99%)')

% Figure on 2D
n = max(unique(Goal_ACP));
for i=1:n
    y(i).data = newValue0(Goal_ACP==i,:);
    Name{i} = strcat('Situation ',num2str(i));
end
typemarker = {'+','o','*','h','x','s','d','^','v','+','o','h','x','s'};
typecolor = [0 0 1;0 1 1;1 0 0;0 1 0;1 0 1; 0 0 0;1 1 0;1 0.5 0.5;0.7 0.5 0.2;0.3 0.5 0.8;0.4 0.2 0.9;0.6 0.1 0.3;0.9 0.4 0.1;0.2 0.9 0.3];

newFig = figure('visible','off');
    for i = 1:n
    plot(y(i).data(:,1),y(i).data(:,2),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
    hold on 
   end
   legend(Name,'location','SE','fontsize',8)
   %legend(handles.axes42,'boxoff');
    title('New Data with PCA on 2D');
    ylabel('Vector 2');
    xlabel('Vector 1')
    name142 = strcat(pathFig,date,'\PCA2D');
    print(newFig,'-dpng',name142)
    saveas(gcf,name142);
    hold off

    axes(handles.axes42);
   for i = 1:n
    plot(y(i).data(:,1),y(i).data(:,2),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
    hold on 
   end
   legend(Name,'location','SE','fontsize',8)
   legend(handles.axes42,'boxoff');
    title('New Data with PCA on 2D');
    ylabel('Vector 2');
    xlabel('Vector 1')
    hold off
    set(handles.uitable3,'data',vectors);
    handles.datauser.vecPCA = vectors;
    guidata(hObject,handles)
    
% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname index] = uigetfile({'*.mat'});
if index == 0
    msgbox('Please load one file mat !')
    return
end
strLDAPCA = [pathname filename];
dataUse = load([pathname filename]);
handles.datauser.data = dataUse.dataNorma.data;
datagoal = dataUse.dataNorma.dataNormaInd;
handles.datauser.goal = datagoal ;
handles.datauser.strLDAPCA = strLDAPCA;
handles.datauser.strPCA = strLDAPCA;
handles.datauser.indLoad = 1;
handles.datauser.indData = 1;
guidata(hObject,handles);

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname index] = uigetfile({'*.mat'});
if index == 0
    msgbox('Please load one file mat !')
    return
end
dataUse = load([pathname filename]);
strLDAPCA = [pathname filename];
handles.datauser.data = dataUse.dataNorma.data;
datagoal = dataUse.dataNorma.dataNormaInd;
handles.datauser.goal = datagoal ;
handles.datauser.strLDAPCA = strLDAPCA;
handles.datauser.strLDA = strLDAPCA;
handles.datauser.indLoad = 0;
handles.datauser.indData = 1;
guidata(hObject,handles);


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes31)
legend(handles.axes31,'off')
cla(handles.axes32)
legend(handles.axes32,'off')


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes41)
cla(handles.axes42)
legend(handles.axes42,'off')


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = handles.datauser.indData;
if a==0
     msgbox('There isn''t any data uploaded!')
else
    figure
    Data = handles.datauser.data;
    Goal = handles.datauser.goal;
    %save('test','Data','Goal')
    LDA_ZF = LDA_ZF_29112011(Data,Goal);
    tableVector1 = LDA_ZF.V;

    n = max(unique(LDA_ZF.Goal));
    for i=1:n
        y(i).data = LDA_ZF.DataNew(Goal==i,:);
        Name{i} = strcat('Situation ',num2str(i));
    end
    typemarker = {'+','o','*','h','x','s','d','^','v','+','o','h','x','s'};
    typecolor = [0 0 1;0 1 1;1 0 0;0 1 0;1 0 1; 0 0 0;1 1 0;1 0.5 0.5;0.7 0.5 0.2;0.3 0.5 0.8;0.4 0.2 0.9;0.6 0.1 0.3;0.9 0.4 0.1;0.2 0.9 0.3];

    % 2D
    for i = 1:n
        plot(y(i).data(:,1),y(i).data(:,2),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
        hold on 
    end
    legend(Name,'location','SE','fontsize',8)
    %legend(handles.axes31,'boxoff');
    %legend('Ref','Fault210','Fault3','Fault4','Fault7','location','SE')
    title('New Data with LDA on 2D');
    ylabel('Vector 2');
    xlabel('Vector 1')
end


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = handles.datauser.indData;
if a == 0
    msgbox('There isn''t any data uploaded!')
else
    figure
    Data = handles.datauser.data;
    Goal = handles.datauser.goal;
    %save('test','Data','Goal')
    LDA_ZF = LDA_ZF_29112011(Data,Goal);
    tableVector1 = LDA_ZF.V;

    n = max(unique(LDA_ZF.Goal));
    for i=1:n
        y(i).data = LDA_ZF.DataNew(Goal==i,:);
        Name{i} = strcat('Situation ',num2str(i));
    end
    typemarker = {'+','o','*','h','x','s','d','^','v','+','o','h','x','s'};
    typecolor = [0 0 1;0 1 1;1 0 0;0 1 0;1 0 1; 0 0 0;1 1 0;1 0.5 0.5;0.7 0.5 0.2;0.3 0.5 0.8;0.4 0.2 0.9;0.6 0.1 0.3;0.9 0.4 0.1;0.2 0.9 0.3];

    % 3D
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
end


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = handles.datauser.indData;
if a==0
     msgbox('There isn''t any data uploaded!')
    return
end
figure

yy = handles.datauser.data;
Goal_ACP = handles.datauser.goal;

[vectors, coeff, newValue0, ValueForDraw,percent_explained] = acp_zf(yy,99,0);

bar(percent_explained(1:size(newValue0,2)));
axis([0 size(newValue0,2)+1 0 100]);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis')

% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = handles.datauser.indData;
if a==0
     msgbox('There isn''t any data uploaded!')
    return
end
figure
yy = handles.datauser.data;
Goal_ACP = handles.datauser.goal;

[vectors, coeff, newValue0, ValueForDraw,percent_explained] = acp_zf(yy,99,0);

% Figure on 2D
n = max(unique(Goal_ACP));
for i=1:n
    y(i).data = newValue0(Goal_ACP==i,:);
    Name{i} = strcat('Situation ',num2str(i));
end
typemarker = {'+','o','*','h','x','s','d','^','v','+','o','h','x','s'};
typecolor = [0 0 1;0 1 1;1 0 0;0 1 0;1 0 1; 0 0 0;1 1 0;1 0.5 0.5;0.7 0.5 0.2;0.3 0.5 0.8;0.4 0.2 0.9;0.6 0.1 0.3;0.9 0.4 0.1;0.2 0.9 0.3];

for i = 1:n
    plot(y(i).data(:,1),y(i).data(:,2),'linestyle','none','marker',typemarker{i},'color',typecolor(i,:))
    hold on 
end
    
legend(Name,'location','SE','fontsize',8)
%legend(handles.axes42,'boxoff');
title('New Data with PCA on 2D');
ylabel('Vector 2');
xlabel('Vector 1')
