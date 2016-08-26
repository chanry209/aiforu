function varargout = similarity_Search(varargin)
% SIMILARITY_SEARCH MATLAB code for similarity_Search.fig
%      SIMILARITY_SEARCH, by itself, creates a new SIMILARITY_SEARCH or raises the existing
%      singleton*.
%
%      H = SIMILARITY_SEARCH returns the handle to a new SIMILARITY_SEARCH or the handle to
%      the existing singleton*.
%
%      SIMILARITY_SEARCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMILARITY_SEARCH.M with the given input arguments.
%
%      SIMILARITY_SEARCH('Property','Value',...) creates a new SIMILARITY_SEARCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before similarity_Search_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to similarity_Search_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help similarity_Search

% Last Modified by GUIDE v2.5 19-Aug-2016 17:45:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @similarity_Search_OpeningFcn, ...
                   'gui_OutputFcn',  @similarity_Search_OutputFcn, ...
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


% --- Executes just before similarity_Search is made visible.
function similarity_Search_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to similarity_Search (see VARARGIN)

% Choose default command line output for similarity_Search
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes similarity_Search wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = similarity_Search_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadFigButton.
function loadFigButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadFigButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sel = get(gcf,'selectiontype');
if isequal(sel,'open')
    %[file path index ] = uigetfile({'*.png;*.jpg;*.tif;*.mat'},'File Selector');
    [filename pathname index ] = uigetfile({'*.png;*.jpg;*.tif'},'File Selector');
    if index==0
        return
    end
    if isequal(filename,0)
        disp('please select your figure');
    else
        imageName=filename;
        Itarget=imread(imageName);
        axes(handles.targetFig);
        imagesc(Itarget);
        axis image;
        axis normal;
        axis off;
    end
    handles.datauser.Itarget = Itarget;
    handles.datauser.imageName=imageName;
end

% handles.datauser.Itarget = Itarget;
% handles.datauser.imageName=imageName;

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function loadFigButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadFigButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function loadModelButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadModelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadModelButton.
function loadModelButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadModelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[test_modelName pathname index ] = uigetfile({'*.mat'},'test model select');
if index==0
    return
end
if isequal(test_modelName,0)
    disp('please select your figure');
else
    load(test_modelName);
end
handles.datauser.files =files;
handles.datauser.Hists=Hists;

guidata(hObject,handles);



function nResult_Callback(hObject, eventdata, handles)
% hObject    handle to nResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nResult as text
%        str2double(get(hObject,'String')) returns contents of nResult as a double


% --- Executes during object creation, after setting all properties.
function nResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in searchButton.
function searchButton_Callback(hObject, eventdata, handles)
% hObject    handle to searchButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Itarget=handles.datauser.Itarget;
files=handles.datauser.files;
%Hists=handles.datauser.Hists;
nResult_str=get(handles.nResult,'string');
nResult=str2double(nResult_str);
similarRank=searchImageHist(Itarget,'test_model', nResult);
Sorted=similarRank(:,1);
ISorted=similarRank(:,2);

%show nResult similar images:
if nResult<1
    fprintf('please entre a positive integer \n');
    return;
elseif nResult <=4
    axes(handles.resultFig);
    for i=1:nResult
        %I=imread(ISorted(i));
        I=imread(files{ISorted(i)});
        str = sprintf('I%d similarity: %.3f',i,100*Sorted(i));
        subplot(2,2,i);
        subimage(I);
        hold on;
        title(str);
        axis auto;
        %axis normal;
        axis off;
    end
elseif nResult<=9
    axes(handles.resultFig);
    for i=1:nResult
        I=imread(files{ISorted(i)});
        str = sprintf('I%d similarity: %.3f',i,100*Sorted(i));
        subplot(3,3,i);
        subimage(I);     
        hold on;
        title(str);
        axis image;
        axis normal;
        axis off;
    end
elseif nResult<=12
    axes(handles.resultFig);
    for i=1:nResult
        I=imread(files{ISorted(i)});
        str = sprintf('I%d similarity: %.3f',i,100*Sorted(i));
        subplot(4,3,i);
        subimage(I);
        hold on;
        title(str);
        axis image;
        axis normal;
        axis off;
    end
else
    fprintf('Search number can not be greater than 12 \n ');
end

% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);
