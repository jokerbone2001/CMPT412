function [H2to1] = computeH_norm(x1, x2)
x = x1(:,1);
y = x1(:,2);
X = x2(:,1);
Y = x2(:,2);
%% Compute centroids of the points
centroid1 = [mean(x1(:,1)), mean(x1(:,2))];
centroid2 = [mean(x2(:,1)), mean(x2(:,2))];

%% Shift the origin of the points to the centroid
centTrans1  = [1, 0, centroid1(1);0,1,centroid1(2);0,0,1];
centTrans2  = [1, 0, centroid2(1);0,1,centroid2(2);0,0,1];



%% Normalize the points so that the average distance from the origin is equal to sqrt(2).

scale1  = [sqrt(2)/centroid1(1), 0,0;0,sqrt(2)/centroid1(2), 0;0,0,1];
scale2  = [sqrt(2)/centroid2(1), 0,0;0,sqrt(2)/centroid2(2), 0;0,0,1];
%% similarity transform 1
T1 = scale1 * centTrans1;

%% similarity transform 2
T2 = scale2 * centTrans2; 

%% Compute Homography
p1 = [x, y, ones(size(x1,1),1)];
p2 = [X, Y, ones(size(x1,1),1)];

p1 = (T1 * p1.').';
p2 = (T2 * p2.').';
H = computeH(p1, p2).';


%% Denormalization
H2to1 = T2\H*T1;

