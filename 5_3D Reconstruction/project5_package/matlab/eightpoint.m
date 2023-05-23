function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

N = size(pts1,1);
T = [1/M,0,0;
    0,1/M,0;
    0,0,1];

pts1_norm = pts1/M;
pts2_norm = pts2/M;
x1 = pts1_norm(:,1);
y1 = pts1_norm(:,2);
x2 = pts2_norm(:,1);
y2 = pts2_norm(:,2);
A = [x2.*x1 y2.*x1 x1 x2.*y1 y2.*y1 y1 x2 y2 ones(N,1)];

[~,~,V] = svd(A);
v = V(:,end);
F = reshape(v,[3,3]);
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';

F = refineF(F,pts1_norm,pts2_norm);
F = T'*F*T;
