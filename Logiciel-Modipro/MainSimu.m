function varargout = MainSimu(varargin)
% MAINSIMU MATLAB code for MainSimu.fig
%      MAINSIMU, by itself, creates a new MAINSIMU or raises the existing
%      singleton*.
%
%      H = MAINSIMU returns the handle to a new MAINSIMU or the handle to
%      the existing singleton*.
%
%      MAINSIMU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINSIMU.M with the given input arguments.
%
%      MAINSIMU('Property','Value',...) creates a new MAINSIMU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainSimu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainSimu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainSimu

% Last Modified by GUIDE v2.5 24-Mar-2012 13:15:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainSimu_OpeningFcn, ...
                   'gui_OutputFcn',  @MainSimu_OutputFcn, ...
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


% --- Executes just before MainSimu is made visible.
function MainSimu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainSimu (see VARARGIN)

% Choose default command line output for MainSimu
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainSimu wait for user response (see UIRESUME)
% uiwait(handles.mainsimu);


% --- Outputs from this function are returned to the command line.
function varargout = MainSimu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function loadpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.textLoading,'string','Loading.................')
pause(1);
name = get(handles.edit1_1,'string');
if isempty(name)
    set(handles.textLoading,'string','Name of class is requested !')
    return
end
%----------------------- ----------------------------
% 1) Import the file Excel
path=handles.datauser.Filenames; % Read the path
if isempty(path)
    set(handles.textLoading,'string','Nothing is requested ?!')
    return
end

% ---------------------------------------------------
% 2) loop of reading files
n = size(path,2);
resultEX(n).Excel = [];
sizeResultNew = zeros(n,2); % How many files are red


for i = 1:n
    [num txt] = xlsread(path{i});
    num(:,1:4)=[];
    num(1:2,:) = [];
    resultEX(i).Excel = num;
    sizeResultNew(i,:) = size(num);
end
sizeResult = sum(sizeResultNew);
y = zeros(sizeResult(1),sizeResultNew(1,2));

count1 = 0;

for i = 1:n
    count2 = sizeResultNew(i,1)+count1;
    y(count1+1:count2,:) = resultEX(i).Excel ;
    count1 = count2;
end
set(handles.text1_2,'string',name);
set(handles.text1_4,'string',num2str(size(y,1)));
set(handles.text1_6,'string',num2str(size(y,2)));
set(handles.textLoading,'string','Loading Completed','BackGroundColor',[1 0 0])
save(name,'y','name');
guidata(hObject,handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadpath.
function loadpath_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path index ] = uigetfile({'*.xls';'*.xlsx'},'File Selector','MultiSelect','on');
       
    if (index)&&(ischar(file)) 
        str{1} = [path file];
        set(hObject,'string',str);
    end
    
    if (index)&&(iscell(file)) 
        n = length(file);
        for j = 1:n
        str{j} = [path file{j}];
        end
        set(hObject,'string',str);
    end
    
    handles.datauser.Filenames = str;
end

guidata(hObject,handles);


