function varargout = segmentation(varargin)
% SEGMENTATION M-file for segmentation.fig
%      SEGMENTATION, by itself, creates a new SEGMENTATION or raises the existing
%      singleton*.
%
%      H = SEGMENTATION returns the handle to a new SEGMENTATION or the handle to
%      the existing singleton*.
%
%      SEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEGMENTATION.M with the given input arguments.
%
%      SEGMENTATION('Property','Value',...) creates a new SEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before segmentation_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to segmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help segmentation

% Last Modified by GUIDE v2.5 17-Jun-2007 10:23:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @segmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @segmentation_OutputFcn, ...
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


% --- Executes just before segmentation is made visible.
function segmentation_OpeningFcn(hObject, eventdata, handles, varargin)
global pathname;
global filename;
global num;
global buchang;
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to segmentation (see VARARGIN)

% Choose default command line output for segmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes segmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = segmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
global pathname;
global filename;
[filename,pathname,filterindex]=uigetfile({ '*.*','All Files (*.*)'},'Pick the first image');
path=[pathname,filename];
yuantu=imread(path);
set(gcf,'CurrentAxes',handles.axes1);
imshow(yuantu);
% set(handles.axes1,'visible','off');
set(handles.text1,'visible','on');
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Run_Callback(hObject, eventdata, handles)
global pathname;
global filename;
set(handles.text7,'string','Please Wait');

filename1=[];
filename2=[];
for i=1:length(filename)
    if filename(i)=='.'
        filename1=str2num(filename1);
        break;
    end
    filename1=[filename1,filename(i)];
end
for j=i:length(filename)
    filename2=[filename2,filename(j)];
end

[xgx,fzjg,jg,zu,num]=demo(pathname,filename1,filename2);%调用主程序
%显示分割结果
set(gcf,'CurrentAxes',handles.axes2);
 imshow(xgx);
% set(handles.axes2,'visible','off');
set(handles.text1,'visible','on');
set(handles.text2,'visible','on');
for i=1:min(size(fzjg,3),3)
    if i==1
        h=handles.axes4;
        handles.text=handles.text4;
    elseif i==2
        h=handles.axes5;
        handles.text=handles.text5;
    elseif i==3
         h=handles.axes6;
         handles.text=handles.text6;
    end
   set(gcf,'CurrentAxes',h);
    imshow(fzjg(:,:,i));
   set(handles.text,'visible','on');
end
set(gcf,'CurrentAxes',handles.axes3);
imshow(jg),colormap(handles.axes3,'default');
set(handles.text3,'visible','on');


set(handles.text7,'string','The Results:');

t=['分割结果说明：仿真共',int2str(num),'个波段，共分为',int2str(length(zu)),'组:[',int2str(zu),'].'];
set(handles.text8,'visible','on');
set(handles.text8,'string',t);
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
clc;
clear;
close all;
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function HImage_Callback(hObject, eventdata, handles)
global num;
global buchang;
HImage()
% hObject    handle to HImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function PCA_Callback(hObject, eventdata, handles)
% hObject    handle to PCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MeanShift_Callback(hObject, eventdata, handles)

% hObject    handle to MeanShift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function refresh_Callback(hObject, eventdata, handles)
set(handles.text1,'visible','off');
set(handles.text2,'visible','off');
set(handles.text3,'visible','off');
set(handles.text4,'visible','off');
set(handles.text5,'visible','off');
set(handles.text6,'visible','off');
set(handles.text8,'visible','off');

 set(gcf,'CurrentAxes',handles.axes2);cla;
 set(gcf,'CurrentAxes',handles.axes3);cla;
 set(gcf,'CurrentAxes',handles.axes4);cla;
 set(gcf,'CurrentAxes',handles.axes5);cla;
 set(gcf,'CurrentAxes',handles.axes6);cla;
 set(gcf,'CurrentAxes',handles.axes1);cla;
set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
set(handles.axes4,'visible','off');
set(handles.axes5,'visible','off');
set(handles.axes6,'visible','off');
set(handles.text7,'string','Welcom to HYIS systerm');
% hObject    handle to refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
clc;
clear;
close all;
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


