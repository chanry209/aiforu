function varargout = mainOperations(varargin)
% MAINOPERATIONS MATLAB code for mainOperations.fig
%      MAINOPERATIONS, by itself, creates a new MAINOPERATIONS or raises the existing
%      singleton*.
%
%      H = MAINOPERATIONS returns the handle to a new MAINOPERATIONS or the handle to
%      the existing singleton*.
%
%      MAINOPERATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINOPERATIONS.M with the given input arguments.
%
%      MAINOPERATIONS('Property','Value',...) creates a new MAINOPERATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainOperations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainOperations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainOperations

% Last Modified by GUIDE v2.5 01-Aug-2016 17:15:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainOperations_OpeningFcn, ...
                   'gui_OutputFcn',  @mainOperations_OutputFcn, ...
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


% --- Executes just before mainOperations is made visible.
function mainOperations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainOperations (see VARARGIN)

% Choose default command line output for mainOperations
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainOperations wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainOperations_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function treatFigLoad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to treatFigLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over treatFigLoad.
function treatFigLoad_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to treatFigLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    %[file path index ] = uigetfile({'*.png;*.jpg;*.tif;*.mat'},'File Selector');
    [file,path,index] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(file,0)
        disp('please select your figure');
    else
        str=[path file]; 
        %treatFig=load(str);
        treatFig=imread(str);
    end
    handles.datauser.treatFig=treatFig;
end

% show the treatFigure in the axes
axes(handles.treatFig)
imshow(handles.datauser.treatFig);
axis image
axis normal
axis off

handles.datauser.treatFig = treatFig;
handles.datauser.figPath=str;
n=find(handles.datauser.figPath=='\',1,'last');
nameFig=str([(n+1):end]);
handles.datauser.nameFig=nameFig;

guidata(hObject,handles);


% --- Executes on button press in loadFigButton.
function loadFigButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadFigButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=handles.datauser.nameFig;
name=strcat('-',name);
figure (1);
imshow(handles.datauser.treatFig);
title(['treat Figure-',date,name]);



function nbrBlock_Callback(hObject, eventdata, handles)
% hObject    handle to nbrBlock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nbrBlock as text
%        str2double(get(hObject,'String')) returns contents of nbrBlock as a double


% --- Executes during object creation, after setting all properties.
function nbrBlock_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nbrBlock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliderBlockVal_Callback(hObject, eventdata, handles)
% hObject    handle to sliderBlockVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

sliderBlockVal=get(handles.sliderBlockVal, 'value');
nbrBlock=num2str(sliderBlockVal);
nbrBlockStr=strcat(['block number : ',nbrBlock]);
set(handles.nbrBlock,'string',nbrBlockStr);
%nbrBlock=int32(sliderBlockVal);
%set(handles.sliderBlockVal,'value',nbrBlock);
nbrBlock=str2double(nbrBlock);
handles.datauser.nbrBlock=nbrBlock;




guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function sliderBlockVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderBlockVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in otusButton.
function otusButton_Callback(hObject, eventdata, handles)
% hObject    handle to otusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig;
figName=handles.datauser.nameFig;
if ndims(J)==3
    J=rgb2gray(J);
end

nbrBlock=handles.datauser.nbrBlock;
resI=otus_block(J,nbrBlock);

otusFig=resI;

axes(handles.otusFig);
colormap gray;
imagesc(otusFig);
axis image % zoom the figure to original scale
axis normal
axis off


figure;
colormap gray;
imagesc(otusFig);
title(['otus segmentation Figure-',figName]);
handles.datauser.otusFig=otusFig;



guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function otusButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to otusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over otusButton.
function otusButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to otusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
