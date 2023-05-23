% part 3
layers = get_lenet();
load lenet.mat

imgs_1 = zeros(784,5);
for i = 1: 6
   img_file = sprintf('test_images/image_%d.png', i);
   img = imread(img_file);
   img = 255 - img;
   img = rgb2gray(img).';
   img = padarray(img, [15,15], 0, 'both');
   img = imresize(img, [28,28]);
   reshaped_img = reshape(img, [], 1);
   imgs_1(:,i) = reshaped_img;
end
layers{1,1}.batch_size = 6;
[output_0, P_0] = convnet_forward(params, layers, imgs_1);
[p_0, out_label] = max(P_0, [], 1);
%disp("     1     3     0     6     4     9")
%disp(out_label-1)


%%part 5
%image 1
image1 = imread('..//images/image1.jpg');
image1 = rgb2gray(image1);
image1 = 255 - image1;
image1 = imbinarize(image1);
%imshow(image);
L = bwlabel(image1,4);
%bounding box
info = regionprops(L, 'Boundingbox');
figure(1)
imshow(L)
for k = 1:length(info)
    BB = info(k).BoundingBox;
    rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2);
end
img_batch = zeros(28*28, length(info));
layers{1,1}.batch_size = length(info);
for i = 1:length(info)
   box = floor(info(i).BoundingBox);
   digit_image = image1(box(2):box(2)+box(4)-1, box(1):box(1)+box(3)-1);
   digit_image = padarray(digit_image, [20,20], 0, 'both');
   digit_image = imresize(digit_image, [28,28]);
   reshaped_digit = reshape(digit_image.', [], 1);
   img_batch(:,i) = reshaped_digit;

end
[~, P1] = convnet_forward(params, layers, img_batch);
[~, prediction1] = max(P1, [], 1);
prediction1 = prediction1 - 1;
disp("     1     2     3     4     5     6     7     8     9     0")
disp(prediction1)

%image 2

image2 = imread('..//images/image2.jpg');
image2 = rgb2gray(image2);
image2 = 255 - image2;
image2 = imbinarize(image2);
%imshow(image);
L = bwlabel(image2,4);
%bounding box
info = regionprops(L, 'Boundingbox');
figure(2)
imshow(L)
for k = 1:length(info)
    BB = info(k).BoundingBox;
    rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2);
end
img_batch = zeros(28*28, length(info));
layers{1,1}.batch_size = length(info);
for i = 1:length(info)
   box = floor(info(i).BoundingBox);
   digit_image = image2(box(2):box(2)+box(4)-1, box(1):box(1)+box(3)-1);
   digit_image = padarray(digit_image, [20,20], 0, 'both');
   digit_image = imresize(digit_image, [28,28]);
   reshaped_digit = reshape(digit_image.', [], 1);
   img_batch(:,i) = reshaped_digit;

end
[~, P2] = convnet_forward(params, layers, img_batch);
[~, prediction2] = max(P2, [], 1);
prediction2 = prediction2 - 1;
disp("     1     2     3     4     5     6     7     8     9     0")
disp(prediction2)

%image 3
image3 = imread('..//images/image3.png');
image3 = rgb2gray(image3);
image3 = 255 - image3;
image3 = imbinarize(image3);
%imshow(image);
L = bwlabel(image3,4);
%bounding box
info = regionprops(L, 'Boundingbox');
figure(3)
imshow(L)
for k = 1:length(info)
    BB = info(k).BoundingBox;
    rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2);
end
img_batch = zeros(28*28, length(info));
layers{1,1}.batch_size = length(info);
for i = 1:length(info)
   box = floor(info(i).BoundingBox);
   digit_image = image3(box(2):box(2)+box(4)-1, box(1):box(1)+box(3)-1);
   digit_image = padarray(digit_image, [20,20], 0, 'both');
   digit_image = imresize(digit_image, [28,28]);
   reshaped_digit = reshape(digit_image.', [], 1);
   img_batch(:,i) = reshaped_digit;
%    figure(i)
%    imshow(digit_image)
end
[~, P3] = convnet_forward(params, layers, img_batch);
[~, prediction3] = max(P3, [], 1);
prediction3 = prediction3(1:5) - 1;
disp("     6     0     6     2     4")
disp(prediction3)

%image4
image4 = imread('..//images/image4.jpg');
image4 = rgb2gray(image4);
image4 = 255 - image4;
image4 = imbinarize(image4);
%imshow(image);
L = bwlabel(image4,4);
%bounding box
info = regionprops(L, 'Boundingbox');

figure(4)
imshow(L)
for k = 1:length(info)
    BB = info(k).BoundingBox;
    rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2);
end

img_batch = zeros(28*28, length(info));
layers{1,1}.batch_size = length(info);
for i = 1:length(info)
   box = floor(info(i).BoundingBox);
   digit_image = image4(box(2):box(2)+box(4)-1, box(1):box(1)+box(3)-1);
   digit_image = padarray(digit_image, [10,10], 0, 'both');
   digit_image = imresize(digit_image, [28,28]);
   reshaped_digit = reshape(digit_image.', [], 1);
   img_batch(:,i) = reshaped_digit;
%    if i == 42
%    figure(i)
%    imshow(digit_image)
%    end
end

[~, P4] = convnet_forward(params, layers, img_batch);
[~, prediction4] = max(P4, [], 1);
prediction4 = prediction4-1;
disp(prediction4)
