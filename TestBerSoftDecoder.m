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
BER_1 = nan(1,length(SNR));
BER_2 = nan(1,length(SNR));
BER_3 = nan(1,length(SNR));
BER_4 = nan(1,length(SNR));
BER_5 = nan(1,length(SNR));
%BER_SE = nan(1,length(SNR));
%BER_E100 = nan(1,length(SNR));


for i = 1:length(SNR)
    disp(['Progress : ' num2str(i) '/' num2str(length(SNR))])
    BER_NE(i) = func_channel(n_Symb, 1, OSF, TAP, 1000000, 0.3, 'pam', SNR(i));
    %BER_1(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 1);
    %BER_2(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 2);
    %BER_3(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 3);
    %BER_4(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 4);
    BER_5(i) = func_encoded_chanel(n_Symb, 2, OSF, TAP, 1000000, 0.3, 'qam', SNR(i), H, 5);
    
end
figure;

semilogy(SNR_dB,BER_NE)
hold on
semilogy(SNR_dB,BER_1)
semilogy(SNR_dB,BER_2)
semilogy(SNR_dB,BER_3)
semilogy(SNR_dB,BER_4)
semilogy(SNR_dB,BER_5)
%semilogy(SNR_dB,BER_E100)

title("BER plot as a function of SNR")
ylabel('BER')
xlabel('SNR [dB]')
%legend('BPSK','QPSK','16QAM','64QAM')
legend('NE','SE1','SE2','SE3','SE4','SE5')
