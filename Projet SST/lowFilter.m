function [signalRealF, signalCompF] = lowFilter(signalReal,signalComp,Bt,fe)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Bt : bande passant du signal                                          %
% - signalReal : partie réele de l'enveloppe                              %
% - signalComp : partie complexe de l'enveloppe                           %
% - fe : fréquence d'échantillonage                                       %
%                                                                         %
% Génere l'enveloppe complexe en bande de base du signal en modulant      %
% fréquentiellement                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

signalRealF = lowpass(signalReal,Bt/2,fe);
signalCompF = lowpass(signalComp,Bt/2,fe);