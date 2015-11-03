function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorith, how you determined which
%     points are inliers, and any other optimizations you made

maxInliers=0;
beste=Inf;
bestInliers=[];

th=100;
for j=1:1000
    idx = randperm(length(pts1),7);
    tempF = sevenpoint( pts1(idx,:), pts2(idx,:), M );
    if isempty(tempF{1})
        continue;
    end
    for i=1:length(tempF)
        L1=tempF{i}*[pts1 ones(length(pts1),1)]';
        L1=L1./repmat(sqrt( L1(1,:).^2 + L1(2,:).^2 ),3,1);
        e1 = abs(dot( pts2', L1(1:2,:)));
        
        L2=tempF{i}'*[pts2 ones(length(pts2),1)]';
        L2=L2./repmat(sqrt( L2(1,:).^2 + L2(2,:).^2 ),3,1);
        e2 = abs(dot( L2(1:2,:), pts1' ));
%         e1
%         e2
        inliers_idx = find (e1<th & e2<th);
        inliers = size(inliers_idx,2);
        if inliers>0
            e = sum( e1(inliers_idx).^2 + e2(inliers_idx).^2 ) / inliers;
        else
            e=Inf;
        end
        if inliers > maxInliers || (inliers==maxInliers && e<beste)
            beste = e;
            bestInliers=inliers_idx;
            maxInliers=inliers;
%             bestinliersidx=inliers_idx;
        end
    end
end
maxInliers
F=eightpoint(pts1(bestInliers,:),pts2(bestInliers,:),M);
end

