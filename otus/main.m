function varargout = main(varargin)
% GUIDETEST MATLAB code for guideTest.fig
%      GUIDETEST, by itself, creates a new GUIDETEST or raises the existing
%      singleton*.
%
%      H = GUIDETEST returns the handle to a new GUIDETEST or the handle to
%      the existing singleton*.
%
%      GUIDETEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDETEST.M with the given input arguments.
%
%      GUIDETEST('Property','Value',...) creates a new GUIDETEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guideTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guideTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guideTest

% Last Modified by GUIDE v2.5 12-Jul-2016 12:16:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;    % GUI只能产生一个窗口实例
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ... %将GUI显示在屏幕上
                   'gui_Callback',   []); %若为空，打开主窗口fig文件，否则执行子函数
if nargin && ischar(varargin{1})        % 若输入参数至少为1个且第1个为字符串，则gui callback的值为第一个参数表示的回调函数
    gui_State.gui_Callback = str2func(varargin{1});  % 若没有输入参数则为空
end

 % 运行默认的处理函数
 % 根据gui_State和参数来确定是执行回调函数，还是运行OpeningFcn和OutputFcn
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
%addpath(pwd);

    
% --- Executes just before guideTest is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure 当前figure对象的句柄
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guideTest (see VARARGIN)

% Choose default command line output for guideTest
handles.output = hObject;  %将figure对象的句柄存入handles的output字段中，用于输出
% Update handles structure

guidata(hObject, handles);

% UIWAIT makes guideTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout为单元数未知的单元数组，默认值创建1个输出参数varagout{1} 
varargout{1} = handles.output;
% varagout{2} = handles.output2; 

function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I;  %将变量变为全局变量，在各函数之间共享
[filename ,pathname]=uigetfile({'*.jpg';'*.png';'*.bmp'},'选择图片');
str=[pathname filename];
I=imread(str);
axes(handles.axes1);
imshow(I);
if ndims(I)==3 
handles.data=rgb2gray(I);
guidata(hObject,handles);
else
    handles.data=I;
    guidata(hObject,handles);
end
figure(1);
imshow(handles.data);

% --- Executes on button press in pushbutton2 --%
%%% for cut the figure of tube from image

function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%call back the function for cut the figure of tube%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%


%%%%%%%%%%%%%% show the result of cuted image%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.RegistrationParameters=RegistrationParameters;
y=RegistrationParameters(1);
x=RegistrationParameters(2);
ang=RegistrationParameters(3);
MI_Value=RegistrationParameters(4);
RegistrationResult=sprintf('X,Y,Angle=[%.5f][%.5f][%.5f]',x,y,ang);
MI_Value=sprintf('MI_Value=[%.4f]',MI_Value);
ElapsedTime=sprintf('Elapsed Time=[%.3f]',ElapsedTime);
axes(handles.axes3)
[RegistrationImage]=Register(handles);
imshow(RegistrationImage)
figure(3);
imshow(RegistrationImage);
set(handles.text1,'string',RegistrationResult);
set(handles.text2,'string',MI_Value);
set(handles.text3,'string',ElapsedTime);








%%

path=handles.dataUser.fileNames;
if isempty(path)
    set(handles.textLoading,'string','Nothing to import...');
    return
end

%%% select image for clipping cut the figure of tube

global I;
[filename ,pathname]=uigetfile({'*.jpg';'*.png';'*.bmp'},'select the image');
str=[pathname filename];
I=imread(str); 
axes(handles.axes1);
imshow(I);
if ndims(I)==3 
handles.data=rgb2gray(I);
guidata(hObject,handles);
else
    handles.data=I;
    guidata(hObject,handles);
end
figure(1);
imshow(handles.data);

function loadPath_buttonDownFcn(hObject, eventdata,handles)
se1=get(gcf,'selectionType');  % gcf 返回当前窗口的句柄值
if isequal(se1,'open')
    [file path index]=uigetfile({'*.jpg';'*.png';'*.bmp'},'select the image');
    if index==0
        return
    end
    
    if index && iscell(file)
        n=length(file);
        for j=1:n
            str{j}=[path file{j}];
        end
        set(hObject,'string',str);
    end
    
    if index && ischar(file)
          str{1}=[path file];
          set(hObject,'string',str);
    end
    
    if isempty(str)
        return
    end 
    
    handles.dataUser.fileNames=str;
end
guidata(hObject, handles);




%%%
        
    

% --- Executes on button press in pushbutton3 --%
%%% begin to do the pretreatment operations
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%% call back the fonctions of pretreatment pretraitment.m，%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
RegistrationParameters=Powell(handles);
toc
ElapsedTime=toc;

%%%%%%%%%%%%%Display preprocessed image results%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.RegistrationParameters=RegistrationParameters;
y=RegistrationParameters(1);
x=RegistrationParameters(2);
ang=RegistrationParameters(3);
MI_Value=RegistrationParameters(4);
RegistrationResult=sprintf('X,Y,Angle=[%.5f][%.5f][%.5f]',x,y,ang);
MI_Value=sprintf('MI_Value=[%.4f]',MI_Value);
ElapsedTime=sprintf('Elapsed Time=[%.3f]',ElapsedTime);
axes(handles.axes3)
[RegistrationImage]=Register(handles);
imshow(RegistrationImage)
figure(3);
imshow(RegistrationImage);
set(handles.text1,'string',RegistrationResult);
set(handles.text2,'string',MI_Value);
set(handles.text3,'string',ElapsedTime);


global ResI  %定义处理后的图片BW这个全局变量
[filename,pathname,filterindex]=...
    uiputfile({'*.bmp';'*.tif';'*.png'},'save picture');  % store the path of pretreatment result image
if filterindex==0
return  
else
str=[pathname filename]; 
axes(handles.axes2);  % use the seconde axe to show the precessed result
imwrite(ResI,str);  % save the precessed result.* 
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J;
[filename ,pathname]=uigetfile({'*.jpg';'*.bmp';'*.bmp'},'选择图片');
str=[pathname filename];
J=imread(str);
axes(handles.axes2);
imshow(J);
if ndims(J)==3
handles.data2=rgb2gray(J);
guidata(hObject,handles);
else
    handles.data2=J;
guidata(hObject,handles);
end
figure(2);
imshow(handles.data2)%
