function varargout = StatisticTool(varargin)
% STATISTICTOOL MATLAB code for StatisticTool.fig
%      STATISTICTOOL, by itself, creates a new STATISTICTOOL or raises the existing
%      singleton*.
%
%      H = STATISTICTOOL returns the handle to a new STATISTICTOOL or the handle to
%      the existing singleton*.
%
%      STATISTICTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICTOOL.M with the given input arguments.
%
%      STATISTICTOOL('Property','Value',...) creates a new STATISTICTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StatisticTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StatisticTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StatisticTool

% Last Modified by GUIDE v2.5 11-Sep-2012 18:09:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StatisticTool_OpeningFcn, ...
                   'gui_OutputFcn',  @StatisticTool_OutputFcn, ...
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


% --- Executes just before StatisticTool is made visible.
function StatisticTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StatisticTool (see VARARGIN)

% Choose default command line output for StatisticTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StatisticTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = StatisticTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.edit11,'string');
if isempty(path)
errordlg('Please input the path of data !')
return
end
datause = load(path);
handles.datause.data = datause.dataNorma.data;
handles.datause.dataNoNorma = datause.dataNorma.dataNoNorma;
handles.datause.titleIndex = datause.dataNorma.F.sensorsChosenName;
m = size(datause.dataNorma.data,2);
cmd = strcat(num2str(m), ' vectors intotal');
set(handles.text1,'string',cmd);
guidata(hObject,handles);

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num=get(handles.edit12,'string');
num = str2num(num);
datause = handles.datause.data(:,num);
datauseNoNorma = handles.datause.dataNoNorma(:,num);
handles.datause.vectorchosen = datause;
titleIndex = handles.datause.titleIndex;
titleUse = titleIndex(num);
set(handles.text1,'string',titleUse);
datatemp = [datauseNoNorma datause];
%save('test','datatemp')
% ---------------------------------------------------
% Table 1 
StatisticResult = StatisticTool_ZF(datatemp);

Count = [StatisticResult.Count StatisticResult.Count];
Mean = StatisticResult.Mean;
SE=StatisticResult.StandardError;
SV = StatisticResult.SampleVariance;
Mode = StatisticResult.Mode;
Median = StatisticResult.Median;
Kurtosis = StatisticResult.Kurtosis;
Skewness = StatisticResult.Skewness;
Min = StatisticResult.Min;
Max = StatisticResult.Max;
Range = StatisticResult.Range;
ConfidenceLevel = StatisticResult.ConfidenceLevel;
TableStatistic = [Count;Min;Max;Range;Mean;Median;Mode;SE;SV;Kurtosis;Skewness;ConfidenceLevel];
handles.datause.TableStatistic = TableStatistic ;
%TableStatistic = {num2str(Count);num2str(Min);num2str(Max);num2str(Range);num2str(Mean);num2str(Median);num2str(Mode);num2str(SE);num2str(SV);num2str(Kurtosis);num2str(Skewness)};
set(handles.uitable1,'data',TableStatistic);
% ---------------------------------------------------
% Table2 - Correlation
TableCorrelation = corr(handles.datause.dataNoNorma);
handles.datause.TableCorrelation= TableCorrelation ;
set(handles.uitable2,'data',TableCorrelation);
guidata(hObject,handles);
% ---------------------------------------------------
% axes31 axes32 - Boxplot
newFig = figure('visible','off');
boxplot(datause,'notch','on','whisker',1)
title('Boxplot of Normalized Data')
pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
    return
end
name231 = strcat(pathFig,date,'\BoxplotNormalized');
print(newFig,'-dpng',name231)
saveas(gcf,name231);
hold off

axes(handles.axes31)
boxplot(datause,'notch','on','whisker',1)
title('Boxplot of Normalized Data')
hold off

newFig = figure('visible','off');
boxplot(datauseNoNorma,'notch','on','whisker',1)
title('Boxplot of No-Normalized Data')
pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
    return
end
name232 = strcat(pathFig,date,'\BoxplotNoNormalized');
print(newFig,'-dpng',name232)
saveas(gcf,name232);
hold off


axes(handles.axes32)
boxplot(datauseNoNorma,'notch','on','whisker',1)
title('Boxplot of No-Normalized Data')
hold off
% ---------------------------------------------------
% axes41 axes42 - histogramme
newFig = figure('visible','off');
hist(datause)
title('Histogram of Normalized Data')
pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
    return
end
name241 = strcat(pathFig,date,'\HistogramNormalized');
print(newFig,'-dpng',name241)
saveas(gcf,name241);
hold off


axes(handles.axes41)
hist(datause)
title('Histogram of Normalized Data')
hold off

newFig = figure('visible','off');
hist(datauseNoNorma)
title('Histgram of No-Normalized Data')
pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
    return
end
name242 = strcat(pathFig,date,'\HistogramNoNormalized');
print(newFig,'-dpng',name242)
saveas(gcf,name242);
hold off

