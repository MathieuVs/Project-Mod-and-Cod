function ber = BERFSK(N,fm,fe,kf,fc,R)
Bt=2*(fm+kf);

% Génération du message par l'émetteur
[message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc);

[N0,noise] = genNoise(fe,message,N,R);
messageB=message + noise;

% Décryptage du message
genBiteSeq = readSignalFSK(messageB,fc,time,Bt,fe,N,fm,kf);

for i=1:length(bitSeq)
    if bitSeq(i)==-1
       bitSeq(i)=0;
    end
end

% Vérification
corretBit=0;
for n = 1:length(bitSeq)
    if bitSeq(n) == genBiteSeq(n)
        corretBit = corretBit+1;
    end
end

ber = 1-(corretBit/N);