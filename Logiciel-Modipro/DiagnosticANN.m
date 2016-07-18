function varargout = DiagnosticANN(varargin)
% DIAGNOSTICANN MATLAB code for DiagnosticANN.fig
%      DIAGNOSTICANN, by itself, creates a new DIAGNOSTICANN or raises the existing
%      singleton*.
%
%      H = DIAGNOSTICANN returns the handle to a new DIAGNOSTICANN or the handle to
%      the existing singleton*.
%
%      DIAGNOSTICANN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIAGNOSTICANN.M with the given input arguments.
%
%      DIAGNOSTICANN('Property','Value',...) creates a new DIAGNOSTICANN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DiagnosticANN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DiagnosticANN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DiagnosticANN

% Last Modified by GUIDE v2.5 24-Sep-2012 12:49:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DiagnosticANN_OpeningFcn, ...
                   'gui_OutputFcn',  @DiagnosticANN_OutputFcn, ...
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


% --- Executes just before DiagnosticANN is made visible.
function DiagnosticANN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DiagnosticANN (see VARARGIN)

% Choose default command line output for DiagnosticANN
handles.output = hObject;

filename = [pwd '/ANN/ANN.jpg'];
PIC = imread(filename);
axes(handles.axes11)
image(PIC);
axis off

filename = [pwd '/ANN/CV.jpg'];
PIC = imread(filename);
axes(handles.axes12)
image(PIC);
axis off

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DiagnosticANN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DiagnosticANN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
Diagnostic

%% Part 1
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


function part1_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit1 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit1 as a double


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit1.
function part1_edit1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit1 (see GCBO)
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

% --- Executes on button press in part1_button1.
function part1_button1_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.part1_edit1,'string');
if isempty(path)
errordlg('Please input the path of data !')
end
pause(0.5)
set(hObject,'string','Wait')
pause(0.5)
datause = load(path);
Situation =  datause.dataNorma.Situation;
F =  datause.dataNorma.F;
Sensors =  datause.dataNorma.sensorsChosenName;
handles.datausing.Situation = Situation;
handles.datausing.F = F;
handles.datausing.Sensors = Sensors;
handles.datausing.path = path;
handles.datausing.testAll = datause.dataNorma.testAll;
handles.datausing.goalAll = datause.dataNorma.goalAll;

set(hObject,'string','OK');
pause(1)
set(hObject,'string','Load');
guidata(hObject,handles);


% --- Executes on button press in part1_button3.
function part1_button3_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nc1 = get(handles.part1_rbNc1,'Value');
Nc2 = get(handles.part1_rbNc2,'Value');
Nc3 = get(handles.part1_rbNc3,'Value');
Nc4 = get(handles.part1_rbNc4,'Value');
Nc5 = get(handles.part1_rbNc5,'Value');
Nc6 = get(handles.part1_rbNc6,'Value');
Nc7 = get(handles.part1_rbNc7,'Value');

Data = zeros(1,7);
Data(1) = Nc1;
Data(2) = Nc2;
Data(3) = Nc3;
Data(4) = Nc4;
Data(5) = Nc5;
Data(6) = Nc6;
Data(7) = Nc7;
Nc = Data;
handles.datausing.Nc = Nc;
set(hObject,'String','OK')
pause(1);
name = {'NET_1';'NET_2';'NET_3';'NET_4';'NET_5';'NET_6';'NET_7'};
nameVal = name(Nc==1);
set(handles.part3_popumenu1,'String',nameVal);
set(hObject,'String','Apply')
guidata(hObject,handles);

% --- Executes on button press in part1_button4.
function part1_button4_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PercentTrain = get(handles.part1_edit2,'String');
PercentTrain = str2double(PercentTrain);
if (PercentTrain>=1)||(PercentTrain<=0)||isnan(PercentTrain)
    msgbox('Percentage must be a value between 0 and 1 !')
end
handles.datausing.percentTrain = PercentTrain;

