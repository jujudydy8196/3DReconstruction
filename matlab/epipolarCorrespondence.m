function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup

im1=double(im1);
im2=double(im2);
l=F*[x1;y1;1];
normalize=sqrt(l(1)^2+l(2)^2);
l=l/normalize;

[h,w,~]=size(im1);

% W=[3 5 10];
windowSize=21;
w_half=floor(windowSize/2);
im1window=im1(round(y1-w_half:y1+w_half),round(x1-w_half:x1+w_half));
G = fspecial('gaussian',[windowSize windowSize],1);

minDiff=Inf;
bestAns=[];
abs(l(1)/l(2))

if abs(l(1)/l(2))>1
    %vertical
    Y=1+w_half:h-w_half;
    for y=Y
        x= (-l(2).*y-l(3))./l(1);
        im2window=im2(round(y-w_half:y+w_half),round(x-w_half:x+w_half));
        diff=norm(G.*(double(im2window)-double(im1window)));
        if (diff<minDiff)
            minDiff=diff;
            bestAns=[x,y];
        end
    end
else
    X=1+w_half:w-w_half;
    for x=X
        y= (-l(1).*x-l(3))./l(2);
        im2window=im2(round(y-w_half:y+w_half),round(x-w_half:x+w_half));
        diff=norm(G.*(double(im2window)-double(im1window)));
        if (diff<minDiff)
            minDiff=diff;
            bestAns=[x,y];
        end
    end    
end

x2=bestAns(1);
y2=bestAns(2);
end

