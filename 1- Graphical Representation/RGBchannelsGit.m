img = imread('test.png');
Red = img(:,:,1);
Green = img(:,:,2);
Bleu = img(:,:,3);


[x, y, ~] = size(img);

red = cat(3, Red, zeros(x, y), zeros(x, y));
green = cat(3, zeros(x, y), Green, zeros(x, y));
bleu = cat(3, zeros(x, y), zeros(x, y), Bleu);

figure, subplot(2, 2, 1), imshow(red), title('Red Channel'),
  subplot(2, 2, 2), imshow(green), title('Green Channel'),
  subplot(2, 2, 3), imshow(bleu), title('Bleu Channel');
