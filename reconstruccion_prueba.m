close all
clc


string_note = G4;

figure(1)
plot(string_note); % f = 110 Hrz
xlabel('N muestras');
ylabel('Amplitud');
title('Grafica de la nota a analizar');

    Signal = string_note(19565:20565); % tramo de la señal con mil muestras
    fs = 11025; %Hz  S/s
    
figure(2)
plot(Signal);
xlabel('N muestras');
ylabel('Amplitud');
title('Fragmento de señal con mil muestras para mejor visualización');

    NSignal  = Signal > 0.000001; %normaliza 
    NSignalD = double(NSignal);   
                                  
figure(3)
plot(NSignalD);                   
xlabel('N muestras');
ylabel('Amplitud Normalizada');   
title('fragmento de señal normalizada con los valores mayores a cero');

    FTSignal  = fft(NSignalD);    
    FTSignal2 = abs(FTSignal);
  
figure(4)
plot(FTSignal2(1:length(FTSignal2)/2)); %grafica 
title('transformada de Fourier de la señal normalizada');
xlabel('frecuencia');
ylabel('Magnitud (pendiente de valor)');

%--------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          todo los datos           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



close all
clc

        string_note = G4;                                                   

l = length(y);                                                              
y = string_note;                                                            
YnormD = 0;                                                                 
promedio = 0;

    for N = 1:1:length(y)
        promedio = (promedio + square((y(N))*(y(N))))/length(y);            
    end

    for N=1:1:length(y)
        if y(N) > promedio | y(N) < -promedio                               
            Ynorm  = y(N) > 0.0001;                                             
            YnormD(N) = double(Ynorm);                                     
        end  
    end
        
figure(9)
plot(YnormD);                                                               
xlabel('Datos');
ylabel('Amplitud');
title('Señal de sonido normalizada (toda la grabacion)');
    

    TF = fft(YnormD,l);                                                     
    F = (abs(TF));
    g = F(3:length(F)/6);

figure(10)
FT_discrete = (abs(g(1:5:length(g))));
stem(FT_discrete);                                                          
xlabel('Frecuencia (Hrz)');
ylabel('Amplitud');
title('Transformada de fourier con la señal normalizada');
    
    Note_frecuency = 0;
                                                                            
                                                                            
    for N=80:1:length(FT_discrete)
        if Note_frecuency == 0 && ...
            (FT_discrete(N) > max(FT_discrete(N-5:N-1))) &&...
             FT_discrete(N) > 500;                                           
            Note_frecuency = N;                                             
        end
    end
    
%--------------------------------------------------------------------------  
promedio_FFT = 0;

    for N = 80:1:length(FT_discrete)                                        
        promedio_FFT = promedio_FFT + FT_discrete(N);
    end

promedio_FFT = promedio_FFT/length(FT_discrete);                            
%--------------------------------------------------------------------------


    for k = -3:1:3                                                          %busca magnitud de segundo armonico
        armonico_2 = FT_discrete(2*Note_frecuency + k)
    end
    
                                                                          
                                                                            
sprintf('La frecuencia de la nota es %d Hz.',Note_frecuency)





