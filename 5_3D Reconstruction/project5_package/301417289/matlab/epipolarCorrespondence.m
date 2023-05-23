function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

win_size = 9;
N = size(pts1,1);
pts1_1 = [pts1 ones(N,1)]; 
pts2 = zeros(N,2);
for i = 1:N
    best_err = intmax;
    point = pts1_1(i,:);
    im1_win = double(im1((point(2)-win_size):(point(2)+win_size),(point(1)-win_size):(point(1)+win_size)));
    l = F*point';
    borderPoints = lineToBorderPoints(l',size(im2));
    xrange = linspace(borderPoints(1),borderPoints(3),300);
    yrange = linspace(borderPoints(2),borderPoints(4),300);
    for idx = 20:length(xrange)-20
        x = round(xrange(idx));
        y = round(yrange(idx));
        im2_win = double(im2((y-win_size):(y+win_size),(x-win_size):(x+win_size)));
        %err = sum(sum(kernel.*(im2_win-im1_win)));
        %err = sum(sum(im2_win-im1_win));
        err = sum(sum((im2_win-im1_win).^2));
        if abs(err)<abs(best_err)
            best_err=err;
            best_x = x;
            best_y = y;
        end
    end
    pts2(i,:)=[best_x,best_y];
end
