img = imread('test.png');
[N, M, ~] = size(img); 
imdistR = zeros(N, M,'uint8');
imdistV = zeros(N, M,'uint8');
imdistB = zeros(N, M,'uint8');

for i=2 : N-1
    for j=2 : M-1
        imdistR(i, j) = int16(mean2(img(i-1:i+1, j-1:j+1, 1))); 
        imdistV(i, j) = int16(mean2(img(i-1:i+1, j-1:j+1, 2))); 
        imdistB(i, j) = int16(mean2(img(i-1:i+1, j-1:j+1, 3))); 
    end
end

imDist = cat(3, imdistR, imdistV, imdistB);
imshow(imDist, []);