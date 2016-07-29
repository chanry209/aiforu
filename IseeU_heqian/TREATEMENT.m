function varargout = TREATEMENT(varargin)
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

% Last Modified by GUIDE v2.5 28-Jul-2016 14:33:22

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

% 
% function pathImTreated_Callback(hObject, eventdata, handles)
% % hObject    handle to pathImTreated (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of pathImTreated as text
% %        str2double(get(hObject,'String')) returns contents of pathImTreated as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function pathImTreated_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to pathImTreated (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% % --- Executes on button press in loadImTreated.
% function loadImTreated_Callback(hObject, eventdata, handles)
% % hObject    handle to loadImTreated (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% 
% % --- Executes on button press in inpaintVal.
% function inpaintVal_Callback(hObject, eventdata, handles)
% % hObject    handle to inpaintVal (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% IOri = handles.datauser.newFig; 
% 
%   if ndims(IOri)==3 
%       I=rgb2gray(IOri);    
%   else
%       I = IOri;
%   end
% %   I = im2double(I);
% I = im2uint8(I); % unit16 or others to uinit8
% coefStr = get(handles.percentDel,'string');
% coef = str2double(coefStr);
% J1 = deletHighlight(I,coef,0);
% 
% axes(handles.figDelSpot);
% colormap gray;
% imagesc(J1);
% title(' Del Spot Figure')
% axis image % zoom the figure to original scale
% axis auto
% axis off
% 
% inpaintFig=J1;
% handles.datauser.inpaintFig=inpaintFig;
% 
% % inpaintName = get(handles.inpaintFig, 'string');
% % inpaintName = strcat(inpaitFig,inpaintName);
% % save(inpaintName,'inpaintFig')
% 
% guidata(hObject,handles);
% 
% 
% % --- Executes during object creation, after setting all properties.
% function percentDel_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to percentDel (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function percentDel_Callback(hObject, eventdata, handles)
% % hObject    handle to percentDel (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of percentDel as text
% %        str2double(get(hObject,'String')) returns contents of percentDel as a double
% 
% 
% % --- Executes on button press in takeOut1.
% function takeOut1_Callback(hObject, eventdata, handles)
% % hObject    handle to takeOut1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% figure;
% IOri = handles.datauser.newFig; 
% 
%   if ndims(IOri)==3 
%       I=rgb2gray(IOri);    
%   else
%       I = IOri;
%   end
% I = im2uint8(I); % unit16 or others to uinit8
% coefStr = get(handles.percentDel,'string');
% coef = str2double(coefStr);
% J1 = deletHighlight(I,coef,0);
% colormap gray;
% imagesc(J1);
% title(' Del Spot Figure')
% axis auto
% axis image
% guidata(hObject,handles);
% 
% 
% % --- Executes on button press in ajustContrast.
% %%% -------- ajust contrast by function imajust.m and histeq.m --%
% function ajustContrast_Callback(hObject, eventdata, handles)
% % hObject    handle to ajustContrast (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% J=handles.datauser.paddingFig;
% ajustConFig=adjustContrast(J);
% 
% axes(handles.figAjustContrast);
% colormap gray;
% imagesc(ajustConFig);
% %title('Ajust Contrast Figure');
% axis auto;
% axis image;
% pause(4);
% 
% handles.datauser.ajustConFig=ajustConFig;
% 
% guidata(hObject,handles);
% 
% 
% % --- Executes on button press in takeOut3.
% function takeOut3_Callback(hObject, eventdata, handles)
% % hObject    handle to takeOut3 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% figure;
% J=handles.datauser.paddingFig;
% ajustConFig=adjustContrast(J);
% 
% colormap gray;
% imagesc(ajustConFig);
% title('Ajust Contrast  Figure');
% axis auto;
% axis image;
% pause(5);
% %save(name,'paddingFig');
% handles.datauser.ajustConFig=ajustConFig;
% 
% guidata(hObject,handles);
% 
% 
% % % --- Executes on button press in morphClose.
% % function morphClose_Callback(hObject, eventdata, handles)
% % % hObject    handle to morphClose (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % 
% % J=handles.datauser.ajustConFig;
% % % 
% % formSE=get(handles.formCloseStrel,'string');
% % aStr=get(handles.sizeCloseSE1,'string');
% % a=str2double(aStr);
% % bStr=get(handles.sizeCloseSE2,'string');
% % b=str2double(bStr);
% % sizeSE=[a,b];
% % 
% % morphCloseFig=closeOperation(J,formSE,sizeSE)
% % 
% % axes(handles.figMorphClose);
% % colormap gray;
% % imagesc(morphCloseFig);
% % title('close Morphology operation  Figure');
% % axis auto;
% % axis image;
% % pause(5);
% % 
% % handles.datauser.morphCloseFig=morphCloseFig;
% % 
% % guidata(hObject,handles);
% 
% %%%-----input the parametre of close morpholgical operation --------%%%
% 
% % function sizeCloseSE1_Callback(hObject, eventdata, handles)
% % % hObject    handle to sizeCloseSE1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % 
% % % Hints: get(hObject,'String') returns contents of sizeCloseSE1 as text
% % %        str2double(get(hObject,'String')) returns contents of sizeCloseSE1 as a double
% % 
% % 
% % % --- Executes during object creation, after setting all properties.
% % function sizeCloseSE1_CreateFcn(hObject, eventdata, handles)
% % % hObject    handle to sizeCloseSE1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    empty - handles not created until after all CreateFcns called
% % 
% % % Hint: edit controls usually have a white background on Windows.
% % %       See ISPC and COMPUTER.
% % if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
% %     set(hObject,'BackgroundColor','white');
% % end
% % 
% % 
% % function sizeCloseSE2_Callback(hObject, eventdata, handles)
% % % hObject    handle to sizeCloseSE1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % 
% % % Hints: get(hObject,'String') returns contents of sizeCloseSE1 as text
% % %        str2double(get(hObject,'String')) returns contents of sizeCloseSE1 as a double
% % 
% % % --- Executes during object creation, after setting all properties.
% % function sizeCloseSE2_CreateFcn(hObject, eventdata, handles)
% % % hObject    handle to sizeCloseSE2 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    empty - handles not created until after all CreateFcns called
% % 
% % if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
% %     set(hObject,'BackgroundColor','white');
% % end
% % 
% % 
% % 
% % % --- Executes on selection change in formCloseStrel.
% % function formCloseStrel_Callback(hObject, eventdata, handles)
% % % hObject    handle to formCloseStrel (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % 
% % % Hints: contents = cellstr(get(hObject,'String')) returns formCloseStrel contents as cell array
% % %        contents{get(hObject,'Value')} returns selected item from formCloseStrel
% % 
% % se2=get(gcf,'selectiontype');
% % if strcmp(se2,'open')
% %     str=get(hObject,'string');
% %     n=get(hObject,'value');
% %     set(handles.sub_se2,'string',str{n})
% % end
% % 
% % % --- Executes during object creation, after setting all properties.
% % function formCloseStrel_CreateFcn(hObject, eventdata, handles)
% % % hObject    handle to formCloseStrel (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    empty - handles not created until after all CreateFcns called
% % 
% % % Hint: listbox controls usually have a white background on Windows.
% % %       See ISPC and COMPUTER.
% % if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
% %     set(hObject,'BackgroundColor','white');
% % end
% % 
% % 
% % % --- Executes on button press in morphOpen.
% % function morphOpen_Callback(hObject, eventdata, handles)
% % % hObject    handle to morphOpen (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% 
% 
% % --- Executes on button press in gaussFilter.
% function gaussFilter_Callback(hObject, eventdata, handles)
% % hObject    handle to gaussFilter (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% J = handles.datauser.ajustConFig;
% fcStr= get(handles.gaussFreq,'string');
% fc=str2double(fcStr);
% 
% resI = gaussian_lowpass_filter(J,fc);
% axes(handles.figGaussFilter);
% colormap gray;
% imagesc(resI)
% %imagesc(1+log(abs(resI)));
% %title(['image GLPF avec fc = ', num2str(fc)]);
% axis auto;
% axis image;
% pause(5);
% %save(name,'paddingFig');
% handles.datauser.gaussFilterFig=resI;
% 
% guidata(hObject,handles);
% 
% % --- Executes on button press in takeOut6.
% function takeOut6_Callback(hObject, eventdata, handles)
% % hObject    handle to takeOut6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% figure;
% J = handles.datauser.ajustConFig;
% fcStr= get(handles.gaussFreq,'string');
% fc=str2double(fcStr);
% 
% resI = gaussian_lowpass_filter(J,fc);
% colormap gray;
% imagesc(resI);
% title(['image GLPF avec fc = ', num2str(fc)]);
% axis auto;
% axis image;
% pause(6);
% 
% handles.datauser.gaussFilterFig=resI;
% handles.datauser.pretreatResFig=resI;
% 
% guidata(hObject,handles);
% 
% 
% 
% function freq_Callback(hObject, eventdata, handles)
% % hObject    handle to freq (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of freq as text
% %        str2double(get(hObject,'String')) returns contents of freq as a double
% 
% 
% 
% % --- Executes during object creation, after setting all properties.
% function freq_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to freq (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% % --- Executes on button press in paddingEdges.
% function paddingEdges_Callback(hObject, eventdata, handles)
% % hObject    handle to paddingEdges (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% J=handles.datauser.inpaintFig;
% paddingFig=paddingEdge(J);
% 
% axes(handles.figPaddingEdges);
% colormap gray;
% imagesc(paddingFig);
% %title('padding Edges Figure');
% axis auto;
% axis image;
% pause(2);
% 
% handles.datauser.paddingFig=paddingFig;
% guidata(hObject,handles);
% 
% 
% % --- Executes on button press in takeOut2.
% function takeOut2_Callback(hObject, eventdata, handles)
% % hObject    handle to takeOut2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% figure;
% J=handles.datauser.inpaintFig;
% paddingFig=paddingEdge(J);
% 
% colormap gray;
% imagesc(paddingFig);
% title('padding Edges Figure');
% axis auto;
% axis image;
% pause(3);
% %save(name,'paddingFig');
% handles.datauser.paddingFig=paddingFig;
% guidata(hObject,handles);
% 
% 
% % --- Executes on button press in runAllpretreatment.
% function runAllpretreatment_Callback(hObject, eventdata, handles)
% % hObject    handle to runAllpretreatment (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% %[res]=preTraitement(I,glpf_fc, rectangleSize,weight)
% %[res]=preTraitement(I,percent,glpf_fc, rectangleSize)
% 
% J = handles.datauser.newFig; 
% if ndims(J)==3
%     I=rgb2gray(J);    
% else
%     J = J;
% end
% 
% J = im2uint8(J); % unit16 or others to uinit8
% 
% percent_str = get(handles.percentTop,'string');
% percent = str2double(percent_str);
% glpf_str=get(handles.freq,'string');
% glpf_fc=str2double(glpf_str);
% a_str=get(handles.rectangleA,'string');
% b_str=get(handles.rectangleB,'string');
% rectangleSize=[str2double(a_str),str2double(b_str)];
% 
% resIall=preTraitement(J,percent,glpf_fc, rectangleSize)
% 
% axes(handles.figResImage);
% colormap gray;
% imagesc(resIall);
% title(' all pretreatment operation result Image')
% axis image % zoom the figure to original scale
% axis auto
% axis off
% 
% resFig=resIall;
% handles.datauser.resFig=resFig;
% 
% 
% function percentTop_Callback(hObject, eventdata, handles)
% % hObject    handle to percentTop (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of percentTop as text
% %        str2double(get(hObject,'String')) returns contents of percentTop as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function percentTop_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to percentTop (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% % --- Executes during object creation, after setting all properties.
% function rectangleA_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to rectangleA (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% 
% % --- Executes during object creation, after setting all properties.
% function rectangleB_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to rectangleB (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% 
% % --- Executes on button press in preResSave.
% function preResSave_Callback(hObject, eventdata, handles)
% % hObject    handle to preResSave (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% path = pwd;
% pathFig = strcat(path,'\pretreamentRes\');
% 
% % make a folder named date to place the figures 
% s = mkdir(pathFig);
% if s~=1
%     msgbox('There is problem of building a new folder for figures!')
%     return
% end
% 
% nameResFig = get(handles.figGaussFilter, 'string');
% nameResFig = strcat(pathFig,nameResFig);
% J = handles.datauser.pretreatResFig;
% save(nameResFig,'J')
% set(handles.preResSave,'string','be Saving')
% pause(8);
% set(handles.preResSave,'string','Save')
% 
% guidata(hObject,handles);
% 
% 
% 
% function blockNumber_Callback(hObject, eventdata, handles)
% % hObject    handle to blockNumber (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of blockNumber as text
% %        str2double(get(hObject,'String')) returns contents of blockNumber as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function blockNumber_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to blockNumber (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% % --- Executes on button press in otusOperation.
% function otusOperation_Callback(hObject, eventdata, handles)
% % hObject    handle to otusOperation (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% nbrBlock=get(handles.blockNumber,'string');
% %nbrBlock=num2double(nbrBlock_str);
% G=handles.datauser.gaussFilterFig;
% resI=otusOperation(G,nbrBlock);
% 
% axes(handles.otusRes);
% colormap gray;
% imagesc(resI);
% title(' Otus Result Figure')
% axis image % zoom the figure to original scale
% axis auto
% axis off
% 
% resOtusFig=resI;
% handles.datauser.resOtusFig=resOtusFig;
% 
% 
