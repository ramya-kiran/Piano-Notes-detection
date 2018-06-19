function [d] = minimumfn(rawimg)
% for every scanline determine distance from an edge pixel to the next closest edge pixel.
g = edgeDetector(rawimg);

[m,n] = size(g);


if m > n
    h = m-n;
    g = [g,zeros(m,h)];
elseif m < n
    h = n - m;
    g = [g;zeros(h,n)];
end
[m,n] = size(g);
d = Inf(m,n);

for a = 1:m
    for b=1:n
        if (g(a,b) == 1 )
            s = sqrt( (a - (1:m-1)).^2 + (b - (1:n-1)).^2 ) ;
            d(a,b) = min(s(:));
        end
    end
end
d(isinf(d)) = 0;
end

