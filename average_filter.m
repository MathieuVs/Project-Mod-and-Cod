function averaged_signal = average_filter(signal,n)
    averaged_signal = zeros(size(signal));
    for i = 1:length(signal)
        sum = 0;
        if i < (n+1)/2
            nb_sample = 0;
            for j = 1 : i+(n-1)/2
                nb_sample = nb_sample +1;
                sum = sum + signal(j);
            end
            averaged_signal(i) = sum/nb_sample;
        elseif i >  length(signal)-(n+1)/2
            nb_sample = 0;
            for j = i-(n-1)/2 : length(signal)
                nb_sample = nb_sample +1;
                sum = sum + signal(j);
            end
            averaged_signal(i) = sum/nb_sample;
        else
            for j = i-(n-1)/2 : i+(n-1)/2
                sum = sum + signal(j);
            end
            averaged_signal(i) = sum/n;
        end
    end
            