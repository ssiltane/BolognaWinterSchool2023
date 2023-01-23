% Plot the results of routine XR02_data_comp.m 
%
% Jennifer Mueller and Samuli Siltanen, October 2022

% Graphical parameters
fsize = 20;

% Load precomputed data
load data/sinograms m_IC noise_amplitude m mn strange_angle groundtruth groundtruth_rot  sino_row sino_col
load data/RadonMatrix  measang 

% Take a look at the results
figure(100)
clf
imagesc([groundtruth,groundtruth_rot,abs(groundtruth-imrotate(groundtruth_rot,-strange_angle,'crop'))])
axis equal
axis off
title('Left: original, middle: rotated, right: abs difference after rotating back','fontsize',fsize)

figure(101)
clf
sinogram1 = reshape(m,[sino_row,sino_col]);
sinogram_IC = radon(groundtruth,measang);
sino_err = abs([sinogram_IC-sinogram1]);
imagesc([sinogram_IC,sinogram1,sino_err])
title(['Relative difference caused by modelling error only: ',num2str(100*norm(sino_err(:))/norm(sinogram_IC(:))),'%'],'fontsize',fsize)

figure(102)
clf
sinogram2 = reshape(mn,[sino_row,sino_col]);
sinogram_IC = radon(groundtruth,measang);
sino_err = abs([sinogram_IC-sinogram2]);
imagesc([sinogram_IC,sinogram2,sino_err])
title(['Relative difference by modelling error and noise: ',num2str(100*norm(sino_err(:))/norm(sinogram_IC(:))),'%'],'fontsize',fsize)