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
fileName="/Users/mathieu/Desktop/RACOON.jpg";

% Génération du message par l'émetteur
[N,message,time,bitSeq,nbl,nbc] = sendImage(fileName,fm,fe,kf,fc);

% Addition du bruit
[N0,noise] = genNoise(fe,message,N);
messageB=message + noise;

% Décryptage du message
genBiteSeq = readSignal(messageB,fc,time,Bt,fe,a,N,fm);

% Vérification
corretBit=0;
for n = 1:length(bitSeq)
    if bitSeq(n) == genBiteSeq(n)
        corretBit = corretBit+1;
    end
end

disp("Nombre des bits correctements transmits : " + corretBit +"/"+ N);

BinaryToImage(genBiteSeq,nbl,nbc);
