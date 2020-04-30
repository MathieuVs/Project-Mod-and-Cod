clear;clc;close all;

%% Encoder

H = [1 1 0 1 1 0 0 1 0 0;
     0 1 1 0 1 1 1 0 0 0;
     0 0 0 1 0 0 0 1 1 1;
     1 1 0 0 0 1 1 0 1 0;
     0 0 1 0 0 1 0 1 0 1];


[G] = generatorEnc(H);



signal = randi([0 1], 6, 5)


encSignal = mod(signal * G, 2);

noise = zeros(6, 10);
noise(2,10)=1;
noise(3,3)=1;
noise(4,7)=1;
noise(5,9)=1;
encSignal = mod(encSignal+noise,2)

%% Decoder

H = [1 1 0 1 1 0 0 1 0 0;
     0 1 1 0 1 1 1 0 0 0;
     0 0 0 1 0 0 0 1 1 1;
     1 1 0 0 0 1 1 0 1 0;
     0 0 1 0 0 1 0 1 0 1];

maxItt = 5;
signalFound = nan(size(signal));
v_node = zeros(size(H,1)+1,size(H,2));
for j = 1:size(encSignal,1)
    v_node(1,:) = encSignal(j,:);
    for k = 1 : maxItt
        c_node = v_node(1,:) & H;
        check = sum(mod(sum(c_node,2),2));
        if check == 0
            break
        end
        for i = 1 : size(H,2)
            v_node(2:size(H,1)+1, i)=mod( sum( c_node(:, [1:i-1,i+1:size(H,2)]), 2),2 ) & H(:,i);
            corr_sig = sum(v_node(:, i))/(sum(H(:,i))+1);
            if corr_sig < 0.5
                v_node(1,i)=0;
            elseif corr_sig > 0.5
                v_node(1,i)=1;
            end
        end
    end
    k
    signalFound(j,:) = v_node(1,6:10);
end

signalFound-signal

