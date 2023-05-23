% Q3.3.1
book_mov = loadVid('../data/book.mov');
source_mov = loadVid('../data/ar_source.mov');
cv_img = imread('../data/cv_cover.jpg');
nFrames = size(source_mov,2);
frame_dir  = '../results/frames';


for i = 1:nFrames
    img_book = book_mov(i).cdata ;
    img_panda = source_mov(i).cdata ;
    [locs1, locs2] = matchPics(cv_img, img_book);
    [bestH2to1,~] = computeH_ransac(locs1, locs2);
    scaled_img = imresize(img_panda, [size(cv_img,1) size(cv_img,2)]);
    img = compositeH(bestH2to1.', scaled_img, img_book);
    %figure;
    %imshow(img);
    fname = sprintf('%s/%s.png', frame_dir, num2str(i));
    imwrite(img, fname);
end

vedio = VideoWriter('ar.avi');
vedio.Quality = 95;
vedio.FrameRate = 20;
open(vedio);
for i=1:nFrames
    frame = imread([frame_dir,'/',num2str(i,'%d'),'.png']);
    writeVideo(vedio,frame);
end
close(vedio);