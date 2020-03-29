%%%%%%%%%%%%%%%%%%
%  RECIEVER FSK  %
%%%%%%%%%%%%%%%%%%


% Definitions des variables
N=10000;   % Nombre de symbole
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivité fréquentielle
fc=6000;  % Frequence porteuse
Bt=2*(fm+kf);  % Fréquence de coupure filtre passe bas
a=10;     % Pente du filtre

% Génération du message par l'émetteur
[message,time,bitSeq] = sendMessage(N,fm,fe,kf,fc);

[signaReal,signalComp] = freqShift(message,fc,time);

% Filtre le signal autour de 0 jusqu'a Bt/2
[signalRealF, signalCompF] = lowFilter(signaReal,signalComp,Bt/2,fe);

% Constitue l'enveloppe complexe (x2) du signal de départ
enveloppe = signalRealF + signalCompF*1j;

eO = exp(-1j*2*pi*kf*time);
e1 = exp(1j*2*pi*kf*time);

corr0=enveloppe.*conj(eO);
corr1=enveloppe.*conj(e1);

%Num=lenght(message)/fe*fm;
res=zeros(1,N);

for n=1:N
    if not(n==N )
        int0 = sum(corr0((1+(n-1)*fe/fm):(1+n*fe/fm)));
        int1 = sum(corr1((1+(n-1)*fe/fm):(1+n*fe/fm)));
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

for i=1:length(bitSeq)
    if bitSeq(i)==-1
       bitSeq(i)=0;
    end
end

if res == bitSeq
    disp("Le message a été correctement modulé et démodulé");
end  

corretBit=0;
for n = 1:length(bitSeq)
    if bitSeq(n) == res(n)
        corretBit = corretBit+1;
    end
end

disp("Nombre des bits correctements transmits : " + corretBit +"/"+ N);
        