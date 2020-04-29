function [] = fun_test_ber(TAP, OSF, n_Symb)

SNR_dB = -5 : 0.1 : 25;

SNR = 10.^(SNR_dB./10);
BER_BPSK = nan(1,length(SNR));
BER_QPSK = nan(1,length(SNR));
BER_16QAM = nan(1,length(SNR));
BER_64QAM = nan(1,length(SNR));


for i = 1:length(SNR)
    BER_BPSK(i) = func_channel(n_Symb, 1, OSF, TAP, 1000000, 0.3, 'pam', SNR(i));
    BER_QPSK(i) = func_channel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i));
    BER_16QAM(i) = func_channel(n_Symb, 4, OSF, TAP, 1000000, 0.3, 'qam', SNR(i));
    BER_64QAM(i) = func_channel(n_Symb, 6, OSF, TAP, 1000000, 0.3, 'qam', SNR(i));
end
figure;

semilogy(SNR_dB,BER_BPSK)
hold on
semilogy(SNR_dB,BER_QPSK)
semilogy(SNR_dB,BER_16QAM)
semilogy(SNR_dB,BER_64QAM)
title(['BER plot SNR, OSF = ', num2str(OSF), ', RCCTAPs = ', num2str(TAP)])
ylabel('BER')
xlabel('SNR [dB]')
legend('BPSK','QPSK','16QAM','64QAM')


