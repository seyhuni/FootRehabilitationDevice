clearvars; clc; close all;
[RehabParameters,path] = uigetfile('*.*','.mat');
RehabFile=load('-mat',RehabParameters);
cd(path)
data=RehabFile.data; 
fs=15;
PDFD_angle=data(:,2);
plot(PDFD_angle,'k')
set(gca,'XTick',0:length(data)/10:length(data));
set(gca,'XTickLabel',0:length(data)/100:length(data)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")

figure
faxes=linspace(-fs/2,fs/2,length(PDFD_angle));
plot(faxes,fftshift(abs(fft(PDFD_angle))));
% xlim([-2 2 ])
title("Sinyalin Genlik Spektrumu")
xlabel("Frekans (Hz)")
ylabel("Genlik")

PDFD_angle_meanfiltered=PDFD_angle-mean(PDFD_angle);


Band    = (2 / fs) * 1;
[B, A]  = butter(3, Band, 'low');   
block_duration_datacorrected_last = filtfilt(B, A, double(PDFD_angle_meanfiltered));
figure;
plot(block_duration_datacorrected_last,'k')
set(gca,'XTick',0:length(block_duration_datacorrected_last)/10:length(block_duration_datacorrected_last));
set(gca,'XTickLabel',0:length(block_duration_datacorrected_last)/100:length(block_duration_datacorrected_last)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")

% N=length(block_duration_datacorrected_last);         %number of points
% t=(0:N-1)/fs;   %time vector
% sgf = sgolayfilt(block_duration_datacorrected_last,7,21);

threshold_angle=10;

x=50;
for k=x:(length(block_duration_datacorrected_last)-x)
    
    gecici=block_duration_datacorrected_last(k-x+1:k+x);
    if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_angle)
        AnglePeaks(k) = block_duration_datacorrected_last(k);
    end
    
    
end

Angle_Peaks=find(AnglePeaks>0);

Angle_Peaks_last=zeros(1,length(block_duration_datacorrected_last));
for t=1:length(Angle_Peaks)
    mt=block_duration_datacorrected_last(Angle_Peaks(t)-5:Angle_Peaks(t)+5);
    mn=max(mt);
    Angle_Peaks_last(find(mt==mn)+Angle_Peaks(t)-6)=mn;
end
Angle_Peaks_pos_last=find(Angle_Peaks_last>0);

Angle_Peaks_pos_last_one=Angle_Peaks_pos_last;
for i=1:length(Angle_Peaks_pos_last)-1
    if((Angle_Peaks_pos_last(i+1)-Angle_Peaks_pos_last(i))<5)
        Angle_Peaks_pos_last_one(i+1)=0;
    end
end

Angle_Peaks_pos_last_one=Angle_Peaks_pos_last_one(Angle_Peaks_pos_last_one>0);

figure;
plot(block_duration_datacorrected_last)
hold on
plot(Angle_Peaks_pos_last_one,block_duration_datacorrected_last(Angle_Peaks_pos_last_one),'r+','MarkerFaceColor','r')

% Movement starting & finishing

hv=ones(1,length(block_duration_datacorrected_last));
Angle_end=sqrt(-1)*hv;
Angle_start=Angle_end;

for k=1:length(Angle_Peaks_pos_last_one)
    mt4=Angle_start(Angle_Peaks_pos_last_one(k):Angle_Peaks_pos_last_one(k)+100);
    mn4=min(mt4);
    Angle_end(find(mt4==mn4)+Angle_Peaks_pos_last_one(k)-1)=mn4;
end
Angle_end_pos_last=find(Angle_end~=sqrt(-1));

Angle_end_pos_last_one=Angle_end_pos_last;
for i=1:length(Angle_end_pos_last)-1
    if((Angle_end_pos_last(i+1)-Angle_end_pos_last(i))<5)
        Angle_end_pos_last_one(i+1)=0;
    end
end

Angle_end_pos_last_one=Angle_end_pos_last_one(Angle_end_pos_last_one>0);


for m=1:length(Angle_Peaks_pos_last_one)
    mt5=block_duration_datacorrected_last(Angle_Peaks_pos_last_one(m)-20:Angle_Peaks_pos_last_one(m));
    mn5=min(mt5);
    Angle_start(Angle_Peaks_pos_last_one(m)-20-1+find(mt5==mn5))= mn5;
end
Angle_start_pos_last=find(Angle_start~=sqrt(-1));

Angle_start_pos_last_one=Angle_start_pos_last;
for i=1:length(Angle_start_pos_last)-1
    if((Angle_start_pos_last(i+1)-Angle_start_pos_last(i))<5)
        Angle_start_pos_last_one(i)=0;
    end
end

Angle_start_pos_last_one=Angle_start_pos_last_one(Angle_start_pos_last_one>0);

hold on
plot(Angle_start_pos_last_one,block_duration_datacorrected_last(Angle_start_pos_last_one),'k+','MarkerFaceColor','k')





%% kuvvvettt

arka=data(:,4);

sag=data(:,5);

sol=data(:,6);

on=data(:,7);

tezkuvvetarka=arka(2:589);
tezkuvvetsag=sag(2:589);
tezkuvvetsol=sol(2:589);
tezkuvveton=on(2:589);
tezkuvvetarka1=tezkuvvetarka-mean(tezkuvvetarka);
tezkuvvetsag1=tezkuvvetsag-mean(tezkuvvetsag);
tezkuvvetsol1=tezkuvvetsol-mean(tezkuvvetsol);
tezkuvveton1=tezkuvveton-mean(tezkuvveton);


figure(2)
subplot(4,1,1)
plot(tezkuvvetarka,'k') % ARKA
title("Arka Kuvvet")
ylabel("Kuvvet (N)")

set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);
subplot(4,1,2)
plot(tezkuvvetsag,'m') % SAÐ
ylabel("Kuvvet (N)")
title("Sað Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);
subplot(4,1,3)
plot(tezkuvvetsol,'r') % SOL
ylabel("Kuvvet (N)")

title("Sol Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);
subplot(4,1,4)
plot(tezkuvveton,'b') % ÖN 
title("Ön Kuvvet")
ylabel("Kuvvet (N)")

set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);
xlabel("Zaman (sn)")
faxes=linspace(-fs/2,fs/2,length(tezkuvvetarka));
plot(faxes,fftshift(abs(fft(tezkuvvetarka))));
% xlim([-2 2 ])
title("Sinyalin Genlik Spektrumu")
xlabel("Frekans (Hz)")
ylabel("Genlik")

figure(3)
subplot(4,1,1)
plot(tezkuvvetarka1,'k') % ARKA
title("Arka Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);
subplot(4,1,2)
plot(tezkuvvetsag1,'m') % SAÐ
title("Sað Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);
subplot(4,1,3)
plot(tezkuvvetsol1,'r') % SOL
title("Sol Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);
subplot(4,1,4)
plot(tezkuvveton1,'b') % ÖN 
title("Ön Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8);

faxes=linspace(-fs/2,fs/2,length(tezkuvvetarka1));
plot(faxes,fftshift(abs(fft(tezkuvvetarka1))));
xlim([-2 2 ])
title("Sinyalin Genlik Spektrumu")
xlabel("Frekans (Hz)")
ylabel("Genlik")

Band    = (2 / fs) * 1.5;
[B, A]  = butter(3, Band, 'low');   
block_duration_datacorrected_last2 = filtfilt(B, A, double(tezkuvvetarka1));
   
Band    = (2 / fs) * 1.5;
[B, A]  = butter(3, Band, 'low');   
block_duration_datacorrected_last3 = filtfilt(B, A, double(tezkuvvetsag1));

Band    = (2 / fs) * 1.5;
[B, A]  = butter(3, Band, 'low');   
block_duration_datacorrected_last4 = filtfilt(B, A, double(tezkuvvetsol1));

Band    = (2 / fs) * 1.5;
[B, A]  = butter(3, Band, 'low');   
block_duration_datacorrected_last5 = filtfilt(B, A, double(tezkuvveton1));

figure(6)
subplot(4,1,1)
plot(block_duration_datacorrected_last2,'k') % ARKA
title("Arka Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8); ylabel("Kuvvet (N)")

subplot(4,1,2)
plot(block_duration_datacorrected_last3,'m') % SAÐ
title("Sað Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8); ylabel("Kuvvet (N)")

subplot(4,1,3)
plot(block_duration_datacorrected_last4,'r') % SOL
title("Sol Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8); ylabel("Kuvvet (N)")

subplot(4,1,4)
plot(block_duration_datacorrected_last5,'b') % ÖN 
title("Ön Kuvvet")
set(gca,'XTick',0:90:588);
set(gca,'XTickLabel',0:9:58.8); ylabel("Kuvvet (N)")
xlabel('Zaman (sn)')