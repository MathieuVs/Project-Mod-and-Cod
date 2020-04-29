%%%%%%%%%%%
% Channel %
%%%%%%%%%%%
clc;clear;close all;

%% Parameters
n_bits = 2048;
Nbps = 4;
OSF = 4;

RRCTaps = 201;
cutoff_f = 1000000;
beta = 0.3;

EbN0 = 0.3;

%% Signal generation
generated_signal = randi([0 1], n_bits,1);

%% Tranceiver
transmitted_signal = func_tranceiver(generated_signal,Nbps,OSF,RRCTaps,cutoff_f,beta,'qam');

%% AWGN

len = length(transmitted_signal);
T = 1/(2*cutoff_f);
sampling_freq = 1/T;

signal_energy = (trapz(abs(transmitted_signal).^2))/sampling_freq;
Eb = signal_energy/(2*n_bits);
N0 = Eb/EbN0;
noise_power = 2*N0*sampling_freq;
noise = sqrt(noise_power/2) * (randn(len,1) + 1i*randn(len,1));

recieved_signal = transmitted_signal + noise;

%% Reciever
decoded_signal = func_reciever(recieved_signal,Nbps,OSF,RRCTaps,cutoff_f,beta,'qam');

%% Verification
error = decoded_signal - generated_signal;
BER = nnz(error)/n_bits
