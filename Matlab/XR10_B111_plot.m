% Plot the results of routine XR10_B111_comp.m
%
% Samuli Siltanen, October 2022

% Plot parameters
fsize     = 18;
gammacorr = .6;

% Load reconstruction and ground truth
load data/XR10_B111 recn omega mu Niter 
load data/sinograms groundtruth 

% Plot reconstruction image
figure(1)
clf
plotim = [groundtruth,recn];
plotim = max(0,plotim);
imagesc(plotim.^gammacorr,[0,1])
colormap gray
axis equal
axis off
relerr = norm((groundtruth(:)-recn(:))/norm(groundtruth(:)));
title(['B111 regularization: relative error ', num2str(round(100*relerr)), '%'],'fontsize',fsize)

