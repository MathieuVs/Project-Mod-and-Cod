clc;clear;close all;

H = [1 1 0 1 1 0 0 1 0 0;
     0 1 1 0 1 1 1 0 0 0;
     0 0 0 1 0 0 0 1 1 1;
     1 1 0 0 0 1 1 0 1 0;
     0 0 1 0 0 1 0 1 0 1];

TAP = 33;
OSF = 4;

n_Symb = 16000;

SNR_dB = -5 : 0.1 : 20;

SNR = 10.^(SNR_dB./10);
BER_NE = nan(1,length(SNR));
BER_E5 = nan(1,length(SNR));
BER_E20 = nan(1,length(SNR));
BER_E100 = nan(1,length(SNR));


for i = 1:length(SNR)
    disp(['Progress : ' num2str(i) '/' num2str(length(SNR))])
    BER_NE(i) = func_channel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i));
    BER_E5(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 5);
    BER_E20(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 20);
    BER_E100(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 100);
    
end
figure;

semilogy(SNR_dB,BER_NE)
hold on
semilogy(SNR_dB,BER_E5)
semilogy(SNR_dB,BER_E20)
semilogy(SNR_dB,BER_E100)

title("BER plot as a function of SNR")
ylabel('BER')
xlabel('SNR [dB]')
%legend('BPSK','QPSK','16QAM','64QAM')
legend('NE','E5','E20','E100')
