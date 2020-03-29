%%%%%%%%%%%%%%
% Tranceiver %
%%%%%%%%%%%%%%

%% Parameters
n_bits = 512;
Nbps = 4;
OSF = 4;

%Need to chose RRCTAP
cutoff_f = 1000000; % in Hz
T = 1/(2*cutoff_f);
beta = 0.3;

sampling_freq = 1/T;

fft_resolution = 100;

%% Random signal generation
signal = randi([0 1], n_bits,1);


%% Symbol mapping
mapped_signal = mapping(signal,Nbps,'qam');
%plot(abs(fft(mapped_signal)))

%% Oversampling
oversampled_signal = upsample(mapped_signal,OSF);
%figure;
%plot(abs(fft(oversampled_signal))) 
%% Nyquist filter
% 1MHz cutoff (1/2T) and 0.3 roll off

%        | T                                                (0 =< |f| < (1-beta)/2T))
% H(f) = | (T/2)*(1+cos[(pi*T/beta)(|f|-(1-beta)/2T)])      ((1-beta)/2T) =< |f| =< (1+beta)/2T))
%        | 0                                                (|f| > (1+beta)/2T))

% use ifft and ifftshift (inverse fast fourier transform)
% put it in pass band?

n_sample = floor( ((1+beta)/(2*T))/ fft_resolution);
freq = -n_sample*fft_resolution:fft_resolution:n_sample*fft_resolution;
fiter_freq = nan(2*n_sample+1,1);

for i = 1:size(freq,2)
    if abs(freq(i))<(1-beta)/(2*T)
        fiter_freq(i) = T;
    elseif ( (1-beta)/(2*T) <= abs(freq(i)) ) & ( abs(freq(i)) <= (1+beta)/(2*T)  )
        fiter_freq(i) = (T/2)*(1+cos((pi*T/beta)*(abs(freq(i))-((1-beta)/(2*T)))));
    else
        fiter_freq(i) = 0;
    end
end

%plot(freq,fiter_freq)
filter_temps = ifft(fiter_freq);

filtered_signal = conv(oversampled_signal,filter_temps);


