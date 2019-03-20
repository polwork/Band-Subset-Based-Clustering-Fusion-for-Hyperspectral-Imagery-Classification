function varargout = enter(varargin)
% ENTER M-file for enter.fig
%      ENTER, by itself, creates a new ENTER or raises the existing
%      singleton*.
%
%      H = ENTER returns the handle to a new ENTER or the handle to
%      the existing singleton*.
%
%      ENTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTER.M with the given input arguments.
%
%      ENTER('Property','Value',...) creates a new ENTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before enter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to enter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help enter

% Last Modified by GUIDE v2.5 15-Jun-2007 16:56:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @enter_OpeningFcn, ...
                   'gui_OutputFcn',  @enter_OutputFcn, ...
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


% --- Executes just before enter is made visible.
function enter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to enter (see VARARGIN)

% Choose default command line output for enter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes enter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = enter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close
segmentation();


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


