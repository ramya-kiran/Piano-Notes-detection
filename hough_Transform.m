function [g,H1] = hough_Transform( rawimg )
% This function identifies lines in an image after producing an edge map
% for the same.  

edgemap = edgeDetector(rawimg);


% edgemap = rawimg;

[m,n] = size(edgemap);
dist = ceil(sqrt (m.^2 + n.^2));
q =  2 * dist;
rho = ceil(linspace(-dist,dist,q));
rhox = size(rho,2);


accumulator1 = zeros(m,rhox);

for i = 1:m
    for j=1:n
        if (edgemap(i,j) == 1)
         
                k = ceil(i * cosd(90) + j * sind(90));
               [~,ry] = find(rho == k);
      
                accumulator1(i,ry) = k;
             
                
      
        end
    end
end

H1 = accumulator1;

value = sum(H1,2);
%maxval = max(value);

% threshold1 = maxval - (maxval/10);
threshold1 = 700000;
threshold2 = 300000;

g = zeros(1,length(value));
z = 1;

while z < length(value)
%   if ((value(z) >= threshold1) && (value(z+1) < threshold1))
  if ((value(z) >= threshold1) && (value(z+1) < threshold2) && ...
           (value(z+2) < threshold2) && (value(z-1) >= threshold1))
    g(1,z) = z;
    z = z+1;
  else
      z = z+1;
  end
  

end

g = g(g>0);











