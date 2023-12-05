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
figure
dorsal_fleksiyon= block_duration_datacorrected_last(block_duration_datacorrected_last>0);
plot(dorsal_fleksiyon,'k')
set(gca,'XTick',0:length(dorsal_fleksiyon)/10:length(dorsal_fleksiyon));
set(gca,'XTickLabel',0:length(dorsal_fleksiyon)/100:length(dorsal_fleksiyon)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")

threshold_angle=10;

x=20;
for k=x:(length(dorsal_fleksiyon)-x)
    
    gecici=dorsal_fleksiyon(k-x+1:k+x);
    if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_angle)
        dorsalTepeler(k) = dorsal_fleksiyon(k);
    end
    
    
end

dorsalTepeler_=find(dorsalTepeler>0);

figure;
plot(dorsal_fleksiyon)
hold on
plot(dorsalTepeler_,dorsal_fleksiyon(dorsalTepeler_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(dorsal_fleksiyon)/10:length(dorsal_fleksiyon));
set(gca,'XTickLabel',0:length(dorsal_fleksiyon)/100:length(dorsal_fleksiyon)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")


hv=ones(1,length(dorsal_fleksiyon));
dorsal_bitis=sqrt(-1)*hv;
dorsal_baslangic=dorsal_bitis;

for m=1:length(dorsalTepeler_)
    mt5=dorsal_fleksiyon(dorsalTepeler_(m)-23:dorsalTepeler_(m));
    mn5=min(mt5);
    dorsal_baslangic(dorsalTepeler_(m)-23-1+find(mt5==mn5))= mn5;
end
dorsal_baslangic_=find(dorsal_baslangic~=sqrt(-1));

figure;
plot(dorsal_fleksiyon)
hold on
plot(dorsal_baslangic_,dorsal_fleksiyon(dorsal_baslangic_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(dorsal_fleksiyon)/10:length(dorsal_fleksiyon));
set(gca,'XTickLabel',0:length(dorsal_fleksiyon)/100:length(dorsal_fleksiyon)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")

for k=1:length(dorsalTepeler_)
    mt4=dorsal_fleksiyon(dorsalTepeler_(k):dorsalTepeler_(k)+15);
    mn4=min(mt4);
    dorsal_bitis(find(mt4==mn4)+dorsalTepeler_(k)-1)=mn4;
end
dorsal_bitis_=find(dorsal_bitis~=sqrt(-1));

figure;
plot(dorsal_fleksiyon)
hold on
plot(dorsal_bitis_,dorsal_fleksiyon(dorsal_bitis_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(dorsal_fleksiyon)/10:length(dorsal_fleksiyon));
set(gca,'XTickLabel',0:length(dorsal_fleksiyon)/100:length(dorsal_fleksiyon)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")



plantar_fleksiyon= block_duration_datacorrected_last(block_duration_datacorrected_last<0);
plantar_fleksiyon=abs(plantar_fleksiyon);
plot(plantar_fleksiyon(1:end),'r')
set(gca,'XTick',0:length(plantar_fleksiyon)/10:length(plantar_fleksiyon));
set(gca,'XTickLabel',0:length(plantar_fleksiyon)/100:length(plantar_fleksiyon)/10);
xlim([0 length(plantar_fleksiyon)])
title("Plantar Fleksiyonda Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")


x=20;
for k=x:(length(plantar_fleksiyon)-x)
    
    gecici=plantar_fleksiyon(k-x+1:k+x);
    if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_angle)
        plantarTepeler(k) = plantar_fleksiyon(k);
    end
    
    
end

plantarTepeler_=find(plantarTepeler>0);

figure;
plot(plantar_fleksiyon)
hold on
plot(plantarTepeler_,plantar_fleksiyon(plantarTepeler_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(plantar_fleksiyon)/10:length(plantar_fleksiyon));
set(gca,'XTickLabel',0:length(plantar_fleksiyon)/100:length(plantar_fleksiyon)/10);
% axis([0 588 -150 0])
title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")
xlim([0 length(plantar_fleksiyon)])


hv=ones(1,length(plantar_fleksiyon));
plantar_bitis=sqrt(-1)*hv;
plantar_baslangic=plantar_bitis;

for m=1:length(plantarTepeler_)
    mt5=plantar_fleksiyon(plantarTepeler_(m)-17:plantarTepeler_(m));
    mn5=min(mt5);
    plantar_baslangic(plantarTepeler_(m)-17-1+find(mt5==mn5))= mn5;
end
plantar_baslangic_=find(plantar_baslangic~=sqrt(-1));

figure;
plot(plantar_fleksiyon)
hold on
plot(plantar_baslangic_,plantar_fleksiyon(plantar_baslangic_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(plantar_fleksiyon)/10:length(plantar_fleksiyon));
set(gca,'XTickLabel',0:length(plantar_fleksiyon)/100:length(plantar_fleksiyon)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")
xlim([0 length(plantar_fleksiyon)])


for k=1:length(plantarTepeler_)
    mt4=plantar_fleksiyon(plantarTepeler_(k):plantarTepeler_(k)+15);
    mn4=min(mt4);
    plantar_bitis(find(mt4==mn4)+plantarTepeler_(k)-1)=mn4;
end
plantar_bitis_=find(plantar_bitis~=sqrt(-1));

figure;
plot(plantar_fleksiyon)
hold on
plot(plantar_bitis_,plantar_fleksiyon(plantar_bitis_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(plantar_fleksiyon)/10:length(plantar_fleksiyon));
set(gca,'XTickLabel',0:length(plantar_fleksiyon)/100:length(plantar_fleksiyon)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")
xlim([0 length(plantar_fleksiyon)])

%% KUVVET DEÐERLERÝ
arka=data(:,4);

sag=data(:,5);

sol=data(:,6);

ontaraf=data(:,7);

figure;
plot(arka,'k')
hold on
set(gca,'XTick',0:length(arka)/10:length(arka));
set(gca,'XTickLabel',0:length(arka)/100:length(arka)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Dorsal fleksiyon anýnda uygulanan kuvvet deðiþimi")
xlim([0 length(arka)])

figure;
plot(ontaraf,'r')
hold on
set(gca,'XTick',0:length(ontaraf)/10:length(ontaraf));
set(gca,'XTickLabel',0:length(ontaraf)/100:length(ontaraf)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Plantar fleksiyon anýnda uygulanan kuvvet deðiþimi")
xlim([0 length(ontaraf)])


arkakuvvet=arka-mean(arka);

onkuvvet=ontaraf-mean(ontaraf);

Band    = (2 / fs) * 1.5;
[B, A]  = butter(3, Band, 'low');   
arka_kuvvet = filtfilt(B, A, double(arkakuvvet));
   
Band    = (2 / fs) * 1.5;
[B, A]  = butter(3, Band, 'low');   
on_kuvvet = filtfilt(B, A, double(onkuvvet));


figure;
plot(on_kuvvet-on_kuvvet(1),'r')
hold on
set(gca,'XTick',0:length(on_kuvvet)/10:length(on_kuvvet));
set(gca,'XTickLabel',0:length(on_kuvvet)/100:length(on_kuvvet)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Plantar fleksiyon anýnda uygulanan kuvvet deðiþimi")
xlim([0 length(on_kuvvet)])

figure;
plot(arka_kuvvet-arka_kuvvet(1),'k')
hold on
set(gca,'XTick',0:length(arka)/10:length(arka_kuvvet));
set(gca,'XTickLabel',0:length(arka_kuvvet)/100:length(arka_kuvvet)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")
title("Dorsal fleksiyon anýnda uygulanan kuvvet deðiþimi")
xlim([0 length(arka_kuvvet)])

on_force=on_kuvvet-on_kuvvet(1);
arka_force=arka_kuvvet-arka_kuvvet(1);

threshold_force=5;

x=20;
for k=x:(length(on_force)-x)
    
    gecici=on_force(k-x+1:k+x);
    if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_angle)
        on_force_tepeler(k) = on_force(k);
    end
    
    
end

on_force_tepeler_=find(on_force_tepeler>0);

figure;
plot(on_force)
hold on
plot(on_force_tepeler_,on_force(on_force_tepeler_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(on_force)/10:length(on_force));
set(gca,'XTickLabel',0:length(on_force)/100:length(on_force)/10);
% axis([0 588 -150 0])
title("Egzersiz esnasýnda uygulanan kuvvet grafiði")
xlabel("Saniye")
ylabel("Açý")
xlim([0 length(on_force)])


hv=ones(1,length(on_force));
on_force_bitis=sqrt(-1)*hv;
on_force_baslangic=on_force_bitis;

for m=1:length(on_force_tepeler_)
    mt5=on_force(on_force_tepeler_(m)-20:on_force_tepeler_(m));
    mn5=min(mt5);
    on_force_baslangic(on_force_tepeler_(m)-20-1+find(mt5==mn5))= mn5;
end
on_force_baslangic_=find(on_force_baslangic~=sqrt(-1));


hold on
plot(on_force_baslangic_,on_force(on_force_baslangic_),'r*','MarkerFaceColor','r')
set(gca,'XTick',0:length(on_force)/10:length(on_force));
set(gca,'XTickLabel',0:length(on_force)/100:length(on_force)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Açý")

for k=1:length(on_force_tepeler_)
    mt4=on_force(on_force_tepeler_(k):on_force_tepeler_(k)+20);
    mn4=min(mt4);
    on_force_bitis(find(mt4==mn4)+on_force_tepeler_(k)-1)=mn4;
end
on_force_bitis_=find(on_force_bitis~=sqrt(-1));

% figure;
% plot(on_force)
hold on
plot(on_force_bitis_,on_force(on_force_bitis_),'ro','MarkerFaceColor','r')
set(gca,'XTick',0:length(on_force)/10:length(on_force));
set(gca,'XTickLabel',0:length(on_force)/100:length(on_force)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet")

threshold_force=5;

x=20;
for k=x:(length(arka_force)-x)
    
    gecici=arka_force(k-x+1:k+x);
    if(gecici(ceil(length(gecici)/2))==max(gecici) & gecici(ceil(length(gecici)/2))>threshold_angle)
        arka_force_tepeler(k) = arka_force(k);
    end
    
    
end

arka_force_tepeler_=find(arka_force_tepeler>0);

figure;
plot(arka_force)
hold on
plot(arka_force_tepeler_,arka_force(arka_force_tepeler_),'r+','MarkerFaceColor','r')
set(gca,'XTick',0:length(arka_force)/10:length(arka_force));
set(gca,'XTickLabel',0:length(arka_force)/100:length(arka_force)/10);
% axis([0 588 -150 0])
title("Egzersiz esnasýnda uygulanan kuvvet grafiði")
xlabel("Saniye")
ylabel("Açý")
xlim([0 length(arka_force)])


hv=ones(1,length(arka_force));
arka_force_bitis=sqrt(-1)*hv;
arka_force_baslangic=arka_force_bitis;

for m=1:length(arka_force_tepeler_)
    mt5=arka_force(arka_force_tepeler_(m)-20:arka_force_tepeler_(m));
    mn5=min(mt5);
    arka_force_baslangic(arka_force_tepeler_(m)-20-1+find(mt5==mn5))= mn5;
end
arka_force_baslangic_=find(arka_force_baslangic~=sqrt(-1));


hold on
plot(arka_force_baslangic_,arka_force(arka_force_baslangic_),'r*','MarkerFaceColor','r')
set(gca,'XTick',0:length(arka_force)/10:length(arka_force));
set(gca,'XTickLabel',0:length(arka_force)/100:length(arka_force)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet(N)")

for k=1:length(arka_force_tepeler_)
    mt4=arka_force(arka_force_tepeler_(k):arka_force_tepeler_(k)+20);
    mn4=min(mt4);
    arka_force_bitis(find(mt4==mn4)+arka_force_tepeler_(k)-1)=mn4;
end
arka_force_bitis_=find(arka_force_bitis~=sqrt(-1));

% figure;
% plot(arka_force)
hold on
plot(arka_force_bitis_,arka_force(arka_force_bitis_),'ro','MarkerFaceColor','r')
set(gca,'XTick',0:length(arka_force)/10:length(arka_force));
set(gca,'XTickLabel',0:length(arka_force)/100:length(arka_force)/10);
% axis([0 588 -150 0])
% title("Açýsal Deðiþim (Y Ekseni)")
xlabel("Saniye")
ylabel("Kuvvet (N)")

