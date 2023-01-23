% Plot results of XR03_naive_comp.m
%
% Jennifer Mueller and Samuli Siltanen, October 2022

% Graphical parameters
fsize = 20;

% Load precomputed data
load data/sinograms groundtruth
load  data/naiverecon naive_recon relerr

% Take a look at the results
figure(3000)
clf
imagesc([groundtruth,naive_recon],[min(groundtruth(:)),max(groundtruth(:))])
axis equal
axis off
title(['Relative error (with inverse crime): ',num2str(100*relerr),'%'],'fontsize',fsize)

