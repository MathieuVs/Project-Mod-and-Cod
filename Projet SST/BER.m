function ber = BER(N,fm,fe,kf,fc,a,R)
Bt=2*(fm+kf);

% Génération du message par l'émetteur
[message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc);

[N0,noise] = genNoise(fe,message,N,R);
messageB=message + noise;

% Décryptage du message
genBiteSeq = readSignal(messageB,fc,time,Bt,fe,a,N,fm);

% Vérification
corretBit=0;
for n = 1:length(bitSeq)
    if bitSeq(n) == genBiteSeq(n)
        corretBit = corretBit+1;
    end
end

ber = 1-(corretBit/N);