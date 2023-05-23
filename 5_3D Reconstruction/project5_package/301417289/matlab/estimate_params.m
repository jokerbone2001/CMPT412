function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
[~,~,V] = svd(P);
c = V(1:3,end) / V(end, end);
[K,R] = RQ3(P(1:3,1:3));
if det(R) < 0
   R = -R; 
end
t = -R*c;
end

function [R,Q] = RQ3(A)
eps = 1e-10;

A(3,3) = A(3,3) + eps;
c = -A(3,3)/sqrt(A(3,3)^2+A(3,2)^2);
s =  A(3,2)/sqrt(A(3,3)^2+A(3,2)^2);
Qx = [1 0 0; 0 c -s; 0 s c];
R = A*Qx;

R(3,3) = R(3,3) + eps;
c = R(3,3)/sqrt(R(3,3)^2+R(3,1)^2);
s = R(3,1)/sqrt(R(3,3)^2+R(3,1)^2);
Qy = [c 0 s; 0 1 0;-s 0 c];
R = R*Qy;

R(2,2) = R(2,2) + eps;
c = -R(2,2)/sqrt(R(2,2)^2+R(2,1)^2);
s =  R(2,1)/sqrt(R(2,2)^2+R(2,1)^2);    
Qz = [c -s 0; s c 0; 0 0 1];
R = R*Qz;

Q = Qz'*Qy'*Qx';

for n = 1:3
    if R(n,n) < 0
        R(:,n) = -R(:,n);
        Q(n,:) = -Q(n,:);
    end
end
end