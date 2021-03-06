function varargout = mainOperation(varargin)
% MAINOPERATION MATLAB code for mainOperation.fig
%      MAINOPERATION, by itself, creates a new MAINOPERATION or raises the existing
%      singleton*.
%
%      H = MAINOPERATION returns the handle to a new MAINOPERATION or the handle to
%      the existing singleton*.
%
%      MAINOPERATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINOPERATION.M with the given input arguments.
%
%      MAINOPERATION('Property','Value',...) creates a new MAINOPERATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainOperation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainOperation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainOperation

% Last Modified by GUIDE v2.5 01-Aug-2016 15:57:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainOperation_OpeningFcn, ...
                   'gui_OutputFcn',  @mainOperation_OutputFcn, ...
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


% --- Executes just before mainOperation is made visible.
function mainOperation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainOperation (see VARARGIN)

% Choose default command line output for mainOperation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainOperation wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = mainOperation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function treatImageLoad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to treatImageLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over treatImageLoad.
function treatImageLoad_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to treatImageLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    %[file path index ] = uigetfile({'*.png;*.jpg;*.tif;*.mat'},'File Selector');
    [file path index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
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
end

% show the treatFigure in the axes
axes(handles.treatFigure)
imshow(treatFig);
axis image
axis normal
axis off

handles.datauser.treatFig = treatFig;
handles.datauser.figPath=str;
n=find(handles.datauser.figPath=='\',1,'last');
nameFig=str([(n+1):end]);
handles.datauser.nameFig=nameFig;

guidata(hObject,handles);


% --- Executes on button press in loadFig.
function loadFig_Callback(hObject, eventdata, handles)
% hObject    handle to loadFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

name=handles.datauser.nameFig;
name=strcat('-',name);
figure (1);
imshow(handles.datauser.treatFig);
title(['treat Figure-',date,name]);
%close figure;


% --- Executes on slider movement.
function numBlockSlide_Callback(hObject, eventdata, handles)
% hObject    handle to numBlockSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

sliderVal=get(handles.numBlockSlide,'string');
numBlock=str2double(sliderVal);
%numBlock=int2double(sliderVal);
set(handles.numBlock,'value',numBlock);
set(handles.numBlock,'string',sprintf('%3.0f',sliderVal));

handles.datauser.numBlock=numBlock;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function numBlockSlide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numBlockSlide (see GCBO)
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
nbrBlock=handles.datauser.numBlock;

if ndims(J)==3
    J=rgb2gray(J);
end

resI=otus_block(J,nbrBlock);

otusFig=resI;
%figName=handles.datauser.nameFig;

axes(handles.otusFig);
colormap gray;
imagesc(otusFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
colormap gray;
imagesc(otusFig);
title(['otus segmentation Figure -',figName]);

handles.datauser.otusFig=otusFig;
guidata(hObject,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over otusButton.
function otusButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to otusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
