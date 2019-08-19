Img = imread('test.png');
Img = double(Img);
%initialization

clustersNbr = 3; % choose any number of cluster except 0
ClustersCentroid = randi([1, 255], clustersNbr, 3);

distanceOfPixelFromCentroid = zeros(clustersNbr, 1);

for it = 1:5 %choose how many iteration to perform
  % step 1: associating pixels to diffrent clusters
  % any layer of Z coresponds to a cluster
  % if a pixel of a layer (cluster) in Z equal to 1 then this pixel belongs to this
  % cluster.
  Z = zeros(size(Img, 1), size(Img, 2), clustersNbr);
  for i = 1:size(Img, 1)
    for j = 1:size(Img, 2)
      for k = 1:clustersNbr        
        % find the distance of pixels from cluster's centroids.
        distanceOfPixelFromCentroid(k, 1) = sqrt(sum((reshape(Img(i, j, :), 1, 3) - ClustersCentroid( k, :)).^2));
      end
      %here we take the minimum distance of pixel from centroid and affect
      %it to the nearest cluster
      [~, MinDistIndice_pixel_centroid] = min(distanceOfPixelFromCentroid);
      Z(i, j, MinDistIndice_pixel_centroid) = 1;
    end
  end
  % step 2: recalculate centroids coordinates
      for k = 1:clustersNbr
        ClustersPixelsNbr =  sum(sum(Z(:, :, k)));       
        %coordonate X of cleuster k
        ClustersCentroid(k, 1) = uint8(round(sum(sum(Z(:, :, k).* Img(:, :, 1))) / ClustersPixelsNbr));
        %coordonate Y of cleuster k
        ClustersCentroid(k, 2) = uint8(round(sum(sum(Z(:, :, k).* Img(:, :, 2))) / ClustersPixelsNbr));
        %coordonate Z of cleuster k
        ClustersCentroid(k, 3) = uint8(round(sum(sum(Z(:, :, k).* Img(:, :, 3))) / ClustersPixelsNbr));
      end
end
% Colorating Clusters using the average color of each cluster 
classifiedImg = zeros(size(Img, 1), size(Img, 2), 3);

RGBColorOfCluster = zeros(1, 3);
for k = 1 : clustersNbr
    ClustersPixelsNbr =  sum(sum(Z(:, :, k)));
    % Red color of cluster k
    RGBColorOfCluster(1, 1) = uint8(round(sum(sum(Z(:, :, k).* Img(:, :, 1))) / ClustersPixelsNbr));
    % affecting red color to only pixels of cluster k
    classifiedImg(:, :, 1) = classifiedImg(:, :, 1) + Z(:, :, k) * RGBColorOfCluster(1, 1);
    % Green color of cluster k
    RGBColorOfCluster(1, 2) = uint8(round(sum(sum(Z(:, :, k).* Img(:, :, 2))) / ClustersPixelsNbr));
    % affecting green color to only pixels of cluster k
    classifiedImg(:, :, 2) = classifiedImg(:, :, 2) + Z(:, :, k) * RGBColorOfCluster(1, 2);
    % Bleu color of cluster k
    RGBColorOfCluster(1, 3) = uint8(round(sum(sum(Z(:, :, k).* Img(:, :, 3))) / ClustersPixelsNbr));
    % affecting bleu color to only pixels of cluster k
    classifiedImg(:, :, 3) = classifiedImg(:, :, 3) + Z(:, :, k) * RGBColorOfCluster(1, 3);    
end

figure(),
classifiedImg = uint8(classifiedImg); 
imshow(classifiedImg), title('classified image using k-means');
disp("centroids:");
disp(ClustersCentroid);