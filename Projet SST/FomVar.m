clc,
N=10000;   % Nombre de symbole
fm=500;   % Frequence du message
fe=20000; % Frequence d'echantillonage
kf=500;   % Selectivité fréquentielle
fc=6000;  % Frequence porteuse
a=10;     % Pente du filtre

R=5:1:30;
Tfom200=zeros(1,25);
Tfom500=zeros(1,25);
Tfom1000=zeros(1,25);
for n =1:26
    Tfom200(n) = fFoM(N,fm,fe,200,fc,a,R(n));
    Tfom500(n) = fFoM(N,fm,fe,500,fc,a,R(n));
    Tfom1000(n) = fFoM(N,fm,fe,1000,fc,a,R(n));
end
hold on;
b=plot(R,Tfom200,'g');
c=plot(R,Tfom500,'b');
d=plot(R,Tfom1000,'r');
legend([b,c,d],'kf=200','kf=500','kf=1000');
title('FoM');
xlabel('Eb/N0');
ylabel('FoM');
    