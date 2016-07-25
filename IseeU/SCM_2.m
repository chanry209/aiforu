function varargout = SCM_2(varargin)
% SCM_2 MATLAB code for SCM_2.fig
%      SCM_2, by itself, creates a new SCM_2 or raises the existing
%      singleton*.
%
%      H = SCM_2 returns the handle to a new SCM_2 or the handle to
%      the existing singleton*.
%
%      SCM_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCM_2.M with the given input arguments.
%
%      SCM_2('Property','Value',...) creates a new SCM_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SCM_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SCM_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SCM_2

% Last Modified by GUIDE v2.5 19-Nov-2012 01:27:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SCM_2_OpeningFcn, ...
                   'gui_OutputFcn',  @SCM_2_OutputFcn, ...
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


% --- Executes just before SCM_2 is made visible.
function SCM_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SCM_2 (see VARARGIN)

% Choose default command line output for SCM_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SCM_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SCM_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double


% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.path,'string');
if isempty(path)
errordlg('Please input the path of data !')
end
pause(0.5)
set(hObject,'string','Wait')
pause(0.5)
datause = load(path);
data =  datause.dataNorma.data;
data = data';
dataNoNorma = datause.dataNorma.dataNoNorma;
dataNoNorma = dataNoNorma';
sensorsName = datause.dataNorma.F.sensorsChosenName;
PS = datause.dataNorma.PS;
PSsave = [PS.mean;PS.std];
indNorma = datause.dataNorma.indNorma;
indGoalTestAll = datause.dataNorma.indGoalTestAll;
indGoal = datause.dataNorma.indGoal;

str1 = pwd;
str2 = strcat(str1,'\SCM\PS_SCM_ind_',num2str(indNorma),'_',date,'.txt');
%save str2 -ascii PSsave
dlmwrite(str2,PSsave,'delimiter',' ','newline','pc')


handles.datausing.data = data;
handles.datausing.dataNoNorma = dataNoNorma;
handles.datausing.path = path;
handles.datausing.sensorsName = sensorsName;
handles.datausing.indGoalTestAll = indGoalTestAll;
handles.datausing.indGoal = indGoal;

set(hObject,'string','OK');
pause(1)
set(hObject,'string','Load');
guidata(hObject,handles);


function thr_Callback(hObject, eventdata, handles)
% hObject    handle to thr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thr as text
%        str2double(get(hObject,'String')) returns contents of thr as a double


% --- Executes during object creation, after setting all properties.
function thr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Apply.
function Apply_Callback(hObject, eventdata, handles)
% hObject    handle to Apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'String','Wait')
choixSystem = get(handles.choixSystem,'value');


thr = get(handles.thr,'String');
thr = str2double(thr);
if (thr>=1)||(thr<=0)||isnan(thr)
    msgbox('Percentage must be a value between 0 and 1 !')
end
handles.datausing.thr = thr;
sensorsName = handles.datausing.sensorsName;
numAltitude = find((strcmp(sensorsName,'ZP'))==1);
data = handles.datausing.data;
dataNoNorma = handles.datausing.dataNoNorma;
altitude = dataNoNorma(numAltitude,:);
CentersFinal = handles.datausing.CentersFinal;
NbOfPoint = handles.datausing.NbOfPoint;
mIndex = handles.datausing.mIndex;
indGoalTestAll = handles.datausing.indGoalTestAll;
[label,distResult] = testClassSCM_NoTarget(CentersFinal,NbOfPoint,mIndex,data);



ResultProba = softmax(distResult);
ResultNum = distResult;

for i = 1:size(ResultProba,2)
    maxCol = max(ResultProba(:,i));
    if  maxCol <= thr
        label(i) = size(ResultProba,1)+1;
    end
end

