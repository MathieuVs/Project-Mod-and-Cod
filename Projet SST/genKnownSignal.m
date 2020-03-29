function [signal,bitSeq] = genKnownSignal(binary,fe,fm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'�chantillons                                             %
% - fe : fr�quence d'�chantillonage                                       %
% - fm : fr�quence du message                                             %
%                                                                         %
% G�nere un signal de N bit (-1 ou 1) � la frequence fm et le             %
% sur-�chantillone en le portant a la fr�quence fe                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generation de la s�quence de bits al�atoire
N=length(binary);
bitSeq=zeros(1,N);
% Transphorme les 0 en 1
for n = 1:N
    if binary(n)==0
        bitSeq(n)=-1;
    else
        bitSeq(n)=1;
    end
end

% Sur�chantillonne la s�quence de bits
overSample=floor(fe/fm);
signal = zeros(1,overSample*N);
for n = 1:N
    for i = 1:overSample
        signal((n-1)*overSample+i)=bitSeq(n);
    end
end