data = handles.datausing.Situation;
n = size(data,2);
nbSample = zeros(n,1);
for i = 1:n
    nbSample(i) = size(data(i).data,2);
end
set(handles.part2_table1,'data',nbSample);

set(hObject,'String','OK')
pause(1)
set(hObject,'String','Apply')

guidata(hObject,handles)


% --- Executes on button press in part1_rbNc1.
function part1_rbNc1_Callback(hObject, eventdata, handles)
% hObject    handle to part1_rbNc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_rbNc1


% --- Executes on button press in part1_rbNc2.
function part1_rbNc2_Callback(hObject, eventdata, handles)
% hObject    handle to part1_rbNc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_rbNc2


% --- Executes on button press in part1_rbNc3.
function part1_rbNc3_Callback(hObject, eventdata, handles)
% hObject    handle to part1_rbNc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_rbNc3


% --- Executes on button press in part1_rbNc4.
function part1_rbNc4_Callback(hObject, eventdata, handles)
% hObject    handle to part1_rbNc4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_rbNc4


% --- Executes on button press in part1_rbNc5.
function part1_rbNc5_Callback(hObject, eventdata, handles)
% hObject    handle to part1_rbNc5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_rbNc5


% --- Executes on button press in part1_rbNc6.
function part1_rbNc6_Callback(hObject, eventdata, handles)
% hObject    handle to part1_rbNc6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_rbNc6


% --- Executes on button press in part1_rbNc7.
function part1_rbNc7_Callback(hObject, eventdata, handles)
% hObject    handle to part1_rbNc7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part1_rbNc7


function part1_edit2_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit2 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit2 as a double
PercentTrain = str2double(get(hObject,'String'));
if (PercentTrain>=1)||(PercentTrain<=0)
    msgbox('Percentage must be a value between 0 and 1 !')
end
handles.datausing.percentTrain = PercentTrain;
guidata(hObject,handles)

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


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit2.
function part1_edit2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end

%--------------------------------------------------------------------------
%% Part 2

function part2_edit4_Callback(hObject, eventdata, handles)
% hObject    handle to part2_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part2_edit4 as text
%        str2double(get(hObject,'String')) returns contents of part2_edit4 as a double

% --- Executes during object creation, after setting all properties.
function part2_edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part2_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function part2_edit5_Callback(hObject, eventdata, handles)
% hObject    handle to part2_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part2_edit5 as text
%        str2double(get(hObject,'String')) returns contents of part2_edit5 as a double


% --- Executes during object creation, after setting all properties.
function part2_edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part2_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in part2_button3.
function part2_button3_Callback(hObject, eventdata, handles)
% hObject    handle to part2_button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mixed = get(handles.part2_mixed,'Value');
nbMixed = get(handles.part2_mixedEdit,'String');
nbMixed = str2double(nbMixed);
nbMixed = floor(nbMixed);

if nbMixed>100||nbMixed<2
    msgbox('The nb of groups is too small or too big, please choose it within [2-100]','Warning','warn');
end

handles.datausing.nbMixed = nbMixed;
handles.datausing.mixed = mixed;
if  mixed == 0

    NbVector = str2double(get(handles.part2_edit4,'string'));
    NbSample = str2double(get(handles.part2_edit5,'string'));
    data = handles.datausing.Situation;

    
    
    
    Data = data(NbVector).data;
    Goal = data(NbVector).GoalInd;
    NbTotalSample = size(Data,2);
    p = randperm(NbTotalSample);
    DataTemp = Data(:,p(1:NbSample));
    data(NbVector).data = DataTemp;
    data(NbVector).GoalInd = Goal ;
    handles.datausing.Situation = data;

% update the table 2.1
    n = size(data,2);
    nbSample = zeros(n,1);
    for i = 1:n
        nbSample(i) = size(data(i).data,2);
    end
    set(handles.part2_table1,'data',nbSample);
    set(handles.part2_edit4,'String','');set(handles.part2_edit5,'String','');

