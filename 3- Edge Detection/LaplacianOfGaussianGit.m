imgC = imread('test.png');
img = double(rgb2gray(imgC));

kernelGaus = [1 2 1; 2 4 2; 1 2 1];
kernel = [0 1 0; 1 -4 1; 0 1 0];
%other kernels
%kernel = [0 -1 0; -1 4 -1; 0 -1 0];
%kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
%kernel = [1 -2 1; -2 4 -2; 1 -2 1];
threshold = 70;
GaussImg = zeros(size(img, 1)-1, size(img, 2)-1);

%Gaussian bluring: Goal is to reduce the noise in the image
for i = 2 : size(img, 1)-1
  for j = 2 : size(img, 2)-1
    GaussImg(i, j) = sum(sum(img(i-1:i+1,j-1:j+1).*kernelGaus)); 
  end
end

%%%% étape 2 : Convolution avec le filtre laplacian + thresholdlage %%%%%
DetEdgeImg = zeros(size(GaussImg, 1)-1, size(GaussImg, 2)-1);

for i = 2 : size(GaussImg, 1)-1
  for j = 2 : size(GaussImg, 2)-1
    DetEdgeImg(i, j) = sum(sum(GaussImg(i-1:i+1,j-1:j+1).*kernel));
    if DetEdgeImg(i, j) < threshold
      DetEdgeImg(i, j) = 255;
    else
      DetEdgeImg(i, j) = 0;
    end
  end
end
%%%% étape 3: detection de contours
for i = 1 : size(DetEdgeImg, 1)
  for j = 1 : size(DetEdgeImg, 2)
    if j < size(DetEdgeImg, 2)
      if DetEdgeImg(i, j) == DetEdgeImg(i, j+1) %0→0, 1→1
         DetEdgeImg(i, j) = 0;
      else
        DetEdgeImg(i, j) = 255;
      end
    else
      if i < size(DetEdgeImg, 1)
        if DetEdgeImg(i, j) == DetEdgeImg(i+1, 1)
          DetEdgeImg(i, j) = 0;
        else
          DetEdgeImg(i, j) = 255;
        end
      end
    end
  end
end

DetEdgeImg = uint8(DetEdgeImg);
figure();
imshow(DetEdgeImg, []); title("Edege detection: Laplacien Of Gaussien");