function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
H = [];
%% 1 For each correspondence, create 2x9 matrix
% 2 Concatenate into single 2n x 9 matrix

for i = 1: size(x1)
   H(2*i-1,:) = [-x1(i,1), -x1(i,2),-1,0,0,0,x1(i,1)*x2(i,1), x2(i,1)*x1(i,2), x2(i,1)];
   H(2*i,:) = [0,0,0,-x1(i,1), -x1(i,2),-1, x1(i,1)*x2(i,2), x1(i,2)*x2(i,2), x2(i,2)];
end

%% 3 Compute SVD
if size(x1,1) <= 4
    [U,S,V] = svd(H);
else
    [U,S,V] = svd(H,'econ');
end

%% 4 Store singular vector of the smallest singular value
smallIndex= 1;
smallVal = S(1,1);
s = size(S);

if s(1) < s(2)
    temp = s(1);
else
    temp = s(2);
end
for i = 1:temp
    if smallVal > S(i,i)
       smallVal = S(i,i);
       smallIndex = i;
    end
end
%V = V(:, smallIndex);
V = V(:, end);
%% 5 Reshape to get

V = reshape(V,[3,3]);
H2to1= V;


end