elseif mixed==1
    
    NbVector = str2double(get(handles.part2_edit4,'string'));
    NbSample = str2double(get(handles.part2_edit5,'string'));
    data = handles.datausing.Situation;
    Data = data(NbVector).data;
    Goal = data(NbVector).GoalInd;
    NbTotalSample = size(Data,2);
    data(NbVector).data=[];
    for i = 1:nbMixed
        p = randperm(NbTotalSample);
        DataTemp = Data(:,p(1:NbSample));
        data(NbVector).data(i).data = DataTemp;
        data(NbVector).GoalInd = Goal ;
        handles.datausing.Situation = data;
    end
% update the table 2.1
    n = size(data,2);
    nbSample = zeros(n,1);
    for i = 1:n
        x = data(i).data;
        if isa(x,'struct')
            nbSample(i) = size(data(i).data(1).data,2);
        else
            nbSample(i) = size(data(i).data,2);
        end
    end
    set(handles.part2_table1,'data',nbSample);
    set(handles.part2_edit4,'String','');set(handles.part2_edit5,'String','');

end
     
guidata(hObject,handles)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part2_edit4.
function part2_edit4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part2_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part2_edit5.
function part2_edit5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part2_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end

% --- Executes during object creation, after setting all properties.
function part2_edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part2_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in part2_button1.
function part2_button1_Callback(hObject, eventdata, handles)
% hObject    handle to part2_button1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kk = get(handles.part2_edit1,'String');
kk = str2double(kk);
kk = floor(kk);
if kk<1
    msgbox('Please input the times of verificaton of nets (>1) !')
end
handles.datausing.kk = kk;
set(hObject,'String','OK');
pause(1)
set(hObject,'String','Apply');
guidata(hObject,handles)


function part2_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to part2_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part2_edit1 as text
%        str2double(get(hObject,'String')) returns contents of part2_edit1 as a double


% --- Executes on button press in part2_button2.
function part2_button2_Callback(hObject, eventdata, handles)
% hObject    handle to part2_button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles.datausing,'mixed')
    mixed = handles.datausing.mixed;
    nbMixed = handles.datausing.nbMixed;
else
    mixed = 0;
    nbMixed = 0;
end

data = handles.datausing.Situation;
Np = 1-handles.datausing.percentTrain;
Data = [];
Goal = [];
testAll = handles.datausing.testAll;
goalAll = handles.datausing.goalAll;
goalAll = ind2vec_zf(goalAll);

