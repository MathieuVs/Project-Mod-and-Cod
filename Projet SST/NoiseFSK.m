%%%%%%%%%%%
%  NOISE  %
%%%%%%%%%%%


% Definitions des variables
N=10000;   % Nombre de symbole
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivité fréquentielle
fc=6000;  % Frequence porteuse
Bt=2*(fm+kf);  % Fréquence de coupure filtre passe bas
a=10;     % Pente du filtre
fileName="/Users/mathieu/Desktop/KDO-ConvertImage.jpg";

% Génération du message par l'émetteur
[N,message,time,bitSeq,nbl,nbc] = sendImage(fileName,fm,fe,kf,fc);

% Addition du bruit
[N0,noise] = genNoise(fe,message,N,10);
%messageB=message + noise;
messageB=message;

% Décryptage du message
genBiteSeq = readSignalFSK(messageB,fc,time,Bt,fe,N,fm,kf);
for i=1:length(bitSeq)
    if bitSeq(i)==-1
       bitSeq(i)=0;
    end
end
% Vérification
corretBit=0;
for n = 1:length(bitSeq)
    if bitSeq(n) == genBiteSeq(n)
        corretBit = corretBit+1;
    end
end

disp("Nombre des bits correctements transmits : " + corretBit +"/"+ N);

BinaryToImage(genBiteSeq,nbl,nbc);
