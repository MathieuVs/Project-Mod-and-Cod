%%%%%%%%%%%%
% Reciever %
%%%%%%%%%%%%

%% Parameters
recieved_signal = zeros(512,1);
Nbps = 4;
OSF = 4;

RRCTaps = 201;

cutoff_f = 1000000;
T = 1/(2*cutoff_f);
beta = 0.3;

frequency_step = sampling_freq/RRCTaps;
frequency_grid = -frequency_step*(RRCTaps-1)/2:frequency_step:frequency_step*(RRCTaps-1)/2;


%% Nyquist filter
% 1MHz cutoff (1/2T) and 0.3 roll off

%        | T                                                (0 =< |f| < (1-beta)/2T))
% H(f) = | (T/2)*(1+cos[(pi*T/beta)(|f|-(1-beta)/2T)])      ((1-beta)/2T) =< |f| =< (1+beta)/2T))
%        | 0                                                (|f| > (1+beta)/2T))

% use ifft and ifftshift (inverse fast fourier transform)
% put it in pass band?

filter_freq = nan(RRCTaps,1);

for i = 1:size(frequency_grid,2)
    if abs(frequency_grid(i))<(1-beta)/(2*T)
        filter_freq(i) = T;
    elseif ( (1-beta)/(2*T) <= abs(frequency_grid(i)) ) && ( abs(frequency_grid(i)) <= (1+beta)/(2*T)  )
        filter_freq(i) = (T/2)*(1+cos((pi*T/beta)*(abs(frequency_grid(i))-((1-beta)/(2*T)))));
    else
        filter_freq(i) = 0;
    end
end

filter_freq = sqrt(filter_freq/T);

%plot(freq,fiter_freq)
filter_temps = ifftshift(ifft(ifftshift(filter_freq)));

filtered_signal = conv(recieved_signal,filter_temps);

%% Oversampling
resampled_signal = filtered_signal(1:OSF:size(filtered_signal,1));


%% Symbol mapping
% Should we detect the Nbps?
demapped_signal = demapping(resampled_signal,Nbps,'qam');

