% Definitions des variables
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivité fréquentielle
fc=6000;  % Frequence porteuse
Bt=2*(fm+kf);  % Fréquence de coupure filtre passe bas
a=10;     % Pente du filtre


r = audiorecorder(fe,16,1) ;
disp("Start recording")
record(r) ;
pause(45) ; % 70 seconds
stop(r) ;
disp("End recording")
message = getaudiodata(r,'double')' ;


time = zeros(1,length(message));
for n = 1:length(message)
    time(n)=(n-1)/fe;
end



genBiteSeq = readSignal(message,fc,time,Bt,fe,a,N,fm);

for n = 1:length(genBiteSeq)
    if genBiteSeq(n)==-1
        genBiteSeq(n)=0;
    end
end
BinaryToImage(genBiteSeq,nbl,nbc);