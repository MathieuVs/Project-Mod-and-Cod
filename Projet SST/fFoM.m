function fom = fFoM(N,fm,fe,kf,fc,a,R)
Bt=2*(fm+kf);


% Génération du message par l'émetteur
[message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc);

% Addition du bruit
[N0,noise] = genNoise(fe,message,N,R);
messageB=message + noise;

% Passage en bande de base du message non bruité
[signaReal,signalComp] = freqShift(message,fc,time);
[signalRealF, signalCompF] = lowFilter(signaReal,signalComp,Bt/2,fe);
enveloppe = signalRealF + signalCompF*1j;
baseSignal = slopeFilter(Bt,a,enveloppe,fe);

% Passage en bande de base du message bruité
[signaRealB,signalCompB] = freqShift(messageB,fc,time);
[signalRealFB, signalCompFB] = lowFilter(signaRealB,signalCompB,Bt/2,fe);
enveloppeB = signalRealFB + signalCompFB*1j;
baseSignalB = slopeFilter(Bt,a,enveloppeB,fe);


powerMessage = sum(abs(messageB.^2))/fe;  % Puissance du signal utile a l'entrée du démodulateur
powerNoise = sum(abs((messageB-message).^2))/fe;     % Puissance du bruit en bande passante à l'entrée du démodulateur
powerMessageD = sum(abs(baseSignalB.^2))/fe; % Puissance du signal utile a la sortie
powerNoiseD = sum(abs((baseSignalB-baseSignal).^2))/fe; % Puissance du bruit à la sortie

Ri = 10*log10(powerMessage/powerNoise); 
Ro = 10*log10(powerMessageD/powerNoiseD);

fom = Ro-Ri;