% --- Executes on button press in radiobutton23.
function radiobutton23_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton23
Hint_23 = get(hObject,'Value');
if Hint_23 == 1
    indNorma  = 2;
    set(handles.radiobutton21,'value',0);
    set(handles.radiobutton22,'value',0);
    set(handles.radiobutton24,'value',0);
    set(handles.radiobutton25,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0
       set(handles.radiobutton21,'value',1);
    end
end
handles.datauser.indNorma = indNorma;
guidata(hObject,handles);


% --- Executes on button press in radiobutton22.
function radiobutton22_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton22
Hint_22 = get(hObject,'Value');
if Hint_22 == 1
    indNorma  = 1;
    set(handles.radiobutton21,'value',0);
    set(handles.radiobutton23,'value',0);
    set(handles.radiobutton24,'value',0);
    set(handles.radiobutton25,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0
       set(handles.radiobutton21,'value',1);
    end
end
handles.datauser.indNorma = indNorma;
guidata(hObject,handles)

% --- Executes on button press in radiobutton24.
function radiobutton24_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton24
Hint_24 = get(hObject,'Value');
if Hint_24 == 1
    indNorma  = 3;
    set(handles.radiobutton21,'value',0);
    set(handles.radiobutton22,'value',0);
    set(handles.radiobutton23,'value',0);
    set(handles.radiobutton25,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0
       set(handles.radiobutton21,'value',1);
    end
end
handles.datauser.indNorma = indNorma;
guidata(hObject,handles)

% --- Executes on button press in radiobutton21.
function radiobutton21_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton21
Hint_21 = get(hObject,'Value');
if Hint_21 == 1
    indNorma  = 0;
    set(handles.radiobutton22,'value',0);
    set(handles.radiobutton23,'value',0);
    set(handles.radiobutton24,'value',0);
    set(handles.radiobutton25,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0
       set(handles.radiobutton21,'value',1);
    end
end
handles.datauser.indNorma = indNorma;
guidata(hObject,handles)

% --- Executes on button press in radiobutton25.
function radiobutton25_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton25
Hint_25 = get(hObject,'Value');
if Hint_25 == 1
    indNorma = 4;% choose which normalization to use
    set(handles.radiobutton21,'value',0);
    set(handles.radiobutton22,'value',0);
    set(handles.radiobutton23,'value',0);
    set(handles.radiobutton24,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0
       set(handles.radiobutton21,'value',1);
    end
end
handles.datauser.indNorma = indNorma;
guidata(hObject,handles)


function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text23,'string','Running....')
pause(0.1);
x = handles.datauser.data;
Goal = handles.datauser.goal;
kind = handles.datauser.indNorma;
ind = handles.datauser.goalInd;
indVector = ind2vec_zf(ind);
maxData = min(x); 
minData = max(x);

if kind==0
    norma = x;
    handles.datauser.datanorma = x;
end

if kind>0
ymin = get(handles.edit21,'string');
ymin = str2double(ymin);
ymax = get(handles.edit22,'string');
ymax = str2double(ymax);

[norma,ps] = norma_zf(x,kind,ymin,ymax);
handles.datauser.datanorma = norma;
handles.datauser.dataNonorma = x;
handles.datauser.datanormaPs = ps;
handles.datauser.datanormaRules.min = minData;
handles.datauser.datanormaRules.max = maxData;
handles.datauser.datanormaVecGoal = indVector;

set(handles.text23,'str','Normalization Completed','BackGroundColor',[1 0 0])
else
set(handles.text23,'str','No Normalization','BackGroundColor',[1 0 0])
end
iTypeSample = max(ind);

Situation(iTypeSample).data = [];
for i=1:iTypeSample
    Situation(i).data = (norma(ind==i,:))';
    Situation(i).Goal = Goal(ind==i);
    Situation(i).GoalVector = indVector(:,ind==i);
    Situation(i).GoalInd = repmat(i,size(Situation(i).GoalVector,2),1);
end

handles.datauser.Situation = Situation;
set(hObject,'string','OK')
guidata(hObject,handles)



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
TableContents;

% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11
sel = get(hObject,'Value');
if sel==2
    data_temp = handles.datauser.datause.iAiw1;
    goal = handles.datauser.datause.iAiw1Goal;
    ind = handles.datauser.datause.iAiw1IndGoal;
else if sel ==3
    data_temp = handles.datauser.datause.iAiw1(:,5:end);
    goal = handles.datauser.datause.iAiw1Goal;
    ind = handles.datauser.datause.iAiw1IndGoal;
    else if sel==4
        data_temp = handles.datauser.datause.iAiw0;   
        goal = handles.datauser.datause.iAiw0Goal;
        ind = handles.datauser.datause.iAiw0IndGoal;
        else if sel==5
                data_temp = handles.datauser.datause.iAiw0(:,5:end);
                goal = handles.datauser.datause.iAiw0Goal;
                ind = handles.datauser.datause.iAiw0IndGoal;
            else if sel==1
                    errordlg('Please choose the data to analysis !')
                end
            end
        end
    end
end
handles.datauser.str1choose = sel;
handles.datauser.data=data_temp;
handles.datauser.goal=goal;
handles.datauser.goalInd=ind;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str1 = char(date);
str2 = strcat('Result_',str1,'.xls');
filespec_user = [pwd str2];

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
Sheet1 = Sheets.Item(1);
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
Sheet1.Range('A1').Value = ' Primary Analysis of Data ';
str = date;
Sheet1.Range('A2').Value = str;
Sheet1.Range('A1:A2').Font.Size = 24;
Sheet1.Range('A1:A2').Font.Bold =2; 
% --------------------------------------------------
% 1 Data Loaded
Sheet1.Range('A4:C4').MergeCells = 1;
Sheet1.Range('A5:F5').MergeCells = 1;
Sheet1.Range('B12:C12').MergeCells = 1;
Sheet1.Range('A4').Value = ' 1 - Data Loaded ';
Sheet1.Range('A4').Font.Bold =2; 
path = get(handles.loadpath,'string');
Sheet1.Range('A5').Value = path;
Sheet1.Range('B6').Value = ' Original  ';
Sheet1.Range('C6').Value = ' As Simu ';
Sheet1.Range('A7').Value = ' Nb of Vectors ';
Sheet1.Range('A8').Value = ' Nb of Samples ';
Sheet1.Range('A9').Value = ' Nb of Samples NaN (deleted) ';
Sheet1.Range('A10').Value = ' Nb of Kinds of Faults ';
Sheet1.Range('A11').Value = ' Total of Faults ';
str1table = handles.datauser.Str1Table;
Sheet1.Range('B7:C11').Value = str1table;
Sheet1.Range('A12').Value = ' Pretreatment  of Data ';
sel = handles.datauser.str1choose;
if sel==2 
Sheet1.Range('B12').Value = ' Raw Data with Inputs ';
else if sel==3
      Sheet1.Range('B12').Value =  'Raw Data without Inputs';
    else if sel==4
            Sheet1.Range('B12').Value = 'New Data as Simu with Inputs';
        else if sel == 5
                Sheet1.Range('B12').Value = 'New Data as Simu without Inputs';
            end
        end
    end
end
Sheet1.Range('A5:A12').HorizontalAlignment = 2;
Sheet1.Range('B7:C12').HorizontalAlignment = 4;

% --------------------------------------------------
% 2 - Notice of normalization
Sheet1.Range('A14:C14').MergeCells = 1;
Sheet1.Range('A14').Value = ' 2 - Normalization of Data ';
Sheet1.Range('A14').Font.Bold =2; 
ind = handles.datauser.indNorma;
Sheet1.Range('A15:C15').MergeCells = 1;
if ind==0
    Sheet1.Range('A15').Value = ' Without Normalization ';
else if ind==1
        Sheet1.Range('A15').Value = ' Method : Z-Score :  ( x-mean )/std(x) ';
    else if ind==2
            Sheet1.Range('A15').Value = ' Method : Centered Values :  x-mean ';
        else if ind==3
                Sheet1.Range('A15').Value = ' Method : Between -1 and 1 : (x-mean)/(max-min) ';
            else if ind==4
                    Sheet1.Range('A15').Value = ' Method : Between Min and Max : (x-min)/(max-min) ';
                end
            end
        end
    end
end
Sheet1.Range('B16').Value = 'Min';
Sheet1.Range('B17').Value = 'Max';
datause = handles.datauser.datanorma;
Sheet1.Range('C16').Value = min(min(datause));
Sheet1.Range('C17').Value = max(max(datause));
% ---------------------------------------------------
% 3 - LDA
Sheet1.Range('A19:C19').MergeCells = 1;
Sheet1.Range('A19').Value = ' 3 Curve of Linear Discirminant Analysis - (LDA) ';
Sheet1.Range('A19').Font.Bold =2; 
PicturePath = which('figure131.png');
h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,310,460,320);
PicturePath = which('figure132.png');
h2 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,640,460,320);

% ---------------------------------------------------
% 4 - PCA
Sheet1.Range('A66:C66').MergeCells = 1;
Sheet1.Range('A66').Value = ' 4 - Principal Component Analysis - (PCA) ';
Sheet1.Range('A66').Font.Bold =2; 
PicturePath = which('figure141.png');
h3 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1020,460,320);
PicturePath = which('figure142.png');
h4 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1360,460,320);

