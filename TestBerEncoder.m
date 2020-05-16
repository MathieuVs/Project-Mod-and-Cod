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
BER_E1 = nan(1,length(SNR));
BER_E2 = nan(1,length(SNR));
BER_E3 = nan(1,length(SNR));
BER_E4 = nan(1,length(SNR));
BER_E5 = nan(1,length(SNR));


for i = 1:length(SNR)
    disp(['Progress : ' num2str(i) '/' num2str(length(SNR))])
    BER_NE(i) = func_channel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i));
    BER_E1(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 1);
    BER_E2(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 2);
    BER_E3(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 3);
    %BER_E4(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 4);
    %BER_E5(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 5);
    
end
figure;

semilogy(SNR_dB,BER_NE)
hold on
semilogy(SNR_dB,BER_E1)
semilogy(SNR_dB,BER_E2)
semilogy(SNR_dB,BER_E3)
%semilogy(SNR_dB,BER_E4)
%semilogy(SNR_dB,BER_E5)

title("BER plot as a function of SNR")
ylabel('BER')
xlabel('Eb/N0 [dB]')
%legend('BPSK','QPSK','16QAM','64QAM')
legend('Not Encoded','1 Iteration','2 Iteration','3 Iteration')
