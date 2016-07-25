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

% Last Modified by GUIDE v2.5 24-Mar-2012 17:59:12

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
checkbox = get(handles.checkbox1_1,'value'); % Check the ZPADS1 is existed or not.
% ---------------------------------------------------
% 2) loop of reading files
n = size(path,2); % how many files are readed
resultEX(n).excel = [];
sizeResultNew = zeros(n,2); % the size of each files

for i = 1:n

    [num text] = xlsread(path{i});
    if (checkbox==1)&&(i==1)
    titleIndex_ori = text(14,:);
    titleIndex_ori(:,[1,35:end]) = [];
    else if(checkbox==0)&&(i==1)
            titleIndex_ori = text(14,:);
            titleIndex_ori(:,[1,34:end]) = [];
        end
    end
    
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
sizeResult = sum(sizeResultNew);
result = zeros(sizeResult(1),sizeResultNew(1,2));
countX1 = 0;

for i = 1:n
    countX2 = sizeResultNew(i,1)+countX1;
    result(countX1+1:countX2,:) = resultEX(i).excel ;
    countX1 = countX2;
end

clear x y x1 y1 x2 y2 x3 y3 resultNew result_temp countX1 countX2 resultEX resultNew sizeResult sizeResultNew num path text
% ---------------------------------------------------
% 3) Organization of Data 
% F02
if checkbox == 1
result_temp = result(:,[29,27,28,31,9,32,7,33,8,13,14,18,17,11,10,12,5,3,4,1,6,2,15,16]);
titleIndex = titleIndex_ori(:,[29,27,28,31,9,32,7,33,8,13,14,18,17,11,10,12,5,3,4,1,6,2,15,16]);
cas = result(:,34:end);
else if checkbox == 0;
% F03
result_temp = result(:,[29,27,28,30,9,31,7,32,8,13,14,18,17,11,10,12,5,3,4,1,6,2,15,16]);
cas = result(:,33:end);
titleIndex = titleIndex_ori(:,[29,27,28,30,9,31,7,32,8,13,14,18,17,11,10,12,5,3,4,1,6,2,15,16]);
    end
end

result_ori = result; % hold all the data
result = [result_temp cas];
%----------------------------------------------------
% Cut the sample with NaN captor
if checkbox==1
[m,n] = find(isnan(result(:,1:24))==1); % same size as the data simulation (3 inputs and 21 output)
[m_ori,n_ori] = find(isnan(result_ori(:,1:33))==1);
else if checkbox==0
        [m,n] = find(isnan(result(:,1:24))==1); % same size as the data simulation (3 inputs and 21 output)
        [m_ori,n_ori] = find(isnan(result_ori(:,1:32))==1);
    end
end

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
%----------------------------------------------------
% Cut the sample with the NAn Cas
% findout which cas == Nan (all 35 cas = NaN) and cut them
if checkbox==1
    NanCas = sum(isnan(result(:,25:end)),2);
    NanCas_ori = sum(isnan(result_ori(:,34:end)),2);

    [mNanCas,nNanCas]=find(NanCas==35);
    [mNanCas_ori,nNanCas_ori]=find(NanCas_ori==35);

else if checkbox==0
    NanCas = sum(isnan(result(:,25:end)),2);
    NanCas_ori = sum(isnan(result_ori(:,33:end)),2);

    [mNanCas,nNanCas]=find(NanCas==35);
    [mNanCas_ori,nNanCas_ori]=find(NanCas_ori==35);
      end
end

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

% ---------------------------------------------------
% Classify the ref and the faults

% Treat the cas to indice 
a = result(:,(25:end)); % 25 - 59 cas
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
Goal = ind2vec_zf(ind); 

load('nameFault');
nameNow = FaultName(vec_sample);
nameNowL= size(nameNow,2);
nameL = size(name,2);