Workbook.Save

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = handles.datauser.datause.data;
Goal = handles.datauser.datause.goal;
indGoal = handles.datauser.datause.indGoal;
name = handles.datauser.datause.name;
%save('test','Data','Goal')
LDA_ZF = LDA_ZF_29112011(Data,indGoal);
n = max(unique(LDA_ZF.Goal));
y(n).data = [];
Name{n} = [];
for i=1:n
    y(i).data = LDA_ZF.DataNew(indGoal==i,:);
    x = name{i};
    Name(i) = x(1);
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




% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yy = handles.datauser.datause.data;
Goal_ACP = handles.datauser.datause.indGoal;
name = handles.datauser.datause.name;

% yy = handles.datauser.datause.data;
% Goal_ACP = handles.datauser.datause.goal;
% save('Test11JAn','yy','Goal_ACP')
%Goal_ACP = vec2ind_zf(Goal);
[vectors, coeff, newValue0, ValueForDraw,percent_explained] = acp_zf(yy,99,0);
% Figure of Percent Explained
newFig = figure('visible','off');
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis')
print(newFig,'-dpng','figure141')

axes(handles.axes41)
%pareto(handles.axes41,percent_explained);
%pareto(percent_explained);
bar(percent_explained(1:size(newValue0,2)));
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis (Threshould = 99%)')

