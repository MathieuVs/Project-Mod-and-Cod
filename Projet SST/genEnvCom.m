function envComp = genEnvCom (kf,time,signal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - kf : Selectivit� fr�quentielle                                        %
% - time : liste des temps au quel est envoy� chaque �chantillon          %
% - signal : singal contenant les symboles sur-�chantillon�s              %
%                                                                         %
% G�nere l'enveloppe complexe en bande de base du signal en modulant      %
% fr�quentiellement                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

envComp=exp(j*2*pi*kf*cumtrapz(time,signal));