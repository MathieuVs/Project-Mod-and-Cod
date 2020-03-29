function [N0,noise] = genNoise(fe,message,N,SNR)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - fe : fr�quence d'�chantillonage                                       %
% - message : message emis � bruiter                                      %
% - N : nombre de symboles envoy�s                                        %
%                                                                         %
% G�nere un bruit blanc additif gausien en fonction du message et d'un SNR%
% (Signal to Noise Ratio)                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = trapz(message.^2)/fe; %power of the signal
Eb = Ps/N; %energie d'un bit  (?? Sur N ou sur Fm ??)
N0=Eb/10^(SNR/10); %transition en d�cimal change rien 
sigma = sqrt(fe*N0/2); %Power du bruit = sigma^2
noise = sigma*randn(1, length(message));