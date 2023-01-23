% Plot the results of routine XR09_TV_comp.m
%
% Samuli Siltanen, October 2022

% Plot parameters
fsize     = 18;
gammacorr = .6;

% Load reconstruction and ground truth
load data/XR09_TV recn alpha max_iter
load data/sinograms groundtruth 

% Plot reconstruction image
figure(1)
clf
imagesc([groundtruth,recn].^gammacorr,[0,1])
colormap gray
axis equal
axis off
relerr = norm((groundtruth(:)-recn(:))/norm(groundtruth(:)));
title(['TV: relative error ', num2str(round(100*relerr)), '%'],'fontsize',fsize)

% % Show the result
% figure
% clf
% plotim = scale01(recn);
% plotim = plotim.^(.7); % gamma correction for image shades
% imagesc(plotim)
% axis equal
% axis off
% colormap(gray(256)) 
