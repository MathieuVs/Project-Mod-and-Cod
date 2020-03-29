function [N0,noise] = genNoise(fe,message,N,SNR)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - fe : fréquence d'échantillonage                                       %
% - message : message emis à bruiter                                      %
% - N : nombre de symboles envoyés                                        %
%                                                                         %
% Génere un bruit blanc additif gausien en fonction du message et d'un SNR%
% (Signal to Noise Ratio)                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = trapz(message.^2)/fe; %power of the signal
Eb = Ps/N; %energie d'un bit  (?? Sur N ou sur Fm ??)
N0=Eb/10^(SNR/10); %transition en décimal change rien 
sigma = sqrt(fe*N0/2); %Power du bruit = sigma^2
noise = sigma*randn(1, length(message));