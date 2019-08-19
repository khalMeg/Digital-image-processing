
img = imread('test.png');
img = rgb2gray(img);
[y, x] = size(img);
hist_array = zeros(1, 256);
for i=1:y
    for j=1:x
        hist_array(img(i, j)+1) = hist_array(img(i, j)+1) + 1;
    end
end            
bar(0:255, hist_array, 'histc');