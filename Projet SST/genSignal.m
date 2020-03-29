function [signal,bitSeq] = genSignal(N,fe,fm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'échantillons                                             %
% - fe : fréquence d'échantillonage                                       %
% - fm : fréquence du message                                             %
%                                                                         %
% Génere un signal de N bit (-1 ou 1) à la frequence fm et le             %
% sur-échantillone en le portant a la fréquence fe                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generation de la séquence de bits aléatoire
bitSeq=randi(2,1,N)-1;

% Transphorme les 0 en 1
for n = 1:N
    if bitSeq(n)==0
        bitSeq(n)=-1;
    end
end


% Suréchantillonne la séquence de bits
overSample=floor(fe/fm);
signal = zeros(1,overSample*N);
for n = 1:N
    for i = 1:overSample
        signal((n-1)*overSample+i)=bitSeq(n);
    end
end