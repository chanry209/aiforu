function varargout = camera(varargin)
% CAMERA M-file for camera.fig
%      CAMERA, by itself, creates a new CAMERA or raises the existing
%      singleton*.
%
%      H = CAMERA returns the handle to a new CAMERA or the handle to
%      the existing singleton*.
%
%      CAMERA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERA.M with the given input arguments.
%
%      CAMERA('Property','Value',...) creates a new CAMERA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before camera_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to camera_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help camera

% Last Modified by GUIDE v2.5 07-Apr-2010 09:56:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @camera_OpeningFcn, ...
                   'gui_OutputFcn',  @camera_OutputFcn, ...
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


% --- Executes just before camera is made visible.
function camera_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to camera (see VARARGIN)

% Choose default command line output for camera
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes camera wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = camera_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
%预览摄像机1
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
vid1=videoinput('winvideo',1,'YUY2_640x480');
vidRes1=get(vid1,'VideoResolution');
nBands1=get(vid1,'NumberOfBands');
set(vid1,'ReturnedColorSpace','rgb');
himage1=imshow(zeros(vidRes1(2),vidRes1(1),nBands1));
preview(vid1,himage1);
%handles.vid1=vid1;
%guidata(hObject,handles);


% --- Executes on button press in pushbutton2.
%预览摄像机2
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global vid2;
axes(handles.axes2);
vid2=videoinput('winvideo',2,'YUY2_640x480');
vidRes2=get(vid2,'VideoResolution');
nBands2=get(vid2,'NumberOfBands');
set(vid2,'ReturnedColorSpace','rgb');
himage2=imshow(zeros(vidRes2(2),vidRes2(1),nBands2));
preview(vid2,himage2);
%handles.vid21=vid2;
%guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
%采集摄像机1&2
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global vid1;
%vid_1=vid1;
axes(handles.axes1);
cla;
vid_1=videoinput('winvideo',1,'YUY2_320x240');
vidRes1=get(vid_1,'VideoResolution')
nBands1=get(vid_1,'NumberOfBands')
set(vid_1,'ReturnedColorSpace','rgb');
himage1=imshow(zeros(vidRes1(2),vidRes1(1),nBands1));
preview(vid_1,himage1);

set(vid_1,'TriggerRepeat',1);
start(vid_1)
figure
%for i=1:20
    data1=getdata(vid_1,1);
    %wait(vid1,5);
    %subplot(4,5,i);
   imshow(data1);
%end
stop(vid_1)

tic
a=toc

axes(handles.axes2);
cla;

vid_2=videoinput('winvideo',2,'YUY2_320x240');
vidRes2=get(vid_2,'VideoResolution')
nBands2=get(vid_2,'NumberOfBands')
set(vid_2,'ReturnedColorSpace','rgb');
himage2=imshow(zeros(vidRes2(2),vidRes2(1),nBands2));
preview(vid_2,himage2);

set(vid_2,'TriggerRepeat',1);
start(vid_2)
figure
%for j=1:20
    data2=getdata(vid_2,1);
    %wait(vid2,5);
    %subplot(4,5,j);
    imshow(data2);
%end
stop(vid_2)





% --- Executes on button press in pushbutton4.
%采集摄像机1
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;
vid1=videoinput('winvideo',1,'YUY2_320x240');
vidRes1=get(vid1,'VideoResolution')
nBands1=get(vid1,'NumberOfBands')
set(vid1,'ReturnedColorSpace','rgb');
himage1=imshow(zeros(vidRes1(2),vidRes1(1),nBands1));
preview(vid1,himage1);

set(vid1,'TriggerRepeat',1);

start(vid1)

figure
%for i=1:20
    data1=getdata(vid1,1);
    %wait(vid1,5);
    %subplot(4,5,i);
    imshow(data1);
    %imwrite(data1,strcat('C:\Users\bme\Documents\MATLAB\new\','1.bmp'),'bmp');
%end
stop(vid1)


% --- Executes on button press in pushbutton5.
%采集摄像机2
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
cla;

vid2=videoinput('winvideo',2,'YUY2_320x240');
vidRes2=get(vid2,'VideoResolution')
nBands2=get(vid2,'NumberOfBands')
set(vid2,'ReturnedColorSpace','rgb');
himage2=imshow(zeros(vidRes2(2),vidRes2(1),nBands2));
preview(vid2,himage2);

set(vid2,'TriggerRepeat',1);

start(vid2)

figure
%for i=1:20
    data2=getdata(vid2,1);
    %wait(vid1,5);
   % subplot(4,5,i);
   imshow(data2);
%end
stop(vid2)