% Figure on 2D
n = max(unique(Goal_ACP));
y(n).data = [];
Name{n} = [];
for i=1:n
    y(i).data = newValue0(Goal_ACP==i,:);
    x = name{i};
    Name(i) = x(1);
    %Name{i} = strcat('Situation ',num2str(i));
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
    print(newFig,'-dpng','figure142')
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
    
% --- Executes on button press in MatFile.
function MatFile_Callback(hObject, eventdata, handles)
% hObject    handle to MatFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uiputfile({'*.mat'},'Save as','Data1.mat');
dataNorma.data = handles.datauser.datanorma;
dataNorma.goal = handles.datauser.goal;
dataNorma.dataNoNorma = handles.datauser.dataNonorma;
dataNorma.Situation = handles.datauser.Situation;
dataNorma.Ps  = handles.datauser.datanormaPs;
dataNorma.Rules = handles.datauser.datanormaRules;
dataNorma.VecGoal = handles.datauser.datanormaVecGoal;
dataNorma.indNorma = handles.datauser.indNorma;
dataNorma.select = handles.datauser.str1choose;
dataNorma.IndGoal = handles.datauser.goalInd;
dataNorma.nameFix = handles.datauser.datause.nameFix;
save([pathname filename],'dataNorma');

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.mat'});
dataUse = load([pathname filename]);
handles.datauser.datause.data = dataUse.dataNorma.data;
handles.datauser.datause.goal = dataUse.dataNorma.goal;
handles.datauser.datause.indGoal = dataUse.dataNorma.IndGoal;
handles.datauser.datause.name = dataUse.dataNorma.nameFix;
% [ind,vec_sample,nbSample] = vec2ind_zf(datagoal);
% handles.datauser.datause.goal = ind-1;
guidata(hObject,handles);

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.mat'});
dataUse = load([pathname filename]);
handles.datauser.datause.data = dataUse.dataNorma.data;
handles.datauser.datause.goal = dataUse.dataNorma.goal;
handles.datauser.datause.indGoal = dataUse.dataNorma.IndGoal;
handles.datauser.datause.name = dataUse.dataNorma.nameFix;
% [ind,vec_sample,nbSample] = vec2ind_zf(datagoal);
% handles.datauser.datause.goal = ind-1;

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



function edit1_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_1 as text
%        str2double(get(hObject,'String')) returns contents of edit1_1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit1_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1_1.
function pushbutton1_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
set(handles.textLoading,'string','Assemblying.................')
pause(1);
%----------------------- ----------------------------
% 1) Import the file Excel
path=handles.datauser.Filenames; % Read the path
if isempty(path)
    set(handles.textLoading,'string','Nothing is requested ?!')
    return
end

n = size(path,2);
result(n).data = [];
% sizeResultNew = zeros(n,2); % How many files are red
m = zeros(1,n);
for i = 1:n
    data = load(path{i});
    result(i).data = data.y;
    result(i).name = repmat({data.name},size(result(i).data,1),1);
    result(i).nameFix = {data.name};
    m(i) = size(result(i).data,1);
    result(i).ind = repmat(i,size(result(i).data,1),1);
