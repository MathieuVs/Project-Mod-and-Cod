function BER = func_encoded_chanel(n_bits, Nbps, OSF, RRCTaps, cutoff_f, beta, mod, SNR, H, maxItt)


%% Signal generation
generated_signal = randi([0 1], n_bits,1);

%% Signal encoding
encoded_signal = func_encoder(generated_signal, H);

%% Tranceiver
transmitted_signal = func_tranceiver(encoded_signal,Nbps,OSF,RRCTaps,cutoff_f,beta,mod);

%% AWGN

len = length(transmitted_signal);
T = 1/(2*cutoff_f);
sampling_freq = 1/T;

signal_energy = (trapz(abs(transmitted_signal).^2))/sampling_freq;
Eb = signal_energy/(2*n_bits);
N0 = Eb/SNR;
noise_power = 2*N0*sampling_freq;
if mod == 'pam'
    noise = sqrt(noise_power/2) * (randn(len,1));
else
    noise = sqrt(noise_power/2) * (randn(len,1) + 1i*randn(len,1));
end

recieved_signal = transmitted_signal + noise;

%% Reciever
demapped_signal = func_reciever(recieved_signal,Nbps,OSF,RRCTaps,cutoff_f,beta,mod);

%% Signal decoding
decoded_signal = func_decoder(demapped_signal, H, maxItt);

%% Verification
error = decoded_signal - generated_signal
BER = nnz(error)/n_bits;