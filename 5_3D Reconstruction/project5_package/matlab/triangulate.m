function [error_p1s, error_p2s, pts3d] = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
n = size(pts1,1);
pts3d = zeros(n,4);
for i =1:n
    x1 = pts1(i,1);
    y1 = pts1(i,2);
    x2 = pts2(i,1);
    y2 = pts2(i,2);

A = [x1*P1(3,:)-P1(1,:);y1*P1(3,:)-P1(2,:);x2*P2(3,:)-P2(1,:);y2*P2(3,:)-P2(2,:)];
    [~,~,v] = svd(A);
    pts3 = v(:,end);
    pts3 = pts3/pts3(end);
    pts3d(i,:) = pts3';
end
p1s = (P1*pts3d')';
p1s = p1s./p1s(:,end);
p2s = (P2*pts3d')';
p2s = p2s./p2s(:,end);
error_p1s = mean(sqrt(sum(([pts1,ones(n,1)]-p1s).^2,2)))/10;
error_p2s = mean(sqrt(sum(([pts2,ones(n,1)]-p2s).^2,2)))/10;
pts3d = pts3d(:,1:3);
