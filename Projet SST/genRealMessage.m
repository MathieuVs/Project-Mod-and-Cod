function message = genRealMessage(envComp,fc,time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - envComp : enveloppe complexe du signal modulé fréquentillement        %
% - fc : frequence porteuse                                               %
% - time : liste des temps au quel est envoyé chaque échantillon          %
%                                                                         %
% Transphorme l'envloppe complexe en message réel en le décalant en       %
% en fréquence a fc et -fc                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

message = real(envComp).*cos(2*pi*fc*time) - imag(envComp).*sin(2*pi*fc*time);