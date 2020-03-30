function transmitted_signal = func_tranceiver(generated_signal,Nbps,OSF,RRCTaps,cutoff_f,beta,mod)





%% Symbol mapping
mapped_signal = mapping(generated_signal,Nbps,mod);

%% Oversampling
oversampled_signal = upsample(mapped_signal,OSF);

%% Nyquist filter
% 1MHz cutoff (1/2T) and 0.3 roll off

%        | T                                                (0 =< |f| < (1-beta)/2T))
% H(f) = | (T/2)*(1+cos[(pi*T/beta)(|f|-(1-beta)/2T)])      ((1-beta)/2T) =< |f| =< (1+beta)/2T))
%        | 0                                                (|f| > (1+beta)/2T))

T = 1/(2*cutoff_f);
sampling_freq = 1/T;

frequency_step = sampling_freq/RRCTaps;
frequency_grid = -frequency_step*(RRCTaps-1)/2:frequency_step:frequency_step*(RRCTaps-1)/2;
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
filter_temps = ifftshift(ifft(ifftshift(filter_freq)));

filtered_signal = conv(oversampled_signal,filter_temps);
transmitted_signal = filtered_signal;