if mixed==0

    for i = 1:size(data,2)
        sizeData = size(data(i).data,2);
        GoalTemp = ones(1,sizeData)*i;
        Data = [Data data(i).data];
        Goal = [Goal GoalTemp];
    end
    
    Goal = ind2vec_zf(Goal);

    indices = ones(size(Data,2),1);
    [trainInd,testInd] = crossvalind('holdout',indices,Np);
    data_Train = Data(:,trainInd);
    data_Test  = Data(:,testInd);
    goal_Train = Goal(:,trainInd);
    goal_Test  = Goal(:,testInd);

    Nc = handles.datausing.Nc;
    % parameterize  
    n = 1000;
    err_glob = 0.001;
    lr0 = 1;
    lr_dec = 0.9;
    lr_inc = 1.1;
    err_ratio = 1;
    lr = [lr0 lr_dec, lr_inc, err_ratio];
    optionbase = [1 2 3 4 5 6 7];
    option = optionbase(Nc==1);
    Loption = size(option,2);
    lamda = 0.5;
    affichage = 0;
    kk = handles.datausing.kk; % 10 times to verify every net

    % Waitbar
    %h = waitbar(0,'1','Name','Progress of System running ...',...
       %          'CreateCancelBtn',...
          %       'setappdata(gcbf,''canceling'',1)');
    h = waitbar(0,'1','Name','Progress of System running...', 'CreateCancelBtn','state=1;delete(h);clear h');
    % ---------------------------------------------------
    CountWaitbar = 0;

    % ---------------------------------------------------    

    for j = 1:Loption

        Tr = 0;

        for k = 1:kk
            CountWaitbar = CountWaitbar +1;
            waitbar(CountWaitbar/sum(kk*Loption),h,sprintf('%d / %d',CountWaitbar,sum(kk*Loption)))
            pause(0.1)

            model = mlp_ZF_momentum(data_Train,goal_Train,n,err_glob,option(j),lr,lamda,affichage);
            [output Result]  = Output_mlp_ZF(model,data_Test,goal_Test);
            [output Result_Train]  = Output_mlp_ZF(model,data_Train,goal_Train);
            [output_testAll Result_testAll]  = Output_mlp_ZF(model,testAll,goalAll);
            R(j) = Result_testAll.CM.Tr;

            if R(j)>Tr
                ResultTemp = Result;
                ResultTemp_Train = Result_Train;
                ResultTemp_testAll = Result_testAll;
                ResultModel = model;
                Tr = R(j);
            end

        end

        Net(j).Result_Test = ResultTemp;
        Net(j).Result_Train = ResultTemp_Train;
        Net(j).Result_testAll = ResultTemp_testAll;
        Net(j).ResultModel = ResultModel;
    end

    indTemp = find(R==max(R));
    ind = indTemp(1);
    str = strcat(['Net ' num2str(ind)]);
    set(handles.part3_text2,'String',str);
    Result_Net.Test = Net(ind).Result_Test;
    Result_Net.Train = Net(ind).Result_Train;
    Result_Net.Model = Net(ind).ResultModel;

    delete(h)
    clear h
    handles.datausing.Result_Net = Result_Net;
    handles.datausing.Net = Net;
    c = num2str(fix(clock));
    c((isspace(c)))=[];
    cmd1=pwd;
    cmd = strcat(cmd1,'/ANN/model_',c);
    save(cmd,'Result_Net')

elseif mixed ==1
        kk = handles.datausing.kk; % 10 times to verify every net
        if kk>nbMixed
            msgbox('The verification nb is bigger than the nb groups of big data!','Warning','Warn')
            return
        end
    
    
    for j = 1:nbMixed
        
        Goal_temp = [];
        Data_temp = [];
        for i = 1:size(data,2)
            x = data(i).data;
            
            if isa(x,'struct')
                DataTemp = x(j).data;
            else
                DataTemp = x;
            end
            
            sizeData = size(DataTemp,2);
            
            GoalTemp = ones(1,sizeData)*i;
            
            Goal_temp = [Goal_temp GoalTemp];
            Data_temp = [Data_temp DataTemp];
            
            DataStruc(j).data = Data_temp;
            GoalStruc(j).goal = Goal_temp;
        end
        
    end
    


    Nc = handles.datausing.Nc;
    % parameterize  
    n = 1000;
    err_glob = 0.001;
    lr0 = 1;
    lr_dec = 0.9;
    lr_inc = 1.1;
    err_ratio = 1;
    lr = [lr0 lr_dec, lr_inc, err_ratio];
    optionbase = [1 2 3 4 5 6 7];
    option = optionbase(Nc==1);
    Loption = size(option,2);
    lamda = 0.5;
    affichage = 0;


    % Waitbar
    h = waitbar(0,'1','Name','Progress of System running ...',...
                 'CreateCancelBtn',...
                 'setappdata(gcbf,''canceling'',1)');

    % ---------------------------------------------------
    CountWaitbar = 0;

    % ---------------------------------------------------    


    
    for j = 1:Loption

    Tr = 0;
  
        for k = 1:kk
            
            Goal = ind2vec_zf(GoalStruc(k).goal);
            Data = DataStruc(j).data;
            
            indices = ones(size(DataStruc(k).data,2),1);
            [trainInd,testInd] = crossvalind('holdout',indices,Np);
            data_Train = Data(:,trainInd);
            data_Test  = Data(:,testInd);
            goal_Train = Goal(:,trainInd);
            goal_Test  = Goal(:,testInd);

            
            
            CountWaitbar = CountWaitbar +1;
            waitbar(CountWaitbar/sum(kk*Loption),h,sprintf('%d / %d',CountWaitbar,sum(kk*Loption)))
            pause(0.1)

            model = mlp_ZF_momentum(data_Train,goal_Train,n,err_glob,option(j),lr,lamda,affichage);
            [output Result]  = Output_mlp_ZF(model,data_Test,goal_Test);
            [output_train Result_Train]  = Output_mlp_ZF(model,testAll,goalAll);
            [output_testAll Result_testAll]  = Output_mlp_ZF(model,testAll,goalAll);
            R(j) = Result_testAll.CM.Tr;
            
            if R(j)>Tr
                ResultTemp = Result;
                ResultTemp_Train = Result_Train;
                ResultTemp_testAll = Result_testAll;
                ResultModel = model;
                Tr = R(j);
            end

        end

    Net(j).Result_Test = ResultTemp;
    Net(j).Result_Train = ResultTemp_Train;
    Net(j).Result_testAll = ResultTemp_testAll;
    Net(j).ResultModel = ResultModel;
    end

     indTemp = find(R==max(R));
     ind = indTemp(1);
     str = strcat(['Net ' num2str(ind)]);
     set(handles.part3_text2,'String',str);
    Result_Net.Test = Net(ind).Result_Test;
    Result_Net.Train = Net(ind).Result_Train;
    Result_Net.testAll = Net(ind).Result_testAll;
    Result_Net.Model = Net(ind).ResultModel;

    delete(h)
    clear h
    handles.datausing.Result_Net = Result_Net;
    handles.datausing.Net = Net;
    c = num2str(fix(clock));
    c((isspace(c)))=[];
    cmd1=pwd;
    cmd = strcat(cmd1,'/ANN/model_',c);
    save(cmd,'Result_Net')
    
