function [img,r,c] = hammingDist(rawimg,template1,template2,template3,color1,color2,color3)

  img = rgb2gray(imread(rawimg));

[result1,k1,l1] = operations(rawimg,template1);
[result2,k2,l2] = operations(rawimg,template2);
[result3,k3,l3] = operations(rawimg,template3);

% notes detction
threshold3 = max(result3(:)) - (max(result3(:))*0.06);
[r3,c3] = find(result3 >= threshold3);

% first design detection
threshold2 = max(result2(:));
[r2,c2] = find(result2 >= threshold2);

% second design detection
threshold1 = max(result1(:));
[r1,c1] = find(result1 >= threshold1);

for i = 1:length(r3)
    img = insertShape(img, 'Rectangle', [c3(i) r3(i) l3 k3],'color',color3, 'Linewidth', 3);
end

for i = 1:length(r2)
    img = insertShape(img, 'Rectangle', [c2(i) r2(i) l2 k2],'color',color2, 'Linewidth', 3);
end

for i = 1:length(r1)
    img = insertShape(img, 'Rectangle', [c1(i) r1(i) l1 k1],'color',color1, 'Linewidth', 3);
end

r = r3;
c = c3;

end

function [result,k,l] = operations(rawimg,template)

  img = rgb2gray(imread(rawimg));
  
temp = rgb2gray(imread(template));

%temp = template;

levelimg = graythresh(img);
levelTemp = graythresh(temp);

imgBW = im2bw(img,levelimg);
% figure();
% imshow(imgBW);
tempBW = im2bw(temp,levelTemp);

% figure();
% imshow(tempBW);

[m,n] = size(imgBW);
[k,l] = size(tempBW);


blockrow = mod(k,m);
blockcol = mod(l,n);


imgBW = [imgBW;zeros(blockrow,n)];
imgBW = [imgBW,zeros((m + blockrow) ,blockcol)];

[m,n] = size(imgBW);

edgeTempReverse = 1 - tempBW;
% figure();
% imshow(edgeTempReverse);

imgBWReverse = 1 - imgBW;
% figure();
% imshow(imgBWReverse);

result = zeros(m,n);

%threshold = (k * l);

for i = 1:(m-k)
    for j = 1:(n-l) 
        block = imgBW(i:(i+(k-1)),j:(j+(l-1)));
        sample = block .* tempBW;
        
        blockReverse = imgBWReverse(i:(i+(k-1)),j:(j+(l-1)));
        sample1 = blockReverse .* edgeTempReverse;
        
        result(i,j) = sum(sample(:)) + sum(sample1(:));
       
    end
end
end



