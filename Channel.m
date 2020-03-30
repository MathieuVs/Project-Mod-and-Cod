%%%%%%%%%%%
% Channel %
%%%%%%%%%%%

%% Parameters
n_bits = 512;
Nbps = 4;
OSF = 4;

%% Signal generation
signal = randi([0 1], n_bits,1);

%% Tranceiver


%% AWGN

signal_energy = (trapz(abs(signal).^2))/sampling_freq;
Eb = signal_energy/n_bits;
N0 = Eb/SNR;
noise_power = 2*N0*sampling_freq;
noise = sqrt(noise_power/2) * (randn(1, len) + 1i*randn(1,len));

%% Reciever


%% Verification