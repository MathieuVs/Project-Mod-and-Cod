function [signalRealF, signalCompF] = lowFilter(signalReal,signalComp,Bt,fe)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Bt : bande passant du signal                                          %
% - signalReal : partie r�ele de l'enveloppe                              %
% - signalComp : partie complexe de l'enveloppe                           %
% - fe : fr�quence d'�chantillonage                                       %
%                                                                         %
% G�nere l'enveloppe complexe en bande de base du signal en modulant      %
% fr�quentiellement                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

signalRealF = lowpass(signalReal,Bt/2,fe);
signalCompF = lowpass(signalComp,Bt/2,fe);