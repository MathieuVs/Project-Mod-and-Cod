function signal = func_soft_decoder(recieved_signal, OSF, RRCTaps, cutoff_f, beta, H, maxItt, var_noise)



    %% Nyquist filter
    % 1MHz cutoff (1/2T) and 0.3 roll off

    %        | T                                                (0 =< |f| < (1-beta)/2T))
    % H(f) = | (T/2)*(1+cos[(pi*T/beta)(|f|-(1-beta)/2T)])      ((1-beta)/2T) =< |f| =< (1+beta)/2T))
    %        | 0                                                (|f| > (1+beta)/2T))

    T = 1/(2*cutoff_f*OSF);
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

    H_RC = filter_freq;
    H_RC = ifftshift(H_RC);
    H_RRC = sqrt(H_RC);       
    h_RC = ifft(H_RC);
    h_RRC = ifft(H_RRC);
    h_RRC = fftshift(h_RRC/sqrt(max(h_RC)));
    h_RC = fftshift(h_RC/max(h_RC));

    filtered_signal = conv(recieved_signal,h_RRC);

    resized_signal = filtered_signal(RRCTaps:length(filtered_signal)-RRCTaps);

    %% Oversampling

    resampled_signal = downsample(resized_signal,OSF);
    
    %% Decoder
    prob_signal = 1./(1+ exp(2.*resampled_signal/var_noise));
    
    
    encodedSignalR = reshape(prob_signal,[length(prob_signal)/size(H,2), size(H,2)]);
    signal = zeros(size(encodedSignalR,1),size(encodedSignalR,2)/2);

    
    for sigLin = 1:size(encodedSignalR,1)
        processed_signal = zeros(1,size(encodedSignalR,2));
        for iter = 1:maxItt
            for sigEl = 1:size(encodedSignalR,2)
                prod_0 = encodedSignalR(sigLin,sigEl);
                prod_1 = 1 - encodedSignalR(sigLin,sigEl);
                for HLin = 1:size(H,1)
                    if H(HLin,sigEl) == 1
                        prod_int = 1;
                        for HEl = 1:size(H,2)
                            if sigEl ~= HEl && H(HLin,HEl) == 1
                                prod_int = prod_int * (2*encodedSignalR(sigLin,HEl) - 1);
                            end
                        end
                        prob = 1/2 +1/2*prod_int;
                        prod_0 = prod_0 * prob;
                        prod_1 = prod_1 * (1-prob);
                    end
                end
                processed_signal(sigEl) = prod_0/(prod_0+prod_1);
            end
            encodedSignalR(sigLin,:) = processed_signal;
        end
        signal(sigLin,:) = encodedSignalR(sigLin,6:10);
    end
    signal = round(1.-signal);
    
    %signal
    signal = reshape(signal, [size(prob_signal,1)/2,1]);
