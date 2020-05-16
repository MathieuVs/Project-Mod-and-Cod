function BER = func_CFO_chanel(n_bits, OSF, RRCTaps, cutoff_f, beta, SNR, H, maxItt, deltaW, phi0)

Nbps = 2;
mod ='qam';
decod = 'hard'


%% Signal generation
generated_signal = randi([0 1], n_bits,1);

%% Signal encoding
n_bits_noise = 2*n_bits;

encoded_signal = func_encoder(generated_signal, H);

%% Tranceiver
transmitted_signal = func_tranceiver(encoded_signal,Nbps,OSF,RRCTaps,cutoff_f,beta,mod);

%% AWGN

len = length(transmitted_signal);
T = 1/(2*cutoff_f);
sampling_freq = 1/T;

signal_energy = (trapz(abs(transmitted_signal).^2))/sampling_freq;
Eb = signal_energy/(2*n_bits_noise);
N0 = Eb/SNR;
noise_power = 2*N0*sampling_freq;
if mod == 'pam'
    noise = sqrt(noise_power/2) * (randn(len,1));
else
    noise = sqrt(noise_power/2) * (randn(len,1) + 1i*randn(len,1));
end

recieved_signal = transmitted_signal + noise;
t = (1:size(recieved_signal))*T;
recieved_signal = recieved_signal .*exp(1j*(deltaW*t'+phi0));
figure
scatter(real(downsample(recieved_signal',OSF)),imag(downsample(recieved_signal',OSF)))

%% Reciever
if decod == 'hard'
    demapped_signal = func_reciever(recieved_signal,Nbps,OSF,RRCTaps,cutoff_f,beta,mod);
    decoded_signal = func_decoder(demapped_signal, H, maxItt);
else
    decoded_signal = func_soft_decoder(recieved_signal, OSF, RRCTaps, cutoff_f, beta, H, maxItt, noise_power);
end

%% Verification
error = decoded_signal - generated_signal;
%error = decoded_signal - generated_signal;
BER = nnz(error)/(n_bits);