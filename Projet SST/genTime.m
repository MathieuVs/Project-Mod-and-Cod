function time = genTime(N,fe,fm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'�chantillons                                             %
% - fe : fr�quence d'�chantillonage                                       %
% - fm : fr�quence du message                                             %
%                                                                         %
% G�nere une liste du temps au quel sera envoy� chaque �l�ment du signal  %
% sur-�chantillon�                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time = zeros(1,fe*N/fm);
for n = 1:fe*N/fm
    time(n)=(n-1)/fe;
end