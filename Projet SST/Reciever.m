%%%%%%%%%%%%%%
%  RECIEVER  %
%%%%%%%%%%%%%%


% Definitions des variables
N=10000;   % Nombre de symbole
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivité fréquentielle
fc=6000;  % Frequence porteuse
Bt=2*(fm+kf);  % Fréquence de coupure filtre passe bas
a=10;     % Pente du filtre

% Génération du message par l'émetteur
[message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc);

% Translation fréquentielle
[signaReal,signalComp] = freqShift(message,fc,time);

% Filtre le signal autour de 0 jusqu'a Bt/2
[signalRealF, signalCompF] = lowFilter(signaReal,signalComp,Bt/2,fe);

% Constitue l'enveloppe complexe (x2) du signal de départ
enveloppe = signalRealF + signalCompF*1j;

% Constitue un signal proportionel à m(t)
baseSignal = slopeFilter(Bt,a,enveloppe,fe);

% Décripe le signal et le ré-échantillone pour obtenir la séquence de bit initale
genBiteSeq = decrypt(fe,fm,N,baseSignal);

% Vérification
if genBiteSeq == bitSeq
    disp("Le message a été correctement modulé et démodulé");
end
