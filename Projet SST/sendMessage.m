function [message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'échantillons                                             %
% - fe : fréquence d'échantillonage                                       %
% - fm : fréquence du message                                             %
% - fc : frequence porteuse                                               %
% - kf : Selectivité fréquentielle                                        %
%                                                                         %
% Genere un signal de N simboles envoyé a une frequence fm,               %
% suréchantilloné a la frequence fe grace a une moduation en fréquence de %
% sélectivité kf et de fréquence porteuse fc                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Genere une liste des temps
time = genTime(N,fe,fm);

% Génere une séquence de bits sur-échantillonés
[signal,bitSeq] = genSignal(N,fe,fm);

% Génere l'enveloppe complexe
envComp = genEnvCom (kf,time,signal);

% Génere le message réel
message = genRealMessage(envComp,fc,time);