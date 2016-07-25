function varargout = DiagnosticGMM(varargin)
% DIAGNOSTICGMM MATLAB code for DiagnosticGMM.fig
%      DIAGNOSTICGMM, by itself, creates a new DIAGNOSTICGMM or raises the existing
%      singleton*.
%
%      H = DIAGNOSTICGMM returns the handle to a new DIAGNOSTICGMM or the handle to
%      the existing singleton*.
%
%      DIAGNOSTICGMM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIAGNOSTICGMM.M with the given input arguments.
%
%      DIAGNOSTICGMM('Property','Value',...) creates a new DIAGNOSTICGMM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DiagnosticGMM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DiagnosticGMM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DiagnosticGMM

% Last Modified by GUIDE v2.5 04-Jan-2012 15:19:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DiagnosticGMM_OpeningFcn, ...
                   'gui_OutputFcn',  @DiagnosticGMM_OutputFcn, ...
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


% --- Executes just before DiagnosticGMM is made visible.
function DiagnosticGMM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DiagnosticGMM (see VARARGIN)

% Choose default command line output for DiagnosticGMM
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DiagnosticGMM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DiagnosticGMM_OutputFcn(hObject, eventdata, handles) 
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
TableContents


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
datause = load(path);
data =  datause.dataNorma;
handles.datausing = data;
set(hObject,'string','OK');
guidata(hObject,handles);






% --- Executes on button press in part1_button2.
function part1_button2_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PercentTrain = get(handles.part1_edit2,'String');
PercentTrain = str2double(PercentTrain);
if (PercentTrain>=1)||(PercentTrain<=0)
    msgbox('Percentage must be a value between 0 and 1 !')
end
handles.datausing.percentTrain = PercentTrain;

data = handles.datausing.Situation;
n = size(data,2);
nbSample = zeros(n,1);
for i = 1:n
    nbSample(i) = size(data(i).data,2);
end
set(handles.part1_table1,'data',nbSample);

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

function part1_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit1 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit1 as a double


% --- Executes on button press in part3_button1.
function part3_button1_Callback(hObject, eventdata, handles)
% hObject    handle to part3_button1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = handles.datausing.Situation;
DataPCA = handles.datausing.PCAData;
%save('dataPCA','DataPCA')
Np = 1-handles.datausing.percentTrain;
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [mtrs, omtr] = GaussianMixture(pixels, initK, finalK, verbose)
% - pixels is a NxM matrix, containing N training vectors, each of M-dimensional
% - start with initK=20 initial clusters
% - finalK=0 means estimate the optimal order
% - verbose=true displays clustering information
% - mtrs is an array of structures, each containing the cluster parameters of the
%   mixture of a particular order
% - omtr is a structure containing the cluster parameters of the mixture with
%   the estimated optimal order

% Waitbar
h = waitbar(0,'1','Name','Progress of System running ...',...
             'CreateCancelBtn',...
             'setappdata(gcbf,''canceling'',1)');
CountWaitbar = 0;

% ---------------------------------------------------
% data without ACP
for i = 1:size(data,2)
    
dataTemp = (data(i).data)';
indices = ones(size(dataTemp,1),1);

[trainInd,testInd] = crossvalind('holdout',indices,Np);
data_Train = dataTemp(trainInd,:);
data_Test  = dataTemp(testInd,:);

[Mtrs(i).mtrs, Class(i).class] = GaussianMixture(data_Train, 40, 0, false);
%disp(sprintf('\toptimal order K*: %d', Class(1).class1.K));

Data(i).dataTrain = data_Train;
Data(i).dataTest = data_Test;

end

L = size(Mtrs(i).mtrs,2);
Taux_Rec = zeros(L,1);

for ii = 1:L
 waitbar(CountWaitbar/80,h,sprintf('%d / %d',CountWaitbar,80))
 pause(0.1)
 CountWaitbar =CountWaitbar +1 ;
    for i = 1:size(data,2)

        TestDataTemp = Data(i).dataTest; 
        likelihood=zeros(size(TestDataTemp,1), 2);
    
        for j = 1:size(data,2)
            likelihood(:,j) = GMClassLikelihood(Mtrs(j).mtrs(ii), TestDataTemp);
        end
    
        for k = 1:size(TestDataTemp,1)
            classTest(k) = find(likelihood(1,:)==max(likelihood(1,:)));
            classGoal(k) = i;
        end
        
        Result(i).Test = classTest;
        Result(i).Goal = classGoal;
        clear TestDataTemp% likelihood classTest classGoal
    end
    
    Output = [];
    Target = [];
    for i = 1:size(data,2)
    Output = [Output Result(i).Test];
    Target = [Target Result(i).Goal];
    end
    MatrixConf(ii).Confusion=MatrixConf_ZF(Target,Output);    
    Taux_Rec(ii) = MatrixConf(ii).Confusion.Tr;
