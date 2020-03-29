%%%%%%%%%%%%%%
%  RECIEVER  %
%%%%%%%%%%%%%%


% Definitions des variables
N=10000;   % Nombre de symbole
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivit� fr�quentielle
fc=6000;  % Frequence porteuse
Bt=2*(fm+kf);  % Fr�quence de coupure filtre passe bas
a=10;     % Pente du filtre

% G�n�ration du message par l'�metteur
[message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc);

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

% V�rification
if genBiteSeq == bitSeq
    disp("Le message a �t� correctement modul� et d�modul�");
end
