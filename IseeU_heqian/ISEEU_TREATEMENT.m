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

% Last Modified by GUIDE v2.5 01-Aug-2016 11:44:11

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
function loadPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadPath (see GCBO)
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
imagesc(I);
title('Orignal Figure')
axis image
axis auto
axis off

% show the oldFig
axes(handles.newFig)
imagesc(I2);
%title('Crop Figure')
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
    
    handles.datauser.fileName = str;
end

guidata(hObject,handles);


% --- Executes on button press in saveNewFig.
function saveNewFig_Callback(hObject, eventdata, handles)
% hObject    handle to saveNewFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = pwd;
pathFig = strcat(path,'\CropFigures\',date);

% make a folder named date to place the figures 
% s = mkdir(pathFig);
% if s~=1
%     msgbox('There is problem of building a new folder for figures!')
%     return
% end
%%% ---------save Figure ----------------------------------------%%%
name = get(handles.newFigName, 'string');
name = strcat(pathFig,'-', name);
I = handles.datauser.newFig;
I=im2uint8(I);  % convert image to 8bit unsighed integers

n=find(name=='\',1,'last');
nameFig=name([n+1:end]);
figure(2);
imshow(I);
%title(['crop Figure-',nameFig]);

save(name,'I');
%saveas(gcf,name);
%cropFigName=figure2;
%print(cropFigName,'-djpeg',name);
set(handles.saveNewFig,'string','be Saving')
pause(1);
set(handles.saveNewFig,'string','Save')
handles.datauser.nameFig=nameFig;
guidata(hObject,handles);


function newFigName_Callback(hObject, eventdata, handles)
% hObject    handle to newFigName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newFigName as text
%        str2double(get(hObject,'String')) returns contents of newFigName as a double


% --- Executes during object creation, after setting all properties.
function newFigName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newFigName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pathImTreated_Callback(hObject, eventdata, handles)
% hObject    handle to pathImTreated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathImTreated as text
%        str2double(get(hObject,'String')) returns contents of pathImTreated as a double


% --- Executes during object creation, after setting all properties.
function pathImTreated_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathImTreated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in loadImTreated.
function loadImTreated_Callback(hObject, eventdata, handles)
% hObject    handle to loadImTreated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function loadButton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton1.
function loadButton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton1 (see GCBO)
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
        axes(handles.figDelSpot);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end

end


n=find(str=='\',1,'last');
nameFig=str([n+1:end]);
figure(2);
imshow(treatFig);
title(['crop Figure-',nameFig]);

handles.datauser.treatFig = treatFig;
handles.datauser.figPath=str;
handles.datauser.nameFig=nameFig;

guidata(hObject,handles);

% --- Executes on button press in previousLoad1.
function previousLoad1_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.newFig;
handles.datauser.treatFig=J;

% n=find(name=='\',1,'last');
% nameFig=name([n+1:end]);
imshow(J);
% title(['crop Figure-',nameFig]);

axes(handles.figDelSpot);
colormap gray;
imagesc(J);
axis image; % zoom the figure to original scale
axis auto;
axis off;

guidata(hObject,handles);

% --- Executes on button press in inpaint.
function inpaint_Callback(hObject, eventdata, handles)
% hObject    handle to inpaint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig;
figName=handles.datauser.nameFig;

if ndims(J)==3
    J=rgb2gray(J);
end
J = im2uint8(J);

coef_str=get(handles.delSpotVal,'string');
coef=str2double(coef_str);

resI=deletHighlight(J,coef,0);
inpaintFig=resI;
%figName=handles.datauser.nameFig;

axes(handles.figDelSpot);
colormap gray;
imagesc(inpaintFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
colormap gray;
imagesc(inpaintFig);
title(['bright spot inpainted Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])
handles.datauser.inpaintFig=inpaintFig;


guidata(hObject,handles);


function delSpotVal_Callback(hObject, eventdata, handles)
% hObject    handle to delSpotVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delSpotVal as text
%        str2double(get(hObject,'String')) returns contents of delSpotVal as a double


% --- Executes during object creation, after setting all properties.
function delSpotVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delSpotVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in takeOut1.
function takeOut1_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figName=handles.datauser.nameFig;

figure;
colormap gray;
imagesc(handles.datauser.inpaintFig);
title(['bright spot inpainted Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])

guidata(hObject,handles);


% --- Executes on button press in previousLoad2.
function previousLoad2_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.inpaintFig;

axes(handles.figAjustContrast);
colormap gray;
imagesc(J);
axis image; % zoom the figure to original scale
axis auto;
axis off;

handles.datauser.treatFig2=J;

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function loadButton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton2.
function loadButton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton2 (see GCBO)
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
        axes(handles.figAjustContrast);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end

end

n=find(str=='\',1,'last');
nameFig=str([n+1:end]);
figure(2);
imshow(treatFig);
title(['crop Figure-',nameFig]);

handles.datauser.treatFig2 = treatFig;
handles.datauser.figPath=str;
handles.datauser.nameFig=nameFig;

guidata(hObject,handles);



% --- Executes on button press in ajustContast.
function ajustContast_Callback(hObject, eventdata, handles)
% hObject    handle to ajustContast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig2;
resI=adjustContrast(J);
ajustContrastFig=resI;

figName=handles.datauser.nameFig;

axes(handles.figAjustContrast);
colormap gray;
imagesc(ajustContrastFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
imshow(ajustContrastFig);
title(['contrast increased Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])
handles.datauser.ajustContrastFig=ajustContrastFig;

guidata(hObject,handles);

% --- Executes on button press in takeOut2.
function takeOut2_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figName=handles.datauser.nameFig;

figure;
colormap gray;
imagesc(handles.datauser.ajustContrastFig);
title(['contrast increased Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])

guidata(hObject,handles);



% --- Executes on button press in morphClose.
function morphClose_Callback(hObject, eventdata, handles)
% hObject    handle to morphClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig3;
figName=handles.datauser.nameFig;

if ndims(J)==3
    J=rgb2gray(J);
end
J = im2uint8(J);

a=get(handles.closeDiskSize,'string');
a=str2double(a);

% if a==0
%     disp('You ordered no close morph operation.');
%     return;
% else
    resI=closeOperation(J,a);
    closeMorphFig=resI;

    figName=handles.datauser.nameFig;
    axes(handles.figMorph);
    colormap gray;
    imagesc(closeMorphFig);
    axis image % zoom the figure to original scale
    axis normal
    axis off

    figure;
    imshow(closeMorphFig);
    title(['close Morph Figure-',figName]);
    %print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
    %print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])
    handles.datauser.closeMorphFig=closeMorphFig;
% end
handles.datause.treatFig4=handles.datauser.closeMorphFig;
guidata(hObject,handles);


% --- Executes on button press in openMorph.
function openMorph_Callback(hObject, eventdata, handles)
% hObject    handle to openMorph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.treatFig4;

a=get(handles.openSize1,'string');
b=get(handles.openSize2,'string');
a=str2double(a);
b=str2double(b);
resI=openOperation(J,a,b);
openMorphFig=resI;

figName=handles.datauser.nameFig;
axes(handles.figMorph);
colormap gray;
imagesc(openMorphFig);
axis image % zoom the figure to original scale
axis normal
axis off

figure;
imshow(openMorphFig);
title(['open Morph Figure-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])
handles.datauser.openMorphFig=openMorphFig;
% end
handles.datause.treatFig4=handles.datauser.openMorphFig;
guidata(hObject,handles);






% --- Executes on button press in previousLoad3.
function previousLoad3_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

J=handles.datauser.ajustContrastFig;

axes(handles.figMorph);
colormap gray;
imagesc(J);
axis image; % zoom the figure to original scale
axis auto;
axis off;

handles.datauser.treatFig3=J;
handles.datauser.treatFig4=J;

guidata(hObject,handles);


% --- Executes on button press in loadButton3.
function loadButton3_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton3 (see GCBO)
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
        axes(handles.figMorph);
        imagesc(treatFig);
        axis image;
        axis normal;
        axis off;
    end

end


n=find(str=='\',1,'last');
nameFig=str([n+1:end]);
figure(2);
imshow(treatFig);
title(['crop Figure-',nameFig]);

handles.datauser.treatFig3 = treatFig;
handles.datauser.figPath=str;
handles.datauser.nameFig=nameFig;

guidata(hObject,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over loadButton3.
function loadButton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to loadButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function loadButton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in edgePadding.
function edgePadding_Callback(hObject, eventdata, handles)
% hObject    handle to edgePadding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in gaussFilter.
function gaussFilter_Callback(hObject, eventdata, handles)
% hObject    handle to gaussFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function closeDiskSize_Callback(hObject, eventdata, handles)
% hObject    handle to closeDiskSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of closeDiskSize as text
%        str2double(get(hObject,'String')) returns contents of closeDiskSize as a double



% --- Executes during object creation, after setting all properties.
function closeDiskSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to closeDiskSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function openSize1_Callback(hObject, eventdata, handles)
% hObject    handle to openSize1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of openSize1 as text
%        str2double(get(hObject,'String')) returns contents of openSize1 as a double


% --- Executes during object creation, after setting all properties.
function openSize1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to openSize1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function openSize2_Callback(hObject, eventdata, handles)
% hObject    handle to openSize2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of openSize2 as text
%        str2double(get(hObject,'String')) returns contents of openSize2 as a double


% --- Executes during object creation, after setting all properties.
function openSize2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to openSize2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in takeOut3.
function takeOut3_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figName=handles.datauser.nameFig;

figure;
colormap gray;
imagesc(handles.datauser.treatFig4);
title(['morph operation-',figName]);
%print(inpainFig,'-djpeg',['bright spot inpainted Figure-',figName])
%print(getimage(handles.figDelSpot),'-djpeg',['bright spot inpainted Figure-',figName])

guidata(hObject,handles);


% --- Executes on button press in previousLoad4.
function previousLoad4_Callback(hObject, eventdata, handles)
% hObject    handle to previousLoad4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadButton4.
function loadButton4_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function gauFilterVal_Callback(hObject, eventdata, handles)
% hObject    handle to gauFilterVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gauFilterVal as text
%        str2double(get(hObject,'String')) returns contents of gauFilterVal as a double


% --- Executes during object creation, after setting all properties.
function gauFilterVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gauFilterVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in takeOut4.
function takeOut4_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in takeOut5.
function takeOut5_Callback(hObject, eventdata, handles)
% hObject    handle to takeOut5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function inpaintVal2_Callback(hObject, eventdata, handles)
% hObject    handle to inpaintVal2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpaintVal2 as text
%        str2double(get(hObject,'String')) returns contents of inpaintVal2 as a double


% --- Executes during object creation, after setting all properties.
function inpaintVal2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpaintVal2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function closeSize_Callback(hObject, eventdata, handles)
% hObject    handle to closeSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of closeSize as text
%        str2double(get(hObject,'String')) returns contents of closeSize as a double


% --- Executes during object creation, after setting all properties.
function closeSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to closeSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gauFreq_Callback(hObject, eventdata, handles)
% hObject    handle to gauFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gauFreq as text
%        str2double(get(hObject,'String')) returns contents of gauFreq as a double


% --- Executes during object creation, after setting all properties.
function gauFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gauFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
