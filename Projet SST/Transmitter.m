        %%%%%%%%%%%%%%%%%
        %  TRANSMITTER  %
        %%%%%%%%%%%%%%%%%

% Definitions des variables
N=1000;   % Nombre de symbole
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivit� fr�quentielle
fc=6000;  % Frequence porteuse

% Mise en forme du graph
box on;hold on;grid on
title('Signal');
xlabel('Frequence(Hz)');
ylabel('PSD(log)');

% Genere une liste des temps
time = genTime(N,fe,fm);

% G�nere une s�quence de bits sur-�chantillon�s
signal = genSignal(N,fe,fm);

% G�nere l'enveloppe complexe
envComp = genEnvCom (kf,time,signal);

% G�nere le message r�el
message = genRealMessage(envComp,fc,time);

% Calcule les Power Spectral Dentity
[psd,f]= welch(message,time,N,fm);
[psdSc,fSc]= welch(signal,time,N,fm);

% Plot la PSD
%plot (f, 10*log10(psd));
%plot (fSc, 10*log10(psdSc));
plot (f, psd);
plot (fSc, psdSc);