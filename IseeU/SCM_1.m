function varargout = SCM_1(varargin)
%SCM_1 M-file for SCM_1.fig
%      SCM_1, by itself, creates a new SCM_1 or raises the existing
%      singleton*.
%
%      H = SCM_1 returns the handle to a new SCM_1 or the handle to
%      the existing singleton*.
%
%      SCM_1('Property','Value',...) creates a new SCM_1 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to SCM_1_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SCM_1('CALLBACK') and SCM_1('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SCM_1.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SCM_1

% Last Modified by GUIDE v2.5 19-Nov-2012 00:24:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SCM_1_OpeningFcn, ...
                   'gui_OutputFcn',  @SCM_1_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before SCM_1 is made visible.
function SCM_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
% filename = [pwd '/SCM/SCM.jpg'];
% PIC = imread(filename);
% axes(handles.axes11)
% image(PIC);
% axis off
% % Choose default command line output for SCM_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SCM_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = SCM_1_OutputFcn(hObject, eventdata, handles)
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


%% ------------------------------------------------
%    Part1
% --- Executes on button press in part1_button4.

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

% --- Executes on button press in part1_button2.
function part1_button2_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button2 (see GCBO)
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
set(handles.part1_table1,'data',nbSample);

set(hObject,'String','OK')
pause(1)
set(hObject,'String','Apply')

guidata(hObject,handles)



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
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over part1_edit4.

sel = get(gcf,'selectiontype');
if isequal(sel,'open')
   set(hObject,'string','');
   set(hObject,'enable','on')
end



% --- Executes on button press in part1_button3.
function part1_button3_Callback(hObject, eventdata, handles)
% hObject    handle to part1_button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mixed = get(handles.part1_mixed,'Value');
nbMixed = get(handles.part1_edit5,'String');
nbMixed = str2double(nbMixed);
nbMixed = floor(nbMixed);

if nbMixed>100||nbMixed<2
    msgbox('The nb of groups is too small or too big, please choose it within [2-100]','Warning','warn');
end

handles.datausing.nbMixed = nbMixed;
handles.datausing.mixed = mixed;
if  mixed == 0

    NbVector = str2double(get(handles.part1_edit3,'string'));
    NbSample = str2double(get(handles.part1_edit4,'string'));
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
    set(handles.part1_table1,'data',nbSample);
    set(handles.part1_edit3,'String','');set(handles.part1_edit4,'String','');

elseif mixed==1
    
    NbVector = str2double(get(handles.part1_edit3,'string'));
    NbSample = str2double(get(handles.part1_edit4,'string'));
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
    set(handles.part1_table1,'data',nbSample);
    set(handles.part1_edit3,'String','');set(handles.part1_edit4,'String','');

end
     
guidata(hObject,handles)

%% ------------------------------------------------
%    Part 2

% --- Executes on button press in part2_button2.
function part2_button2_Callback(hObject, eventdata, handles)
% hObject    handle to part2_button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in part2_button3.
function part2_button3_Callback(hObject, eventdata, handles)
% hObject    handle to part2_button3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mixed = handles.datausing.mixed;
nbMixed = handles.datausing.nbMixed;

nbVectorFix = get(handles.part2_edit1,'String');
nbVectorFix = str2double(nbVectorFix);
nbVectorFix = floor(nbVectorFix);

data = handles.datausing.Situation;
dataForSize = data(1).data;

if isa(dataForSize,'struct')
    sizeData = size(dataForSize(1).data,1);
else
    sizeData = size(data(1).data,1);
end
            
if (nbVectorFix<1)||(nbVectorFix>sizeData)
    cmdStr = strcat(['Please choose a number between 0 and ',num2str(sizeData)]); 
    errordlg(cmdStr)
    return
end

handles.datausing.nbVectorFix = nbVectorFix;
Np = 1-handles.datausing.percentTrain;
ErrorTarget = 0;

Data = [];
Goal = [];

testAllOri = handles.datausing.testAll;
goalAll = handles.datausing.goalAll;
goalAll = goalAll';

% goalAll = cell(size(goalAll_temp,1),1);
% 
% for i = min(goalAll_temp):max(goalAll_temp)
%     goalSize = size(find(goalAll_temp==i),1);
%     goalAll(goalAll_temp==i) = {strcat('Situation',num2str(i))};
% end
% numel(cell2mat(strfind(goalAll,'Situation2'))==1)
% ans = 199


if mixed==0 
        
        Goal_temp = [];
        Data_temp = [];
        for i = 1:size(data,2)
            x = data(i).data;
            DataTemp = x';
                       
            sizeData = size(DataTemp,1);
            
            GoalTemp = repmat(i,sizeData,1);
            
            Goal_temp = [Goal_temp;GoalTemp];
            Data_temp = [Data_temp;DataTemp];
        end
        
    Data = Data_temp;
    Goal = Goal_temp;
    LDA_ZF =SCM_Pretreat(Data,Goal); 
    V = LDA_ZF.V;
    testAll = testAllOri'*V';
    
    Data = LDA_ZF.DataNew;
    Goal = LDA_ZF.Goal;

    Indice = ones(length(Data(:,1)),1);
    [trainInd,testInd] = crossvalind('holdout',Indice,Np);

    Data_Train = Data(trainInd,:);
    Goal_Train = Goal(trainInd,:);
    Data_Test = Data(testInd,:);
    Goal_Test = Goal(testInd,:);

   % [SCR_ZF,Cnew,MatriceConfusion,CentersFinal,kCalcul,NbOfPoint] = SCR_Learn_4Faults(Data_Train,Goal_Train,nbVectorFix,ErrorTarget,Data_Test,Goal_Test); 
    SCR_1 = SCR_Learn_1Step(Data_Train,Goal_Train,nbVectorFix,ErrorTarget,Data_Test,Goal_Test); 
    
    DataNew = SCR_1.Data; % recharge the new data after LDA
    Coord = SCR_1.Coord;
    mIndex = SCR_1.mIndex;
    Goal = SCR_1.Goal;
    ErrorTarget = SCR_1.ErrorTarget;
    Data_Test = SCR_1.Data_Test;
    Goal_Test = SCR_1.Goal_Test; 
    
    k = size(Coord,1);
    [LengthData SizeData]= size(DataNew);
    NbPoint = 0;
    kCalcul = 1;
    flag = 1;
    error = 1;
    tempCenters2 = [];    
    while (error>ErrorTarget)&&(flag==1)
            tic
            GoalRestTemp = [];
            IndRest = [];

         %% Calculation of the centers and their variances

            for i = 1:k

                for j = 1:k

                    if (i~=j)&&(isempty(Coord(i,j).coordinate)==0)
                            tempInd = Coord(i,j).coordinate;
                            temp = DataNew(tempInd,:);
                            % Trouver les Data Restes et ses Goals
                            IndRest = [IndRest;tempInd];
                            LengthGoalTest = length(tempInd);
                            GoalRest = repmat(i,LengthGoalTest,1);
                            GoalRest = [GoalRestTemp;GoalRest];
                            GoalRestTemp = GoalRest;

                            while size(temp,1)==1
                            temp = [zeros(1,SizeData);temp];
                            end

                            Centers2(i,j).mean = mean(temp); 
                            Centers2(i,j).var = var(temp);
                            NbPoint = NbPoint+1;

                            % Calculation of the Point who is near the center
                            tempData = DataNew(tempInd,:);
                            tempCenter = Centers2(i,j).mean;

                            DistP2P = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                            IndDistP2P = find(DistP2P==min(DistP2P));    
                            tempCenter = tempData(IndDistP2P(1),:); % avoid more than 2 points have the same min dist

                            % Calulation of the Point who is nearby the real center 
                            kIndP2P = 1;

                            while kIndP2P == 1

                                DistP2P_1 = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                                IndDistP2P_1 = find(DistP2P_1==min(DistP2P_1));    
                                tempCenter_1 = tempData(IndDistP2P_1,:);

                                DistP2P_2 = sum(((tempData - repmat(tempCenter_1,size(tempData,1),1))).^2,2);
                                IndDistP2P_2 = find(DistP2P_2==min(DistP2P_2));    
                                tempCenter_2 = tempData(IndDistP2P_2,:);                    

                                Verify_temp=sum(tempCenter==tempCenter_2)/length(tempCenter);
                                if (DistP2P_1(IndDistP2P_1) == DistP2P_2(IndDistP2P_2))&&(Verify_temp==1)
                                    kIndP2P = 2;
                                end

                                tempCenter=tempCenter_1;
                            end
                            Centers2(i,j).mean = tempCenter;

                            clear tempInd temp tempData IndDistP2P Verify_temp tempCenter DistP2P kIndP2P DistP2P_1 DistP2P_2 IndDistP2P_1 IndDistP2P_2 tempCenter_1 tempCenter_2

                    else if (i==j)&&(isempty(Coord(i,j).coordinate)==0)&&(kCalcul==1)

                            tempInd = Coord(i,j).coordinate;
                            temp = DataNew(tempInd,:);             

                            while size(temp,1)==1
                            temp = [zeros(1,SizeData);temp];
                            end

                            Centers2(i,j).mean = mean(temp); 
                            Centers2(i,j).var = var(temp);

                            NbPoint = NbPoint+1;

                            % Calculation of the Point who is near the center
                            tempData = DataNew(tempInd,:);
                            tempCenter = Centers2(i,j).mean;

                            DistP2P = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                            IndDistP2P = find(DistP2P==min(DistP2P));    
                            tempCenter = tempData(IndDistP2P(1),:);

                            % Calulation of the Point who is nearby the real center 
                            kIndP2P = 1;

                            while kIndP2P == 1

                                DistP2P_1 = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                                IndDistP2P_1 = find(DistP2P_1==min(DistP2P_1));    
                                tempCenter_1 = tempData(IndDistP2P_1,:);

                                DistP2P_2 = sum(((tempData - repmat(tempCenter_1,size(tempData,1),1))).^2,2);
                                IndDistP2P_2 = find(DistP2P_2==min(DistP2P_2));    
                                tempCenter_2 = tempData(IndDistP2P_2,:);                    

                                Verify_temp=sum(tempCenter==tempCenter_2)/length(tempCenter);
                                if (DistP2P_1(IndDistP2P_1) == DistP2P_2(IndDistP2P_2))&&(Verify_temp==1)
                                    kIndP2P = 2;
                                end

                                tempCenter=tempCenter_1;
                            end
                            Centers2(i,j).mean = tempCenter;

                            clear tempInd temp tempData IndDistP2P Verify_temp tempCenter DistP2P kIndP2P DistP2P_1 DistP2P_2 IndDistP2P_1 IndDistP2P_2 tempCenter_1 tempCenter_2

                            else if(i==j)&&(isempty(Coord(i,j).coordinate)==0)&&(kCalcul>1)
                                 Centers2(i,j).var = inf(1,SizeData);
                                 Centers2(i,j).mean = inf(1,SizeData); 


                                else if (i~=j)&&(isempty(Coord(i,j).coordinate)==1)

                                    Centers2(i,j).var = inf(1,SizeData);
                                    Centers2(i,j).mean = inf(1,SizeData); 



                                    else if(i==j)&&(isempty(Coord(i,j).coordinate)==1)
                                      Centers2(i,j).var = inf(1,SizeData);
                                      Centers2(i,j).mean = inf(1,SizeData); 
                                        end
                                    end
                                end
                        end
                    end

                end

            end

            CentersFinal = [tempCenters2 Centers2]; % midification ///
            %disp(CentersFinal)
            tempCenters2 = CentersFinal;
            % disp(['The nb of mistaked points are : ',num2str(length(IndRest))]);
            % -------------------------
            for i = 1:k*kCalcul % Reorganiser the mean and var of the centers 1 2 3 4 5

                VarNewTemp = [];
                MeanNewTemp = [];
                for j = 1:k
                    VarNewTemp = [VarNewTemp;CentersFinal(j,i).var];
                    MeanNewTemp = [MeanNewTemp;CentersFinal(j,i).mean];
                end
                VarNewTotal(i).var = VarNewTemp;
                MeanNewTotal(i).mean = MeanNewTemp;
                clear VarNewTemp MeanNewTemp

            end

            DistTotal = zeros(k,k*kCalcul);

            % For Learning ------------------------------------------------------------
            for i = 1:LengthData
                for ii = 1 : k*kCalcul
                    if isempty(VarNewTotal(ii).var)||isempty(MeanNewTotal(ii).mean)
                        DistTotal(:,ii) = inf(k,1);
                    else
                    dist = sum(((repmat(DataNew(i,1:mIndex),size(MeanNewTotal(ii).mean(:,1:mIndex),1),1)-...
                        MeanNewTotal(ii).mean(:,1:mIndex))).^2,2);

                    dist(isnan(dist)) = inf;

                    DistTotal(:,ii) = dist;
                    
                    end

                end
                
                temp = min(DistTotal,[],2);
                temp1 = find(temp == min(temp));
                Target5Centers(i) = temp1(1);
            end
            CM_ZF_Dist_Centers5 = MatrixConf_ZF(Goal,Target5Centers);

            % for Testing -------------------------------------------------------------
             L_CV = length(Goal_Test);

            for i = 1:L_CV
                for ii = 1 : k*kCalcul
                    if isempty(VarNewTotal(ii).var)||isempty(MeanNewTotal(ii).mean)
                        DistTotal(:,ii) = inf(k,1);
                    else
                    dist = sum(((repmat(Data_Test(i,1:mIndex),size(MeanNewTotal(ii).mean(:,1:mIndex),1),1)-...
                        MeanNewTotal(ii).mean(:,1:mIndex))).^2,2);

                    dist(isnan(dist)) = inf;

                    DistTotal(:,ii) = dist;

                    end

                end
                temp3 = min(DistTotal,[],2);
                temp4 = find(temp3 == min(temp3));
                resultTest(i) = temp4(1);
            end

                ResultCV_Test = MatrixConf_ZF(Goal_Test,resultTest);

                ScoresTest(kCalcul) = ResultCV_Test.Tr*100;
                MatriceConfusion(kCalcul).CM_Test = ResultCV_Test.CM;
                MatriceConfusion(kCalcul).CM_Num_Test = ResultCV_Test.CM_Num;
            % -------------------------------------------------------------------------
            clear Coord
            error = 1-CM_ZF_Dist_Centers5.Tr;
            Scores(kCalcul) = CM_ZF_Dist_Centers5.Tr*100; % pourcentage

            Coord = CM_ZF_Dist_Centers5.Point; % Final CM
            MatriceConfusion(kCalcul).IndexPoints = Coord;
            MatriceConfusion(kCalcul).CM = CM_ZF_Dist_Centers5.CM;
            MatriceConfusion(kCalcul).CM_Num = CM_ZF_Dist_Centers5.CM_Num;

            NbOfPoint(kCalcul)  = NbPoint;

            clear Centers2 Target5Centers

          %% Definir the Flag
            ErrorVerify(kCalcul) = error;
            if (kCalcul>3)&&(ErrorVerify(kCalcul) == ErrorVerify(kCalcul-1))&&(ErrorVerify(kCalcul-1) == ErrorVerify(kCalcul-2)) 
                    flag=2;  
                    CentersFinal = CentersFinal(:,1:end-2);
            end

            kCalcul = kCalcul+1;
      
            cmd1 = strcat(['Iteration : ', num2str(kCalcul)]);
            cmd2 = strcat(['The nb of mistaked points are : ',num2str(length(IndRest))]);
            cmd3 =strcat([('The error of '), num2str(kCalcul),sprintf('th time calculation is '),num2str(error)]);
            cmd4 =strcat([('The nb of centers recent is '), num2str(NbPoint)]);
            cmd5 =strcat('Learning - Confusion Matrix is');
            digits(2);
            cmd6 = char(vpa(CM_ZF_Dist_Centers5.CM_Num));
            cmd7 =strcat('Testing - Confusion Matrix is');
            cmd8 = char(vpa(ResultCV_Test.CM_Num));
            timeUse = toc;
            cmd9 = strcat(['Elapsed time is ', num2str(timeUse),'Seconds']);
            cmd = {cmd1;cmd2;cmd3;cmd4;cmd5;cmd6;cmd7;cmd8;cmd9};

            set(handles.textProcess,'String',cmd);
            set(handles.textProcess,'FontSize',12);
            pause(0.8)
        
    end
    xCenter = find(ScoresTest==max(ScoresTest));
    xCenter = xCenter(1);
    xCenter = NbOfPoint(xCenter);
    kCalcul = kCalcul-1;
    NbOfPointFinal = xCenter;
    set(handles.text36,'string',num2str(NbOfPointFinal));
    
    axes(handles.axes22);
    plot(NbOfPoint,Scores,'r-*')
    hold on
    plot(NbOfPoint,ScoresTest,'b.-')
    xlabel('Nb of the centers')
    ylabel('Scores (Percentage)')
    title('Scores in relation to centers Nb')
    legend(['Learning Cts: ',num2str(NbOfPoint(end))],'Testing CV','location','SE')
    plot(0:0.01:NbOfPointFinal,max(ScoresTest));
    plot(NbOfPointFinal,0:0.01:max(ScoresTest));
    hold off
    
    % Save the figure
    newFig = figure('Visible','off');
    plot(NbOfPoint,Scores,'r-*')
    hold on
    plot(NbOfPoint,ScoresTest,'b.-')
    xlabel('Nb of the centers')
    ylabel('Scores (Percentage)')
    plot(0:0.01:NbOfPointFinal,max(ScoresTest));
    plot(NbOfPointFinal,0:0.01:max(ScoresTest));
    title('Scores in relation to Centers Nb')
    legend(['Learning Cts: ',num2str(NbOfPoint(end))],'Testing CV','location','SE')
    pathFig = pwd;
    pathFig = strcat(pathFig,'\SCM\figures\');

    % make a folder named date to place the figures 
    s = mkdir(pathFig,date);
    if s~=1
        msgbox('There is problem of building a new folder for figures!')
        return
    end
    
    nameFig = strcat(pathFig,date,'\nbScoreSCM');
    saveas(gcf,nameFig);
    print(newFig,'-dpng',nameFig);
    hold off

    
    % Save the results
    pathResults = pwd;
    pathResults = strcat(pathResults,'\SCM\Results\');
    s = mkdir(pathResults,date);
    if s~=1
        msgbox('There is problem of building a new folder for figures!')
        return
    end
    
    nameResults = strcat(pathResults,date,'\modelSCM');

    ResultTest = testClassSCM(CentersFinal,xCenter,mIndex,Data_Test,Goal_Test);
    ResultTestAll = testClassSCM(CentersFinal,xCenter,mIndex,testAll,goalAll);
  
    %ResultTestNoTarget = testClassSCM_NoTarget(CentersFinal,nbCenters,mIndex,testAll);
   
    BestCentersFinal = CenterFinal;
    BestV = V;
    BestMatriceConfusion=MatriceConfusion;
    BestkCalcul=kCalcul;
    BestResultTest=ResultTest;
    BestResultTestAll=ResultTestAll;
    BestNbOfPointFinal=NbOfPointFinal;
    
    save(nameResults, 'BestCentersFinal','BestV','BestMatriceConfusion','BestkCalcul','BestResultTest','BestResultTestAll','BestNbOfPointFinal','mIndex')
    
    set(handles.part3_table1,'data',ResultTest.CM);
    set(handles.part3_table2,'data',ResultTest.CM_Num);
    set(handles.part3_text8,'String',num2str(ResultTest.Tr));
    
    set(handles.part3_table3,'data',ResultTestAll.CM);
    set(handles.part3_table4,'data',ResultTestAll.CM_Num);
    set(handles.part3_text10,'String',num2str(ResultTestAll.Tr));

elseif mixed ==1
   
    for j = 1:nbMixed
        
        Goal_temp = [];
        Data_temp = [];
        for i = 1:size(data,2)
            x = data(i).data;
            
            if isa(x,'struct')
                DataTemp = x(j).data';
            else
                DataTemp = x';
            end
            
            sizeData = size(DataTemp,1);
            
            GoalTemp = repmat(i,sizeData,1);
            
            Goal_temp = [Goal_temp;GoalTemp];
            Data_temp = [Data_temp;DataTemp];

            
            DataStruc(j).data = Data_temp;
            GoalStruc(j).goal = Goal_temp;
        end
        
    end
    
    ScoreRecent = 0;
    
    for nbMix = 1:nbMixed
    
        Data = DataStruc(nbMix).data;
        Goal = GoalStruc(nbMix).goal;

        LDA_ZF =SCM_Pretreat(Data,Goal); 
        V = LDA_ZF.V;
        testAll = testAllOri'*V';
        
        Data = LDA_ZF.DataNew;
        Goal = LDA_ZF.Goal;
        
        Indice = ones(length(Data(:,1)),1);
        [trainInd,testInd] = crossvalind('holdout',Indice,Np);

        Data_Train = Data(trainInd,:);
        Goal_Train = Goal(trainInd,:);
        Data_Test = Data(testInd,:);
        Goal_Test = Goal(testInd,:);        
        
        SCR_1 = SCR_Learn_1Step(Data_Train,Goal_Train,nbVectorFix,ErrorTarget,Data_Test,Goal_Test); 
    
        DataNew = SCR_1.Data; % recharge the new data after LDA
        Coord = SCR_1.Coord;
        mIndex = SCR_1.mIndex;
        Goal = SCR_1.Goal;
        ErrorTarget = SCR_1.ErrorTarget;
        Data_Test = SCR_1.Data_Test;
        Goal_Test = SCR_1.Goal_Test; 
        
        k = size(Coord,1);
        [LengthData SizeData]= size(DataNew);
        NbPoint = 0;
        kCalcul = 1;
        flag = 1;
        error = 1;
        tempCenters2 = [];    
        
     while (error>ErrorTarget)&&(flag==1)
                tic
                GoalRestTemp = [];
                IndRest = [];

             %% Calculation of the centers and their variances

                for i = 1:k

                    for j = 1:k

                        if (i~=j)&&(isempty(Coord(i,j).coordinate)==0)
                                tempInd = Coord(i,j).coordinate;
                                temp = DataNew(tempInd,:);
                                % Trouver les Data Restes et ses Goals
                                IndRest = [IndRest;tempInd];
                                LengthGoalTest = length(tempInd);
                                GoalRest = repmat(i,LengthGoalTest,1);
                                GoalRest = [GoalRestTemp;GoalRest];
                                GoalRestTemp = GoalRest;

                                while size(temp,1)==1
                                temp = [zeros(1,SizeData);temp];
                                end

                                Centers2(i,j).mean = mean(temp); 
                                Centers2(i,j).var = var(temp);
                                NbPoint = NbPoint+1;

                                % Calculation of the Point who is near the center
                                tempData = DataNew(tempInd,:);
                                tempCenter = Centers2(i,j).mean;

                                DistP2P = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                                IndDistP2P = find(DistP2P==min(DistP2P));    
                                tempCenter = tempData(IndDistP2P(1),:); % avoid more than 2 points have the same min dist

                                % Calulation of the Point who is nearby the real center 
                                kIndP2P = 1;

                                while kIndP2P == 1

                                    DistP2P_1 = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                                    IndDistP2P_1 = find(DistP2P_1==min(DistP2P_1));    
                                    tempCenter_1 = tempData(IndDistP2P_1,:);

                                    DistP2P_2 = sum(((tempData - repmat(tempCenter_1,size(tempData,1),1))).^2,2);
                                    IndDistP2P_2 = find(DistP2P_2==min(DistP2P_2));    
                                    tempCenter_2 = tempData(IndDistP2P_2,:);                    

                                    Verify_temp=sum(tempCenter==tempCenter_2)/length(tempCenter);
                                    if (DistP2P_1(IndDistP2P_1) == DistP2P_2(IndDistP2P_2))&&(Verify_temp==1)
                                        kIndP2P = 2;
                                    end

                                    tempCenter=tempCenter_1;
                                end
                                Centers2(i,j).mean = tempCenter;

                                clear tempInd temp tempData IndDistP2P Verify_temp tempCenter DistP2P kIndP2P DistP2P_1 DistP2P_2 IndDistP2P_1 IndDistP2P_2 tempCenter_1 tempCenter_2

                        else if (i==j)&&(isempty(Coord(i,j).coordinate)==0)&&(kCalcul==1)

                                tempInd = Coord(i,j).coordinate;
                                temp = DataNew(tempInd,:);             

                                while size(temp,1)==1
                                temp = [zeros(1,SizeData);temp];
                                end

                                Centers2(i,j).mean = mean(temp); 
                                Centers2(i,j).var = var(temp);

                                NbPoint = NbPoint+1;

                                % Calculation of the Point who is near the center
                                tempData = DataNew(tempInd,:);
                                tempCenter = Centers2(i,j).mean;

                                DistP2P = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                                IndDistP2P = find(DistP2P==min(DistP2P));    
                                tempCenter = tempData(IndDistP2P(1),:);

                                % Calulation of the Point who is nearby the real center 
                                kIndP2P = 1;

                                while kIndP2P == 1

                                    DistP2P_1 = sum(((tempData - repmat(tempCenter,size(tempData,1),1))).^2,2);
                                    IndDistP2P_1 = find(DistP2P_1==min(DistP2P_1));    
                                    tempCenter_1 = tempData(IndDistP2P_1,:);

                                    DistP2P_2 = sum(((tempData - repmat(tempCenter_1,size(tempData,1),1))).^2,2);
                                    IndDistP2P_2 = find(DistP2P_2==min(DistP2P_2));    
                                    tempCenter_2 = tempData(IndDistP2P_2,:);                    

                                    Verify_temp=sum(tempCenter==tempCenter_2)/length(tempCenter);
                                    if (DistP2P_1(IndDistP2P_1) == DistP2P_2(IndDistP2P_2))&&(Verify_temp==1)
                                        kIndP2P = 2;
                                    end

                                    tempCenter=tempCenter_1;
                                end
                                Centers2(i,j).mean = tempCenter;

                                clear tempInd temp tempData IndDistP2P Verify_temp tempCenter DistP2P kIndP2P DistP2P_1 DistP2P_2 IndDistP2P_1 IndDistP2P_2 tempCenter_1 tempCenter_2

                                else if(i==j)&&(isempty(Coord(i,j).coordinate)==0)&&(kCalcul>1)
                                     Centers2(i,j).var = inf(1,SizeData);
                                     Centers2(i,j).mean = inf(1,SizeData); 


                                    else if (i~=j)&&(isempty(Coord(i,j).coordinate)==1)

                                        Centers2(i,j).var = inf(1,SizeData);
                                        Centers2(i,j).mean = inf(1,SizeData); 



                                        else if(i==j)&&(isempty(Coord(i,j).coordinate)==1)
                                          Centers2(i,j).var = inf(1,SizeData);
                                          Centers2(i,j).mean = inf(1,SizeData); 
                                            end
                                        end
                                    end
                            end
                        end

                    end

                end

                CentersFinal = [tempCenters2 Centers2]; % midification ///
                %disp(CentersFinal)
                tempCenters2 = CentersFinal;
                % disp(['The nb of mistaked points are : ',num2str(length(IndRest))]);
                % -------------------------
                for i = 1:k*kCalcul % Reorganiser the mean and var of the centers 1 2 3 4 5

                    VarNewTemp = [];
                    MeanNewTemp = [];
                    for j = 1:k
                        VarNewTemp = [VarNewTemp;CentersFinal(j,i).var];
                        MeanNewTemp = [MeanNewTemp;CentersFinal(j,i).mean];
                    end
                    VarNewTotal(i).var = VarNewTemp;
                    MeanNewTotal(i).mean = MeanNewTemp;
                    clear VarNewTemp MeanNewTemp

                end

                DistTotal = zeros(k,k*kCalcul);

                % For Learning ------------------------------------------------------------
                for i = 1:LengthData
                    for ii = 1 : k*kCalcul
                        if isempty(VarNewTotal(ii).var)||isempty(MeanNewTotal(ii).mean)
                            DistTotal(:,ii) = inf(k,1);
                        else
                        dist = sum(((repmat(DataNew(i,1:mIndex),size(MeanNewTotal(ii).mean(:,1:mIndex),1),1)-...
                            MeanNewTotal(ii).mean(:,1:mIndex))).^2,2);

                        dist(isnan(dist)) = inf;

                        DistTotal(:,ii) = dist;

                        end

                    end

                    temp = min(DistTotal,[],2);
                    temp1 = find(temp == min(temp));
                    Target5Centers(i) = temp1(1);
                end
                CM_ZF_Dist_Centers5 = MatrixConf_ZF(Goal,Target5Centers);

                % for Testing -------------------------------------------------------------
                 L_CV = length(Goal_Test);

                for i = 1:L_CV
                    for ii = 1 : k*kCalcul
                        if isempty(VarNewTotal(ii).var)||isempty(MeanNewTotal(ii).mean)
                            DistTotal(:,ii) = inf(k,1);
                        else
                        dist = sum(((repmat(Data_Test(i,1:mIndex),size(MeanNewTotal(ii).mean(:,1:mIndex),1),1)-...
                            MeanNewTotal(ii).mean(:,1:mIndex))).^2,2);

                        dist(isnan(dist)) = inf;

                        DistTotal(:,ii) = dist;

                        end

                    end
                    temp3 = min(DistTotal,[],2);
                    temp4 = find(temp3 == min(temp3));
                    resultTest(i) = temp4(1);
                end

                    ResultCV_Test = MatrixConf_ZF(Goal_Test,resultTest);

                    ScoresTest(kCalcul) = ResultCV_Test.Tr*100;
                    MatriceConfusion(kCalcul).CM_Test = ResultCV_Test.CM;
                    MatriceConfusion(kCalcul).CM_Num_Test = ResultCV_Test.CM_Num;
                % -------------------------------------------------------------------------
                clear Coord
                error = 1-CM_ZF_Dist_Centers5.Tr;
                Scores(kCalcul) = CM_ZF_Dist_Centers5.Tr*100; % pourcentage

                Coord = CM_ZF_Dist_Centers5.Point; % Final CM
                MatriceConfusion(kCalcul).IndexPoints = Coord;
                MatriceConfusion(kCalcul).CM = CM_ZF_Dist_Centers5.CM;
                MatriceConfusion(kCalcul).CM_Num = CM_ZF_Dist_Centers5.CM_Num;

                NbOfPoint(kCalcul)  = NbPoint;

                clear Centers2 Target5Centers

              %% Definir the Flag
                ErrorVerify(kCalcul) = error;
                if (kCalcul>3)&&(ErrorVerify(kCalcul) == ErrorVerify(kCalcul-1))&&(ErrorVerify(kCalcul-1) == ErrorVerify(kCalcul-2)) 
                        flag=2;  
                        CentersFinal = CentersFinal(:,1:end-2);
                end

                kCalcul = kCalcul+1;

            cmd1 = strcat(['Iteration : ', num2str(kCalcul)]);
            cmd2 = strcat(['The nb of mistaked points are : ',num2str(length(IndRest))]);
            cmd3 =strcat([('The error of '), num2str(kCalcul),sprintf('th time calculation is '),num2str(error)]);
            cmd4 =strcat([('The nb of centers recent is '), num2str(NbPoint)]);
            cmd5 =strcat('Learning - Confusion Matrix is');
            digits(2);
            cmd6 = char(vpa(CM_ZF_Dist_Centers5.CM_Num));
            cmd7 =strcat('Testing - Confusion Matrix is');
            cmd8 = char(vpa(ResultCV_Test.CM_Num));
            timeUse = toc;
            cmd9 = strcat(['Elapsed time is ', num2str(timeUse),'Seconds']);
            cmd = {cmd1;cmd2;cmd3;cmd4;cmd5;cmd6;cmd7;cmd8;cmd9};

            set(handles.textProcess,'String',cmd);
            set(handles.textProcess,'FontSize',12);
            pause(0.8)

     end
     
    xCenter = find(ScoresTest==max(ScoresTest));
    xCenter = xCenter(1);
    NbOfPointFinal = NbOfPoint(xCenter);
    kCalcul = kCalcul-1;
    set(handles.text36,'string',num2str(NbOfPointFinal));

    axes(handles.axes22);
    plot(NbOfPoint,Scores,'r-*')
    hold on
    plot(NbOfPoint,ScoresTest,'b.-')
    xlabel('Nb of the centers')
    ylabel('Scores (Percentage)')
    title('Scores in relation to centers Nb')
    legend(['Learning Cts: ',num2str(NbOfPoint(end))],'Testing CV','location','SE')
    plot(0:0.01:NbOfPointFinal,max(ScoresTest));
    plot(NbOfPointFinal,0:0.01:max(ScoresTest));
    hold off
    
    % Save the figure
    newFig = figure('Visible','off');
    plot(NbOfPoint,Scores,'r-*')
    hold on
    plot(NbOfPoint,ScoresTest,'b.-')
    xlabel('Nb of the centers')
    ylabel('Scores (Percentage)')
    plot(0:0.01:NbOfPointFinal,max(ScoresTest));
    plot(NbOfPointFinal,0:0.01:max(ScoresTest));
    title('Scores in relation to centers Nb')
    legend(['Learning Cts: ',num2str(NbOfPoint(end))],'Testing CV','location','SE')
    pathFig = pwd;
    pathFig = strcat(pathFig,'\SCM\figures\');

    % make a folder named date to place the figures 
    s = mkdir(pathFig,date);
    if s~=1
        msgbox('There is problem of building a new folder for figures!')
        return
    end
    
    nameFig = strcat(pathFig,date,'\nbScoreSCMMixed_',num2str(nbMix));
    saveas(gcf,nameFig);
    print(newFig,'-dpng',nameFig);
    hold off

    ResultTest = testClassSCM(CentersFinal,xCenter,mIndex,Data_Test,Goal_Test);
    ResultTestAll = testClassSCM(CentersFinal,xCenter,mIndex,testAll,goalAll);
  
        if ResultTestAll.Tr>ScoreRecent
            BestResultTest = ResultTest;
            BestResultTestAll = ResultTestAll;
            BestCentersFinal = CentersFinal;
            BestV = V;
            BestMatriceConfusion=MatriceConfusion;
            BestkCalcul=kCalcul;
            BestNbOfPointFinal = NbOfPointFinal;  
            
            ScoreRecent = ResultTestAll.Tr;
        end     
    
    end
    
    % Save the results
    pathResults = pwd;
    pathResults = strcat(pathResults,'\SCM\Results\');
    s = mkdir(pathResults,date);
    if s~=1
        msgbox('There is problem of building a new folder for figures!')
        return
    end
    
    nameResultsMix = strcat(pathResults,date,'\modelSCMMix');   
    save(nameResultsMix, 'BestCentersFinal','BestV','BestMatriceConfusion','BestkCalcul','BestResultTest','BestResultTestAll','BestNbOfPointFinal','mIndex')
    
    set(handles.part3_table1,'data',BestResultTest.CM);
    set(handles.part3_table2,'data',BestResultTest.CM_Num);
    set(handles.part3_text8,'String',num2str(BestResultTest.Tr));
    
    set(handles.part3_table3,'data',BestResultTestAll.CM);
    set(handles.part3_table4,'data',BestResultTestAll.CM_Num);
    set(handles.part3_text10,'String',num2str(BestResultTestAll.Tr));
    pause(0.8)
end

%handles.datausing.bestNbVec = IndmaxDist;

guidata(hObject,handles)






% --- Executes on button press in part2_button1.
function part2_button1_Callback(hObject, eventdata, handles)
% hObject    handle to part2_button1 (see GCBO)
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
% testAll = handles.datausing.testAll;
% goalAll = handles.datausing.goalAll;
% goalAll = goalAll';
% goalAll = num2str(goalAll);

if mixed==0 
        
        Goal_temp = [];
        Data_temp = [];
        for i = 1:size(data,2)
            x = data(i).data;
            DataTemp = x';
                       
            sizeData = size(DataTemp,1);
            
            cmdGoal = strcat('Situation',num2str(i));
            GoalTemp = repmat({cmdGoal},sizeData,1);
            
            Goal_temp = [Goal_temp;GoalTemp];
            Data_temp = [Data_temp;DataTemp];
        end
    Data = Data_temp;
    Goal = Goal_temp;
    
    mIndex_temp = size(Data,2);
     if mIndex_temp>20;
        mInd = 20;
    else
        mInd = mIndex_temp;
    end
    TrDistIni = zeros(mInd,1);
        
       % Waitbar
    h = waitbar(0,'1','Name','Progress of System running ...',...
         'CreateCancelBtn',...
         'setappdata(gcbf,''canceling'',1)');
    CountWaitbar = 1; 
    
    % Show the Best mInd
    for ii = 1:mInd % score / nb vector 
            
        LDA_ZF  = LDAZFversion2(Data,Goal,ii);
        TrDistIni(ii) = LDA_ZF.TrDist;
        
            CountWaitbar = CountWaitbar +1;
            waitbar(CountWaitbar/mInd,h,sprintf('%d / %d',CountWaitbar,mInd))
            pause(0.1)
    end
    
    delete(h)
    clear h
    
    % Affichage the score of method Distance
    axes(handles.axes21)
    plot(0:1:mInd,[0;TrDistIni],'r-.')
    hold on
    IndmaxDist = find(TrDistIni==max(TrDistIni));
    IndmaxDist = IndmaxDist(1);
    plot(1:0.1:mInd,max(TrDistIni));
    plot(IndmaxDist,min(TrDistIni):0.05:max(TrDistIni));
    cmd1 = strcat('\fontsize{10}\color{black}{Score according to the nb of vectors}');
    cmd2 = strcat('\fontsize{10}Data - Distance');
    title({cmd1;cmd2})
    % title({'\fontsize{14}\color{black}{Score according to the nb of vectors}';'\fontsize{12}Data of TPQE - Normalization 2 - Distance'})
    xlabel('nb of the vectors')
    ylabel('Scores')
    legend(['Best choice is ',num2str(IndmaxDist)],'location','SE');
    hold off
   
    % Save the figure
    newFig = figure('Visible','off');
    plot(0:1:mInd,[0;TrDistIni],'r-.')
    hold on
    IndmaxDist = find(TrDistIni==max(TrDistIni));
    IndmaxDist = IndmaxDist(1);
    plot(1:0.1:mInd,max(TrDistIni));
    plot(IndmaxDist,min(TrDistIni):0.05:max(TrDistIni));
    cmd1 = strcat('\fontsize{10}\color{black}{Score according to the nb of vectors}');
    cmd2 = strcat('\fontsize{10}Data - Distance');
    title({cmd1;cmd2})
    % title({'\fontsize{14}\color{black}{Score according to the nb of vectors}';'\fontsize{12}Data of TPQE - Normalization 2 - Distance'})
    xlabel('nb of the vectors')
    ylabel('Scores')
    legend(['Best choice is ',num2str(IndmaxDist)],'location','SE');

    
    pathFig = pwd;
    pathFig = strcat(pathFig,'\SCM\figures\');

    % make a folder named date to place the figures 
    s = mkdir(pathFig,date);
    if s~=1
        msgbox('There is problem of building a new folder for figures!')
        return
    end
    
    nameFig = strcat(pathFig,date,'\nbVecSCM');
    saveas(gcf,nameFig);
    print(newFig,'-dpng',nameFig);
    hold off
    
elseif mixed ==1
   
    
    for j = 1:nbMixed
        
        Goal_temp = [];
        Data_temp = [];
        for i = 1:size(data,2)
            x = data(i).data;
            
            if isa(x,'struct')
                DataTemp = x(j).data';
            else
                DataTemp = x';
            end
            
            sizeData = size(DataTemp,1);
            
            cmdGoal = strcat('Situation',num2str(i));
            GoalTemp = repmat({cmdGoal},sizeData,1);
            
            Goal_temp = [Goal_temp;GoalTemp];
            Data_temp = [Data_temp;DataTemp];
            
            DataStruc(j).data = Data_temp;
            GoalStruc(j).goal = Goal_temp;
        end
        
    end
    Data = Data_temp;
    Goal = Goal_temp;
    
    mIndex_temp = size(Data,2);
    if mIndex_temp>20;
        mInd = 20;
    else
        mInd = mIndex_temp;
    end
    TrDistIni = zeros(mInd,1);
        
       % Waitbar
    h = waitbar(0,'1','Name','Progress of System running ...',...
         'CreateCancelBtn',...
         'setappdata(gcbf,''canceling'',1)');
    CountWaitbar = 1; 
    
    % Show the Best mInd
    for ii = 2:mInd % score / nb vector 
            
        LDA_ZF  = LDAZFversion2(Data,Goal,ii);
        TrDistIni(ii) = LDA_ZF.TrDist;
        
            CountWaitbar = CountWaitbar +1;
            waitbar(CountWaitbar/mInd,h,sprintf('%d / %d',CountWaitbar,mInd))
            pause(0.1)
    end
    
    delete(h)
    clear h
    
    % Affichage the score of method Distance
    axes(handles.axes21)
    plot(0:1:mInd,[0;TrDistIni],'r-.')
    hold on
    IndmaxDist = find(TrDistIni==max(TrDistIni));
    IndmaxDist = IndmaxDist(1);
    plot(0:0.1:mInd,max(TrDistIni));
    plot(IndmaxDist,min(TrDistIni):0.05:max(TrDistIni));
    cmd1 = strcat('\fontsize{10}\color{black}{Score according to the nb of vectors}');
    cmd2 = strcat('\fontsize{10}Data - Distance');
    title({cmd1;cmd2})
    % title({'\fontsize{14}\color{black}{Score according to the nb of vectors}';'\fontsize{12}Data of TPQE - Normalization 2 - Distance'})
    xlabel('nb of the vectors')
    ylabel('Scores')
    legend(['Best choice is ',num2str(IndmaxDist)],'location','SE');
    hold off

    % Save the figure
    newFig = figure('Visible','off');
    plot(0:1:mInd,[0;TrDistIni],'r-.')
    hold on
    IndmaxDist = find(TrDistIni==max(TrDistIni));
    IndmaxDist = IndmaxDist(1);
    plot(0:0.1:mInd,max(TrDistIni));
    plot(IndmaxDist,min(TrDistIni):0.05:max(TrDistIni));
    cmd1 = strcat('\fontsize{10}\color{black}{Score according to the nb of vectors}');
    cmd2 = strcat('\fontsize{10}Data - Distance');
    title({cmd1;cmd2})
    % title({'\fontsize{14}\color{black}{Score according to the nb of vectors}';'\fontsize{12}Data of TPQE - Normalization 2 - Distance'})
    xlabel('nb of the vectors')
    ylabel('Scores')
    legend(['Best choice is ',num2str(IndmaxDist)],'location','SE');
    
    pathFig = pwd;
    pathFig = strcat(pathFig,'\SCM\figures\');

    % make a folder named date to place the figures 
    s = mkdir(pathFig,date);
    if s~=1
        msgbox('There is problem of building a new folder for figures!')
        return
    end
    
    nameFig = strcat(pathFig,date,'\nbVecSCM');
    saveas(gcf,nameFig);
    print(newFig,'-dpng',nameFig);
    hold off
    
    % ---------------------------------------------------    
  
%     c = num2str(fix(clock));
%     c((isspace(c)))=[];
%     cmd1=pwd;
%     cmd = strcat(cmd1,'/SCM/model_',c);
%     save(cmd,'Result_Net') 
end
handles.datausing.bestNbVec = IndmaxDist;

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


% --- Executes on button press in pushbuttonTest.
function pushbuttonTest_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf);
SCM_2;
