function signal = func_decoder(encodedSignal, H, maxItt)

    encodedSignalR = reshape(encodedSignal,[length(encodedSignal)/size(H,2), size(H,2)]);
    signal = zeros(size(encodedSignalR,1),size(encodedSignalR,2)/2);

    v_node = zeros(size(H,1)+1,size(H,2));
    for j = 1:size(encodedSignalR,1)
        v_node(1,:) = encodedSignalR(j,:);
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
                    v_node(i)=0;
                elseif corr_sig > 0.5
                    v_node(i)=1;
                end
            end
        end
        signal(j,:) = v_node(1,6:10);
    end
    %signal
    signal = reshape(signal, [size(encodedSignal,1)/2,1]);
    SD=signal'
