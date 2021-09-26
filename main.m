% 1: Take two photographs
HP=imread('H.png');  %read images
LP=imread('L.png');
HP=im2double(HP);  
LP=im2double(LP);
HP=imcrop(HP,[110.5 78.5 3412 2916]);  %crop images
LP=imcrop(LP,[843.5 480.5 2136 2142]);
HP=imresize(HP,[500 500]);  %resize images
HP= imrotate(HP,-90,'bilinear','crop');
LP=imresize(LP,[500 500]);
HP=rgb2gray(HP);  %convert rgb to gray
LP=rgb2gray(LP);
imshow([HP LP])
imwrite(HP,"HP.png")
imwrite(LP,"LP.png")

% 2.Compute frequency representations 
HP_freq=fft2(HP);
LP_freq=fft2(LP);
imshow(fftshift(abs(HP_freq))/50)
imshow(fftshift(abs(LP_freq))/150)
imwrite(fftshift(abs(HP_freq))/100,"HP-freq.png")
imwrite(fftshift(abs(LP_freq))/150,"LP-freq.png")

% 3. Visualize kernels (2 pts)
sob=[-1 0 1;-2 0 2;-1 0 1];
gauskern=fspecial('gaussian',40,2.5);
surf(gauskern)
saveas(gcf,'gaus-surf','png')
surf(conv2(gauskern,sob))
saveas(gcf,'dog-surf','png')

HP_filt=imfilter(HP,gauskern);
LP_filt=imfilter(LP,gauskern);
imshow(HP_filt)
imshow(LP_filt)
imwrite(HP_filt,"HP-filt.png")
imwrite(LP_filt,"LP-filt.png")

HF_filt_freq=fft2(HP_filt);
LF_filt_freq=fft2(LP_filt);
imshow(fftshift(abs(HF_filt_freq))/50)
imshow(fftshift(abs(LF_filt_freq))/100)
imwrite(fftshift(abs(HF_filt_freq))/50,"HP-filt-freq.png")
imwrite(fftshift(abs(LF_filt_freq))/100,"LP-filt-freq.png")

HP_dogfilt=imfilter(HP,conv2(gauskern,sob));
LP_dogfilt=imfilter(LP,conv2(gauskern,sob));
imshow(HP_dogfilt)
imshow(LP_dogfilt)
imwrite(HP_dogfilt,"HP-dogfilt.png")
imwrite(LP_dogfilt,"LP-dogfilt.png")

HP_dogfilt_freq=fft2(HP_dogfilt);
LP_dogfilt_freq=fft2(LP_dogfilt);
imshow(fftshift(abs(HP_dogfilt_freq))/50)
imshow(fftshift(abs(LP_dogfilt_freq))/100)
imwrite(fftshift(abs(HP_dogfilt_freq))/50,"HP-dogfilt-freq.png")
imwrite(fftshift(abs(LP_dogfilt_freq))/100,"LP-dogfilt-freq.png")

% 4.Anti-aliasing (4 pts)
HP_sample=HP(1:2:end, 1:2:end);
LP_sample=LP(1:2:end, 1:2:end);
% imshow([HP LP])
imshow(HP_sample)
imshow(LP_sample)
imwrite(HP_sample,"HP-sub2.png")
imwrite(LP_sample,"LP-sub2.png")


%对比
% imshow([abs(fftshift(fft2(HP))) abs(fftshift(fft2(HP_sample,500,500)))]/50)
% imshow([abs(fftshift(fft2(LP))) abs(fftshift(fft2(LP_sample,500,500)))]/100)

imshow(abs(fftshift(fft2(HP_sample,500,500)))/50)
imshow(abs(fftshift(fft2(LP_sample,500,500)))/100)
imwrite(abs(fftshift(fft2(HP_sample,500,500)))/100,"HP-sub2-freq.png")
imwrite(abs(fftshift(fft2(LP_sample,500,500)))/100,"LP-sub2-freq.png")

HP_sample2=HP(1:4:end, 1:4:end);
LP_sample2=LP(1:4:end, 1:4:end);
imshow(HP_sample2)
imshow(LP_sample2)
imwrite(HP_sample2,"HP-sub4.png")
imwrite(LP_sample2,"LP-sub4.png")

%对比 
% imshow([abs(fftshift(fft2(HP))) abs(fftshift(fft2(HP_sample2,500,500)))]/50)
% imshow([abs(fftshift(fft2(LP))) abs(fftshift(fft2(LP_sample2,500,500)))]/100)

imshow(abs(fftshift(fft2(HP_sample2,500,500)))/50)
imshow(abs(fftshift(fft2(LP_sample2,500,500)))/100)
imwrite(abs(fftshift(fft2(HP_sample2,500,500)))/100,"HP-sub4-freq.png")
imwrite(abs(fftshift(fft2(LP_sample2,500,500)))/100,"LP-sub4-freq.png")

% 抗锯齿
HP_gaussfilt=imgaussfilt(HP_sample,0.5);
HP_gaussfilt2=imgaussfilt(HP_sample2,0.5);
imshow(HP_gaussfilt)
imshow(HP_gaussfilt2)
imwrite(HP_gaussfilt,"HP-sub2-aa.png")
imwrite(HP_gaussfilt2,"HP-sub4-aa.png")

%对比
imshow([abs(fftshift(fft2(HP))) abs(fftshift(fft2(HP_sample,500,500))) abs(fftshift(fft2(HP_gaussfilt,500,500)))]/100)
imshow([abs(fftshift(fft2(HP))) abs(fftshift(fft2(HP_sample2,500,500))) abs(fftshift(fft2(HP_gaussfilt2,500,500)))]/100)

imshow([abs(fftshift(fft2(HP_gaussfilt,500,500)))]/100)
imshow([abs(fftshift(fft2(HP_gaussfilt2,500,500)))]/100)
imwrite([abs(fftshift(fft2(HP_gaussfilt,500,500)))]/100,"HP-sub2-aa-freq.png")
imwrite([abs(fftshift(fft2(HP_gaussfilt2,500,500)))]/100,"HP-sub4-aa-freq.png")

%  5.Canny edge detection thresholding (3 pts)
[cannyedge, thresh]=edge(HP, 'canny');
imshow([HP edge(HP,'canny',[0.1 0.2])])%0.1438 0.3594
imwrite(edge(HP,'canny',[0.1 0.2]),"HP-canny-optimal.png")
imwrite(edge(HP,'canny',[0.08 0.3594]),"HP-canny-lowlow.png")
imwrite(edge(HP,'canny',[0.3 0.3594]),"HP-canny-highlow.png")
imwrite(edge(HP,'canny',[0.1438 0.2]),"HP-canny-lowhigh.png")
imwrite(edge(HP,'canny',[0.1438 0.6]),"HP-canny-highhigh.png")

[cannyedge, thresh]=edge(LP, 'canny');
imshow([LP edge(LP,'canny',[0.09 0.1])])%0.025 0.0625
imwrite(edge(LP,'canny',[0.09 0.1]),"LP-canny-optimal.png")
imwrite(edge(LP,'canny',[0.002 0.0625]),"LP-canny-lowlow.png")
imwrite(edge(LP,'canny',[0.05 0.0625]),"LP-canny-highlow.png")
imwrite(edge(LP,'canny',[0.025 0.03]),"LP-canny-lowhigh.png")
imwrite(edge(LP,'canny',[0.025 0.1]),"LP-canny-highhigh.png")