end
guidata(hObject,handles)


%--------------------------------------------------------------------------
%% Part 3

% --- Executes during object creation, after setting all properties.
function part3_popumenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part3_popumenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in part3_popumenu1.
function part3_popumenu1_Callback(hObject, eventdata, handles)
% hObject    handle to part3_popumenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns part3_popumenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from part3_popumenu1
sel = get(hObject,'Value');
data = handles.datausing.Net;
%if sel==1
    set(handles.part3_table1,'data',data(sel).Result_Test.CM.CM);
    set(handles.part3_table2,'data',data(sel).Result_Test.CM.CM_Num);
    set(handles.part3_table3,'data',data(sel).Result_testAll.CM.CM);
    set(handles.part3_table4,'data',data(sel).Result_testAll.CM.CM_Num);
    
    cmd1 = strcat([num2str(data(sel).Result_Test.CM.Tr*100,4),'%']);
    cmd2 = strcat([num2str(data(sel).Result_testAll.CM.Tr*100,4),'%']);
    set(handles.part3_text8,'string',cmd1)
    set(handles.part3_text10,'string',cmd2)
    
%end

% if sel==2
%     set(handles.part3_table1,'data',data(2).Result_Train.CM.CM);
%     set(handles.part3_table2,'data',data(2).Result_Test.CM.CM);
%     set(handles.part3_table3,'data',data(2).Result_Train.CM.CM_Num);
%     set(handles.part3_table4,'data',data(2).Result_Test.CM.CM_Num);
%     cmd1 = strcat([num2str(data(2).Result_Train.CM.Tr*100,4),'%']);
%     cmd2 = strcat([num2str(data(2).Result_Test.CM.Tr*100,4),'%']);
%     set(handles.part3_text8,'string',cmd1)
%     set(handles.part3_text10,'string',cmd2)
% end   
% 
% if sel==3
%     set(handles.part3_table1,'data',data(3).Result_Train.CM.CM);
%     set(handles.part3_table2,'data',data(3).Result_Test.CM.CM);
%     set(handles.part3_table3,'data',data(3).Result_Train.CM.CM_Num);
%     set(handles.part3_table4,'data',data(3).Result_Test.CM.CM_Num);
%     
%     cmd1 = strcat([num2str(data(3).Result_Train.CM.Tr*100,4),'%']);
%     cmd2 = strcat([num2str(data(3).Result_Test.CM.Tr*100,4),'%']);
%     set(handles.part3_text8,'string',cmd1)
%     set(handles.part3_text10,'string',cmd2)
% end
% 
% if sel==4
%     set(handles.part3_table1,'data',data(4).Result_Train.CM.CM);
%     set(handles.part3_table2,'data',data(4).Result_Test.CM.CM);
%     set(handles.part3_table3,'data',data(4).Result_Train.CM.CM_Num);
%     set(handles.part3_table4,'data',data(4).Result_Test.CM.CM_Num);
%     cmd1 = strcat([num2str(data(4).Result_Train.CM.Tr*100,4),'%']);
%     cmd2 = strcat([num2str(data(4).Result_Test.CM.Tr*100,4),'%']);
%     set(handles.part3_text8,'string',cmd1)
%     set(handles.part3_text10,'string',cmd2)
% end
% 
% if sel==5
%     set(handles.part3_table1,'data',data(5).Result_Train.CM.CM);
%     set(handles.part3_table2,'data',data(5).Result_Test.CM.CM);
%     set(handles.part3_table3,'data',data(5).Result_Train.CM.CM_Num);
%     set(handles.part3_table4,'data',data(5).Result_Test.CM.CM_Num);
%     
%     cmd1 = strcat([num2str(data(5).Result_Train.CM.Tr*100,4),'%']);
%     cmd2 = strcat([num2str(data(5).Result_Test.CM.Tr*100,4),'%']);
%     set(handles.part3_text8,'string',cmd1)
%     set(handles.part3_text10,'string',cmd2)
% end
% 
% if sel==6
%     set(handles.part3_table1,'data',data(6).Result_Train.CM.CM);
%     set(handles.part3_table2,'data',data(6).Result_Test.CM.CM);
%     set(handles.part3_table3,'data',data(6).Result_Train.CM.CM_Num);
%     set(handles.part3_table4,'data',data(6).Result_Test.CM.CM_Num);
%     
%     cmd1 = strcat([num2str(data(6).Result_Train.CM.Tr*100,4),'%']);
%     cmd2 = strcat([num2str(data(6).Result_Test.CM.Tr*100,4),'%']);
%     set(handles.part3_text8,'string',cmd1)
%     set(handles.part3_text10,'string',cmd2)
% end
% 
% if sel==7
%     set(handles.part3_table1,'data',data(7).Result_Train.CM.CM);
%     set(handles.part3_table2,'data',data(7).Result_Test.CM.CM);
%     set(handles.part3_table3,'data',data(7).Result_Train.CM.CM_Num);
%     set(handles.part3_table4,'data',data(7).Result_Test.CM.CM_Num);
%     
%     cmd1 = strcat([num2str(data(7).Result_Train.CM.Tr*100,4),'%']);
%     cmd2 = strcat([num2str(data(7).Result_Test.CM.Tr*100,4),'%']);
%     set(handles.part3_text8,'string',cmd1)
%     set(handles.part3_text10,'string',cmd2)
% end
guidata(hObject,handles)


