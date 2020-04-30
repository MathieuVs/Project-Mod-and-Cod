function reshaped_signal = custom_reshape(signal, size)
    if size(1) == 1 | size(2) == 1
        reshaped_signal=(reshape(signal', [size(1) size(2)]));
    else
        reshaped_signal=(reshape(signal, [size(2) size(1)]))';
    end