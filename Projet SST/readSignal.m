function genBiteSeq = readSignal(message,fc,time,Bt,fe,a,N,fm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'échantillons                                             %
% - fe : fréquence d'échantillonage                                       %
% - fm : fréquence du message                                             %
% - fc : frequence porteuse                                               %
% - message : le message à demoduler                                      %
% - time : liste des temps au quel est envoyé chaque échantillon          %
% - Bt : bande passante du signal                                         %
% - a : pente du filtre en pente                                          %
%                                                                         %
% Passe le signal en bande de base, le filtre transphorme la modulation   %
% en fréquence en modulation en amplitude et décrypte la séquance de bits %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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