% --- Executes on button press in makexlsfile.
function makexlsfile_Callback(hObject, eventdata, handles)
% hObject    handle to makexlsfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str1 = pwd;
str2 = strcat(str1,'\results\Result_ANN_',date,'.xls');
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
%Sheet1.Range('A1:C1').ColumnWidth = [28,12,12];

Sheet1.PageSetup.TopMargin = 60;
Sheet1.PageSetup.BottomMargin = 45;
Sheet1.PageSetup.LeftMargin = 45;
Sheet1.PageSetup.RightMargin = 45;

Sheet1.Range('A1:AB500').HorizontalAlignment=3;

Sheet1.Range('A1:I1').MergeCells = 1;
Sheet1.Range('A2:I2').MergeCells = 1;
Sheet1.Range('A1').Value = ' Diagnostic by ANN ';
str = date;
Sheet1.Range('A2').Value = str;
Sheet1.Range('A1:A2').Font.Size = 24;
Sheet1.Range('A1:A2').Font.Bold =2; 
% --------------------------------------------------
% 1 Schema 
Sheet1.Range('A4:I4').MergeCells = 1;
Sheet1.Range('A5:I5').MergeCells = 1;
Sheet1.Range('A4').Value = ' 1 - Schema of Nets  ';
Sheet1.Range('A4').Font.Bold =2; 
path = get(handles.part1_edit1,'string');
Sheet1.Range('A5').Value = path;
PicturePath = [pwd '\ANN\ANN.jpg'];
h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,15,120,400,280);
% --------------------------------------------------
% 2 PARAMETRIZATION 
Sheet1.Range('A30:G30').MergeCells = 1;
Sheet1.Range('A30').Value = ' 2 - Preparation of Nets ';
Sheet1.Range('A30').Font.Bold =2; 
Sheet1.Range('A32').Value = ' Net_1 ';
Sheet1.Range('B32').Value = ' Net_2 ';
Sheet1.Range('C32').Value = ' Net_3 ';
Sheet1.Range('D32').Value = ' Net_4 ';
Sheet1.Range('E32').Value = ' Net_5 ';
Sheet1.Range('F32').Value = ' Net_6 ';
Sheet1.Range('G32').Value = ' Net_7 ';
Sheet1.Range('A32:G32').Font.Bold =2; 