resultConfusion = MatrixConf_ZF(indGoalTestAll,label);
%resultConfusionAfter1000 = MatrixConf_ZF(indGoalTestAll,output);
set(handles.uitable4,'data',label');
unknown = find(label==(size(ResultProba,1)+1));
output = label;

if choixSystem==1
    clear resultConfusion 
    output(output~=1)=2;
    resultConfusion = MatrixConf_ZF(indGoalTestAll,output);
%     indGoalTestAll(1:1000)=[];
%     output(1:1000)=[];
%     resultConfusionAfter1000 = MatrixConf_ZF(indGoalTestAll,output);
    output(unknown) = 3;
end

handles.datausing.output = output;
handles.datausing.distResult =distResult;

set(handles.uitable3,'data',unknown)
set(handles.uitable1,'data',ResultNum)
set(handles.uitable2,'data',ResultProba)

% -----------------------------
% Figure
 %typemarker = {'+','o','*','h','x','s','d','^','v','+','o','h','x','s'};
typecolor = [0 1 1;1 0 0;0 1 0;1 0 1; 0 0 0;1 1 0;1 0.5 0.5;0.7 0.5 0.2;0.3 0.5 0.8;0.4 0.2 0.9;0.6 0.1 0.3;0.9 0.4 0.1;0.2 0.9 0.3];
x = 1:size(altitude,2);
newFig = figure('Visible','off');
% plot(x,altitude,'LineWidth',2);

if choixSystem ==1
    
    for i = 1:max(output)
        y_temp = output-1;
        y_temp(y_temp~=i-1)=0;
        
        [AX,H1,H2] = plotyy(x,altitude,x,y_temp,'plot');
        xlim(AX(1),[0 max(x)+1000])
        xlim(AX(2),[0 max(x)+1000])
        ylimMax1 = (floor(max(altitude)/10000)+1)*10000;
        ylim(AX(1),[0 ylimMax1])
        ylim(AX(2),[0 max(output)])
        set(AX(1),'yTick',[0:10000:ylimMax1]) %  ÉèÖÃ×ó±ßYÖáµÄ¿Ì¶È
        set(AX(2),'yTick',[0:1:max(output)]) %ÉèÖÃÓÒ±ßYÖáµÄ¿Ì¶È
    
        set(get(AX(1),'Ylabel'),'String','Altitude') 
        set(get(AX(2),'Ylabel'),'String','Faults') 

        set(H1,'LineStyle','--')
        set(H1,'color','b')
        set(H2,'color',typecolor(i,:))
        hold on
    end
    
    set(get(AX(1),'Ylabel'),'String','Altitude') 
    set(get(AX(2),'Ylabel'),'String','Faults')     
    legend('Altitude','Ref','[]','Faults','[]','Situations Unknown','location','NE')
    
else
    for i = 1:max(output)
        y_temp = output-1;
        y_temp(y_temp~=i-1)=0;
        
        [AX,H1,H2] = plotyy(x,altitude,x,y_temp,'plot');
        xlim(AX(1),[0 max(x)+1000])
        xlim(AX(2),[0 max(x)+1000])
        ylimMax1 = (floor(max(altitude)/10000)+1)*10000;
        ylim(AX(1),[0 ylimMax1])
        ylim(AX(2),[0 max(output)])
        set(AX(1),'yTick',[0:10000:ylimMax1]) %  ÉèÖÃ×ó±ßYÖáµÄ¿Ì¶È
        set(AX(2),'yTick',[0:1:max(output)]) %ÉèÖÃÓÒ±ßYÖáµÄ¿Ì¶È

        set(get(AX(1),'Ylabel'),'String','Altitude') 
        set(get(AX(2),'Ylabel'),'String','Faults') 

        set(H1,'LineStyle','--')
        set(H1,'color','b')
        set(H2,'color','r')
        hold on
        
    end
    
    set(get(AX(1),'Ylabel'),'String','Altitude') 
    set(get(AX(2),'Ylabel'),'String','Faults')     
    
    
end

title('Profil of Flight');
xlabel('Time')
pathFig = pwd;
pathFig = strcat(pathFig,'\SCM\');

% % make a folder named date to place the figures 
% s = mkdir(pathFig,date);
% if s~=1
%     msgbox('There is problem of building a new folder for figures!')
%     return
% end

% save figure
name = strcat(pathFig,'Profil',date);

saveas(gcf,name);
print(newFig,'-dpng',name);
hold off

axes(handles.axes1)
plot(x,altitude,'LineWidth',2);
hold on

for i = 1:max(output)
    plot(x(output == i),(output(output == i)-1)*10000,'linestyle','none','marker','.','color',typecolor(i,:))
    hold on 
end
%legend('Altitude','Ref','Fault 1','Fault 2','Fault 3','Fault Unknown','location','NE')

if choixSystem ==1
    legend('Altitude','Ref','Faults','Fault Unknown','location','NE')
end

title('Profil of Flight');
ylabel('Altitude + Situations');
xlabel('Time')
axis([0,max(x)+1000,0,45000])
hold off
%------------------------------
set(hObject,'String','OK')
pause(1)
set(hObject,'String','Apply')
pathString = pwd;
str1 = strcat(pathString,'/SCM/resultConfusion',date);

save(str1','resultConfusion')
guidata(hObject,handles)

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over path.
function path_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path index ] = uigetfile('*.mat','File Selector');
    if index 
        str = [path file];
        set(hObject,'string',str);
    end
end



function pathModel_Callback(hObject, eventdata, handles)
% hObject    handle to pathModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathModel as text
%        str2double(get(hObject,'String')) returns contents of pathModel as a double


% --- Executes during object creation, after setting all properties.
function pathModel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pathModel.
function pathModel_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pathModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path index ] = uigetfile('*.mat','File Selector');
    if index 
        str = [path file];
        set(hObject,'string',str);
    end
end

% --- Executes on button press in loadModel.
function loadModel_Callback(hObject, eventdata, handles)
% hObject    handle to loadModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.pathModel,'string');
if isempty(path)
errordlg('Please input the path of data !')
end
pause(0.5)
set(hObject,'string','Wait')
pause(0.5)
datause = load(path);
CentersFinal = datause.BestCentersFinal;
V = datause.BestV;
mIndex = datause.mIndex;
NbOfPoint = datause.BestNbOfPointFinal;
thrDefault  = 1/(size(CentersFinal,1))+0.1;

