% This function takes an image as input
% and produces an edge map for the image.
% Function uses a Sobel operator for the gradient detection.
% Function uses a Gaussian convolutor for removing noise from the image.
function detected = edgeDetector(rawimage)
    im = imread(rawimage);
    gray = double(rgb2gray(im));
    gauss = [2,4,5,4,2;4,9,12,9,4;5,12,15,12,5;4,9,12,9,4;2,4,5,4,2] *1/159;
    im1 = convolve(gray, gauss);
    operatorx = [-1,0,1;-2,0,2;-1,0,1];
    operatory = [-1,-2,-1;0,0,0;1,2,1];
    lx = convolve(im1, operatorx);
    ly = convolve(im1, operatory);
    detected = sqrt(lx.^2 + ly.^2);
    [m,n]  = size(detected);
    detected = detected(4:m-3,4:n-3);
    detected = detected > 100.0;% & detected < 128.0;
end