str1table = handles.datausing.Nc;
Sheet1.Range('A33:G33').Value = str1table;

Sheet1.Range('A35:D35').MergeCells = 1;
Sheet1.Range('A35').Value = ' Percent of data for Trainning : ';
Sheet1.Range('E35').Value = get(handles.part1_edit2,'string'); 

Sheet1.Range('A37:D37').MergeCells = 1;
Sheet1.Range('A37').Value = ' Different Situations to Classify : ';

Sample = get(handles.part2_table1,'data');
n = size(Sample);
Sheet1.Range('E37').Value = ' Situation ';
Sheet1.Range('F37').Value = ' Nb Sample ';

for i=1:n
    cmd1 = strcat('E',num2str(37+i));
    cmd2 = strcat('F',num2str(37+i));
    Sheet1.Range(cmd1).Value = num2str(i);
    Sheet1.Range(cmd2).Value = Sample(i);
end
% --------------------------------------------------
% 3 Results
Sheet1.Range('A47:G47').MergeCells = 1;
Sheet1.Range('A47').Value = ' 3 - Result of Nets ';
Sheet1.Range('A47').Font.Bold =2; 
cmd3 = get(handles.part3_popumenu1,'string');
Lcmd3 = length(cmd3);

Lv = 49;
data = handles.datausing.Net;
for i = 1:Lcmd3
    % Table 1
cmd4 = strcat('B',num2str(Lv));
Sheet1.Range(cmd4).Value = cmd3(i);
Sheet1.Range(cmd4).Font.Bold =2; 
Lv = Lv+1;

cmd41 = strcat('F',num2str(Lv));
Sheet1.Range(cmd41).Value = 'Score : ';
cmd42 = strcat('G',num2str(Lv));
Sheet1.Range(cmd42).Value = strcat(num2str(data(i).Result_Train.CM.Tr*100,4),'%');

cmd5 = strcat('C',num2str(Lv));
Sheet1.Range(cmd5).Value = 'Trainning';
Sheet1.Range(cmd5).Font.Bold =2; 
Lv = Lv + 1;

data1  = data(i).Result_Train.CM.CM;
[m,n] = size(data1);
cmd7 = char(67+n-1);
cmd6 = strcat('C',num2str(Lv),':',cmd7,num2str(Lv+m-1));
Sheet1.Range(cmd6).Value = data1;
Lv = Lv+m+1;

