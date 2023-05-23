% A test script using templeCoords.mat
%
% Write your code here
%
%% Load the two images and the point correspondences from someCorresp.mat

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
some_pts = load('../data/someCorresp');
pts1 = some_pts.pts1;
pts2 = some_pts.pts2;
M = max(size(im1,1),size(im1,2));
%% Run eightpoint to compute the fundamental matrix F
F = eightpoint(pts1, pts2, M);
% displayEpipolarF(im1, im2, F);
%% Load the points in image 1 contained in templeCoords.mat 
temptle_coords = load('../data/templeCoords');
pts1 = temptle_coords.pts1;
% [coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F);
% run your epipolarCorrespondences on them to get the corresponding points in image 
[pts2] = epipolarCorrespondence(im1, im2, F, pts1);
%% Load intrinsics.mat and compute the essential matrix E.
b = load('../data/intrinsics');
K1 = b.K1;
K2 = b.K2;
E = essentialMatrix(F, K1, K2);

%% Compute the first camera projection matrix P1 and use camera2.m to compute the four candidates for P2
R1=eye(3);
t1 = zeros(3,1);
P1 = [R1,t1];
P2s = camera2(E);
best_count = 0;
error1 = 0;
error2 = 0;
%% Run your triangulate function using the four sets of camera matrix candidates, 
% the points from templeCoords.mat and their computed correspondences.
% Figure out the correct P2 and the corresponding 3D points.
for i = 1:4
    [error_p1s, error_p2s, pts3d] = triangulate(K1*P1, pts1, K2*P2s(:,:,i), pts2 );
    error1 = error1 + error_p1s;
    error2 = error2 + error_p2s;
    if all(pts3d(:,3)>0)
        P2 = P2s(:,:,i);
        pts3D = pts3d;
    end
end
fprintf('error_p1s = %f\n', error1/4)
fprintf('error_p2s = %f\n', error2/4)


R1=P1(:,1:3);
t1=P1(:,4);
R2 = P2(:,1:3);
t2 = P2(:,4);

%% Use matlab’s plot3 function to plot these point correspondences on screen. Please type “axis equal” after “plot3” to scale axes to the same unit.

figure
plot3(pts3D(:,1), pts3D(:,2), pts3D(:,3),"b.");

%% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
