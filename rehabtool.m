function varargout = rehabtool(varargin)
% REHABTOOL MATLAB code for rehabtool.fig
%      REHABTOOL, by itself, creates a new REHABTOOL or raises the existing
%      singleton*.
%
%      H = REHABTOOL returns the handle to a new REHABTOOL or the handle to
%      the existing singleton*.
%
%      REHABTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REHABTOOL.M with the given input arguments.
%
%      REHABTOOL('Property','Value',...) creates a new REHABTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rehabtool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rehabtool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rehabtool

% Last Modified by GUIDE v2.5 31-Aug-2023 00:45:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rehabtool_OpeningFcn, ...
                   'gui_OutputFcn',  @rehabtool_OutputFcn, ...
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


% --- Executes just before rehabtool is made visible.
function rehabtool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rehabtool (see VARARGIN)

% Choose default command line output for rehabtool
handles.output = hObject;
cla(handles.axes4,'reset');
cla(handles.axes5,'reset');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rehabtool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rehabtool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
cla(handles.axes4,'reset');
cla(handles.axes5,'reset');

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

[RehabParameters,path] = uigetfile('*.*','.mat');
RehabFile=load('-mat',RehabParameters);
RehabData=RehabFile.data; 
X_angle=RehabData(:,1);
Y_angle=RehabData(:,2);
Z_angle=RehabData(:,3);
F1=RehabData(:,4);
F2=RehabData(:,5);
F3=RehabData(:,6);
F4=RehabData(:,7);

threshold_force=0.5;

f = msgbox("Kayýt baþarýyla yüklendi.","Baþarýlý");

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

axes(handles.axes4); cla;
plot(X_angle);
xlim([0 length(X_angle)])
xlabel('Zaman')
ylabel('Açý')
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;
axes(handles.axes4); cla;
plot(Y_angle);
xlim([0 length(Y_angle)])
xlabel('Zaman')
ylabel('Açý')
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

axes(handles.axes4); cla;
plot(Z_angle);
xlim([0 length(Z_angle)])
xlabel('Zaman')
ylabel('Açý')
% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

x=50;
for k=x:(length(F1)-x)
    
    gecici=F1(k-x+1:k+x);
    if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_force)
        F1peaks(k) = F1(k);
    end
    
    
end

F1_peaks=find(F1peaks>0);

F1_peaks_last=zeros(1,length(F1));
for t=1:length(F1_peaks)
    mt=F1(F1_peaks(t)-5:F1_peaks(t)+5);
    mn=max(mt);
    F1_peaks_last(find(mt==mn)+F1_peaks(t)-6)=mn;
end
F1_peaks_pos_last=find(F1_peaks_last>0);

F1_peaks_pos_last_one=F1_peaks_pos_last;
for i=1:length(F1_peaks_pos_last)-1
    if((F1_peaks_pos_last(i+1)-F1_peaks_pos_last(i))<5)
        F1_peaks_pos_last_one(i+1)=0;
    end
end

F1_peaks_pos_last_one=F1_peaks_pos_last_one(F1_peaks_pos_last_one>0);
hv=ones(1,length(F1));
F1_end=sqrt(-1)*hv;
F1_start=F1_end;

for k=1:length(F1_peaks_pos_last_one)
    mt4=F1(F1_peaks_pos_last_one(k):F1_peaks_pos_last_one(k)+100);
    mn4=min(mt4);
    F1_end(find(mt4==mn4)+F1_peaks_pos_last_one(k)-1)=mn4;
end
F1_end_pos_last=find(F1_end~=sqrt(-1));

F1_end_pos_last_one=F1_end_pos_last;
for i=1:length(F1_end_pos_last)-1
    if((F1_end_pos_last(i+1)-F1_end_pos_last(i))<5)
        F1_end_pos_last_one(i+1)=0;
    end
end

F1_end_pos_last_one=F1_end_pos_last_one(F1_end_pos_last_one>0);


for m=1:length(F1_peaks_pos_last_one)
    mt5=F1(F1_peaks_pos_last_one(m)-F1_peaks_pos_last_one(1)+1:F1_peaks_pos_last_one(m));
    mn5=min(mt5);
    F1_start(F1_peaks_pos_last_one(m)-F1_peaks_pos_last_one(1)+1-1+find(mt5==mn5))= mn5;
end
F1_start_pos_last=find(F1_start~=sqrt(-1));

F1_start_pos_last_one=F1_start_pos_last;
for i=1:length(F1_start_pos_last)-1
    if((F1_start_pos_last(i+1)-F1_start_pos_last(i))<5)
        F1_start_pos_last_one(i)=0;
    end
end

F1_start_pos_last_one=F1_start_pos_last_one(F1_start_pos_last_one>0);

