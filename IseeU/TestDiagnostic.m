function varargout = TestDiagnostic(varargin)
% TESTDIAGNOSTIC MATLAB code for TestDiagnostic.fig
%      TESTDIAGNOSTIC, by itself, creates a new TESTDIAGNOSTIC or raises the existing
%      singleton*.
%
%      H = TESTDIAGNOSTIC returns the handle to a new TESTDIAGNOSTIC or the handle to
%      the existing singleton*.
%
%      TESTDIAGNOSTIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTDIAGNOSTIC.M with the given input arguments.
%
%      TESTDIAGNOSTIC('Property','Value',...) creates a new TESTDIAGNOSTIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TestDiagnostic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TestDiagnostic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestDiagnostic

% Last Modified by GUIDE v2.5 16-Jan-2012 21:37:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestDiagnostic_OpeningFcn, ...
                   'gui_OutputFcn',  @TestDiagnostic_OutputFcn, ...
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


% --- Executes just before TestDiagnostic is made visible.
function TestDiagnostic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TestDiagnostic (see VARARGIN)

% Choose default command line output for TestDiagnostic
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TestDiagnostic wait for user response (see UIRESUME)
% uiwait(handles.testdiagnostic);


% --- Outputs from this function are returned to the command line.
function varargout = TestDiagnostic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function part1_edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in part1_button1.
function part1_button1_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.part1_text1,'string','Loading.................')
pause(1)
%----------------------- ----------------------------
% Import the file Excel
path=handles.DiagnosticTest.Filenames;

if isempty(path)
set(handles.part1_text1,'string','Nothing is requested ?!')
return
end

% loop of reading files
result = [];

for i = 1:size(path,2);

[num text] = xlsread(path{i});
text = text(19:end,:);
text = text(:,2:end);
num = num(3:end,1:end);
x = str2double(text);
y = num;

if size(x,2)~=size(y,2)
cmd = strcat('Be careful ! There is problem in the ',num2str(i),'st',' data, maybe some colume is empty !');
errordlg(cmd);
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
x2((result_temp==-2000))=-1000;
y2((result_temp==-2000))=-1000;
x3((isnan(x2)==1))=0;
y3((isnan(y2)==1))=0;

resultNew = x3+y3;
result = [result;resultNew];
clear x y x1 y1 x2 y2 x3 y3 resultNew result_temp

end

result_temp = result(:,[29,27,28,31,9,32,7,33,8,13,14,18,17,11,10,12,5,3,4,1,6,2,15,16]);
cas = result(:,34:end);
result_ori = result; % hold all the data
result = [result_temp cas];
%----------------------------------------------------
% Cut the sample with NaN captor
[m,n] = find(isnan(result(:,1:24))==1); % same size as the data simulation (3 inputs and 21 output)
[m_ori,n_ori] = find(isnan(result_ori(:,1:33))==1);

if isempty(m) == 1
    NumNan = 0;
else
m = unique(m);
NumNan = length(m);
result(m,:) = [];  % remove all the row who(inputs&outpus) inclus the data == Nan 
end

if isempty(m_ori) == 1
    NumNan_ori = 0;
else
m_ori = unique(m_ori);
NumNan_ori = length(m_ori);
result_ori(m_ori,:) = [];
end

NumData1 = length(result);
NumData1_ori = length(result_ori);
%fprintf('There are %d data (24vectros) lost (input or output =Nan) . \n',NumNan);
%fprintf('There are %d data (33vectros) lost (input or output =Nan) . \n',NumNan_ori);

%----------------------------------------------------
% Cut the sample with the NAn Cas
% findout which cas == Nan (all 35 cas = NaN) and cut them

NanCas = sum(isnan(result(:,25:end)),2);
NanCas_ori = sum(isnan(result_ori(:,34:end)),2);

[mNanCas,nNanCas]=find(NanCas==35);
[mNanCas_ori,nNanCas_ori]=find(NanCas_ori==35);

if isempty(mNanCas)==1
    mNanCas = 0;
else
mNanCas = unique(mNanCas);
result(mNanCas,:) = [];% if all the cas are Nan, cut them
end

