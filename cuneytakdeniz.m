clearvars
if ~isempty(instrfind)
   fclose(instrfind);
   delete(instrfind);
end
ports = seriallist
s = serial(ports(1), "BaudRate",115200,'DataBits',8,'Terminator','LF');

fopen(s);
%fprintf(s,'*IDN?')
index = 0;
datas = 0;
datas2 =0;
datas3 =0;
datas4=0;
datas5=0;
datas6=0;
datas7=0;
tic
disp("........Connected")
 while (index<200) 
    index=index+1;
    out = fscanf(s);
    if(length(str2num(out))>0)
     b=str2num(out);
     datas(index)=b(1);
     datas2(index)=b(2);
     datas3(index)=b(3);
     datas4(index)=b(4);
     datas5(index)=b(5);
     datas6(index)=b(6);
     datas7(index)=b(7);
    end

end
toc
% fclose(s);
% clear s
figure
subplot(7,1,1)
plot(datas(1:end))
title('angle x')
subplot(7,1,2)
plot(datas2(1:end),'r')
title('angle y')
subplot(7,1,3)
plot(datas3(1:end),'k')
title('angle z')
subplot(7,1,4)
plot(datas4(1:end),'k')  %A0
title('force 1')
subplot(7,1,5)
plot(datas5(1:end),'k')  %A1
title('force 2')
subplot(7,1,6)
plot(datas6(1:end),'k')  %A2
title('force 3')
subplot(7,1,7)
plot(datas7(1:end),'k')  %A3
title('force 4')

