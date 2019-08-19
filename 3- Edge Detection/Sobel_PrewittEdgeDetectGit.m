% lecture de l'image
imgC = imread('test.png'); 
img = double(rgb2gray(imgC));

% c = (1 or 2): 1 for Prewitt method, 2 for Sobel method
c = 2;

kernelHoriz = [-1 0 1; 
                -c 0 c; 
                -1 0 1];

kernelVert = kernelHoriz'; 

derivedHorizImg = zeros(size(img, 1)-1, size(img, 2)-1);
derivedVertImg = zeros(size(img, 1)-1, size(img, 2)-1);
edgeImg = zeros(size(img, 1)-1, size(img, 2)-1);

% convolution par les deux masques
for i = 2 : size(img, 1)-1
  for j = 2 : size(img, 2)-1
    derivedHorizImg(i, j) = sum(sum(img(i-1:i+1,j-1:j+1).*kernelHoriz));
    derivedVertImg(i, j) = sum(sum(img(i-1:i+1,j-1:j+1).*kernelVert));
    edgeImg(i, j) = sqrt(derivedHorizImg(i, j).^2 + derivedVertImg(i, j).^2);
  end
end

% afichage
edgeImg = uint8(edgeImg);
figure();
subplot(2, 2, 1); imshow(derivedHorizImg, []); title("Horizontally derived Image");
subplot(2, 2, 2); imshow(derivedVertImg, []); title(" Vertically derived Image");
subplot(2, 2, [3 4]), imshow(edgeImg, []);
if c == 1
  title ("Edge detected using Prewitt method");
else 
  title ("Edge detected using Sobel method");
end