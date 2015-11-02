% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       4. Save the correct M2, p1, p2, R and P to q2_5.mat
load('some_corresp.mat');
M=640;
[ F ] = eightpoint( pts1, pts2, M );
load('intrinsics.mat');
[ E ] = essentialMatrix( F, K1, K2 );
[M2s] = camera2(E);
M1 = [eye(3) zeros(3,1)];

bestM2=[];
bestError=Inf;
C1=K1*M1;
bestP=[];
for i=1:4
    M2=M2s(:,:,i);
    C2=K2*M2;
    [ P ] = triangulate( M1, pts1, M2, pts2 );
    error=0;
    for j=1:length(pts1)
        if error>bestError
            break;
        end
        p1=C1*[P(j,:) 1]';
        p1=p1./p1(3);
        p2=C2*[P(j,:) 1]';
        p2=p2./p2(3);
        error= error+ pdist([pts1(j,:);p1(1:2)'])^2+pdist([pts2(j,:);p2(1:2)'])^2;
    end
    if error<bestError
        bestP=P;
        bestError=error;
        bestM2=M2s(:,:,i);
    end
end
save('q2_5.mat','bestM2','pts1','pts2','bestP');
