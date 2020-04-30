function BER = func_soft_encoded_chanel(n_bits, OSF, RRCTaps, cutoff_f, beta, SNR, H, maxItt)

Nbps = 1;
mod ='pam';


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

%% Signal decoding
%length(demapped_signal)
%decoded_signal = custom_reshape(demapped_signal,[lenttttttt/5, 10]);
%decoded_signal = decoded_signal(:,6:10);
%decoded_signal = custom_reshape(decoded_signal,[lenttttttt*2, 1]);




decoded_signal = func_soft_decoder(recieved_signal, OSF, RRCTaps, cutoff_f, beta, H, maxItt, noise_power);

%% Verification
error = decoded_signal - generated_signal;
%error = decoded_signal - generated_signal;
BER = nnz(error)/(n_bits);