axes(handles.axes5); cla;
plot(F1)
hold on
plot(F1_peaks_pos_last_one,F1(F1_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F1_start_pos_last_one,F1(F1_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F1_end_pos_last_one,F1(F1_end_pos_last_one),'b+','MarkerFaceColor','r')

xlim([0 length(F1)])
xlabel('Zaman')
ylabel('Kuvvet')

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

x=50;
for k=x:(length(F2)-x)
        gecici=F2(k-x+1:k+x);
        if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_force)
        F2peaks(k) = F2(k);
    end
end

F2_peaks=find(F2peaks>0);

F2_peaks_last=zeros(1,length(F2));
for t=1:length(F2_peaks)
    mt1=F2(F2_peaks(t)-5:F2_peaks(t)+5);
    mn1=max(mt1);
    F2_peaks_last(find(mt1==mn1)+F2_peaks(t)-6)=mn1;
end
F2_peaks_pos_last=find(F2_peaks_last>0);

F2_peaks_pos_last_one=F2_peaks_pos_last;
for i=1:length(F2_peaks_pos_last)-1
    if((F2_peaks_pos_last(i+1)-F2_peaks_pos_last(i))<15)
        F2_peaks_pos_last_one(i+1)=0;
    end
end

F2_peaks_pos_last_one=F2_peaks_pos_last_one(F2_peaks_pos_last_one>0);

hv2=ones(1,length(F2));
F2_end=sqrt(-1)*hv2;
F2_start=F2_end;

for k=1:length(F2_peaks_pos_last_one)
    mt6=F2(F2_peaks_pos_last_one(k):F2_peaks_pos_last_one(k)+100);
    mn6=min(mt6);
    F2_end(find(mt6==mn6)+F2_peaks_pos_last_one(k)-1)=mn6;
end
F2_end_pos_last=find(F2_end~=sqrt(-1));

F2_end_pos_last_one=F2_end_pos_last;
for i=1:length(F2_end_pos_last)-1
    if((F2_end_pos_last(i+1)-F2_end_pos_last(i))<5)
        F2_end_pos_last_one(i+1)=0;
    end
end

F2_end_pos_last_one=F2_end_pos_last_one(F2_end_pos_last_one>0);


for m=1:length(F2_peaks_pos_last_one)
    mt7=F2(F2_peaks_pos_last_one(m)-F2_peaks_pos_last_one(1)+1:F2_peaks_pos_last_one(m));
    mn7=min(mt7);
    F2_start(F2_peaks_pos_last_one(m)-F2_peaks_pos_last_one(1)+1-1+find(mt7==mn7))= mn7;
end
F2_start_pos_last=find(F2_start~=sqrt(-1));

F2_start_pos_last_one=F2_start_pos_last;
for i=1:length(F2_start_pos_last)-1
    if((F2_start_pos_last(i+1)-F2_start_pos_last(i))<20)
        F2_start_pos_last_one(i)=0;
    end
end

F2_start_pos_last_one=F2_start_pos_last_one(F2_start_pos_last_one>0);

axes(handles.axes5); cla;
plot(F2)
hold on
plot(F2_peaks_pos_last_one,F2(F2_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F2_start_pos_last_one,F2(F2_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F2_end_pos_last_one,F2(F2_end_pos_last_one),'b+','MarkerFaceColor','r')

xlim([0 length(F2)])
xlabel('Zaman')
ylabel('Kuvvet')

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

x=50;
for k=x:(length(F3)-x)
        gecici=F3(k-x+1:k+x);
        if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_force)
        F3peaks(k) = F3(k);
    end
end

F3_peaks=find(F3peaks>0);

F3_peaks_last=zeros(1,length(F3));
for t=1:length(F3_peaks)
    mt2=F3(F3_peaks(t)-5:F3_peaks(t)+5);
    mn2=max(mt2);
    F3_peaks_last(find(mt2==mn2)+F3_peaks(t)-6)=mn2;
end
F3_peaks_pos_last=find(F3_peaks_last>0);

F3_peaks_pos_last_one=F3_peaks_pos_last;
for i=1:length(F3_peaks_pos_last)-1
    if((F3_peaks_pos_last(i+1)-F3_peaks_pos_last(i))<5)
        F3_peaks_pos_last_one(i+1)=0;
    end
end

F3_peaks_pos_last_one=F3_peaks_pos_last_one(F3_peaks_pos_last_one>0);

hv3=ones(1,length(F3));
F3_end=sqrt(-1)*hv3;
F3_start=F3_end;

for k=1:length(F3_peaks_pos_last_one)
    mt8=F3(F3_peaks_pos_last_one(k):F3_peaks_pos_last_one(k)+100);
    mn8=min(mt8);
    F3_end(find(mt8==mn8)+F3_peaks_pos_last_one(k)-1)=mn8;
end
F3_end_pos_last=find(F3_end~=sqrt(-1));

F3_end_pos_last_one=F3_end_pos_last;
for i=1:length(F3_end_pos_last)-1
    if((F3_end_pos_last(i+1)-F3_end_pos_last(i))<5)
        F3_end_pos_last_one(i+1)=0;
    end
end

F3_end_pos_last_one=F3_end_pos_last_one(F3_end_pos_last_one>0);


for m=1:length(F3_peaks_pos_last_one)
    mt9=F3(F3_peaks_pos_last_one(m)-F3_peaks_pos_last_one(1)+1:F3_peaks_pos_last_one(m));
    mn9=min(mt9);
    F3_start(F3_peaks_pos_last_one(m)-F3_peaks_pos_last_one(1)+1-1+find(mt9==mn9))= mn9;
end
F3_start_pos_last=find(F3_start~=sqrt(-1));

F3_start_pos_last_one=F3_start_pos_last;
for i=1:length(F3_start_pos_last)-1
    if((F3_start_pos_last(i+1)-F3_start_pos_last(i))<5)
        F3_start_pos_last_one(i)=0;
    end
end

F3_start_pos_last_one=F3_start_pos_last_one(F3_start_pos_last_one>0);

axes(handles.axes5); cla;
plot(F3)
hold on
plot(F3_peaks_pos_last_one,F3(F3_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F3_start_pos_last_one,F3(F3_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F3_end_pos_last_one,F3(F3_end_pos_last_one),'b+','MarkerFaceColor','r')
xlim([0 length(F3)])
xlabel('Zaman')
ylabel('Kuvvet')

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

x=50;
for k=x:(length(F4)-x)
        gecici=F4(k-x+1:k+x);
        if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_force)
        F4peaks(k) = F4(k);
    end
end

F4_peaks=find(F4peaks>0);

F4_peaks_last=zeros(1,length(F4));
for t=1:length(F4_peaks)
    mt3=F4(F4_peaks(t)-5:F4_peaks(t)+5);
    mn3=max(mt3);
    F4_peaks_last(find(mt3==mn3)+F4_peaks(t)-6)=mn3;
end
F4_peaks_pos_last=find(F4_peaks_last>0);

F4_peaks_pos_last_one=F4_peaks_pos_last;
for i=1:length(F4_peaks_pos_last)-1
    if((F4_peaks_pos_last(i+1)-F4_peaks_pos_last(i))<5)
        F4_peaks_pos_last_one(i+1)=0;
    end
end

F4_peaks_pos_last_one=F4_peaks_pos_last_one(F4_peaks_pos_last_one>0);

hv4=ones(1,length(F4));
F4_end=sqrt(-1)*hv4;
F4_start=F4_end;

for k=1:length(F4_peaks_pos_last_one)
    mt10=F4(F4_peaks_pos_last_one(k):F4_peaks_pos_last_one(k)+100);
    mn10=min(mt10);
    F4_end(find(mt10==mn10)+F4_peaks_pos_last_one(k)-1)=mn10;
end
F4_end_pos_last=find(F4_end~=sqrt(-1));

F4_end_pos_last_one=F4_end_pos_last;
for i=1:length(F4_end_pos_last)-1
    if((F4_end_pos_last(i+1)-F4_end_pos_last(i))<5)
        F4_end_pos_last_one(i+1)=0;
    end
end

F4_end_pos_last_one=F4_end_pos_last_one(F4_end_pos_last_one>0);


for m=1:length(F4_peaks_pos_last_one)
    mt11=F4(F4_peaks_pos_last_one(m)-F4_peaks_pos_last_one(1)+1:F4_peaks_pos_last_one(m));
    mn11=min(mt11);
    F4_start(F4_peaks_pos_last_one(m)-F4_peaks_pos_last_one(1)+1-1+find(mt11==mn11))= mn11;
end
F4_start_pos_last=find(F4_start~=sqrt(-1));

F4_start_pos_last_one=F4_start_pos_last;
for i=1:length(F4_start_pos_last)-1
    if((F4_start_pos_last(i+1)-F4_start_pos_last(i))<5)
        F4_start_pos_last_one(i)=0;
    end
end

F4_start_pos_last_one=F4_start_pos_last_one(F4_start_pos_last_one>0);

axes(handles.axes5); cla;
plot(F4)
hold on
plot(F4_peaks_pos_last_one,F4(F4_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F4_start_pos_last_one,F4(F4_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F4_end_pos_last_one,F4(F4_end_pos_last_one),'b+','MarkerFaceColor','r')

xlim([0 length(F4)])
xlabel('Zaman')
ylabel('Kuvvet')

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global RehabData; global threshold_force; global F1; global F2; global F3; global F4; 
global X_angle; global Y_angle; global Z_angle; global F1_peaks_pos_last_one; 
global F2_peaks_pos_last_one; global F3_peaks_pos_last_one; global F4_peaks_pos_last_one;
global RehabParameters;

basefilename= RehabParameters(1:end-4);
% dlmwrite([basefilename '.csv'] ,[length(F1_peaks_pos_last_one)' length(F2_peaks_pos_last_one)' length(F3_peaks_pos_last_one)' length(F4_peaks_pos_last_one)'],'precision','%20.5f');
xlswrite(basefilename,[length(F1_peaks_pos_last_one)' length(F2_peaks_pos_last_one)' length(F3_peaks_pos_last_one)' length(F4_peaks_pos_last_one)'])