LengthName = 1;
for i = 1:nameNowL
        y = strfind(name,nameNow{i});
        z  = cell2mat(y);
        if (z~=0)&&(z~=1)
            msgbox('There is problem of the database, some fault repeated !');
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
F.result = result(:,(1:24));
F.goal = Goal;
F.ind= ind;
F.vec_sample= vec_sample;
F.nbSample= nbSample;
F.nameFault = nameNow;
F.titleIndex = titleIndex;
%---------------------------------------------------
% For F_ori (32 captors)
% Treat the cas to indice 
if checkbox==1
a_ori = result_ori(:,(34:end)); 
else if checkbox==0
    a_ori = result_ori(:,(33:end)); 
    end
end

[m2_ori,n2_ori] = find(isnan(a)==1);
if m2_ori>0
a_ori(m2,n2) = 0;% if the cas is Nan, make them as 0
end
b_ori = a_ori;
% --------------------------------------------------
%b_ori(b_ori~=0)=1;
b_ori(b_ori~=1)=0; %% Modified by Dassault email at le 21 03 2012

% vecteur to indice
[ind_ori,vec_sample_ori,nbSample_ori] = vec2ind_zf(b_ori');

nameNow = FaultName(vec_sample_ori);
nameNowL= size(nameNow,2);
nameL = size(name,2);

LengthName = 1;
for i = 1:nameNowL
        y = strfind(name,nameNow{i});
        z  = cell2mat(y);
        if (z~=0)&&(z~=1)
            msgbox('There is problem of the database, some fault repeated !');
        else if z==0
            msgbox(strcat('There is new fault : ',nameNow{i}));
            name{nameL + LengthName} = nameNow{i};
            LengthName = LengthName + 1; 
              end
        end
end


% ---------------------------------------------------
% indice to vecteur
Goal_ori = ind2vec_zf(ind_ori); 
% verify there is ref or not
temp = sum(vec_sample_ori);

if min(temp) ~= 0
    %msgbox('Attention! There isn''t data of REF, the analysis continues.')
    nbFault_ori = sum(nbSample_ori(1:end));
else
    %msgbox('The data of REF are corresponding to situation 1 in the figures.')
    nbFault_ori = sum(nbSample(2:end));
end

% fprintf('There are %d Faults \n',nbFault_ori);
% fprintf('--------------------------------------------- \n')
if checkbox==1
    Fori.result =result_ori(:,(1:33));
    else if checkbox==0
            Fori.result =result_ori(:,(1:32));
        end
end
Fori.goal = Goal_ori;
Fori.ind= ind_ori;
Fori.vec_sample= vec_sample_ori;
Fori.nbSample= nbSample_ori;
Fori.nameFault = nameNow;
Fori.titleIndex = titleIndex_ori;
%----------------------------------------------------
% Set string of text 1 2 3 4
set(handles.text11,'string',num2str(size(result_ori,2)-35));
set(handles.text12,'string',num2str(size(result_ori,1)));
set(handles.text13,'string',num2str(DataRemove_ori +NumNan_ori ));
set(handles.text14,'string',num2str(size(nbSample_ori,2)));
set(handles.text15,'string',num2str(nbFault_ori));

set(handles.text16,'string',num2str(size(result,2)-35));
set(handles.text17,'string',num2str(size(result,1)));
set(handles.text18,'string',num2str(DataRemove +NumNan ));
set(handles.text19,'string',num2str(size(nbSample,2)));
set(handles.text20,'string',num2str(nbFault));

Str1Table = [(size(result_ori,2)-35) (size(result,2)-35);...
 (size(result_ori,1)) (size(result,1));...
 (DataRemove_ori +NumNan_ori ) (DataRemove +NumNan );...
 size(nbSample_ori,2) size(nbSample,2);...
 nbFault_ori nbFault];

% SAVE
handles.datauser.Fori = Fori;
handles.datauser.F = F;
handles.datauser.Str1Table = Str1Table;
set(hObject,'string','OK');
% --------------------------------------------------
% Save the data
save('F_ALL','Fori','F');
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
x = handles.datauser.data.result;
Goal = handles.datauser.data.goal;
ind = handles.datauser.data.ind;
vec_sample = handles.datauser.data.vec_sample;
nbSample = handles.datauser.data.nbSample;

kind = handles.datauser.indNorma;

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
    set(handles.text23,'str','Normalization Completed','BackGroundColor',[1 0 0])
else
    set(handles.text23,'str','No Normalization','BackGroundColor',[1 0 0])
end

iTypeSample = max(ind);
for i=1:iTypeSample
    Situation(i).data = (norma(ind==i,:))';
    Situation(i).GoalVector = Goal(:,ind==i);
    Situation(i).GoalInd = i;
    Situation(i).vec_sample = vec_sample(:,i);
    Situation(i).nbSample =nbSample(i);
    Situation(i).nameFault = FaultName(vec_sample(:,i));
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
    data_temp = handles.datauser.Fori;
else if sel ==3
    data_temp = handles.datauser.Fori;
    data_temp.result(:,[27,28,29])=[];
    data_temp.titleIndex(:,[27,28,29]) = [];
    else if sel==4
        data_temp = handles.datauser.F;   
        else if sel==5
                data_temp = handles.datauser.F;
                data_temp.result(:,1:3)=[];
            else if sel==1
                    errordlg('Please choose the data to analysis !')
                end
            end
        end
    end
end
handles.datauser.str1choose = sel;
handles.datauser.data = data_temp;
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
PicturePath = strcat(str1,'\','figures\',date,'\','figure131.png');
h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,310,460,320);
PicturePath = strcat(str1,'\','figures\',date,'\','figure132.png');
h2 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,640,460,320);

% ---------------------------------------------------
% 4 - PCA
Sheet1.Range('A66:C66').MergeCells = 1;
Sheet1.Range('A66').Value = ' 4 - Principal Component Analysis - (PCA) ';
Sheet1.Range('A66').Font.Bold =2; 
PicturePath = strcat(str1,'\','figures\',date,'\','figure141.png');
h3 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1020,460,320);
PicturePath = strcat(str1,'\','figures\',date,'\','figure142.png');
h4 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,5,1360,460,320);

Workbook.Save








% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = handles.datauser.datause.data;
Goal = handles.datauser.datause.goal;
save('test','Data','Goal')
LDA_ZF = LDA_ZF_29112011(Data,Goal);
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
    end
    
    % save figure
    name131 = strcat(pathFig,date,'\figure131');
    
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
    
    name132 = strcat(pathFig,date,'\figure132');
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




% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yy = handles.datauser.datause.data;
Goal_ACP = handles.datauser.datause.goal;
%save('Test11JAn','yy','Goal_ACP')
%Goal_ACP = vec2ind_zf(Goal);
pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
end

[vectors, coeff, newValue0, ValueForDraw,percent_explained] = acp_zf(yy,99,0);
% Figure of Percent Explained
newFig = figure('visible','off');
bar(percent_explained(1:size(newValue0,2)));
axis([0 size(newValue0,2)+1 0 100]);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis')

name141 = strcat(pathFig,date,'\figure141');
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
    name142 = strcat(pathFig,date,'\figure142');
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
    
% --- Executes on button press in MatFile.
function MatFile_Callback(hObject, eventdata, handles)
% hObject    handle to MatFile (see GCBO)
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
dataNorma.F_nameFault = handles.datauser.F.nameFault;
dataNorma.Fori_nameFault = handles.datauser.Fori.nameFault;
dataNorma.F.titleIndex = handles.datauser.F.titleIndex;
dataNorma.Fori.titleIndex = handles.datauser.Fori.titleIndex;

save([pathname filename],'dataNorma');


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


% --- Executes on button press in checkbox1_1.
function checkbox1_1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1_1
