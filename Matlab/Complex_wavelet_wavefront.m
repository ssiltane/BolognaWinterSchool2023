% Test dual-tree wavelets and morphology-based recovery of missing
% wave-front set elements
%
% Samuli Siltanen July 2022

% Parameters for plotting
threshold = 0.03; % Must be between zero and one
pizzabox_threshold = 0.1; % Must be between zero and one
imMAX = .5; % Set the brightest tone in the images
color0630 = [.3 .3 .3];
color0730 = [0 1 1];
color0830 = [0 1 0];
color0930 = [1 0 1];
color1030 = [1 0 0];
color1130 = [.7 .7 0];
fsize = 16;

% Read in the image and normalize it
im = imread('images/circ_pic.png','png');
%im = imread('images/m_pic.png','png');
%im = imread('images/e_pic.png','png');
%im = imread('images/c_pic.png','png');
im = double(im);
im = im/max(im(:));

% Calculate dual-tree transform
wtc = dddtree2('cplxdt',im,3,'dtf1');

% Normalize the subbands
sbands = wtc.cfs{1};
complex_sbands = sbands(:,:,:,:,1)+1i*sbands(:,:,:,:,2);
MAX = max(abs(complex_sbands(:)));
sbands = sbands/MAX;

% Threshold the coefficients
sbands(abs(sbands(:,:,:,:,1)+1i*sbands(:,:,:,:,2))<threshold) = 0;

% Pick out individual subbands
coefs0630 = sbands(:,:,2,1,1)+1i*sbands(:,:,2,1,2);
coefs0730 = sbands(:,:,3,1,1)+1i*sbands(:,:,3,1,2);
coefs0830 = sbands(:,:,1,1,1)+1i*sbands(:,:,1,1,2);
coefs0930 = sbands(:,:,1,2,1)+1i*sbands(:,:,1,2,2);
coefs1030 = sbands(:,:,3,2,1)+1i*sbands(:,:,3,2,2);
coefs1130 = sbands(:,:,2,2,1)+1i*sbands(:,:,2,2,2);

% Create plot window
figure(1)
clf
subplot(2,3,1)
imagesc(abs(coefs0630),[0,imMAX]);
axis equal
axis off
title('Subband 06:30')
subplot(2,3,2)
imagesc(abs(coefs0730),[0,imMAX]);
axis equal
axis off
title('Subband 07:30')
subplot(2,3,3)
imagesc(abs(coefs0830),[0,imMAX]);
axis equal
axis off
title('Subband 08:30')
subplot(2,3,4)
imagesc(abs(coefs0930),[0,imMAX]);
axis equal
axis off
title('Subband 9:30')
subplot(2,3,5)
imagesc(abs(coefs1030),[0,imMAX]);
axis equal
axis off
title('Subband 10:30')
subplot(2,3,6)
imagesc(abs(coefs1130),[0,imMAX]);
axis equal
axis off
title('Subband 11:30')

colormap summer


%% Clean up the subbands


% Morphological opening to remove isolated coefficients
angstep = 180/6;
se0630 = strel('line',10,-.5*angstep);
coefs0630_0 = imopen(abs(coefs0630),se0630);
se0730 = strel('line',10,-1.5*angstep);
coefs0730_0 = imopen(abs(coefs0730),se0730);
se0830 = strel('line',10,-2.5*angstep);
coefs0830_0 = imopen(abs(coefs0830),se0830);
se0930 = strel('line',10,-3.5*angstep);
coefs0930_0 = imopen(abs(coefs0930),se0930);
se1030 = strel('line',10,-4.5*angstep);
coefs1030_0 = imopen(abs(coefs1030),se1030);
se1130 = strel('line',10,-5.5*angstep);
coefs1130_0 = imopen(abs(coefs1130),se1130);

% Record size
[row,col] = size(coefs1130_0);

