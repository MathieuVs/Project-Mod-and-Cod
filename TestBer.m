clc;clear;close all;

TAP = 33;
OSF = 1;


SNR_dB = -5 : 0.1 : 25;

SNR = 10.^(SNR_dB./10);
BER_BPSK = nan(1,length(SNR));
BER_QPSK = nan(1,length(SNR));
BER_16QAM = nan(1,length(SNR));
BER_64QAM = nan(1,length(SNR));


for i = 1:length(SNR)
    BER_BPSK(i) = func_channel(98304, 1, 4, 33, 1000000, 0.3, 'pam', SNR(i));
    BER_QPSK(i) = func_channel(98304, 2, 4, 33, 1000000, 0.3, 'qam', SNR(i));
    BER_16QAM(i) = func_channel(98304, 4, 4, 33, 1000000, 0.3, 'qam', SNR(i));
    BER_64QAM(i) = func_channel(98304, 6, 4, 33, 1000000, 0.3, 'qam', SNR(i));
end
figure;

semilogy(SNR_dB,BER_BPSK)
hold on
semilogy(SNR_dB,BER_QPSK)
semilogy(SNR_dB,BER_16QAM)
semilogy(SNR_dB,BER_64QAM)

title("BER plot as a function of SNR")
ylabel('BER')
xlabel('SNR [dB]')
legend('BPSK','QPSK','16QAM','64QAM')


