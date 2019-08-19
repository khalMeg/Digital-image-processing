img = imread('test.png');
h = imshow(img);
[x,y]=ginput(2);
x = int8(x);
y = int8(y);
%cropping the image over the rgb channels
R = img(min(y): max(y), min(x): max(x), 1);
G = img(min(y): max(y), min(x): max(x), 2);
B = img(min(y): max(y), min(x): max(x), 3);
imgF = cat(3, R, G, B);
imshow(imgF);