[m2,n2] = find(isnan(result)==1); % if there is individual cas (not all the line) = Nan, we make it as 0
result(m2,n2) = 0;

if isempty(mNanCas_ori)==1
    mNanCas_ori = 0;
else
mNanCas_ori = unique(mNanCas);
result_ori(mNanCas_ori,:) = [];% if all the cas are Nan, cut them
end

[m2_ori,n2_ori] = find(isnan(result_ori)==1); % if there is individual cas (not all the line) = Nan, we make it as 0
result_ori(m2_ori,n2_ori) = 0;

NumData3 = length(result);
DataRemove = NumData1-NumData3;
NumData3_ori = length(result_ori);
DataRemove_ori = NumData1_ori-NumData3_ori;
%fprintf('There are %d exemples(row) of data (24 vectors) removed, because of Cas = Nan. \n', DataRemove);
%fprintf('There are %d exemples(row) of data (33 vectors) removed, because of Cas = Nan. \n', DataRemove_ori);
%fprintf('We can write ''Capteur NoOpen'' or ''Capteur fault'' easily for these cas. \n');

% ---------------------------------------------------
% Classify the ref and the faults

% Treat the cas to indice 
a = result(:,(25:end)); % 25 - 59 cas
[m2,n2] = find(isnan(a)==1);
if m2>0
a(m2,n2) = 0;% if the cas is Nan, make them as 0
end
b = a;
b(b~=0)=1;

