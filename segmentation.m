function segmentation()

clc

n = 10

for i = 1:n
    disp(i);
    im = imread(['/Imagens/' num2str(i) '.jpg']);
    imshow(im);
end