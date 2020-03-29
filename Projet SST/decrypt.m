function genBiteSeq = decrypt(fe,fm,N,baseSignal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - N : nombre d'�chantillons                                             %
% - fe : fr�quence d'�chantillonage                                       %
% - fm : fr�quence du message                                             %
% - baseSignal : un signal uniquement proportionel � m(t)                 %
%                                                                         %
% D�crypte le signal en effectuant la moyenne sur la p�riode d'envoi pour %
% le r�-�chantilloner du bit et en v�rifiant si elle est positive ou      %
% n�gative                                                                %
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