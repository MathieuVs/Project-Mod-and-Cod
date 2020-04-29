H = [1 1 0 1 1 0 0 1 0 0;
     0 1 1 0 1 1 1 0 0 0;
     0 0 0 1 0 0 0 1 1 1;
     1 1 0 0 0 1 1 0 1 0;
     0 0 1 0 0 1 0 1 0 1];

for i = 1:size(H,1)
    for j = 0:size(H,1)-i
        if H(i+j,i) == 1
            H( [i,i+j] ,:) = H([i+j,i],:);
            break
        end
    end
    for j = 1:size(H,1)
        if H(j,i) ~=0 && i ~= j
            H(j,:) = abs( H(j,:) - H(i,:));
        end
    end
end

G = [ (H(:, 6:10))' (H(:, 1:5)) ];


 