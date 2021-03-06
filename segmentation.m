function segmentation()

clc

for i = 1:1
    disp(i);
    rgb = imread([num2str(i) '.jpg']);
    
    [altura,largura] = size(rgb);
    
    rgb_cropped = imcrop(rgb,[0 0 largura (altura/2)]);
    
    r = rgb_cropped(:,:,1);
    g = rgb_cropped(:,:,2);
    b = rgb_cropped(:,:,3);
    
    figure,imshow(r);title('R');
    figure,imshow(g);title('G');
    figure,imshow(b);title('B');
    
    hsv = rgb2hsv(rgb_cropped);
    
    h = hsv(:,:,1);
    s = hsv(:,:,2);
    v = hsv(:,:,3);
    
    figure,imshow(h);title('H');
    figure,imshow(s);title('S');
    figure,imshow(v);title('V');
        
    hsv = rgb2hsv(rgb_cropped);
    R = hsv(:,:,2);
    %figure,imshow(R);
    [u, v] = size(R);

    BW1 = edge(R,'Sobel');
    figure, imshow(BW1);
    title('Sobel');

    se = strel('line',2,0);
    D = imerode(BW1, se);
    figure, imshow(D);

    se1 = strel('line',2,90);
    D1 = imerode(BW1, se1);
    figure, imshow(D1);

    %bwlabel();
    
    img = imread('1_.jpg');
    bw = im2bw(rgb_cropped);
    % find both black and white regions
    stats = [regionprops(bw); regionprops(not(bw))]
    % show the image and draw the detected rectangles on it
    figure,imshow(bw); 
    hold on;
    for i = 1:numel(stats)
        rectangle('Position', stats(i).BoundingBox, ...
        'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
    end
end