Sheet1.Range(cmd6).Borders.Weight = 3;
Sheet1.Range(cmd6).Borders.Item(1).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(2).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(3).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(4).Linestyle = 1;

   % Table 2
cmd4 = strcat('B',num2str(Lv));
Sheet1.Range(cmd4).Value = cmd3(i);
Sheet1.Range(cmd4).Font.Bold =2; 
Lv = Lv+1;

cmd5 = strcat('C',num2str(Lv));
Sheet1.Range(cmd5).Value = 'Trainning';
Sheet1.Range(cmd5).Font.Bold =2; 
Lv = Lv + 1;

data2  = data(i).Result_Train.CM.CM_Num;
[m,n] = size(data2);
cmd7 = char(67+n-1);
cmd6 = strcat('C',num2str(Lv),':',cmd7,num2str(Lv+m-1));
Sheet1.Range(cmd6).Value = data2;
Lv = Lv+m+1;

Sheet1.Range(cmd6).Borders.Weight = 3;
Sheet1.Range(cmd6).Borders.Item(1).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(2).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(3).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(4).Linestyle = 1;

   % Table 3
cmd4 = strcat('B',num2str(Lv));
Sheet1.Range(cmd4).Value = cmd3(i);
Sheet1.Range(cmd4).Font.Bold =2; 
Lv = Lv+1;

cmd41 = strcat('F',num2str(Lv));
Sheet1.Range(cmd41).Value = 'Score : ';
cmd42 = strcat('G',num2str(Lv));
Sheet1.Range(cmd42).Value = strcat(num2str(data(i).Result_Test.CM.Tr*100,4),'%');

cmd5 = strcat('C',num2str(Lv));
Sheet1.Range(cmd5).Value = 'Test';
Sheet1.Range(cmd5).Font.Bold =2; 
Lv = Lv + 1;

data3  = data(i).Result_Train.CM.CM;
[m,n] = size(data3);
cmd7 = char(67+n-1);
cmd6 = strcat('C',num2str(Lv),':',cmd7,num2str(Lv+m-1));
Sheet1.Range(cmd6).Value = data3;
Lv = Lv+m+1;

Sheet1.Range(cmd6).Borders.Weight = 3;
Sheet1.Range(cmd6).Borders.Item(1).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(2).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(3).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(4).Linestyle = 1;

   % Table 4
cmd4 = strcat('B',num2str(Lv));
Sheet1.Range(cmd4).Value = cmd3(i);
Sheet1.Range(cmd4).Font.Bold =2; 
Lv = Lv+1;

cmd5 = strcat('C',num2str(Lv));
Sheet1.Range(cmd5).Value = 'Test';
Sheet1.Range(cmd5).Font.Bold =2; 
Lv = Lv + 1;

data4  = data(i).Result_Test.CM.CM_Num;
[m,n] = size(data4);
cmd7 = char(67+n-1);
cmd6 = strcat('C',num2str(Lv),':',cmd7,num2str(Lv+m-1));
Sheet1.Range(cmd6).Value = data4;

Sheet1.Range(cmd6).Borders.Weight = 3;
Sheet1.Range(cmd6).Borders.Item(1).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(2).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(3).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(4).Linestyle = 1;

Lv = Lv+m+2;
end


% --- Executes on button press in pushbuttonTest.
function pushbuttonTest_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf);
ANN_2;


% --- Executes on button press in part2_mixed.
function part2_mixed_Callback(hObject, eventdata, handles)
% hObject    handle to part2_mixed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of part2_mixed



function part2_mixedEdit_Callback(hObject, eventdata, handles)
% hObject    handle to part2_mixedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part2_mixedEdit as text
%        str2double(get(hObject,'String')) returns contents of part2_mixedEdit as a double


% --- Executes during object creation, after setting all properties.
function part2_mixedEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part2_mixedEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