set(handles.thr,'String',num2str(thrDefault));
handles.datausing.CentersFinal = CentersFinal;
handles.datausing.V = V;
handles.datausing.NbOfPoint = NbOfPoint;
handles.datausing.mIndex = mIndex; 
cmd = strcat(['Nb of Total Centers is ',num2str(size(CentersFinal,2)),'; Nb suggested is ',num2str(NbOfPoint),'.']);
set(handles.text6,'string',cmd);

set(hObject,'string','OK');
pause(1)
set(hObject,'string','Load');
guidata(hObject,handles);


% % --- Executes on button press in excel.
%  function excel_Callback(hObject, eventdata, handles)
% 
% % hObject    handle to excel (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% str1 = pwd;
% str2 = strcat(str1,'\results\Result_SCM_',date,'.xls');
% filespec_user = str2;
% try
%     Excel = actxGetRunningServer('Excel.Application');  
% catch
%     Excel = actxserver('Excel.Application');
% end
% Excel.Visible = 1;
% 
% if exist(filespec_user,'file')
%     Workbook = Excel.Workbooks.Open(filespec_user);
% else
%     Workbook = Excel.Workbooks.Add;
%     Workbook.SaveAs(filespec_user);
% end
% 
% Sheets = Excel.ActiveWorkbook.Sheets;
% Sheet1 = Sheets.Item(2);
% Sheet1.Activate;
% set(Excel,'StandardFont','Times New Roman')
% 
% Sheet1.Range('A1:A2').RowHeight = [28,24];
% %Sheet1.Range('A1:C1').ColumnWidth = [28,12,12];
% 
% Sheet1.PageSetup.TopMargin = 60;
% Sheet1.PageSetup.BottomMargin = 45;
% Sheet1.PageSetup.LeftMargin = 45;
% Sheet1.PageSetup.RightMargin = 45;
% 
% Sheet1.Range('A1:AB500').HorizontalAlignment=3;
% 
% Sheet1.Range('A1:I1').MergeCells = 1;
% Sheet1.Range('A2:I2').MergeCells = 1;
% Sheet1.Range('A1').Value = ' Diagnostic by SCM _ TEST';
% str = date;
% Sheet1.Range('A2').Value = str;
% Sheet1.Range('A1:A2').Font.Size = 24;
% Sheet1.Range('A1:A2').Font.Bold =2; 
% % --------------------------------------------------
% % 
% Sheet1.Range('A4:I4').MergeCells = 1;
% Sheet1.Range('C5:I5').MergeCells = 1;
% Sheet1.Range('A5:B5').MergeCells = 1;
% Sheet1.Range('C6:I6').MergeCells = 1;
% Sheet1.Range('A6:B6').MergeCells = 1;
% Sheet1.Range('A4').Value = ' Results - Three Tables  ';
% Sheet1.Range('A4').Font.Bold =2; 
% 
% path = get(handles.path,'string');
% Sheet1.Range('A5').Value = 'Testing Data';
% Sheet1.Range('C5').Value = path;
% 
% pathModel = get(handles.pathModel,'string');
% Sheet1.Range('A6').Value = 'Model';
% Sheet1.Range('C6').Value = pathModel;
% 
% % --------------------------------------------------
% Sheet1.Range('D7').Value = 'Threshold';
% Sheet1.Range('E7').Value = handles.datausing.thr;
% % --------------------------------------------------
% Sheet1.Range('A9').Value = 'Unknown';
% tab1 = get(handles.uitable3,'data');
% Lunknown = length(tab1);
% cmd1 = strcat('A10:','A',num2str(Lunknown+9));
% Sheet1.Range(cmd1).Value = tab1;
% 
% % ---------------------------------------------------
% Sheet1.Range('C9').Value = 'Result';
% tab2 = handles.datausing.output;
% tab2=tab2';
% Lunknown = length(tab2);
% cmd1 = strcat('C10:','C',num2str(Lunknown+9));
% Sheet1.Range(cmd1).Value = tab2;
% 
% % ---------------------------------------------------
% Sheet1.Range('E9').Value = 'Standard Result';
% tab3 = get(handles.uitable1,'data');
% tab3=tab3';
% tab3Size = size(tab3);
% cmd3 = strcat('E10:',char(68+tab3Size(2)),num2str(tab3Size(1)+9));
% Sheet1.Range(cmd3).Value = tab3;
% 
% % ---------------------------------------------------
% cmd2 = strcat(char(68+tab3Size(2)+2),num2str(9));
% Sheet1.Range(cmd2).Value = 'Probability Result';
% tab4 = get(handles.uitable2,'data');
% tab4=tab4';
% tab4Size = size(tab4);
% cmd4 = strcat(char(68+tab3Size(2)+2),'10:',char(68+tab3Size(2)+1+tab4Size(2)),num2str(tab4Size(1)+9));
% Sheet1.Range(cmd4).Value = tab4;




% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
Diagnostic


% --- Executes on button press in choixSystem.
function choixSystem_Callback(hObject, eventdata, handles)
% hObject    handle to choixSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choixSystem



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NbOfPoint = get(handles.edit4,'string');
NbOfPoint = str2double(NbOfPoint);
NbOfPoint = floor(NbOfPoint);

set(hObject,'string','Waiting');
pause(0.8);
nbMax = handles.datausing.NbOfPoint;
mIndex = handles.datausing.mIndex;

if NbOfPoint<1||NbOfPoint >nbMax
errordlg('The Nb of centers chosen is too small or too big !')
end

CentersFinal = handles.datausing.CentersFinal;
nSize = size(CentersFinal,1);

for i =1:NbOfPoint
    for j = 1:nSize 
    Centers(j).final(i,:) = CentersFinal(j,i).mean(1:mIndex);
    end
end   

str1 = pwd;
for i = 1:nSize
    str2 = strcat(str1,'\SCM\C',num2str(i),'_',date,'.txt');
    dlmwrite(str2,Centers(i).final,'delimiter',' ','newline','pc');
end

Data  = handles.datausing.data;
V = handles.datausing.V;
DataNew = Data'*V';
handles.datausing.data = DataNew;

set(hObject,'string','OK');
pause(1);
set(hObject,'string','Apply');
guidata(hObject,handles);




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit4.
function edit4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over thr.
function thr_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to thr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
