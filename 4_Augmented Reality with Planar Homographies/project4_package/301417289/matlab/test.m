close all
clear all;

%% read image
cv_cover  = imread('../data/cv_cover.jpg');
cv_desk   = imread('../data/cv_desk.png');

hp_cover  = imread('../data/hp_cover.jpg');
hp_desk   = imread('../data/hp_desk.png');


[locs1, locs2] = matchPics(cv_cover,cv_desk);

%H = computeH(locs1, locs2);
%H = computeH_norm(locs1, locs2).';
[H,inliers] = computeH_ransac(locs1, locs2);

%% cv_cover
points = [randperm(350, 10).', randperm(450, 10).'];
% hp_cover
%points = [randperm(200, 10).', randperm(230, 10).'];

tform = projective2d(H);

%% computeH and computeH_norm
%out = transformPointsForward(tform,points);

%computeH_ransac
out = transformPointsForward(tform,inliers);

figure;
%% show image
% show computeH and computeH_norm
%showMatchedFeatures(cv_cover, cv_desk, points, out, 'montage');
% show computeH_ransac
showMatchedFeatures(cv_cover, cv_desk, inliers, out, 'montage');