function genBiteSeq = readSignal(message,fc,time,Bt,fe,a,N,fm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'�chantillons                                             %
% - fe : fr�quence d'�chantillonage                                       %
% - fm : fr�quence du message                                             %
% - fc : frequence porteuse                                               %
% - message : le message � demoduler                                      %
% - time : liste des temps au quel est envoy� chaque �chantillon          %
% - Bt : bande passante du signal                                         %
% - a : pente du filtre en pente                                          %
%                                                                         %
% Passe le signal en bande de base, le filtre transphorme la modulation   %
% en fr�quence en modulation en amplitude et d�crypte la s�quance de bits %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Translation fr�quentielle
[signaReal,signalComp] = freqShift(message,fc,time);

% Filtre le signal autour de 0 jusqu'a Bt/2
[signalRealF, signalCompF] = lowFilter(signaReal,signalComp,Bt/2,fe);

% Constitue l'enveloppe complexe (x2) du signal de d�part
enveloppe = signalRealF + signalCompF*1j;

% Constitue un signal proportionel � m(t)
baseSignal = slopeFilter(Bt,a,enveloppe,fe);

% D�cripe le signal et le r�-�chantillone pour obtenir la s�quence de bit initale
genBiteSeq = decrypt(fe,fm,N,baseSignal);