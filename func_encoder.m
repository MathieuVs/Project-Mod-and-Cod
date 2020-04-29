function encodedSignal = func_encoder(signal, H)
    SE=signal'
    signalR = reshape(signal,[length(signal)/size(H,1), size(H,1)]);
    
    [G] = generatorEnc(H);

    encodedSignal = mod(signalR * G, 2);
    
    encodedSignal = reshape(encodedSignal, [2*size(signal,1),1]);