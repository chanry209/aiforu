function varargout = ISEEU_TREATEMENT(varargin)
% ISEEU_TREATEMENT MATLAB code for ISEEU_TREATEMENT.fig
%      ISEEU_TREATEMENT, by itself, creates a new ISEEU_TREATEMENT or raises the existing
%      singleton*.
%
%      H = ISEEU_TREATEMENT returns the handle to a new ISEEU_TREATEMENT or the handle to
%      the existing singleton*.
%
%      ISEEU_TREATEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISEEU_TREATEMENT.M with the given input arguments.
%
%      ISEEU_TREATEMENT('Property','Value',...) creates a new ISEEU_TREATEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ISEEU_TREATEMENT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ISEEU_TREATEMENT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ISEEU_TREATEMENT

% Last Modified by GUIDE v2.5 25-Jul-2016 17:07:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ISEEU_TREATEMENT_OpeningFcn, ...
                   'gui_OutputFcn',  @ISEEU_TREATEMENT_OutputFcn, ...
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

% --- Executes just before ISEEU_TREATEMENT is made visible.
function ISEEU_TREATEMENT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ISEEU_TREATEMENT (see VARARGIN)

% Choose default command line output for ISEEU_TREATEMENT
handles.output = hObject;
% Update handles structure

guidata(hObject, handles);

% UIWAIT makes ISEEU_TREATEMENT wait for user response (see UIRESUME)
% uiwait(handles.iseeu_treatement);

% --- Outputs from this function are returned to the command line.
function varargout = ISEEU_TREATEMENT_OutputFcn(hObject, eventdata, handles) 
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
% 1) Import the figure
fileName=handles.datauser.fileName; % Read the path
if isempty(fileName)
    set(handles.textLoading,'string','Nothing is requested ?!')
    return
end

% ---------------------------------------------------
% 2) Read file
figure(1)
I = imread(fileName); % load the Figure
[I2, rect] = imcrop(I); % crop the figure, remember copy the new figure
I2 = imrotate(I2, 90); % rotation of the figure
newFig = I2; % n;ew figure data

% save
handles.datauser.oldFig = I;
handles.datauser.newFig = newFig;

% show the oldFig
axes(handles.oldFig)
image(I);
title('Orignal Figure')
axis image
axis auto
axis off

% show the oldFig
axes(handles.newFig)
image(I2);
title('Crop Figure')
axis image % zoom the figure to original scale
axis auto
axis off

set(handles.x1,'string',rect(1))
set(handles.y1,'string',rect(2))
set(handles.x2,'string',rect(3))
set(handles.y2,'string',rect(4))

% SAVE
set(hObject,'string','OK');
set(handles.textLoading,'string','Loading Completed','BackGroundColor',[1 0 0])
pause(1)
set(hObject,'string','Load');
set(handles.textLoading,'string','Load the Next','BackGroundColor',[0.7 0.7 0.7])
guidata(hObject,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadpath.
function loadpath_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    [file path index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if (index)&&(ischar(file)) 
        str = [path file];
        set(hObject,'string',str);
    end
        
    if isempty(str)
        return
    end
    
    handles.datauser.fileName = str;
end

guidata(hObject,handles);


% --- Executes on button press in saveNewFig.
function saveNewFig_Callback(hObject, eventdata, handles)
% hObject    handle to saveNewFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = pwd;
pathFig = strcat(path,'\NewFigures\');

% make a folder named date to place the figures 
s = mkdir(pathFig);
if s~=1
    msgbox('There is problem of building a new folder for figures!')
    return
end
name = get(handles.newFigName, 'string');
name = strcat(pathFig,name);
I = handles.datauser.newFig;
save(name,'I')
set(handles.saveNewFig,'string','be Saving')
pause(1);
set(handles.saveNewFig,'string','Save')

guidata(hObject,handles);
