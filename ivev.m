clearvars; clc; close all;
[RehabParameters,path] = uigetfile('*.*','.mat');
RehabFile=load('-mat',RehabParameters);
cd(path)
data=RehabFile.data; 
fs=15;
ivev_angle=data(:,3);
ivev_angle2=ivev_angle;
for i=1:length(ivev_angle)-1
    if (ivev_angle(i)<320)
        ivev_angle2(i)=ivev_angle2(i)+359;
    end
    
end
plot(ivev_angle2,'k')

set(gca,'XTick',0:length(data)/10:length(data));
set(gca,'XTickLabel',0:length(data)/100:length(data)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim")
xlabel("Saniye")
ylabel("Açý")

ivev_angle_meanfiltered=ivev_angle2-mean(ivev_angle2);

figure
faxes=linspace(-fs/2,fs/2,length(ivev_angle_meanfiltered));
plot(faxes,fftshift(abs(fft(ivev_angle_meanfiltered))));
% xlim([-2 2 ])
title("Sinyalin Genlik Spektrumu")
xlabel("Frekans (Hz)")
ylabel("Genlik")

figure
plot(ivev_angle_meanfiltered)
Band    = (2 / fs) * 1.2;
[B, A]  = butter(3, Band, 'low');   
block_duration_datacorrected_last = filtfilt(B, A, double(ivev_angle_meanfiltered));
figure;
plot(block_duration_datacorrected_last,'k')
set(gca,'XTick',0:length(block_duration_datacorrected_last)/10:length(block_duration_datacorrected_last));
set(gca,'XTickLabel',0:length(block_duration_datacorrected_last)/100:length(block_duration_datacorrected_last)/10);
% axis([0 1800 -50 50])
title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")

iversiyon= block_duration_datacorrected_last(block_duration_datacorrected_last>0);
eversiyon= block_duration_datacorrected_last(block_duration_datacorrected_last<0);
figure
plot(iversiyon,'k')
set(gca,'XTick',0:length(iversiyon)/10:length(iversiyon));
set(gca,'XTickLabel',0:length(iversiyon)/100:length(iversiyon)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim(iversiyon) ")
xlabel("Saniye")
ylabel("Açý")
xlim([0 length(iversiyon)])

figure
plot(-eversiyon,'k')
set(gca,'XTick',0:length(eversiyon)/10:length(eversiyon));
set(gca,'XTickLabel',0:length(eversiyon)/100:length(eversiyon)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim (eversiyon) ")
xlabel("Saniye")
ylabel("Açý")
xlim([0 length(eversiyon)])


%% KUVVETLER 

sag=data(:,5);

sol=data(:,6);

figure;
plot(sag,'k')
hold on
set(gca,'XTick',0:length(sag)/10:length(sag));
set(gca,'XTickLabel',0:length(sag)/100:length(sag)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Ýversiyon esnasýnda görülen kuvvet deðiþimi")
xlim([0 length(sag)])

figure;
plot(sol/2.5,'r')
hold on
set(gca,'XTick',0:length(sol)/10:length(sol));
set(gca,'XTickLabel',0:length(sol)/100:length(sol)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Eversiyon esnasýnda görülen kuvvet deðiþimi")
xlim([0 length(sol)])

sagkuvvet=sag-mean(sag);

solkuvvet=sol-mean(sol);
solkuvvet_=solkuvvet/3;

Band    = (2 / fs) * 1;
[B, A]  = butter(3, Band, 'low');   
sag_kuvvet = filtfilt(B, A, double(sagkuvvet));
   
Band    = (2 / fs) * 1;
[B, A]  = butter(3, Band, 'low');   
sol_kuvvet = filtfilt(B, A, double(solkuvvet_));


figure;
plot(sag_kuvvet-sag_kuvvet(1),'r')
hold on
set(gca,'XTick',0:length(sag_kuvvet)/10:length(sag_kuvvet));
set(gca,'XTickLabel',0:length(sag_kuvvet)/100:length(sag_kuvvet)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Ýversiyon esnasýnda görülen kuvvet deðiþimi")
xlim([0 length(sag_kuvvet)])

figure;
plot(sol_kuvvet-sol_kuvvet(1),'k')
hold on
set(gca,'XTick',0:length(sol_kuvvet)/10:length(sol_kuvvet));
set(gca,'XTickLabel',0:length(sol_kuvvet)/100:length(sol_kuvvet)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Eversiyon esnasýnda görülen kuvvet deðiþimi")
xlim([0 length(sol_kuvvet)])