axes(handles.axes42)
hist(datauseNoNorma)
title('Histgram of No-Normalized Data')
hold off






% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
TableContents


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit11.
function edit11_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%f = getframe(gcf);
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
Sheet1 = Sheets.Item(3);
Sheet1.Activate;
set(Excel,'StandardFont','Times New Roman')
Sheet1.Range('A1:A2').RowHeight = [24,24];
Sheet1.Range('A1:C1').ColumnWidth = [28,12,12];

Sheet1.PageSetup.TopMargin = 60;
Sheet1.PageSetup.BottomMargin = 45;
Sheet1.PageSetup.LeftMargin = 45;
Sheet1.PageSetup.RightMargin = 45;

Sheet1.Range('A1:F1').MergeCells = 1;
Sheet1.Range('A2:F2').MergeCells = 1;

Sheet1.Range('A4:C4').MergeCells = 1;
Sheet1.Range('A5:F5').MergeCells = 1;
Sheet1.Range('A9:C9').MergeCells = 1;
Sheet1.Range('H9:J9').MergeCells = 1;
Sheet1.Range('A25:C25').MergeCells = 1;
Sheet1.Range('A67:C67').MergeCells = 1;

Sheet1.Range('A1:AB500').HorizontalAlignment=3;

Sheet1.Range('A1').Value = ' Statistic Analysis ';
str = date;
Sheet1.Range('A2').Value = str;
Sheet1.Range('A1:A2').Font.Size = 24;
Sheet1.Range('A1:A2').Font.Bold =2; 

Sheet1.Range('A4').Value = ' 1 Data Chosen ';
Sheet1.Range('A4').Font.Bold =2; 
%Sheet1.Range('A4').BackGroundColor =[243 248 58]; 

path = get(handles.edit11,'string');
Sheet1.Range('A5').Value = path;
Sheet1.Range('A6').Value = ' Total Number of Vectors ';
Sheet1.Range('A5:A7').HorizontalAlignment = 2;

num = size(handles.datause.data,2);
Sheet1.Range('B6').Value = num;
Sheet1.Range('A7').Value = ' Vector Chosen to Analysis';
choose = get(handles.edit12,'string');
Sheet1.Range('B7').Value = choose;

Sheet1.Range('A9').Value = ' 2 Statistic Index ';
Sheet1.Range('A9').Font.Bold =2; 
Sheet1.Range('B10').Value = ' No Norma';
Sheet1.Range('C10').Value = ' Norma ';
Sheet1.Range('A11').Value = ' Count ';
Sheet1.Range('A12').Value = ' Min ';
Sheet1.Range('A13').Value = ' Max ';
Sheet1.Range('A14').Value = ' Range ';
Sheet1.Range('A15').Value = ' Mean ';
Sheet1.Range('A16').Value = ' Median ';
Sheet1.Range('A17').Value = ' Mode ';
Sheet1.Range('A18').Value = ' Standard Error ';
Sheet1.Range('A19').Value = ' Standard Variance ';
Sheet1.Range('A20').Value = ' Kurtosis ';
Sheet1.Range('A21').Value = ' Skewness ';
Sheet1.Range('A22').Value = ' ConfidenceLevel(95%)R ';
Sheet1.Range('A23').Value = ' ConfidenceLevel(95%)L ';
table1 = get(handles.uitable1,'data');
Sheet1.Range('B11:C23').Value = table1;
Sheet1.Range('A11:A23').HorizontalAlignment = 2;

Sheet1.Range('H9').Value = ' 3 Correlation Matrix ';
Sheet1.Range('H9').Font.Bold =2; 
table2 = get(handles.uitable2,'data');
if num>(25-8) %H is 8th
    str0 = char(65);
    str1 = char(65+num-19);
    str1 = strcat(str0,str1);
else
    str1 = char(69+num);%char(65)=A
end

str = strcat('H10:',str1,num2str(10+num-1));
Sheet1.Range(str).Value = table2;


Sheet1.Range('A25').Value = ' 4 Box Plot ';
Sheet1.Range('A25').Font.Bold =2; 
PicturePath = which('figure231.png');
h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,400,400,300);
PicturePath = which('figure232.png');
h2 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,680,400,300);

Sheet1.Range('A67').Value = ' 5 Histogram ';
Sheet1.Range('A67').Font.Bold =2; 
PicturePath = which('figure241.png');
h3 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1040,400,300);
PicturePath = which('figure242.png');
h4 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1340,400,300);

Workbook.Save


% --- Executes on button press in pushbuttonHelp.
function pushbuttonHelp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
filename = [pwd '\toolStatistique.jpg'];
PIC = imread(filename);
image(PIC);
set(gca,'xtick',[],'xticklabel',[]);
set(gca,'ytick',[],'yticklabel',[]);
set(gca,'Units','centimeters','position',[1 1 24 16])
set(gcf,'Units','centimeters','position',[1 1 26 18])