end

    indice = find(Taux_Rec==max(Taux_Rec));
    index = indice(1);
    ResultWithoutPCA_Best = MatrixConf(index).Confusion;

% ---------------------------------------------------
% figure
    newFig = figure('visible','off');
    plot(1:L,Taux_Rec,'r*');
    hold on
    plot(1:L,Taux_Rec,'b-.');
    title('Le Taux de reconnaissance en fonction de K')
    ylabel('Pourcentage du taux de reconnaissance')
    xlabel('Nombre des mixtures : K')
    c = num2str(fix(clock));
    c(find(isspace(c)))=[];
    cmd =strcat('.\GMM\K_mixture_WithoutPCA_',c);
    print(newFig,'-dpng',cmd);
    print(newFig,'-dpng','GMM2')
    hold off

    axes(handles.part3_axes1)
    plot(1:L,Taux_Rec,'r*');
    hold on
    plot(1:L,Taux_Rec,'b-.');
    title('TR en fonction de K')
    ylabel('Pourcentage du taux de reconnaissance')
    xlabel('Nombre des mixtures : K')
    ylim([0 1])
    hold off
    clear data
    handles.datausing.ResultWithoutPCA = MatrixConf;
    handles.datausing.ResultWithoutPCA_Best =  ResultWithoutPCA_Best;
%save('Test1','MatrixConf','ResultWithoutPCA_Best')
    % ---------------------------------------------------
% ---------------------------------------------------
% data with ACP
data = DataPCA;
%save('Test2','data')
clear Mtrs Class data_Train data_Test likelihood classTest classGoa Result
for i = 1:size(data,2)

dataTemp = (data(i).newValue)';
indices = ones(size(dataTemp,1),1);

[trainInd,testInd] = crossvalind('holdout',indices,Np);
data_Train = dataTemp(trainInd,:);
data_Test  = dataTemp(testInd,:);
%save('Test3','data_Train')
[Mtrs(i).mtrs, Class(i).class] = GaussianMixture(data_Train, 40, 0, false);
%disp(sprintf('\toptimal order K*: %d', Class(1).class1.K));

Data(i).dataTrain = data_Train;
Data(i).dataTest = data_Test;

