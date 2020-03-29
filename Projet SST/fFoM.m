function fom = fFoM(N,fm,fe,kf,fc,a,R)
Bt=2*(fm+kf);


% G�n�ration du message par l'�metteur
[message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc);

% Addition du bruit
[N0,noise] = genNoise(fe,message,N,R);
messageB=message + noise;

% Passage en bande de base du message non bruit�
[signaReal,signalComp] = freqShift(message,fc,time);
[signalRealF, signalCompF] = lowFilter(signaReal,signalComp,Bt/2,fe);
enveloppe = signalRealF + signalCompF*1j;
baseSignal = slopeFilter(Bt,a,enveloppe,fe);

% Passage en bande de base du message bruit�
[signaRealB,signalCompB] = freqShift(messageB,fc,time);
[signalRealFB, signalCompFB] = lowFilter(signaRealB,signalCompB,Bt/2,fe);
enveloppeB = signalRealFB + signalCompFB*1j;
baseSignalB = slopeFilter(Bt,a,enveloppeB,fe);


powerMessage = sum(abs(messageB.^2))/fe;  % Puissance du signal utile a l'entr�e du d�modulateur
powerNoise = sum(abs((messageB-message).^2))/fe;     % Puissance du bruit en bande passante � l'entr�e du d�modulateur
powerMessageD = sum(abs(baseSignalB.^2))/fe; % Puissance du signal utile a la sortie
powerNoiseD = sum(abs((baseSignalB-baseSignal).^2))/fe; % Puissance du bruit � la sortie

Ri = 10*log10(powerMessage/powerNoise); 
Ro = 10*log10(powerMessageD/powerNoiseD);

fom = Ro-Ri;