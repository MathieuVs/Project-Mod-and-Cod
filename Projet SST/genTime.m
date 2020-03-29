function time = genTime(N,fe,fm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'échantillons                                             %
% - fe : fréquence d'échantillonage                                       %
% - fm : fréquence du message                                             %
%                                                                         %
% Génere une liste du temps au quel sera envoyé chaque élément du signal  %
% sur-échantilloné                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time = zeros(1,fe*N/fm);
for n = 1:fe*N/fm
    time(n)=(n-1)/fe;
end