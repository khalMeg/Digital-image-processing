img = imread('test.png');
[N, M, ~] = size(img);
imdistR = zeros(N, M,'uint8');
imdistV = zeros(N, M,'uint8');
imdistB = zeros(N, M,'uint8');

for i=2 : N-1
    for j=2 : M-1
        %sort
        tabTrieR = sort(reshape(img(i-1:i+1, j-1:j+1, 1), 1, []));
        tabTrieV = sort(reshape(img(i-1:i+1, j-1:j+1, 2), 1, []));
        tabTrieB = sort(reshape(img(i-1:i+1, j-1:j+1, 3), 1, []));
        %taking the first = min element
        imdistR(i, j) = tabTrieR(1); 
        imdistV(i, j) = tabTrieV(1);
        imdistB(i, j) = tabTrieB(1);
    end
end

imDist = cat(3, imdistR, imdistV, imdistB);
imshow(imDist, []);