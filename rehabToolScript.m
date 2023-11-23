%toplam peak sayýsý forceda (basma sayýsý)
%xls

clearvars; clc;
[RehabParameters,path] = uigetfile('*.*','.mat');
RehabFile=load('-mat',RehabParameters);
cd(path)
RehabData=RehabFile.data; 
% RehabData=RehabData(525:end,:);
X_angle=RehabData(:,1);
Y_angle=RehabData(:,2);
Z_angle=RehabData(:,3);
F1=RehabData(:,4);
F2=RehabData(:,5);
F3=RehabData(:,6);
F4=RehabData(:,7);

threshold_force=0.5;

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


%START and FINISH Points

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

figure(1);
plot(F1)
hold on
plot(F1_peaks_pos_last_one,F1(F1_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F1_start_pos_last_one,F1(F1_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F1_end_pos_last_one,F1(F1_end_pos_last_one),'b+','MarkerFaceColor','r')


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

figure(2);
plot(F2)
hold on
plot(F2_peaks_pos_last_one,F2(F2_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F2_start_pos_last_one,F2(F2_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F2_end_pos_last_one,F2(F2_end_pos_last_one),'b+','MarkerFaceColor','r')

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

figure(3);
plot(F3)
hold on
plot(F3_peaks_pos_last_one,F3(F3_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F3_start_pos_last_one,F3(F3_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F3_end_pos_last_one,F3(F3_end_pos_last_one),'b+','MarkerFaceColor','r')

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

figure(4);
plot(F4)
hold on
plot(F4_peaks_pos_last_one,F4(F4_peaks_pos_last_one),'r+','MarkerFaceColor','r')
hold on
plot(F4_start_pos_last_one,F4(F4_start_pos_last_one),'k+','MarkerFaceColor','r')
hold on
plot(F4_end_pos_last_one,F4(F4_end_pos_last_one),'b+','MarkerFaceColor','r')

figure(5);
plot(X_angle(F1_start_pos_last_one:F1_end_pos_last_one))
hold on
plot(Y_angle(F1_start_pos_last_one:F1_end_pos_last_one))
hold on
plot(Z_angle(F1_start_pos_last_one:F1_end_pos_last_one))

figure(6);
plot(X_angle(F2_start_pos_last_one:F2_end_pos_last_one))
hold on
plot(Y_angle(F2_start_pos_last_one:F2_end_pos_last_one))
hold on
plot(Z_angle(F2_start_pos_last_one:F2_end_pos_last_one))

figure(7);
plot(X_angle(F3_start_pos_last_one:F3_end_pos_last_one))
hold on
plot(Y_angle(F3_start_pos_last_one:F3_end_pos_last_one))
hold on
plot(Z_angle(F3_start_pos_last_one:F3_end_pos_last_one))

figure(8);
plot(X_angle(F4_start_pos_last_one:F4_end_pos_last_one))
hold on
plot(Y_angle(F4_start_pos_last_one:F4_end_pos_last_one))
hold on
plot(Z_angle(F4_start_pos_last_one:F4_end_pos_last_one))