% Add color
coefs0630_0plot = zeros(row,col,3);
coefs0630_0plot(:,:,1) = max(color0630(1)*double(threshold<coefs0630_0),coefs0630_0plot(:,:,1));
coefs0630_0plot(:,:,2) = max(color0630(2)*double(threshold<coefs0630_0),coefs0630_0plot(:,:,2));
coefs0630_0plot(:,:,3) = max(color0630(3)*double(threshold<coefs0630_0),coefs0630_0plot(:,:,3));
coefs0630_0plot = 1-coefs0630_0plot;
%
coefs0730_0plot = zeros(row,col,3);
coefs0730_0plot(:,:,1) = max(color0730(1)*double(threshold<coefs0730_0),coefs0730_0plot(:,:,1));
coefs0730_0plot(:,:,2) = max(color0730(2)*double(threshold<coefs0730_0),coefs0730_0plot(:,:,2));
coefs0730_0plot(:,:,3) = max(color0730(3)*double(threshold<coefs0730_0),coefs0730_0plot(:,:,3));
coefs0730_0plot = 1-coefs0730_0plot;
%
coefs0830_0plot = zeros(row,col,3);
coefs0830_0plot(:,:,1) = max(color0830(1)*double(threshold<coefs0830_0),coefs0830_0plot(:,:,1));
coefs0830_0plot(:,:,2) = max(color0830(2)*double(threshold<coefs0830_0),coefs0830_0plot(:,:,2));
coefs0830_0plot(:,:,3) = max(color0830(3)*double(threshold<coefs0830_0),coefs0830_0plot(:,:,3));
coefs0830_0plot = 1-coefs0830_0plot;
%
coefs0930_0plot = zeros(row,col,3);
coefs0930_0plot(:,:,1) = max(color0930(1)*double(threshold<coefs0930_0),coefs0930_0plot(:,:,1));
coefs0930_0plot(:,:,2) = max(color0930(2)*double(threshold<coefs0930_0),coefs0930_0plot(:,:,2));
coefs0930_0plot(:,:,3) = max(color0930(3)*double(threshold<coefs0930_0),coefs0930_0plot(:,:,3));
coefs0930_0plot = 1-coefs0930_0plot;
%
coefs1030_0plot = zeros(row,col,3);
coefs1030_0plot(:,:,1) = max(color1030(1)*double(threshold<coefs1030_0),coefs1030_0plot(:,:,1));
coefs1030_0plot(:,:,2) = max(color1030(2)*double(threshold<coefs1030_0),coefs1030_0plot(:,:,2));
coefs1030_0plot(:,:,3) = max(color1030(3)*double(threshold<coefs1030_0),coefs1030_0plot(:,:,3));
coefs1030_0plot = 1-coefs1030_0plot;
%
coefs1130_0plot = zeros(row,col,3);
coefs1130_0plot(:,:,1) = max(color1130(1)*double(threshold<coefs1130_0),coefs1130_0plot(:,:,1));
coefs1130_0plot(:,:,2) = max(color1130(2)*double(threshold<coefs1130_0),coefs1130_0plot(:,:,2));
coefs1130_0plot(:,:,3) = max(color1130(3)*double(threshold<coefs1130_0),coefs1130_0plot(:,:,3));
coefs1130_0plot = 1-coefs1130_0plot;


% Create plot window
figure(2)
clf
subplot(2,3,1)
imshow(uint8(255*coefs0630_0plot))
axis equal
axis off
title('Cleaned Subband 06:30')
subplot(2,3,2)
imshow(uint8(255*coefs0730_0plot))
axis equal
axis off
title('Cleaned Subband 07:30')
subplot(2,3,3)
imshow(uint8(255*coefs0830_0plot))
axis equal
axis off
title('Cleaned Subband 08:30')
subplot(2,3,4)
imshow(uint8(255*coefs0930_0plot))
axis equal
axis off
title('Cleaned Subband 9:30')
subplot(2,3,5)
imshow(uint8(255*coefs1030_0plot))
axis equal
axis off
title('Cleaned Subband 10:30')
subplot(2,3,6)
imshow(uint8(255*coefs1130_0plot))
axis equal
axis off
title('Cleaned Subband 11:30')


%% Show computational singular support

% Compute approximate singular support of original image
singsupp = zeros(row,col,3);
singsupp(:,:,1) = max(color0630(1)*double(threshold<coefs0630_0),singsupp(:,:,1));
singsupp(:,:,1) = max(color0730(1)*double(threshold<coefs0730_0),singsupp(:,:,1));
singsupp(:,:,1) = max(color0830(1)*double(threshold<coefs0830_0),singsupp(:,:,1));
singsupp(:,:,1) = max(color0930(1)*double(threshold<coefs0930_0),singsupp(:,:,1));
singsupp(:,:,1) = max(color1030(1)*double(threshold<coefs1030_0),singsupp(:,:,1));
singsupp(:,:,1) = max(color1130(1)*double(threshold<coefs1130_0),singsupp(:,:,1));
singsupp(:,:,2) = max(color0630(2)*double(threshold<coefs0630_0),singsupp(:,:,2));
singsupp(:,:,2) = max(color0730(2)*double(threshold<coefs0730_0),singsupp(:,:,2));
singsupp(:,:,2) = max(color0830(2)*double(threshold<coefs0830_0),singsupp(:,:,2));
singsupp(:,:,2) = max(color0930(2)*double(threshold<coefs0930_0),singsupp(:,:,2));
singsupp(:,:,2) = max(color1030(2)*double(threshold<coefs1030_0),singsupp(:,:,2));
singsupp(:,:,2) = max(color1130(2)*double(threshold<coefs1130_0),singsupp(:,:,2));
singsupp(:,:,3) = max(color0630(3)*double(threshold<coefs0630_0),singsupp(:,:,3));
singsupp(:,:,3) = max(color0730(3)*double(threshold<coefs0730_0),singsupp(:,:,3));
singsupp(:,:,3) = max(color0830(3)*double(threshold<coefs0830_0),singsupp(:,:,3));
singsupp(:,:,3) = max(color0930(3)*double(threshold<coefs0930_0),singsupp(:,:,3));
singsupp(:,:,3) = max(color1030(3)*double(threshold<coefs1030_0),singsupp(:,:,3));
singsupp(:,:,3) = max(color1130(3)*double(threshold<coefs1130_0),singsupp(:,:,3));
singsupp = 1-singsupp;

figure(3)
subplot(1,2,1)
imshow(uint8(255*im))
axis equal
axis off
title('Image','fontsize',16)
subplot(1,2,2)
imagesc(uint8(255*singsupp))
axis equal
axis off
colormap gray
title('Singular support','fontsize',16)

