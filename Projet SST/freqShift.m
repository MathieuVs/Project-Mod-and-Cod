function [mReal,mComp] = freqShift(message,fc,time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - fc : fr�quence porteuse                                               %
% - time : liste des temps au quel est envoy� chaque �chantillon          %
% - message : le message recu                                             %
%                                                                         %
% Recr�e la partie r�ele et imaginaire de l'enveloppe complexe du signal  %
% en translatant le message fr�quenciellement                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mReal = message.*cos(2*pi*fc*time);
mComp = message.*sin(2*pi*fc*time);