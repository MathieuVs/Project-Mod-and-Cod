function [message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'�chantillons                                             %
% - fe : fr�quence d'�chantillonage                                       %
% - fm : fr�quence du message                                             %
% - fc : frequence porteuse                                               %
% - kf : Selectivit� fr�quentielle                                        %
%                                                                         %
% Genere un signal de N simboles envoy� a une frequence fm,               %
% sur�chantillon� a la frequence fe grace a une moduation en fr�quence de %
% s�lectivit� kf et de fr�quence porteuse fc                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Genere une liste des temps
time = genTime(N,fe,fm);

% G�nere une s�quence de bits sur-�chantillon�s
[signal,bitSeq] = genSignal(N,fe,fm);

% G�nere l'enveloppe complexe
envComp = genEnvCom (kf,time,signal);

% G�nere le message r�el
message = genRealMessage(envComp,fc,time);