% for i=1:class1.K
%    disp(sprintf('\tCluster %d:', i));
%    disp(sprintf('\t\tpi: %f', class1.cluster(i).pb));
%    disp([sprintf('\t\tmean: '), mat2str(class1.cluster(i).mu',6)]);
%    disp([sprintf('\t\tcovar: '), mat2str(class1.cluster(i).R,6)]);
% end

end

% disp('performing maximum likelihood classification...');
% disp('for each test vector, the following calculates the log-likelihood given each of the two classes, and classify');
% disp('the first half of the samples are generated from class 1, the remaining half from class 2');
% disp(' ');

L = size(Mtrs(i).mtrs,2);
Taux_Rec = zeros(L,1);

for ii = 1:L
 waitbar(CountWaitbar/80,h,sprintf('%d / %d',CountWaitbar,80))
 pause(0.1)
 CountWaitbar =CountWaitbar +1 ;
    for i = 1:size(data,2)

        TestDataTemp = Data(i).dataTest; 
        likelihood=zeros(size(TestDataTemp,1), 2);
    
        for j = 1:size(data,2)
            likelihood(:,j) = GMClassLikelihood(Mtrs(j).mtrs(ii), TestDataTemp);
        end
    
        for k = 1:size(TestDataTemp,1)
            classTest(k) = find(likelihood(1,:)==max(likelihood(1,:)));
            classGoal(k) = i;
        end
        
        Result(i).Test = classTest;
        Result(i).Goal = classGoal;
        clear TestDataTemp% likelihood classTest classGoal
    end
    
    Output = [];
    Target = [];
    for i = 1:size(data,2)
    Output = [Output Result(i).Test];
    Target = [Target Result(i).Goal];
    end
    MatrixConf(ii).Confusion=MatrixConf_ZF(Target,Output);    
    Taux_Rec(ii) = MatrixConf(ii).Confusion.Tr;
end

    indice = find(Taux_Rec==max(Taux_Rec));
    index = indice(1);
    ResultWithPCA_Best = MatrixConf(index).Confusion;
% ---------------------------------------------------
% figure
    newFig = figure('visible','off');
    plot(1:L,Taux_Rec,'r*');
    hold on
    plot(1:L,Taux_Rec,'b-.');
    title('Le Taux de reconnaissance en fonction de K')
    ylabel('Pourcentage du taux de reconnaissance')
    xlabel('Nombre des mixtures : K')
    c = num2str(fix(clock));
    c(find(isspace(c)))=[];
    cmd =strcat('.\GMM\K_mixture_WithPCA_',c);
    print(newFig,'-dpng',cmd);
    print(newFig,'-dpng','GMM3')
    hold off
    
    axes(handles.part3_axes2)
    plot(1:L,Taux_Rec,'r*');
    hold on
    plot(1:L,Taux_Rec,'b-.');
    title('TR en fonction de K')
    ylabel('Pourcentage du taux de reconnaissance')
    xlabel('Nombre des mixtures : K')
    ylim([0 1])
    hold off

    handles.datausing.ResultWithPCA = MatrixConf;
    handles.datausing.ResultWithPCA_Best =  ResultWithPCA_Best;

    delete(h)
    clear h
    
    set(handles.part3_table1,'data',ResultWithoutPCA_Best.CM_Num)
    set(handles.part3_table2,'data',ResultWithPCA_Best.CM_Num)
    
    cmd1 = strcat([num2str(ResultWithoutPCA_Best.Tr*100,4),'%']);
    cmd2 = strcat([num2str(ResultWithPCA_Best.Tr*100,4),'%']);
    set(handles.part3_text4,'string',cmd1)
    set(handles.part3_text6,'string',cmd2)
    
    

guidata(hObject,handles)




% --- Executes on button press in part1_button3.
function part1_button3_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NbDel = str2double(get(handles.part1_edit3,'String'));
data = handles.datausing.Situation;
if (NbDel>length(data))||(NbDel<1)
    msgbox('Check the nb of class to be delected !')
end
handles.datausing.Situation(NbDel) = [];
data(NbDel) = [];
% update the table 2.1

n = size(data,2);
nbSample = zeros(n,1);
for i = 1:n
    nbSample(i) = size(data(i).data,2);
end
set(handles.part1_table1,'data',nbSample);
set(handles.part1_edit3,'String','');
guidata(hObject,handles)

% --- Executes on button press in part1_button4.
function part1_button4_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
merge1 = str2double(get(handles.part1_edit4,'String'));
merge2 = str2double(get(handles.part1_edit5,'String'));
data = handles.datausing.Situation;
if (merge1>size(data,2))||(merge1<=0)||(merge2>size(data,2))||(merge2<=0)||(merge1==merge2)
    msgbox('Percentage must be a value between 0 and 1 !')
    return
end
data(merge1).data = [data(merge1).data data(merge2).data];
data(merge2) = [];

% re organize the Situation
n = size(data,2);
for i = 1:n
    GoalVector = zeros(n,1);
    GoalVector(i) = 1;
    data(i).GoalVector = repmat(GoalVector,1,size(data(i).data,2)); 
    data(i).GoalInd = i; 
end
handles.datausing.Situation = data;

% update the table 2.1
n = size(data,2);
nbSample = zeros(n,1);
for i = 1:n
    nbSample(i) = size(data(i).data,2);
end
set(handles.part1_table1,'data',nbSample);
set(handles.part1_edit4,'String','');set(handles.part1_edit5,'String','');
guidata(hObject,handles)

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


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit3.
function part1_edit3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end



function part1_edit5_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit5 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit5 as a double


% --- Executes during object creation, after setting all properties.
function part1_edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit4.
function part1_edit4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit5.
function part1_edit5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end





function part1_edit6_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit6 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit6 as a double


% --- Executes during object creation, after setting all properties.
function part1_edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function part1_edit7_Callback(hObject, eventdata, handles)
% hObject    handle to part1_edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part1_edit7 as text
%        str2double(get(hObject,'String')) returns contents of part1_edit7 as a double


% --- Executes during object creation, after setting all properties.
function part1_edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in part1_button5.
function part1_button5_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NbVector = str2double(get(handles.part1_edit6,'string'));
NbSample = str2double(get(handles.part1_edit7,'string'));
data = handles.datausing.Situation;
Data = data(NbVector).data;
Goal = data(NbVector).GoalVector;
NbTotalSample = size(Data,2);
p = randperm(NbTotalSample);
DataTemp = Data(:,p(1:NbSample));
GoalTemp = Goal(:,p(1:NbSample));
data(NbVector).data = DataTemp;
data(NbVector).GoalVector = GoalTemp ;
handles.datausing.Situation = data;

% update the table 2.1
n = size(data,2);
nbSample = zeros(n,1);
for i = 1:n
    nbSample(i) = size(data(i).data,2);
end
set(handles.part1_table1,'data',nbSample);
set(handles.part1_edit6,'String','');set(handles.part1_edit7,'String','');
%save('TestGMM','data')
guidata(hObject,handles)






% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit6.
function part1_edit6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit7.
function part1_edit7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part1_edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end


% --- Executes on button press in makexlsfile.
function makexlsfile_Callback(hObject, eventdata, handles)
% hObject    handle to makexlsfile (see GCBO)
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
Sheet3 = Workbook.Sheets.Item(3);
SheetHandle = Workbook.Sheet.Add([],Sheet3,1,[]);
Sheet1 = Sheets.Item(4);
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
Sheet1.Range('A1').Value = ' Diagnostic by GMM ';
str = date;
Sheet1.Range('A2').Value = str;
Sheet1.Range('A1:A2').Font.Size = 24;
Sheet1.Range('A1:A2').Font.Bold =2; 
% --------------------------------------------------
% 1 Schema 
Sheet1.Range('A4:I4').MergeCells = 1;
Sheet1.Range('A5:I5').MergeCells = 1;
Sheet1.Range('A4').Value = ' 1 - Parametrization ';
Sheet1.Range('A4').Font.Bold =2; 
path = get(handles.part1_edit1,'string');
Sheet1.Range('A5').Value = path;
% PicturePath = which('figure3.jpg');
% h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,15,120,400,280);
Sheet1.Range('A7:D7').MergeCells = 1;
Sheet1.Range('A7').Value = ' Percent of data for Trainning : ';
Sheet1.Range('E7').Value = get(handles.part1_edit2,'string'); 

Sheet1.Range('A9:D9').MergeCells = 1;
Sheet1.Range('A9').Value = ' Diiferent Situations to Classify : ';

Sample = get(handles.part1_table1,'data');
n = size(Sample);
Sheet1.Range('E9').Value = ' Situation ';
Sheet1.Range('F9').Value = ' Nb Sample ';

for i=1:n
    cmd1 = strcat('E',num2str(9+i));
    cmd2 = strcat('F',num2str(9+i));
    Sheet1.Range(cmd1).Value = num2str(i);
    Sheet1.Range(cmd2).Value = Sample(i);
end

% --------------------------------------------------
% 2 Compression of Data

Sheet1.Range('A20:G20').MergeCells = 1;
Sheet1.Range('A20').Value = ' 2 - Compression of Data - GMM ';
Sheet1.Range('A20').Font.Bold =2; 
% Sheet1.Range('G32').Value = ' Net_ATT ';
% Sheet1.Range('A32:G32').Font.Bold =2; 
Sheet1.Range('A22:D22').MergeCells = 1;
Sheet1.Range('A22').Value = ' Percent of Variance Explained : ';
cmd = strcat(get(handles.part1_edit2,'string'),'%');
Sheet1.Range('E22').Value = cmd; 

Sheet1.Range('B23:F23').MergeCells = 1;
Sheet1.Range('B23').Value = get(handles.part2_text1,'string');

%cmd = handles.datausing.figCmd_Parento;
PiturePath = which('GMM1.png');
h1 = Excel.ActiveSheet.Shapes.AddPicture(PiturePath,0,1,15,400,400,280);

% --------------------------------------------------
% 3 Resultats
data1 = handles.datausing.ResultWithoutPCA_Best.CM_Num;
data2 = handles.datausing.ResultWithPCA_Best.CM_Num;

Sheet1.Range('A47:G47').MergeCells = 1;
Sheet1.Range('A47').Value = ' 3 - Result of GMM ';
Sheet1.Range('A47').Font.Bold =2; 
Sheet1.Range('B49:G49').MergeCells = 1;
Sheet1.Range('B49').Value = ' --- Result without PCA --- ';
Sheet1.Range('B49').Font.Bold =2; 


PiturePath = which('GMM2.png');
h1 = Excel.ActiveSheet.Shapes.AddPicture(PiturePath,0,1,15,760,400,280);

    % Table 1
Sheet1.Range('B70:C70').MergeCells = 1;
Sheet1.Range('B70').Value = 'Score : ';
Sheet1.Range('D70').Value = get(handles.part3_text4,'string');

Lv=71;
[m,n] = size(data1);
cmd7 = char(67+n-1);
cmd6 = strcat('C',num2str(Lv),':',cmd7,num2str(Lv+m-1));
Sheet1.Range(cmd6).Value = data1;
Sheet1.Range(cmd6).Borders.Weight = 3;
Sheet1.Range(cmd6).Borders.Item(1).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(2).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(3).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(4).Linestyle = 1;

   % Table 2
Sheet1.Range('L49:P49').MergeCells = 1;
Sheet1.Range('L49').Value = ' --- Result without PCA --- ';
Sheet1.Range('L49').Font.Bold =2; 

PiturePath = which('GMM2.png');
h2 = Excel.ActiveSheet.Shapes.AddPicture(PiturePath,0,1,450,760,400,280);

Sheet1.Range('l70:M70').MergeCells = 1;
Sheet1.Range('L70').Value = 'Score : ';
Sheet1.Range('N70').Value = get(handles.part3_text6,'string');

Lv=71;
[m,n] = size(data2);
cmd7 = char(77+n-1);
cmd6 = strcat('M',num2str(Lv),':',cmd7,num2str(Lv+m-1));
Sheet1.Range(cmd6).Value = data1;
Sheet1.Range(cmd6).Borders.Weight = 3;
Sheet1.Range(cmd6).Borders.Item(1).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(2).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(3).Linestyle = 1;
Sheet1.Range(cmd6).Borders.Item(4).Linestyle = 1;

% --- Executes on button press in part2_pushbutton1.
function part2_pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to part2_pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = handles.datausing.Situation;
%save('Test5','Data')
PercentPCA = handles.datausing.PercentPCA;
LData = size(Data,2);
DataTotal = [];
nData = zeros(1,LData);
for i = 1:LData
    nData(i) =  size(Data(i).data,2);% length of data of each situation
    DataTotal = [DataTotal Data(i).data];
end
DataTotal = DataTotal';
% save('Test6','DataTotal')
[vectors, coeff, newValue0, ValueForDraw,percent_explained] = acp_zf(DataTotal,PercentPCA,0);
% Figure of Percent Explained
%save('Test4','newValue0')
newFig = figure('visible','off');
bar(percent_explained(1:size(newValue0,2)));
axis([0 size(newValue0,2)+1 0 100]);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis')

pathFig = pwd;
pathFig = strcat(pathFig,'\figures\');
s = mkdir(pathFig,date);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
end
nameGMM = strcat(pathFig,date,'\DiagGMM');
print(newFig,'-dpng',nameGMM)
saveas(gcf,nameGMM);

axes(handles.part2_axes1)
bar(percent_explained(1:size(newValue0,2)));
axis([0 size(newValue0,2)+1 0 100]);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Principal Component Analysis ')

newValue0 = newValue0';
SizeNewValue0 = size(newValue0,1);
cmd = ['The nb of vectors used by GMM is ', num2str(SizeNewValue0)];
set(handles.part2_text1,'string',cmd);

DataPCA(1).newValue = newValue0(:,1:nData(1));
nbLast = 0;
for i = 2:length(nData)
 nbLast = nbLast+nData(i-1);  
DataPCA(i).newValue = newValue0(:,(nbLast+1:nbLast+nData(i)));
end

handles.datausing.PCAData = DataPCA; 
set(hObject,'String','OK')
%save('DataGMMPCA','DataPCA')
guidata(hObject,handles)



function part2_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to part2_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of part2_edit1 as text
%        str2double(get(hObject,'String')) returns contents of part2_edit1 as a double


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


% --- Executes on button press in part2_pushbutton2.
function part2_pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to part2_pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PercentPCA = str2double(get(handles.part2_edit1,'String'));
handles.datausing.PercentPCA = PercentPCA;
set(hObject,'string','OK')
guidata(hObject,handles)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part2_edit1.
function part2_edit1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to part2_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end
