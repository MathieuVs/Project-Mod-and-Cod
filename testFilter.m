cutoff_f = 1000000;
beta = 0.3;
OSF=4;
RRCTaps=101;

sampling_freq = 2*cutoff_f*OSF;
T = OSF/(sampling_freq);


frequency_step = sampling_freq/RRCTaps;
highestFreq = frequency_step*(RRCTaps-1)/2;
frequency_grid = linspace(-highestFreq,highestFreq,RRCTaps);
filter_freq = nan(RRCTaps,1);

for i = 1:size(frequency_grid,2)
    if abs(frequency_grid(i))<(1-beta)/(2*T)
        filter_freq(i) = T;
    elseif ( (1-beta)/(2*T) <= abs(frequency_grid(i)) ) && ( abs(frequency_grid(i)) <= (1+beta)/(2*T)  )
        filter_freq(i) = (T/2)*(1+(cos(((pi*T)/beta)*(abs(frequency_grid(i))-(1-beta)/(2*T)))));
    else
        filter_freq(i) = 0;
    end
end

figure
plot(frequency_grid,filter_freq)
xlabel('Frequency [Hz]')
title('Filter frequency domain')


% H_RC = filter_freq;
% H_RC = ifftshift(H_RC);
% H_RRC = sqrt(H_RC);       
% h_RC = ifft(H_RC);
% h_RRC = ifft(H_RRC);
% h_RRC = fftshift(h_RRC/sqrt(max(h_RC)));
% h_RC = fftshift(h_RC/max(h_RC));
% 
% figure
% temps = (-(RRCTaps-1)/2:(RRCTaps-1)/2)/sampling_freq;
% plot(temps,h_RC)
% hold on
% plot(temps,h_RRC)
% temps_scat = temps(mod((RRCTaps-1)/2,OSF)+1:OSF:length(temps));
% filter_temps_scat = h_RC(mod((RRCTaps-1)/2,OSF)+1:OSF:length(temps));
% scatter(temps_scat,filter_temps_scat)
% 
% title('Filter temporal domain')
% xlabel('Time [s]')
% legend('Raised cos','Root raised cos')

% filter_temps = fftshift(ifft(ifftshift(filter_freq)));
% filter_temps = filter_temps/max(filter_temps);
% filter_freq_rrc = sqrt(filter_freq);
% filter_temps_rrc = fftshift(ifft(ifftshift(filter_freq_rrc)));
% filter_temps_rrc = filter_temps_rrc/max(filter_temps);
% 
% temps = (-(RRCTaps-1)/2:(RRCTaps-1)/2)/sampling_freq;
% plot(temps,filter_temps)
% temps_scat = temps(mod((RRCTaps-1)/2,OSF)+1:OSF:length(temps));
% filter_temps_scat = filter_temps(mod((RRCTaps-1)/2,OSF)+1:OSF:length(temps));
% hold on
% scatter(temps_scat,filter_temps_scat)
% plot(temps,filter_temps_rrc)

