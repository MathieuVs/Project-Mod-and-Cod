


% Definitions des variables
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivit� fr�quentielle
fc=6000;  % Frequence porteuse
Bt=2*(fm+kf);  % Fr�quence de coupure filtre passe bas
a=10;     % Pente du filtre
fileName="/Users/mathieu/Desktop/KDO-ConvertImage.jpg";
exportFile="/Users/mathieu/Desktop/file.wav";

% G�n�ration du message par l'�metteur
[N,message,time,bitSeq,nbl,nbc] = sendImage(fileName,fm,fe,kf,fc);

nbl
nbc
audiowrite(exportFile,message,fe); 
