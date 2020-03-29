function envComp = genEnvCom (kf,time,signal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - kf : Selectivité fréquentielle                                        %
% - time : liste des temps au quel est envoyé chaque échantillon          %
% - signal : singal contenant les symboles sur-échantillonés              %
%                                                                         %
% Génere l'enveloppe complexe en bande de base du signal en modulant      %
% fréquentiellement                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

envComp=exp(j*2*pi*kf*cumtrapz(time,signal));