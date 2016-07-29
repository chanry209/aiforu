function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 11-Sep-2012 11:07:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;
% Update handles structure

guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.main);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
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
pause(1)
%----------------------- ----------------------------
% 1) Import the file Excel
path=handles.datauser.Filenames; % Read the path
if isempty(path)
    set(handles.textLoading,'string','Nothing is requested ?!')
    return
end

% ---------------------------------------------------
% 2) loop of reading files
n = size(path,2); % how many files are readed
resultEX(n).excel = [];
sizeResultNew = zeros(n,2); % the size of each files

% set(handles.listbox2,'string',x)

for i = 1:n
% --------------------------------------------------
% Read the name
    [num text] = xlsread(path{i});
    Lnum = size(num,2);
    Ltext = size(text,2);

    if (i>=2)&&((Lnum~=LnumOld)||(Ltext~=LtextOld))
        str = strcat(['The ',num2str(i),'th file hasn''t same number of sensor as precedent file, you can''t load them in one time ! ']);
        msg1 = msgbox(str,'System Info','warn');
        uiwait(msg1);        
        return
    end
    LnumOld = Lnum;
    LtextOld = Ltext;
    
    if( Lnum+1)~=Ltext
        str = strcat(['The ',num2str(i),'th file has problem, some columns are empty! ']);
        msg1 = msgbox(str,'System Info','warn');
        uiwait(msg1);
        return
    end
    
    titleIndex = text(14,:);
    numCas = strcmp(titleIndex,'CAS1');
    indRule = find(numCas==1);
    nameSensors = titleIndex(2:indRule-1);
    nameCas = titleIndex(indRule:end);
    set(handles.listbox2,'string',nameSensors)
    set(handles.listbox3,'string',nameCas)
    
% --------------------------------------------------
% Manipulation of Data
    text = text(19:end,:);
    text = text(:,2:end);
    num = num(3:end,1:end);
    x = str2double(text);
    y = num;

    if size(x,2)~=size(y,2)
    cmd = strcat('Be careful ! There is problem in the ',num2str(i),'th',' data, maybe some colume is empty !');
    errordlg(cmd);
    return
    end
    % ---------------------------------------------------
    % Delete the sample which is NaN
    x1 = x;
    y1 = y;
    x2 = x;
    y2 = y;
    x3 = x;
    y3 = y;

    x1((isnan(x1)==1))=-1000;
    y1((isnan(y1)==1))=-1000;

    result_temp = x1+y1;
    x2((result_temp==-2000))=-1000; % Nan+Num = Nan, so -2000 means that it is Nan at x and y
    y2((result_temp==-2000))=-1000;
    x3((isnan(x2)==1))=0;
    y3((isnan(y2)==1))=0;

    resultNew = x3+y3;
    sizeResultNew(i,:) = size(resultNew);
    resultEX(i).excel = resultNew;
    %result = [result;resultNew];

end % end of the reading

% Regroup all the data 
if size(sizeResultNew,1)>1
    sizeResult = sum(sizeResultNew);
else
    sizeResult = sizeResultNew;
end
result = zeros(sizeResult(1),sizeResultNew(1,2));
countX1 = 0;

for i = 1:n
    countX2 = sizeResultNew(i,1)+countX1;
    result(countX1+1:countX2,:) = resultEX(i).excel ;
    countX1 = countX2;
end

clear x y x1 y1 x2 y2 x3 y3 resultNew result_temp countX1 countX2 resultEX resultNew sizeResult sizeResultNew num path text
% ---------------------------------------------------
% Verification of Nan
numNan = isnan(result);
numNan = sum(numNan);
if max(numNan)>(2/3*size(result,1))
        msg1 = msgbox('some columns are empty or nearly empty!','System Info','warn');
        uiwait(msg1);    
end
% 3) Organization of Data 

