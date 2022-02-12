close all; clear all;

%images loading
im1='10_insta.jpg'
im2='10_screenShiftedSameRes.jpg'
subplot(1,2,1);
imshow(CleanUpImage(im1));
subplot(1,2,2);
imshow(CleanUpImage(im2));

%first image conversion into YCbCr
imgRGB1=double(imread(im1));
[height,width,color]=size(imgRGB1);
YCbCr1=rgb2ycbcr(imgRGB1);

%second image conversion into YCbCr
imgRGB2=double(imread(im2));
YCbCr2=rgb2ycbcr(imgRGB2);

%computation in RGB of the images difference
contDiff = 0;
processMatrix = [height, width, color];
for h=1:height
    for w=1:width
        for c=1:color
            processMatrix(h,w,c) = abs(imgRGB1(h,w,c) - imgRGB2(h,w,c));
            if processMatrix(h,w,c) ~= 0
                contDiff= contDiff +1;
            end
        end
    end
end

figure; 
imshow(processMatrix);
title('RGB difference');
xlabel(sprintf('Change rate: %f', contDiff/(height*width*color)*100));

%computation in YCbCr of the images difference
contDiff = 0;
processMatrix = [height, width, color];
for h=1:height
    for w=1:width
        for c=1:color
            processMatrix(h,w,c) = abs(YCbCr1(h,w,c) - YCbCr2(h,w,c));
            if processMatrix(h,w,c) ~= 0
                contDiff= contDiff +1;
            end
        end
    end
end

figure; 
imshow(processMatrix);
title('YCbCr difference');
xlabel(sprintf('Change rate: %f', contDiff/(height*width*color)*100));

%computation in Y of the images difference
contDiff = 0;
resultMatrix = [height, width];
for h=1:height
    for w=1:width
        %difference of the Y value
        resultMatrix(h,w) = abs(YCbCr1(h,w,1) - YCbCr2(h,w,1));
        if resultMatrix(h,w) ~= 0
            contDiff= contDiff +1;
        end
    end
end

figure; 
imshow(resultMatrix);
title('Y difference');
xlabel(sprintf('Change rate: %f', contDiff/(height*width)*100));

%computation in Cb of the images difference
contDiff = 0;
resultMatrix = [height, width];
for h=1:height
    for w=1:width
        %difference of the Cb value
        resultMatrix(h,w) = abs(YCbCr1(h,w,2) - YCbCr2(h,w,2));
        if resultMatrix(h,w) ~= 0
            contDiff= contDiff +1;
        end
    end
end

figure; 
imshow(resultMatrix);
title('Cb difference');
xlabel(sprintf('Change rate: %f', contDiff/(height*width)*100));

%computation in Cr of the images difference
contDiff = 0;
resultMatrix = [height, width];
for h=1:height
    for w=1:width
        %difference of the Cr value
        resultMatrix(h,w) = abs(YCbCr1(h,w,3) - YCbCr2(h,w,3));
        if resultMatrix(h,w) ~= 0
            contDiff= contDiff +1;
        end
    end
end

figure;
imshow(resultMatrix);
title('Cr difference');
xlabel(sprintf('Change rate: %f', contDiff/(height*width)*100));

%computation using the CAGI of the images
[ Result_CAGI1,Result_Inv_CAGI1 ] = CAGI(im1);
[ Result_CAGI2,Result_Inv_CAGI2 ] = CAGI(im2);

%CAGI
[height,width,color]=size(Result_CAGI1);
contDiff = 0;
processMatrix = [height, width, color];
for h=1:height
    for w=1:width
        for c=1:color
            processMatrix(h,w,c) = abs(Result_CAGI1(h,w,c) - Result_CAGI2(h,w,c));
            if processMatrix(h,w,c) ~= 0
                contDiff= contDiff +1;
            end
        end
    end
end

figure; 
imshow(processMatrix);
title('CAGI difference');
xlabel(sprintf('Change rate: %f', contDiff/(height*width*color)*100));

%INVERSE CAGI
[height,width,color]=size(Result_Inv_CAGI1);
contDiff = 0;
processMatrix = [height, width, color];
for h=1:height
    for w=1:width
        for c=1:color
            processMatrix(h,w,c) = abs(Result_Inv_CAGI1(h,w,c) - Result_Inv_CAGI2(h,w,c));
            if processMatrix(h,w,c) ~= 0
                contDiff= contDiff +1;
            end
        end
    end
end

figure; 
imshow(processMatrix);
title('Inverse CAGI difference');
xlabel(sprintf('Change rate: %f', contDiff/(height*width*color)*100));
