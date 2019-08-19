img = imread('test.png');
imgGS = rgb2gray(img);
[y, x] = size(imgGS); 

% I) Image normalisation 

    %Step 1: searching MAX and MIN values
MAX = 0;
MIN = 255;

for i=1:y
    for j=1:x
        if imgGS(i,j) < MIN
            MIN = imgGS(i,j);
        end
        if imgGS(i,j) > MAX
            MAX = imgGS(i,j);
        end
    end
end

    %Step 2: Adjusting image pixels values
a = 255 / (MAX - MIN);
NormImg = (imgGS - MIN) * a;

%II) Accumulate the normalized Image    
    %step 1 : find the normalized histogram from the normalized image
NormHist = zeros(1, 256);
for i=1:y
    for j=1:x
        NormHist(NormImg(i, j)+1) = NormHist(NormImg(i, j)+1) + 1;
    end
end

  %step 2: calculating the accumulated histogram of the normalized image.
    %note that we cn simply call the built-in function cumsum() in order to
    %find the accumulated histogram : %histC = cumsum(histC);
    AccHist = zeros(1, 256);
for i=1:256
    AccHist(i) = AccHist(i) + sum(NormHist(:,1:i));
end

%III) Image Equalization
%NormImg = im2double(NormImg);
EqualImg = zeros(y, x);
for i=1:y
    for j=1:x
        EqualImg(i, j) = AccHist(NormImg(i, j)+1) * 255/y*x;
    end
end

%Ploting results
figure();
    subplot(2,2,1);
    bar((0:255), NormHist(:));
    title("Normalized Histogram");    
    subplot(2,2,2);
    bar((0:255), AccHist(:));
    title("Acumulated Normalized Histogram");
    subplot(2,2,3);
    imshow(NormImg, []);    
    title("Normalized Image");
    subplot(2,2,4);
    imshow(EqualImg, []);
    title("Equalized Image");