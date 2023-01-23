% Demonstration code for total generalized variation (TGV) tomography
%
% Copyright (c) 2012 Kristian Bredies
%
%   kristian.bredies@uni-graz.at
%
% If you use parts of this code, please cite:
%
% Kristian Bredies. Recovering piecewise smooth multichannel
% images by minimization of convex functionals with total
% generalized variation penalty. Lecture Notes in Computer
% Science, 8293:44-77, 2014.
%
% Adapted to tomography by Samuli Siltanen, August 2016
% Further modified by Samuli Siltanen, October 2022

clear all;
close all;

% Load the measurement matrix and noisy data from file.
load data/RadonMatrix A measang N P Nang
load data/sinograms   mn 

% Normalize measurement matrix so that its norm is one. Normalize 
% measurement similarly
normA = normest(A);
A = A/normA; 
m = mn/normA; % 
disp('Data loaded')

% TV reconstruction

% Maximum number of iterations
max_iter = 8000;

% Regularization parameter
alpha = 0.002;   % 1e-4

% Reconstruct using total generalized variation
recn = tomo_tv(m, A, 2, alpha, max_iter, 1);

% Save results to disc
save data/XR09_TV recn alpha max_iter

% Show the result
XR09_TV_plot





