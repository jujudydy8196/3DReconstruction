load('../data/templeCoords.mat');
im1=imread('../data/im1.png');
im2=imread('../data/im2.png');
% P=zeros(length(x1),3);
findM2;
x2=zeros(length(x1),1);
y2=zeros(length(x1),1);

for i=1:length(x1)
    [ x2(i), y2(i) ] = epipolarCorrespondence( im1, im2, F, x1(i), y1(i) );
end
pts1=[x1,y1];
pts2=[x2,y2];
[ F ] = eightpoint( pts1, pts2, M );
[ E ] = essentialMatrix( F, K1, K2 );
[M2s] = camera2(E);
C1=K1*M1;
for i=1:4
    M2=M2s(:,:,i);
    C2=K2*M2;
    [ P ] = triangulate( C1, pts1, C2, pts2 );
    if all(P(:,3) > 0)
        break;
    end
end

P = triangulate( M1, pts1, M2,pts2);
idx=find(P(:,3)<5)
scatter3(P(idx,1),P(idx,2),P(idx,3),25,'filled');
% xlim([-0.75 0.6])
% zlim([0 5])