%----------------------------------------------------
% Cut the sample with NaN captor
[m,n] = find(isnan(result)==1); % same size as the data simulation (3 inputs and 21 output)

if isempty(m) == 1
    NumNan = 0;
else
    m = unique(m);
    NumNan = length(m); % ** Number of Nan Examples
    result(m,:) = [];  % remove all the row who(inputs&outpus) inclus the data == Nan 
end

NumData = length(result); % ** Number of useful examples
%----------------------------------------------------
% Classify the ref and the faults

% Treat the cas to indice 
a = result(:,(indRule-1:end)); % all the cas
[m2,n2] = find(isnan(a)==1);
if m2>0
    a(m2,n2) = 0;% if the cas is Nan, make them as 0
end
b = a;
% ---------------------------------------------------
% b(b~=0)=1; 
b(b~=1)=0; %% Modified by Dassault email at le 21 03 2012

% vecteur to indice
[ind,vec_sample,nbSample] = vec2ind_zf(b');
%Goal = ind2vec_zf(ind); 
% set the table of kinds of faults
    set(handles.uitable1,'data',vec_sample);
% Make a name of Faults
load('nameFault');
nameNow = FaultName(vec_sample);
nameNowL= size(nameNow,2);
nameL = size(name,2);

LengthName = 1;
for i = 1:nameNowL
        y = strfind(name,nameNow{i});
        z  = cell2mat(y);
        z = sum(z);
        if (z>1)
            msgbox('Problem! Some fault repeated in the database !');
        else if z==0
            msgbox(strcat('There is new fault : ',nameNow{i}));
            name{nameL + LengthName} = nameNow{i};
            LengthName = LengthName + 1; 
              end
        end
end

% verify there is ref or not
temp = sum(vec_sample);
if min(temp) ~= 0
    msgbox('Attention! There isn''t data of REF, the analysis continues.')
    nbFault = sum(nbSample(1:end));
else
    %msgbox('The data of REF are corresponding to situation 1 in the figures.')
    nbFault = sum(nbSample(2:end));
end

% ---------------------------------------------------
% indice to vecteur
F.result = result(:,(1:indRule-2));
%F.goal = Goal;
F.ind= ind;
F.vec_sample= vec_sample;
F.nbSample= nbSample;
F.nameFault = nameNow;
F.titleIndex = titleIndex;
F.nameSensors = nameSensors;
F.nameCas = nameCas;
%----------------------------------------------------
% Set string of text 1 2 3 4
set(handles.text11,'string',num2str(size(result,2)));
set(handles.text12,'string',num2str(size(result,1)));
set(handles.text13,'string',num2str(NumNan));
set(handles.text14,'string',num2str(size(nbSample,2)));
set(handles.text15,'string',num2str(nbFault));

str1Table = [size(result,2);size(result,1);NumNan;size(nbSample,2);nbFault];
% SAVE
handles.datauser.F = F;
handles.datauser.str1Table = str1Table;
handles.datauser.indNorma = 1;
set(hObject,'string','OK');
pause(1);
set(hObject,'string','LOAD');
% --------------------------------------------------
% Save the data
%save('F_ALL','Fori','F');
save('nameFault','name');
set(handles.textLoading,'string','Loading Completed','BackGroundColor',[1 0 0])
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
    if index==0
        return
    end
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
    
    if isempty(str)
        return
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
    set(handles.radiobutton26,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    hint6 = get(handles.radiobutton26,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0&&hint6==0
       set(handles.radiobutton22,'value',1);
       indNorma = 1;
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
    set(handles.radiobutton26,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    hint6 = get(handles.radiobutton26,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0&&hint6==0
       set(handles.radiobutton22,'value',1);
       indNorma = 1;
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
    set(handles.radiobutton26,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    hint6 = get(handles.radiobutton26,'value');
    
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0&&hint6==0
       set(handles.radiobutton22,'value',1);
       indNorma = 1;
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
    set(handles.radiobutton26,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    hint6 = get(handles.radiobutton26,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0&&hint6==0
       set(handles.radiobutton22,'value',1);
       indNorma = 1;
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
    set(handles.radiobutton26,'value',0);
else
    hint1 = get(handles.radiobutton21,'value');
    hint2 = get(handles.radiobutton22,'value');
    hint3 = get(handles.radiobutton23,'value');
    hint4 = get(handles.radiobutton24,'value');
    hint5 = get(handles.radiobutton25,'value');
    hint6 = get(handles.radiobutton26,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0&&hint6==0
       set(handles.radiobutton22,'value',1);
       indNorma = 1;
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
set(hObject,'string','Wait')
pause(1);
x = handles.datauser.F.sensorsChosen;
ind = handles.datauser.F.sensorsChosenInd;
kind = handles.datauser.indNorma;

if kind==0
    norma = x;
    handles.datauser.datanorma = x;
end

if kind>0
    x=x';
    ymin = get(handles.edit21,'string');
    ymin = str2double(ymin);
    ymax = get(handles.edit22,'string');
    ymax = str2double(ymax);

    [norma,ps] = norma_zf(x,kind,ymin,ymax);
    x = x';
    norma = norma';
    handles.datauser.datanorma = norma;
    handles.datauser.dataNoNorma = x;
    handles.datauser.datanormaPs = ps;
    set(handles.text23,'str','Normalization Completed','BackGroundColor',[1 0 0])
else
    set(handles.text23,'str','No Normalization','BackGroundColor',[1 0 0])
end

iTypeSample = max(ind);
testAll = [];
goalAll = [];

for i=1:iTypeSample
    Situation(i).data = (norma(ind==i,:))';
    Situation(i).GoalInd = i;
    testAll = [testAll Situation(i).data];
    goalAll = [goalAll Situation(i).GoalInd*ones(1,size(Situation(i).data,2))];
end

handles.datauser.Situation = Situation;
handles.datauser.testAll = testAll;
handles.datauser.goalAll = goalAll;
handles.datauser.dataNormaInd = ind;
set(hObject,'string','OK')
pause(1)
set(hObject,'string','Apply')
guidata(hObject,handles)



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
Sheet1.Range('A4').Value = ' 1 - Data Loaded ';
Sheet1.Range('A4').Font.Bold =2; 
path = get(handles.loadpath,'string');
path = cell2mat(path);
Sheet1.Range('A5').Value = path;
Sheet1.Range('B6').Value = ' Count  ';
Sheet1.Range('A7').Value = ' Nb of Vectors ';
Sheet1.Range('A8').Value = ' Nb of Samples ';
Sheet1.Range('A9').Value = ' Nb of Samples NaN (deleted) ';
Sheet1.Range('A10').Value = ' Nb of Kinds of Situations ';
Sheet1.Range('A11').Value = ' Total of Faults ';
str1table = handles.datauser.str1Table;
%Sheet1.Range('B7:B11').Value = str1table;
str = tableWrtieInExcel(str1table,'B','7');
Sheet1.Range(str).Value = str1table;

% Three tables
Sheet1.Range('C6').Value = 'Sensors';
Sheet1.Range('D6').Value = 'Chosen';
Sheet1.Range('E6').Value = 'CAS';
Sheet1.Range('F6').Value = 'Situation';
Sheet1.Range('G6').Value = 'SortCAS';

sensorsTotal = handles.datauser.F.nameSensors;
str = tableWrtieInExcel(sensorsTotal','C','7');
Sheet1.Range(str).Value = sensorsTotal';

sensorsChosen = handles.datauser.F.sensorsChosenName;
str = tableWrtieInExcel(sensorsChosen','D','7');
Sheet1.Range(str).Value = sensorsChosen';

nameCas = handles.datauser.F.nameCas;
str = tableWrtieInExcel(nameCas','E','7');
Sheet1.Range(str).Value = nameCas';

str2table = get(handles.uitable2,'data');
str = tableWrtieInExcel(str2table,'F','7');
Sheet1.Range(str).Value = str2table;

vecSample = handles.datauser.F.vec_sample;
[str,col,raw]= tableWrtieInExcel(vecSample,'G','7');
Sheet1.Range(str).Value = vecSample;
raw = str2double(raw);
% --------------------------------------------------
% % 2 - Notice of normalization
raw = raw+1;
str = strcat('A',num2str(raw),':','C',num2str(raw));
Sheet1.Range(str).MergeCells = 1;
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' 2 - Normalization of Data ';
Sheet1.Range(str).Font.Bold =2; 

raw = raw+1;
ind = handles.datauser.indNorma;
str = strcat('A',num2str(raw),':','C',num2str(raw));
Sheet1.Range(str).MergeCells = 1;
if ind==0
    Sheet1.Range(str).Value = ' Without Normalization ';
else if ind==1
        Sheet1.Range(str).Value = ' Method : Z-Score :  ( x-mean )/std(x) ';
    else if ind==2
            Sheet1.Range(str).Value = ' Method : Centered Values :  x-mean ';
        else if ind==3
                Sheet1.Range(str).Value = ' Method : Between -1 and 1 : (x-mean)/(max-min) ';
            else if ind==4
                    Sheet1.Range(str).Value = ' Method : Between Min and Max : (x-min)/(max-min) ';
                else if ind == 5
                     Sheet1.Range(str).Value = ' Method : Normalization by Norm x/norm(x) ';   
                    end
                end
            end
        end
    end
end

% datause = handles.datauser.datanorma;
% raw = raw+1;
% str = strcat('B',num2str(raw));
% Sheet1.Range(str).Value = 'Min';
% str = strcat('C',num2str(raw));
% Sheet1.Range(str).Value = min(min(datause));
% 
% 
% raw = raw+1;
% str = strcat('B',num2str(raw));
% Sheet1.Range(str).Value = 'Max';
% str = strcat('C',num2str(raw));
% Sheet1.Range(str).Value = max(max(datause));

% % ---------------------------------------------------
% 3 - Application of Normalization
raw = raw + 2;
str = strcat('A',num2str(raw),':','C',num2str(raw));
Sheet1.Range(str).MergeCells = 1;
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' 3 Application of Normalization ';
Sheet1.Range(str).Font.Bold =2; 

raw = raw+1;
data = handles.datauser.F.sensorsChosen;
sizeData = size(data,2);
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' Amount of Sensors : ';
str = strcat('B',num2str(raw));
Sheet1.Range(str).Value = sizeData;

raw = raw+1;
nameSensors = handles.datauser.F.sensorsChosenName;
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' Sensors : ';
str = tableWrtieInExcel(nameSensors,'B',num2str(raw));
Sheet1.Range(str).Value = nameSensors ;

raw = raw + 1;
minData = min(data);
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' Min of data applied : ';
str = tableWrtieInExcel(minData,'B',num2str(raw));
Sheet1.Range(str).Value = minData ;

raw = raw+1;
maxData = max(data);
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' Max of data applied : ';
str = tableWrtieInExcel(maxData,'B',num2str(raw));
Sheet1.Range(str).Value = maxData ;

ind = handles.datauser.Test.indOut;
if ind == 1
raw = raw+2;
dataTemp = handles.datauser.Test.outBoundMin;
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' SensorsMin ouf of Bound : ';
str = tableWrtieInExcel(dataTemp,'B',num2str(raw));
Sheet1.Range(str).Value = dataTemp ;

raw = raw+1;
dataTemp = handles.datauser.Test.outBoundMax;
str = strcat('A',num2str(raw));
Sheet1.Range(str).Value = ' SensorsMax ouf of Bound : ';
str = tableWrtieInExcel(dataTemp,'B',num2str(raw));
Sheet1.Range(str).Value = dataTemp ;
end
Workbook.Save

% --- Executes on button press in SaveAPP.
function SaveAPP_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAPP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname index] = uiputfile({'*.mat'},'Save as','dataTest.mat');
if  index ==0
    return
end

dataNorma.data = handles.datauser.Test.data;
dataNorma.dataNoNorma = handles.datauser.Test.dataNoNorma;
dataNorma.PS = handles.datauser.Test.Ps ;
dataNorma.indNorma = handles.datauser.Test.indNorma  ;
dataNorma.F.sensorsChosenName = handles.datauser.F.sensorsChosenName;

indGoalTestAll = handles.datauser.Test.F.ind;
indGoalTestAll(indGoalTestAll~=1)=2;

dataNorma.indGoal = handles.datauser.Test.F.ind;
dataNorma.indGoalTestAll = indGoalTestAll;

set(hObject,'string','OK');
save([pathname filename],'dataNorma');
pause(1);
set(handles.SaveAPP,'String','Save');
guidata(hObject,handles)


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.mat'});
if pathname == 0
    msgbox('Please load one file mat !')
    return
end
dataUse = load([pathname filename]);
handles.datauser.datause.data = dataUse.dataNorma.data;
datagoal = dataUse.dataNorma.goal;
 [ind,vec_sample,nbSample] = vec2ind_zf(datagoal);
handles.datauser.datause.goal = ind-1;
guidata(hObject,handles);

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.mat'});
if pathname == 0
    msgbox('Please load one file mat !')
    return
end
dataUse = load([pathname filename]);
handles.datauser.datause.data = dataUse.dataNorma.data;
datagoal = dataUse.dataNorma.goal;
 [ind,vec_sample,nbSample] = vec2ind_zf(datagoal);
handles.datauser.datause.goal = ind-1;
guidata(hObject,handles);


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
sel  = get(gcf,'selectiontype');
strList = get(handles.listbox5,'string');
% strListVeri = fieldnames(handles.datauser.F);
% resultVeri = sum(strcmp(strListVeri,'strList'));

if isempty(strList)
    strListNum = [];
    strList = [];
else if ~isempty(strList)
        lengthStrList = length(strList);
        strListNum = zeros(lengthStrList,1);
        for i = 1:lengthStrList
            name = strList(i);
            veriName = strcmp(handles.datauser.F.nameSensors,name);
            strListNum(i)=find(veriName==1);
        end
    end
end

if strcmp(sel,'open')
    str = get(hObject,'string');
    n = get(hObject,'value');
    strList{end+1} = str{n};
    strListNum = [strListNum;n];
    set(handles.listbox5,'string',strList);
end
handles.datauser.F.strListNum = strListNum;
handles.datauser.F.strList = strList;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5
sel  = get(gcf,'selectiontype');

if strcmp(sel,'open')
    strList = get(hObject,'string');
    if isempty(strList)
        return
    else
        strList = get(handles.listbox5,'string');
        lengthStrList = length(strList);
        strListNum = zeros(lengthStrList,1);
        for i = 1:lengthStrList
            name = strList(i);
            veriName = strcmp(handles.datauser.F.nameSensors,name);
            strListNum(i)=find(veriName==1);
        end       
        n = get(hObject,'value');
        strList(n) = '';
        strListNum(n) = [];
        set(handles.listbox5,'string',strList,'value',max(1,n-1));
        handles.datauser.F.strListNum = strListNum;
        handles.datauser.F.strList = strList;
    end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1_1.
function pushbutton1_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
strList = get(handles.listbox5,'string');

if isempty(strList)
    msg1 = msgbox('There isn''t any sensors chosen!','systInfo','Warn');
    uiwait(msg1);
    return

else
        lengthStrList = length(strList);
        strListNum = zeros(lengthStrList,1);
        for i = 1:lengthStrList
            name = strList(i);
            veriName = strcmp(handles.datauser.F.nameSensors,name);
            strListNum(i)=find(veriName==1);
        end
end

numChosenTemp = strListNum;
nameChosenTemp = handles.datauser.F.nameSensors;

numChosen = unique(numChosenTemp);
nameChosen = nameChosenTemp(numChosen);
nameChosen = nameChosen';
if length(numChosenTemp)~=length(numChosen)
    msg1 = msgbox('Some same sensors are duplicated selection ! ','System Info','warn');
    uiwait(msg1);   
end

sensorsChosen = handles.datauser.F.result(:,numChosen);
handles.datauser.F.sensorsChosen= sensorsChosen;
handles.datauser.F.strListNum = numChosen;
handles.datauser.F.strList = nameChosen;

handles.datauser.F.sensorsChosenName= nameChosen' ;

set(handles.listbox5,'string',nameChosen);
guidata(hObject,handles);


% --- Executes on button press in pushbutton1_2.
function pushbutton1_2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result = handles.datauser.F.result;
numChosen = 1:size(result,2);
numChosen = numChosen';
strName = handles.datauser.F.nameSensors;
set(handles.listbox5,'string',strName);

sensorsChosen = handles.datauser.F.result;
handles.datauser.F.sensorsChosen= sensorsChosen;
handles.datauser.F.sensorsChosenName = strName;
handles.datauser.F.strListNum = numChosen;
handles.datauser.F.strList = strName;
guidata(hObject,handles);


% --- Executes on button press in pushbutton1_3.
function pushbutton1_3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
goalInd = handles.datauser.F.ind;
maxInd = max(goalInd);
countInd = zeros(maxInd,1);
for i = 1:maxInd
    countInd(i) = numel(goalInd(goalInd==i));
end
set(handles.uitable2,'data',countInd);
set(handles.pushbutton1_3,'string','OK');
handles.datauser.F.sensorsChosenInd = goalInd;
% ----------------------
% pre set the index of Bound out
handles.datauser.Test.indOut = 0;
guidata(hObject,handles);



function edit_del_Callback(hObject, eventdata, handles)
% hObject    handle to edit_del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_del as text
%        str2double(get(hObject,'String')) returns contents of edit_del as a double


% --- Executes during object creation, after setting all properties.
function edit_del_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_merger1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_merger1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_merger1 as text
%        str2double(get(hObject,'String')) returns contents of edit_merger1 as a double


% --- Executes during object creation, after setting all properties.
function edit_merger1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_merger1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_del.
function pushbutton_del_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nbDel = str2double(get(handles.edit_del,'String'));
data = handles.datauser.F.sensorsChosen;
if isempty(data)
   msg1 = msgbox('There isn''t any data !','infoSyst','Warn');
   uiwait(msg1);
   return
end
goalInd = handles.datauser.F.sensorsChosenInd;

if (isempty(nbDel))||(nbDel>max(goalInd))||(nbDel<1)
    msg1 = msgbox('Check the nb of class to be delected !','infoSyst','Warn');
    uiwait(msg1);
    return
end

numSampleDel = find(goalInd==nbDel);
data(numSampleDel,:)=[];
goalInd(numSampleDel)=[];
numBiger=find(goalInd>nbDel);
if ~isempty(numBiger)
    goalInd(numBiger) = goalInd(numBiger)-1;
end

handles.datauser.F.sensorsChosen = data;
handles.datauser.F.sensorsChosenInd = goalInd;

% show in the table
maxInd = max(goalInd);
countInd = zeros(maxInd,1);
for i = 1:maxInd
    countInd(i) = numel(goalInd(goalInd==i));
end
set(handles.uitable2,'data',countInd);

guidata(hObject,handles)

% --- Executes on button press in pushbutton_merger.
function pushbutton_merger_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_merger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
merger1 = str2double(get(handles.edit_merger1,'String'));
merger2 = str2double(get(handles.edit_merger2,'String'));

goalInd = handles.datauser.F.sensorsChosenInd;

if (merger1>max(goalInd))||(merger1<1)||(merger2>max(goalInd))||(merger2<1)||(merger1==merger2)
    msg1 = msgbox('Percentage must be a value between 0 and 1 !','infoSyst','Warm');
    uiwait(msg1);
    return
end

goalInd(goalInd==merger2)=merger1;

numBiger=find(goalInd>merger2);
if ~isempty(numBiger)
    goalInd(numBiger) = goalInd(numBiger)-1;
end
handles.datauser.F.sensorsChosenInd = goalInd;

% show in the table
maxInd = max(goalInd);
countInd = zeros(maxInd,1);
for i = 1:maxInd
    countInd(i) = numel(goalInd(goalInd==i));
end
set(handles.uitable2,'data',countInd);

guidata(hObject,handles)


function edit_merger2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_merger2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_merger2 as text
%        str2double(get(hObject,'String')) returns contents of edit_merger2 as a double


% --- Executes during object creation, after setting all properties.
function edit_merger2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_merger2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_saveDataOri.
function pushbutton_saveDataOri_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_saveDataOri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uiputfile({'*.mat'},'Save as','DataOri.mat');
if filename==0
    return
end
data = handles.datauser.F;
set(hObject,'string','OK');
save([pathname filename],'data');


% --- Executes on button press in radiobutton26.
function radiobutton26_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton26
Hint_26 = get(hObject,'Value');
if Hint_26 == 1
    indNorma = 5;% choose which normalization to use
    set(handles.radiobutton21,'value',0);
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
    hint6 = get(handles.radiobutton26,'value');
    if hint1==0&&hint2==0&&hint3==0&&hint4==0&&hint5==0&&hint6==0
       set(handles.radiobutton22,'value',1);
       indNorma = 1;
    end
end
handles.datauser.indNorma = indNorma;
guidata(hObject,handles)

% --- Executes on button press in pushbuttonSaveNorma.
function pushbuttonSaveNorma_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSaveNorma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname index] = uiputfile({'*mat'},'Save as','dataAppr.mat');
set(hObject,'string','Wait')
pause(1)
if  index==0
    return
end
dataNorma.data = handles.datauser.datanorma;
dataNorma.dataNoNorma = handles.datauser.dataNoNorma;
dataNorma.Situation = handles.datauser.Situation;
dataNorma.Ps  = handles.datauser.datanormaPs;
dataNorma.indNorma = handles.datauser.indNorma;
dataNorma.dataNormaInd = handles.datauser.dataNormaInd;
dataNorma.sensorsChosenName = handles.datauser.F.sensorsChosenName;
dataNorma.F = handles.datauser.F;
dataNorma.testAll = handles.datauser.testAll;
dataNorma.goalAll = handles.datauser.goalAll;

set(hObject,'string','OK');
pause(1)
set(hObject,'string','Save')

save([pathname filename],'dataNorma');



function edit3_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_1 as text
%        str2double(get(hObject,'String')) returns contents of edit3_1 as a double


% --- Executes during object creation, after setting all properties.
function edit3_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonLoadPS.
function pushbuttonLoadPS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%----------------------- ----------------------------
% 1) Import the file Excel
path=handles.datauser.FilenamesPs; % Read the path
if isempty(path)
    msg1 = msgbox('Rules of data treated are needed!','infoSyst','Warn');
    uiwait(msg1);
    return
end

appNormaPs = load(path);
Ps = appNormaPs.dataNorma.Ps;
maxData = max(appNormaPs.dataNorma.dataNoNorma);
minData = min(appNormaPs.dataNorma.dataNoNorma);
sizeSensors = size(appNormaPs.dataNorma.data,2);
indNorma = appNormaPs.dataNorma.indNorma;

handles.datauser.APP.Ps = Ps;
handles.datauser.APP.maxData = maxData;
handles.datauser.APP.minData = minData;
handles.datauser.APP.sizeSensors = sizeSensors;
handles.datauser.APP.indNorma = indNorma;

strNotice = strcat(['1: Number of sensors - ', num2str(sizeSensors),10,...,
    '2: Type of Normalization - ', num2str(indNorma),'; ',10,...,
    '3: Min of sensors : ',num2str(minData),' ',10,...,
    '4: Max of sensors : ',num2str(maxData)]);

set(handles.text3_1,'string',strNotice);
set(hObject,'string','OK');
pause(1);
set(handles.pushbuttonLoadPS,'String','Upload');
guidata(hObject,handles);





% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit3_1.
function edit3_1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit3_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path] = uigetfile({'*.mat'},'File Selector');
    if file==0
        return;
    end
    str = [path file];
    set(hObject,'string',str);
   
    if isempty(str)
        return
    end
    handles.datauser.FilenamesPs = str;
end

guidata(hObject,handles);


% --- Executes on button press in ApplyAPP.
function ApplyAPP_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyAPP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = handles.datauser.F;
data = F.sensorsChosen;

Ps = handles.datauser.APP.Ps;
minDataAPP = handles.datauser.APP.minData;
maxDataAPP = handles.datauser.APP.maxData;
indNorma = handles.datauser.APP.indNorma;
minData = min(data);
maxData = max(data);

if length(minData)~=length(minDataAPP)
   str1 = strcat('Attention ! The size of test data and learning data are different.');
   msg1 = msgbox(str1,'infoSyst','Warn');
   uiwait(msg1);
    return
end


mMin  = find(minData<minDataAPP);
mMax = find(maxData>maxDataAPP);
handles.datauser.Test.outBoundMin = mMin;
handles.datauser.Test.outBoundMax = mMax;

if (~isempty(mMin))||(~isempty(mMax))
    str1 = strcat('Attention ! Some measurement of sensors are out of the bounds of learning data, but the works will be continue. Verify the min of these sensors : ',num2str(mMin),' ; ',10,'Verify the max of these sensors : ',num2str(mMax));
    msg1 = msgbox(str1,'infoSyst','Warn');
    uiwait(msg1);
    handles.datauser.Test.indOut = 1;
end

data = data';
normal = norma_apply_zf(data,Ps,indNorma);
normal = normal';
handles.datauser.Test.F=F;
handles.datauser.Test.data = normal;
handles.datauser.Test.dataNoNorma = data';
handles.datauser.Test.Ps = Ps;
handles.datauser.Test.indNorma = indNorma;

set(handles.ApplyAPP,'String','OK');
pause(1);
set(handles.ApplyAPP,'String','Apply');
guidata(hObject,handles)


% --- Executes on button press in nextPage.
function nextPage_Callback(hObject, eventdata, handles)
% hObject    handle to nextPage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(Main)
Main1_2


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=handles.datauser.FilenamesNorma; % Read the path
set(hObject,'string','wait');
pause(1)

if isempty(path)
    msg1 = msgbox('Data treated are needed!','infoSyst','Warn');
    uiwait(msg1);
    return
end

x = load(path);
handles.datauser.F = x.data;
handles.datauser.indNorma = 1;
set(hObject,'string','OK');
pause(1)
set(hObject,'string','Load');
guidata(hObject,handles);



function edit9_Callback(hObject, eventdata, ~)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit9.
function edit9_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path] = uigetfile({'*.mat'},'File Selector');
    if file==0
        return;
    end
    str = [path file];
    set(hObject,'string',str);
   
    if isempty(str)
        return
    end
    handles.datauser.FilenamesNorma = str;
end

guidata(hObject,handles);



function loadpath_Callback(hObject, eventdata, handles)
% hObject    handle to loadpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loadpath as text
%        str2double(get(hObject,'String')) returns contents of loadpath as a double
