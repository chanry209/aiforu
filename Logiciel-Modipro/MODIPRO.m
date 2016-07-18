function varargout = MODIPRO(varargin)
% MODIPRO MATLAB code for MODIPRO.fig
%      MODIPRO, by itself, creates a new MODIPRO or raises the existing
%      singleton*.
%
%      H = MODIPRO returns the handle to a new MODIPRO or the handle to
%      the existing singleton*.
%
%      MODIPRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODIPRO.M with the given input arguments.
%
%      MODIPRO('Property','Value',...) creates a new MODIPRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MODIPRO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MODIPRO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MODIPRO

% Last Modified by GUIDE v2.5 27-Dec-2011 12:27:25

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MODIPRO_OpeningFcn, ...
                   'gui_OutputFcn',  @MODIPRO_OutputFcn, ...
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


% --- Executes just before MODIPRO is made visible.
function MODIPRO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MODIPRO (see VARARGIN)

% Choose default command line output for log
movegui(gcf,'center');
%movegui(handles.login_figure,'center');
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
handles.output = hObject;
javaFrame=get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon.jpg'));

filename = [pwd '\couverture.jpg'];
PIC = imread(filename);
axes(handles.axes2)
image(PIC);
axis off

% filename = [pwd '\fig2.jpg'];
% PIC = imread(filename);
% axes(handles.axes3)
% image(PIC);
% axis off
% 
% filename = [pwd '\fig1.jpg'];
% PIC = imread(filename);
% axes(handles.axes1)
% image(PIC);
% axis off

data = load('UserData');
%save('dataUserTest','data')
handles.user=data.UserID;
handles.code=data.UserCode;

handles.manage_user=data.ManagerID;
handles.manage_code=data.ManagerCode;

handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MODIPRO wait for user response (see UIRESUME)
% uiwait(handles.login_figure);


% --- Outputs from this function are returned to the command line.
function varargout = MODIPRO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%function student_number_Callback(hObject, eventdata, handles)
% hObject    handle to student_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of student_number as text
%        str2double(get(hObject,'String')) returns contents of student_number as a double


% --- Executes during object creation, after setting all properties.
function student_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to student_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function student_code_Callback(hObject, eventdata, handles)
% hObject    handle to student_code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of student_code as text
%        str2double(get(hObject,'String')) returns contents of student_code as a double


% --- Executes during object creation, after setting all properties.
function student_code_CreateFcn(hObject, eventdata, handles)
% hObject    handle to student_code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MODIPRO.
function login_Callback(hObject, eventdata, handles)
% hObject    handle to MODIPRO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choose=get(handles.choose_account,'Value');
switch choose
    case 1
        msgbox('Please chose a type of user','System Info','warn');
    case 2

        manage_users=handles.manage_user;
        manage_codes=handles.manage_code;
        user=get(handles.student_number,'string');
        code=get(handles.student_code,'string');
        n=find(strcmp(manage_users,{user}));

        if length(n)&&isequal(manage_codes{n},code)
            delete(gcf);
            LOGIN
        else
            errordlg('Error of Name of Code');
%             set(handles.student_code,'string','');
%             set(hObject,'userdata','');
        end
    case 3
        user=get(handles.student_number,'string');
        code=get(handles.student_code,'string');
        users=handles.user;
        codes=handles.code;
        n=find(strcmp(users,{user}));
        if length(n)&&isequal(codes{n},code)
           delete(gcf);
           TableContents;
        end
end


% --- Executes on selection change in choose_account.
function choose_account_Callback(hObject, eventdata, handles)
% hObject    handle to choose_account (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choose_account contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_account


% --- Executes during object creation, after setting all properties.
function choose_account_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_account (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on login_figure and none of its controls.
%function login_figure_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to login_figure (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on student_code and none of its controls.
function student_code_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to student_code (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%close(handles.login_figure);
close(gcf);

% --- Executes on button press in register.
function register_Callback(hObject, eventdata, handles)
% hObject    handle to register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choose=get(handles.choose_account,'Value');
switch choose
    case 1
        msgbox('Please chose a type of user','System Info','warn');
    case 2
        msgbox('Can''t be registered as administor£¡','System Info','warn');
    case 3
        delete(gcf)
        %delete(handles.login_figure);
        register;
end