end
    mTotal = sum(m);
    dataTotal = zeros(mTotal,size(result(1).data,2));
    goalTotal = repmat({'None'},mTotal,1);
    goalIndTotal = zeros(mTotal,1);
    count1 = 0;
    nameFix = repmat({'None'},n,1);
for i=1:n
        count2 = size(result(i).data)+count1;
        dataTotal(count1+1:count2,:) = result(i).data;
        goalTotal(count1+1:count2) = result(i).name;
        goalIndTotal(count1+1:count2) = result(i).ind;
        nameFix(i) = {result(i).name};
        count1 = count2;
end

RecherchSuper = zeros(mTotal,1);
Position(mTotal).num = [];

for i=1:mTotal
temp1 = 0;
temp = [];

    for j = 1:mTotal
        if(dataTotal(j,:)==dataTotal(i,:))

        Position(i).num = [temp,j];
        temp = Position(i).num ;
        RecherchSuper(i)=temp1+1;
        temp2 = temp1+1;
        temp1 = temp2;

        end
    end

end
NbSuperIO = length(find(RecherchSuper~=1));
SuperposeIO.Nb = NbSuperIO;
SuperposeIO.Position = Position;
SuperposeIO.RecherchSuper = RecherchSuper;

DataIO.DataOri = dataTotal;
DataIO.ClassOri = goalTotal;
DataIO.GoalIndOri = goalIndTotal;
DataIO.DataCut = dataTotal((RecherchSuper==1),:);
DataIO.ClassCut = goalTotal(RecherchSuper==1);
DataIO.ClassIndCut = goalIndTotal(RecherchSuper==1);

[iAiw0Index,temp] = find(DataIO.DataCut(:,4)==0);
[iAiw1Index,temp] = find(DataIO.DataCut(:,4)==1);
   
dataOutput_iAiw_0 = DataIO.DataCut(iAiw0Index,:);
goalOutput_iAiw_0 = DataIO.ClassCut(iAiw0Index,:);
goalIndOutput_iAiw_0 = DataIO.ClassIndCut(iAiw0Index,:);

dataOutput_iAiw_1 = DataIO.DataCut(iAiw1Index,:);
goalOutput_iAiw_1 = DataIO.ClassCut(iAiw1Index,:);
goalIndOutput_iAiw_1 = DataIO.ClassIndCut(iAiw1Index,:);

dataOutput_iAiw_1(:,[4,8,14,20])=[];
dataOutput_iAiw_0(:,[4,8,14,20,12,13,15,16,17,28,30])=[];

handles.datauser.datause.iAiw0 =  dataOutput_iAiw_0;
handles.datauser.datause.iAiw0Goal = goalOutput_iAiw_0;
handles.datauser.datause.iAiw0IndGoal = goalIndOutput_iAiw_0;

handles.datauser.datause.iAiw1 = dataOutput_iAiw_1;
handles.datauser.datause.iAiw1Goal = goalOutput_iAiw_1;
handles.datauser.datause.iAiw1IndGoal = goalIndOutput_iAiw_1;

DataIO.DataOri(:,[8,14,20]) = [];
handles.datauser.datause.All = DataIO.DataOri; 
handles.datauser.datause.AllGoal = DataIO.ClassOri;
handles.datauser.datause.SuperposeIO = SuperposeIO;
handles.datauser.datause.nameFix =nameFix;
set(handles.textLoading,'string','Assemblage completed !')
guidata(hObject,handles);
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit1_2.

function edit1_2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path index ] = uigetfile({'*.mat'},'File Selector','MultiSelect','on');
    
    if (index)&&(ischar(file)) 
        str{1} = [path file];
        set(hObject,'string',str);
    end
    
    if (index)&&(iscell(file)) 
        n = length(file);
        for j = 1:n
        str{j} = [path file{j}];
        end
        set(hObject,'string',str);
    end
    
    handles.datauser.Filenames = str;
end

guidata(hObject,handles);


% --- Executes on button press in pushbutton41.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
