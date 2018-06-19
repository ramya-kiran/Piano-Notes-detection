% This function matches an image which is given as the first input with a
% template which is given as the second input.
% Score gives us the output matrix after the convotion between the output
% of the distancefn on the image and the edge map of the template.
% r and c gives the row and column values in the image where the template
% matches the image.
% imshow(img) marks the template in the image.
function [score,r,c,img] = detecting(rawimg,template)

img = imread(rawimg);

% generating edge map for the template
edgeTemp = edgeDetector(template);
% generating distance of the pixel to the nearest edge in the image.
distfn = distancefn(rawimg);

% setting up template and image convolution
[m,n] = size(distfn);
[k,l] = size(edgeTemp);

blockrow = mod(m,k);
blockcol = mod(n,l);

distfn = [distfn;zeros(blockrow,n)];
distfn = [distfn,zeros((m + blockrow) ,blockcol)];

[m,n] = size(distfn);

% performing convolution
for i = 1:(m-k)
    for j = 1:(n-l)
        block = distfn(i:(i+ (k-1)),j:(j+(l-1)));
        sample = block .* edgeTemp;
        distfn(i,j) = sum(sample(:));
    end
end

distfn = distfn(1:m-blockrow, 1:n-blockcol);
% identifying the region in the image where the template matches the best.
threshold = min(distfn(:));

[r,c] = find( distfn <= threshold);
score = distfn;

if ~isempty(r)
    
    for i = 1:length(r)
        img = insertShape(img, 'Rectangle', [c(i) r(i) l k], 'Linewidth', 5);
    end
else
    disp('No match found');
end














