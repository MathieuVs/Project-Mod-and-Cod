function baseSignal = slopeFilter(Bt,a,enveloppe,fe)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Bt : bande passant du signal                                          %
% - a : pente du filtre                                                   %
% - enveloppe : enveloppe complexe du signal                              %
% - fe : fréquence d'échantillonage                                       %
%                                                                         %
% Utilise des filtres en pente pour transphormer les variations en        %
% fréquence en variation en amplitude. Les deux signaux obtenu a l'aide   %
% de filtres à pentes opposé sont soustraits l'un a l'autre pour enlever  %
% la composante continue de l'amplitude et obtenir quelque chose          %
% uniquement proportionel a m(t)                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S1= a*( -diff(enveloppe)*fe + 1j*pi*Bt*enveloppe(1:size(enveloppe,2)-1));
S2=-a*( -diff(enveloppe)*fe - 1j*pi*Bt*enveloppe(1:size(enveloppe,2)-1));
baseSignal = abs(S1)-abs(S2);