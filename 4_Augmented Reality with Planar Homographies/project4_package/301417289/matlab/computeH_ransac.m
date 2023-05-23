function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3
len = size(locs1,1);
num_points = 4;
points_1 = [locs1,ones(len,1)];
points_2 = [locs2,ones(len,1)];
best_count = 0;
best_H = [];
dist = 9000000;
inliers = [];
%% RANSAC loop
% 1. Get four point correspondences (randomly)
% 2. Compute H using DLT
% 3. Count inliers
for i = 1: 500
    count = 0;
    if len < 4
        num_points = len;
    end
    randpoints = randperm(len, num_points);
%   h_norm = computeH_norm(locs2((randpoints),:),locs1((randpoints),:));
    points_1 = locs1((randpoints),:);
    points_2 = locs2((randpoints),:);
    h_norm = computeH_norm(points_2,points_1);

    if abs(det(h_norm)) < 1e-7
        continue;
    end

    tform = projective2d(h_norm.');
    abs_distance = abs(locs1-transformPointsForward(tform, locs2));
    pt_index = [];
   
    for j = 1: len
        if norm(abs_distance(j,:),2) <= 3.5
            count = count+1;
            pt_index = [pt_index, j];
        end
    end

    if count >= best_count
        if count == best_count
            if sum(abs_distance,'all') < dist
                dist = sum(abs_distance,'all');
            end
        else
            dist = sum(abs_distance,'all'); 
        end
        best_count = count;
        points_1 = locs1(pt_index,:);
        points_2 = locs2(pt_index,:);
        best_H = computeH_norm(points_1,points_2);
        inliers = locs1(pt_index,:);  
    end

end
if size(best_H,1) == 0
    bestH2to1 = computeH_norm(points_1,points_2);
else
    bestH2to1= best_H.';
end
end