% vecteur to indice
[ind,vec_sample,nbSample] = vec2ind_zf(b');
[Goal option] = ind2vec_zf(ind); 

% save('test16Jan','ind','vec_sample','nbSample','Goal','option')


if option == 0
    msgbox('Attention! There isn''t data of REF, the analysis continues.')
    ind = ind-1;
    vec_sample(:,1)=[];
    nbSample(1)=[];
    nbFault = sum(nbSample(1:end));
else
    msgbox('The data of REF are corresponding to situation 1 in the figures.')
    nbFault = sum(nbSample(2:end));
end

% iTypeSample = max(ind);
% for i=1:iTypeSample
%     Situation(i).data = (result(ind==i,:))';
%     Situation(i).GoalVector = Goal(:,ind==i);
%     Siuation(i).GoalInd = i;
% end
% ---------------------------------------------------
% indice to vecteur
% ref    = result(ind==1,:);
% ref    = ref';
% fault = result(ind~=1,:);
% fault = fault'; 
% Target_ref = Goal(:,ind==1);
% Target_fault = Goal(:,ind~=1);

% fprintf('There are %d Faults \n',nbFault);
% F.ref =ref;
% F.fault = fault;
% F.Target_ref = Target_ref;
% F.Target_fault = Target_fault;
F.result = result(:,(1:24));
F.goal = Goal;
F.ind= ind;
F.vec_sample= vec_sample;
F.nbSample= nbSample;

%---------------------------------------------------
% For F_ori (32 captors)
% Treat the cas to indice 
a_ori = result_ori(:,(34:end)); 
[m2_ori,n2_ori] = find(isnan(a)==1);
if m2_ori>0
a_ori(m2,n2) = 0;% if the cas is Nan, make them as 0
end
b_ori = a_ori;
b_ori(b_ori~=0)=1;

% vecteur to indice
[ind_ori,vec_sample_ori,nbSample_ori] = vec2ind_zf(b_ori');
% ---------------------------------------------------
% indice to vecteur
[Goal_ori option_ori] = ind2vec_zf(ind_ori); 
if option_ori == 0
    %msgbox('Attention! There isn''t data of REF, the analysis continues.')
    ind_ori = ind_ori-1;
    vec_sample_ori(:,1)=[];
    nbSample_ori(1)=[];
    nbFault_ori = sum(nbSample_ori(1:end));
else
    %msgbox('The data of REF are corresponding to situation 1 in the figures.')
    nbFault_ori = sum(nbSample_ori(2:end));
end

% iTypeSample_ori = max(ind_ori);
% for i=1:iTypeSample_ori
%     Situation_ori(i).data = (result_ori(ind_ori==i,:))';
%     Situation_ori(i).GoalVector = Goal_ori(:,ind==i);
%     Siuation_ori(i).GoalInd = i;
% end

% ref_ori    = result_ori(ind_ori==1,1:33);
% ref_ori    = ref_ori';
% fault_ori = result_ori(ind_ori~=1,1:33);
% fault_ori = fault_ori'; 
% Target_ref_ori = Goal_ori(:,ind_ori==1);
% Target_fault_ori = Goal_ori(:,ind_ori~=1);

% fprintf('There are %d Faults \n',nbFault_ori);
% fprintf('--------------------------------------------- \n')

Fori.result =result_ori(:,(1:33));
Fori.goal = Goal_ori;
Fori.ind= ind_ori;
Fori.vec_sample= vec_sample_ori;
Fori.nbSample= nbSample_ori;


%----------------------------------------------------
% Set string of text 1 2 3 4
set(handles.part1_text9,'string',num2str(size(result_ori,2)-35));
set(handles.part1_text10,'string',num2str(size(result_ori,1)));
set(handles.part1_text11,'string',num2str(DataRemove_ori +NumNan_ori ));
set(handles.part1_text12,'string',num2str(size(nbSample_ori,2)));
set(handles.part1_text13,'string',num2str(nbFault_ori));

set(handles.part1_text14,'string',num2str(size(result,2)-35));
set(handles.part1_text15,'string',num2str(size(result,1)));
set(handles.part1_text16,'string',num2str(DataRemove +NumNan ));
set(handles.part1_text17,'string',num2str(size(nbSample,2)));
set(handles.part1_text18,'string',num2str(nbFault));

Str1Table = [(size(result_ori,2)-35) (size(result,2)-35);...
 (size(result_ori,1)) (size(result,1));...
 (DataRemove_ori +NumNan_ori ) (DataRemove +NumNan );...
 size(nbSample_ori,2) size(nbSample,2);...
 nbFault_ori nbFault];

% SAVE
handles.DiagnosticTest.Fori = Fori;
handles.DiagnosticTest.F = F;
handles.DiagnosticTest.Str1Table = Str1Table;
set(hObject,'string','OK');
guidata(hObject,handles);
%save('TestCMP','Fori','F');
set(handles.part1_text1,'string','Loading Completed','BackGroundColor',[1 0 0])


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit1.
function part1_edit1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit1 (see GCBO)
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
    handles.DiagnosticTest.Filenames = str;
end

guidata(hObject,handles);

% --- Executes on button press in BackButton.
function BackButton_Callback(hObject, eventdata, handles)
% hObject    handle to BackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
TableContents;

% --- Executes on button press in fileExcel.
function fileExcel_Callback(hObject, eventdata, handles)
% hObject    handle to fileExcel (see GCBO)
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
path = get(handles.part1_edit1,'string');
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

    
% --- Executes on button press in part1_button5.
function part1_button5_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uiputfile({'*.mat'},'Save as','Data1.mat');
dataNorma.data = handles.datauser.datanorma;
dataNorma.goal = handles.datauser.data.goal;
dataNorma.dataNoNorma = handles.datauser.dataNonorma;
dataNorma.Situation = handles.datauser.Situation;
dataNorma.Ps  = handles.datauser.datanormaPs;
dataNorma.indNorma = handles.datauser.indNorma;
dataNorma.select = handles.datauser.str1choose;
dataNorma.F_vecsample = handles.datauser.F.vec_sample;
dataNorma.Fori_vecsample = handles.datauser.Fori.vec_sample;
save([pathname filename],'dataNorma');


function part1_edit2_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit2 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit2 as a double
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path index ] = uigetfile('*.mat','File Selector');
    if index 
        str = [path file];
        set(hObject,'string',str);
    end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function part1_edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in part1_button3.
function part1_button3_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.part1_edit2,'string');
if isempty(path)
errordlg('Please input the path of data !')
end
datause = load(path);
data =  datause.dataNorma;
handles.DiagnosticTest.dataCmp = data;
set(hObject,'string','OK');
guidata(hObject,handles);

