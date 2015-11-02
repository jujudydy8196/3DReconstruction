function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup
pts1n = pts1/M;
pts2n = pts2/M;
x1=pts1n(:,1);
y1=pts1n(:,2);
x2=pts2n(:,1);
y2=pts2n(:,2);
n=length(pts1n);

A=[ x1.*x2 x1.*y2 x1 y1.*x2 y1.*y2 y1 x2 y2 ones(n,1) ] ;
[u s v]=svd(A);
F_nons=v(:,end);
F_nons=reshape(F_nons,3,3)';

[uf sf vf]=svd(F_nons);
sf(3,3)=0;
F=uf*sf*vf';

% F = refineF(F_nons,pts1,pts2);

T=[1/M 0 0; 0 1/M 0; 0 0 1];
F=T'*F*T;

% save('q2_1.mat','F','M','pts1','pts2');
end

