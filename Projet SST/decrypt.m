function genBiteSeq = decrypt(fe,fm,N,baseSignal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'échantillons                                             %
% - fe : fréquence d'échantillonage                                       %
% - fm : fréquence du message                                             %
% - baseSignal : un signal uniquement proportionel à m(t)                 %
%                                                                         %
% Décrypte le signal en effectuant la moyenne sur la période d'envoi pour %
% le ré-échantilloner du bit et en vérifiant si elle est positive ou      %
% négative                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = fe/fm;
genBiteSeq = zeros(1,N);

for i = 1:N
    if i==N
        moy = mean(baseSignal( ((i-1)*n)+1 : (i*n)-1 ));
    else
        moy = mean(baseSignal( ((i-1)*n)+1 : (i*n) ));
    end
    if moy >0
        genBiteSeq(i)= 1;
    else
        genBiteSeq(i)=-1;
    end
end