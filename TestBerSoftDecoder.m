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
BER_HE = nan(1,length(SNR));
BER_SE = nan(1,length(SNR));
BER_3 = nan(1,length(SNR));
BER_4 = nan(1,length(SNR));
BER_5 = nan(1,length(SNR));
%BER_SE = nan(1,length(SNR));
%BER_E100 = nan(1,length(SNR));


for i = 1:length(SNR)
    disp(['Progress : ' num2str(i) '/' num2str(length(SNR))])
    BER_NE(i) = func_channel(n_Symb, 1, OSF, TAP, 1000000, 0.3, 'pam', SNR(i));
    BER_HE(i) = func_encoded_chanel(n_Symb, 1, OSF, TAP, 1000000, 0.3, 'pam', SNR(i), H, 5);
    BER_SE(i) = func_soft_encoded_chanel(n_Symb, OSF, TAP, 1000000, 0.3, SNR(i), H, 5);
    
end
%%
n_avg=5;
BER_NE_av = average_filter(BER_NE,n_avg);
BER_HE_av = average_filter(BER_HE,n_avg);
BER_SE_av = average_filter(BER_SE,n_avg);
% 
% BER_NE_av = log(BER_NE_av);
% BER_HE_av = log(BER_HE_av);
% BER_SE_av = log(BER_SE_av);

BER_NE_av = BER_NE_av(1:120);
BER_HE_av = BER_HE_av(1:120);
BER_SE_av = BER_SE_av(1:90);

SNR_dB_NE = SNR_dB(1:120);
SNR_dB_HE = SNR_dB(1:120);
SNR_dB_SE = SNR_dB(1:90);

figure;

BER_GRID = [10^-3 2*10^-3 3*10^-3 4*10^-3 5*10^-3 6*10^-3 7*10^-3 8*10^-3 9*10^-3 10^-2 2*10^-2 3*10^-2 4*10^-2 5*10^-2 6*10^-2 7*10^-2 8*10^-2 9*10^-2 10^-1];
%BER_GRID = flip(BER_GRID);
% plot(SNR_dB_NE,BER_NE_av)
% hold on
% plot(SNR_dB_HE,BER_HE_av)
% plot(SNR_dB_SE,BER_SE_av)

SNR_NE = interp1(BER_NE_av,SNR_dB_NE,BER_GRID);
SNR_HE = interp1(BER_HE_av,SNR_dB_HE,BER_GRID);
SNR_SE = interp1(BER_SE_av,SNR_dB_SE,BER_GRID);

HE_GAIN = SNR_NE - SNR_HE;
SE_GAIN = SNR_NE - SNR_SE;

semilogx(BER_GRID, HE_GAIN)
hold on
semilogx(BER_GRID, SE_GAIN)
%semilogx(BER_GRID, SNR_SE)
% semilogy(SNR_dB,BER_3)
% semilogy(SNR_dB,BER_4)
% semilogy(SNR_dB,BER_5)
%semilogy(SNR_dB,BER_E100)

title("Coding gain")
ylabel('SNR GAIN [dB]')
xlabel('BER')
%legend('BPSK','QPSK','16QAM','64QAM')
legend('Hard coding gain','Soft coding gain')
