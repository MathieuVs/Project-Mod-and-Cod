clc;clear;close all;

H = [1 1 0 1 1 0 0 1 0 0;
     0 1 1 0 1 1 1 0 0 0;
     0 0 0 1 0 0 0 1 1 1;
     1 1 0 0 0 1 1 0 1 0;
     0 0 1 0 0 1 0 1 0 1];

TAP = 33;
OSF = 4;

n_Symb = 1600;

SNR_dB = -5 : 0.1 : 20;

SNR = 10.^(SNR_dB./10);
BER_NE = nan(1,length(SNR));
BER_E = nan(1,length(SNR));
BER_SE = nan(1,length(SNR));
%BER_E100 = nan(1,length(SNR));


for i = 1:length(SNR)
    disp(['Progress : ' num2str(i) '/' num2str(length(SNR))])
    BER_NE(i) = func_channel(n_Symb, 1, OSF, TAP, 1000000, 0.3, 'pam', SNR(i));
    BER_E(i) = func_encoded_chanel(n_Symb, 1, OSF, TAP, 1000000, 0.3, 'pam', SNR(i), H, 5);
    BER_SE(i) = func_soft_encoded_chanel(n_Symb, OSF, TAP, 1000000, 0.3, SNR(i), H, 5);
    
end
figure;

semilogy(SNR_dB,BER_NE)
hold on
semilogy(SNR_dB,BER_E)
semilogy(SNR_dB,BER_SE)
%semilogy(SNR_dB,BER_E100)

title("BER plot as a function of SNR")
ylabel('BER')
xlabel('SNR [dB]')
%legend('BPSK','QPSK','16QAM','64QAM')
legend('NE','E','SE')
