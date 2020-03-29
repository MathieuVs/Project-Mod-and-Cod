function message = genRealMessage(envComp,fc,time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - envComp : enveloppe complexe du signal modul� fr�quentillement        %
% - fc : frequence porteuse                                               %
% - time : liste des temps au quel est envoy� chaque �chantillon          %
%                                                                         %
% Transphorme l'envloppe complexe en message r�el en le d�calant en       %
% en fr�quence a fc et -fc                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

message = real(envComp).*cos(2*pi*fc*time) - imag(envComp).*sin(2*pi*fc*time);