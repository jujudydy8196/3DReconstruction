function [ P ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%
load('intrinsics.mat');
n=length(p1);
C1=K1*M1;
C2=K2*M2;
P=zeros(n,3);
for i=1:n
    A=[p1(i,2)*C1(3,:)-C1(2,:); C1(1,:)-p1(i,1)*C1(3,:); p2(i,2)*C2(3,:)-C2(2,:); C2(1,:)-p2(i,1)*C2(3,:)];
    [u s v]=svd(A);
    P(i,:)=[v(1,4)/v(4,4) v(2,4)/v(4,4) v(3,4)/v(4,4)];
end

