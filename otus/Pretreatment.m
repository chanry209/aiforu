function varargout = Pretreatment(varargin)
% PRETREATMENT MATLAB code for Pretreatment.fig
%      PRETREATMENT, by itself, creates a new PRETREATMENT or raises the existing
%      singleton*.
%
%      H = PRETREATMENT returns the handle to a new PRETREATMENT or the handle to
%      the existing singleton*.
%
%      PRETREATMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRETREATMENT.M with the given input arguments.
%
%      PRETREATMENT('Property','Value',...) creates a new PRETREATMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pretreatment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pretreatment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pretreatment

% Last Modified by GUIDE v2.5 26-Jul-2016 16:28:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pretreatment_OpeningFcn, ...
                   'gui_OutputFcn',  @Pretreatment_OutputFcn, ...
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


% --- Executes just before Pretreatment is made visible.
function Pretreatment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pretreatment (see VARARGIN)

% Choose default command line output for Pretreatment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pretreatment wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Pretreatment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
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
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton.
function loadButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
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


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadPath.
function loadPath_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadPath (see GCBO)
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
    
    handles.dataUser.fileName = str;
end

guidata(hObject,handles);
