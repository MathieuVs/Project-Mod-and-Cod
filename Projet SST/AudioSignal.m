


% Definitions des variables
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivité fréquentielle
fc=6000;  % Frequence porteuse
Bt=2*(fm+kf);  % Fréquence de coupure filtre passe bas
a=10;     % Pente du filtre
fileName="/Users/mathieu/Desktop/KDO-ConvertImage.jpg";
exportFile="/Users/mathieu/Desktop/file.wav";

% Génération du message par l'émetteur
[N,message,time,bitSeq,nbl,nbc] = sendImage(fileName,fm,fe,kf,fc);

nbl
nbc
audiowrite(exportFile,message,fe); 