% --- Executes on button press in part1_button4.
function part1_button4_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dataTest = handles.DiagnosticTest.data;
dataCmp = handles.DiagnosticTest.dataCmp;
vec_sampleTest = dataTest.vec_sample;
vec_sampleCmp = dataCmp.F_vecsample;

% 1st compare
[LTest mTest]= size(vec_sampleTest);
[LCmp mCmp]= size(vec_sampleCmp);
if LTest~=LCmp
    errordlg('The nb of Cas in the testing file is not 35!')
end

% 2nd compare
indTest = [];
indSave = zeros(1,mCmp);
for i = 1:mTest
        for j = 1:mCmp
    
        ind = sum(vec_sampleCmp(:,j)==vec_sampleCmp(:,i));
        if ind == LTest; %35cas
           indTest= [indTest j];
           indSave(i) = j;
        end
        end
end

if  mTest~=size(indTest)
    errordlg('There is new situations in the test data, please retrain the system in the Diagnostic Module !')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% --- Executes on button press in part1_radiobutton1.
function part1_radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to part1_radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_radiobutton1
Hint_11 = get(hObject,'Value');
if Hint_11 == 1
    indNbrEx  = 1;
    set(handles.part1_radiobutton2,'value',0);
else
    hint1 = get(handles.part1_radiobutton1,'value');
    hint2 = get(handles.part1_radiobutton2,'value');
   
    if hint1==0&&hint2==0
        indNbrEx  = 0;
        set(handles.part1_radiobutton1,'value',1);
    end
end
handles.DiagnosticTest.indNbrEx = indNbrEx;
guidata(hObject,handles)

% --- Executes on button press in part1_radiobutton2.
function part1_radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to part1_radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_radiobutton2
Hint_12 = get(hObject,'Value');
if Hint_12 == 1
    indNbrEx  = 2;
    set(handles.part1_radiobutton1,'value',0);
else
    hint1 = get(handles.part1_radiobutton1,'value');
    hint2 = get(handles.part1_radiobutton2,'value');
   
    if hint1==0&&hint2==0
        indNbrEx  = 0;
       set(handles.part1_radiobutton2,'value',1);
    end
end
handles.DiagnosticTest.indNbrEx = indNbrEx;
guidata(hObject,handles)


function part1_edit3_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit3 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit3 as a double


% --- Executes during object creation, after setting all properties.
function part1_edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function part1_edit4_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit4 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit4 as a double


% --- Executes during object creation, after setting all properties.
function part1_edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in part1_button2.
function part1_button2_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

indNbrEx = handles.DiagnosticTest.indNbrEx;
data = handles.DiagnosticTest.F;

if indNbrEx == 2
    MinTest = get(handles.part1_edit3,'string');
    MinTest = str2double(MinTest);
    MaxTest = get(handles.part1_edit4,'string');
    MaxTest = str2double(MaxTest);
    MaxExit = size(data.result,1);


    if (MinTest>MaxTest)||(MinTest<1)
    msgbox('Error! Please correctly choose the domain of data for test.')
    end

    if MaxTest>MaxExit
    msgbox('Error! Please correctly choose the domain of data for test.')
    end
    
    data.result = data.result(MinTest:MaxTest,:);
    data.goal = data.goal(:,MinTest:MaxTest);
    data.ind = data.ind(:,MinTest:MaxTest);
    indTest = unique(data.ind);
    data.vec_sample = (data.vec_sample(:,indTest));
    for i = min(data.ind):max(data.ind)
        nbSampleTest(i) = numel(data.ind(data.ind==i));
    end
    data.nbSample = nbSampleTest;
    handles.DiagnosticTest.data = data;
    
else if indNbrEx == 1
    handles.DiagnosticTest.data = handles.DiagnosticTest.F;    
    else if indNbrEx == 0
    msgbox('Error! Please correctly choose the data for test.')  
          end
    
    end   

end
save('TestDataCmp','data')
guidata(hObject,handles)

function part1_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit1 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit1 as a double


% --- Executes on key press with focus on part1_edit1 and none of its controls.
function part1_edit1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
