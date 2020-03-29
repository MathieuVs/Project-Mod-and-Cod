function res = readSignalFSK(message,fc,time,Bt,fe,N,fm,kf)

[signaReal,signalComp] = freqShift(message,fc,time);

% Filtre le signal autour de 0 jusqu'a Bt/2
[signalRealF, signalCompF] = lowFilter(signaReal,signalComp,Bt/2,fe);

% Constitue l'enveloppe complexe (x2) du signal de départ
enveloppe = signalRealF + signalCompF*1j;

eO = exp(-1j*2*pi*kf*time);
e1 = exp(1j*2*pi*kf*time);

corr0=enveloppe.*conj(eO);
corr1=enveloppe.*conj(e1);

%N=floor(lenght(message)/fe*fm)+1;
res=zeros(1,N);

for n=1:N
    if not(n==N )
        int0 = sum(corr0((1+(n-1)*fe/fm):(n*fe/fm)));
        int1 = sum(corr1((1+(n-1)*fe/fm):(n*fe/fm)));
    else
        int0 = sum(corr0((1+(n-1)*fe/fm):length(message)));
        int1 = sum(corr1((1+(n-1)*fe/fm):length(message)));
    end
    if(abs(int0)<abs(int1))
        res(n)=0;
    else
        res(n)=1;
    end
end