function [mReal,mComp] = freqShift(message,fc,time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - fc : fréquence porteuse                                               %
% - time : liste des temps au quel est envoyé chaque échantillon          %
% - message : le message recu                                             %
%                                                                         %
% Recrée la partie réele et imaginaire de l'enveloppe complexe du signal  %
% en translatant le message fréquenciellement                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mReal = message.*cos(2*pi*fc*time);
mComp = message.*sin(2*pi*fc*time);