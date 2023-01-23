% Plot the results of routine XR09_TV_comp.m
%
% Arguments:
% N    resolution of the image is N x N
%
% Samuli Siltanen, October 2022

% Plot parameters
fsize     = 18;
gammacorr = .6;

% Load reconstruction and ground truth
load data/XR05_Tikhonov recn alpha 
load data/sinograms groundtruth 

% Remove negative values in reconstruction
recn_plot = recn;
recn_plot = max(recn_plot,0);

% Plot reconstruction image
figure(1)
clf
plotim = [groundtruth,recn_plot];
plotim = plotim/max(plotim(:));
imagesc(plotim.^gammacorr,[0,1])
colormap gray
axis equal
axis off
relerr = norm((groundtruth(:)-recn(:))/norm(groundtruth(:)));
title(['Tikhonov: relative error ', num2str(round(100*relerr)), '%'],'fontsize',fsize)


