function varargout = LOGIN(varargin)
% LOGIN MATLAB code for LOGIN.fig
%      LOGIN, by itself, creates a new LOGIN or raises the existing
%      singleton*.
%
%      H = LOGIN returns the handle to a new LOGIN or the handle to
%      the existing singleton*.
%
%      LOGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGIN.M with the given input arguments.
%
%      LOGIN('Property','Value',...) creates a new LOGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LOGIN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LOGIN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LOGIN

% Last Modified by GUIDE v2.5 03-Apr-2012 18:09:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LOGIN_OpeningFcn, ...
                   'gui_OutputFcn',  @LOGIN_OutputFcn, ...
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


% --- Executes just before LOGIN is made visible.
function LOGIN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LOGIN (see VARARGIN)

% Choose default command line output for LOGIN
handles.output = hObject;
movegui(gcf,'center');

data = load('UserData');
handles.user=data.UserID;
handles.code=data.UserCode;
handles.manage_user=data.ManagerID;
handles.manage_code=data.ManagerCode;

% Set Table I and II
table1 = [handles.manage_user(2:end) handles.manage_code(2:end)];
set(handles.uitable1,'data',table1)
table2 = [handles.user(2:end) handles.code(2:end)];
set(handles.uitable2,'data',table2)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LOGIN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LOGIN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_2 as text
%        str2double(get(hObject,'String')) returns contents of edit1_2 as a double


% --- Executes during object creation, after setting all properties.
function edit1_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_1 as text
%        str2double(get(hObject,'String')) returns contents of edit1_1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_3 as text
%        str2double(get(hObject,'String')) returns contents of edit1_3 as a double


% --- Executes during object creation, after setting all properties.
function edit1_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newName = get(handles.edit1_1,'string');
newCode = get(handles.edit1_2,'string');

name=handles.manage_user;
code =handles.manage_code;
n=find(strcmp(name,{newName}));
if length(n)
    msg=msgbox('Already registered£¡','System Info','warn');
    uiwait(msg);
else
    handles.manage_user = [name;newName] ;
    handles.manage_code = [code;newCode];
    ManagerID = [name;newName];
    ManagerCode = [code;newCode];
    UserID = handles.user;
    UserCode = handles.code;
    save('UserData','UserID','UserCode','ManagerID','ManagerCode')
end

% Set Table I and II
table1 = [handles.manage_user(2:end) handles.manage_code(2:end)];
set(handles.uitable1,'data',table1)
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=handles.manage_user;
code =handles.manage_code;
indexDelete = get(handles.edit1_3,'string');
indDel = str2num(indexDelete);
indDel = floor(indDel)+1;
if (indDel<2)||(indDel>length(name))
    msg=msgbox('Please verify the index of admimistor which you want to delete !','System Info','warn');
    uiwait(msg);
    return
else
    name(indDel) = [];
    code(indDel) = [];
    handles.manage_user = name;
    handles.manage_code = code;
    ManagerID = name;
    ManagerCode = code;
    UserID = handles.user;
    UserCode = handles.code;
    save('UserData','UserID','UserCode','ManagerID','ManagerCode')
    % Set Table I and II
    table1 = [name(2:end) code(2:end)];
    set(handles.uitable1,'data',table1)
end
    guidata(hObject, handles);



function edit2_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_2 as text
%        str2double(get(hObject,'String')) returns contents of edit2_2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_1 as text
%        str2double(get(hObject,'String')) returns contents of edit2_1 as a double


% --- Executes during object creation, after setting all properties.
function edit2_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_3 as text
%        str2double(get(hObject,'String')) returns contents of edit2_3 as a double


% --- Executes during object creation, after setting all properties.
function edit2_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newName = get(handles.edit2_1,'string');
newCode = get(handles.edit2_2,'string');

name=handles.user;
code =handles.code;
n=find(strcmp(name,{newName}));
if length(n)
    msg=msgbox('Already registered£¡','System Info','warn');
    uiwait(msg);
else
    handles.user = [name;newName] ;
    handles.code = [code;newCode];
    UserID = handles.user;
    UserCode = handles.code;
    ManagerID = handles.manage_user;
    ManagerCode = handles.manage_code;

    save('UserData','UserID','UserCode','ManagerID','ManagerCode')
end

% Set Table I and II
table2 = [handles.user(2:end) handles.code(2:end)];
set(handles.uitable2,'data',table2)
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=handles.user;
code =handles.code;
indexDelete = get(handles.edit2_3,'string');
indDel = str2num(indexDelete);
indDel = floor(indDel)+1;
if (indDel<2)||(indDel>length(name))
    msg=msgbox('Please verify the index of admimistor which you want to delete !','System Info','warn');
    uiwait(msg);
    return
else
    name(indDel) = [];
    code(indDel) = [];
    handles.user = name;
    handles.code = code;
    ManagerID = handles.manage_user;
    ManagerCode = handles.manage_code;
    UserID = handles.user;
    UserCode = handles.code;
    save('UserData','UserID','UserCode','ManagerID','ManagerCode')
    % Set Table I and II
    table2 = [name(2:end) code(2:end)];
    set(handles.uitable2,'data',table2)
end
    guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
ISEEU;
