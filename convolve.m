function [output] = convolve(in1,operator)
    in1 = double(in1);
    [m,n] = size(in1);
    [d1,d2] = size(operator);
    padsize = max(d1,d2);
    padsize = floor(padsize/2);
    in1 = [zeros(padsize,n); in1]; % add padsize to top
    in1 = [in1;zeros(padsize,n)]; % add padsize to bottom
    in1 = [zeros(m+(padsize*2),padsize), in1]; % add padsize columns left accounting for increased rows
    in1 = [in1, zeros(m+(padsize*2),padsize)]; % add padsize columns right acounting for increased rows
    out = zeros(size(in1));
    for i = (padsize+1):(m+padsize)
        for j = (padsize+1):(n+padsize)
            sample = in1(i-padsize:i+padsize,j-padsize:j+padsize);
            outij = sample.*operator;
            out(i,j) = sum(outij(:));
        end
    end
    output = out(padsize+1:m+padsize,padsize+1:n+padsize);
end