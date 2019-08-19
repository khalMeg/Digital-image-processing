img = imread('test.png');
[N, M, ~] = size(img); 
imdistR = zeros(N, M,'uint8');
imdistV = zeros(N, M,'uint8');
imdistB = zeros(N, M,'uint8');
% used Gaussian kernel
GaussianKernel = [1 2 1; 2 4 2; 1 2 1];

for i=2 : N-1
    for j=2 : M-1
    %convolution with the Gaussian kernel
        imdistR(i, j) = sum(sum(double(img(i-1:i+1, j-1:j+1, 1)) .* GaussianKernel)) / 16;
        imdistV(i, j) = sum(sum(double(img(i-1:i+1, j-1:j+1, 2)) .* GaussianKernel)) / 16; 
        imdistB(i, j) = sum(sum(double(img(i-1:i+1, j-1:j+1, 3)) .* GaussianKernel)) / 16; 
    end
end

imDist = cat(3, imdistR, imdistV, imdistB);
imshow(imDist, []);