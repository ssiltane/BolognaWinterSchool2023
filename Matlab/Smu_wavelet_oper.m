% Soft thresholding operator defined by these three steps:
%
% (1) wavelet transform the input image
% (2) soft-threshold the wavelet coefficients using Smu.m
% (3) inverse wavelet transform
%
% The operation is defined in the reference 
% [Daubechies, Defrise and De Mol 2004] Communications on Pure and Applied 
% Mathematics, Vol. LVII, 1413-1457 (2004)
%
% Arguments:
% h       low-pass wavelet filter, horizontal vector
% g       high-pass wavelet filter, horizontal vector
% im      image, a real-valued MxN square matrix
% D       number of scales used; M and N must both be divisible by 2^D
% mu      threshold, a positive real number
%
% Returns:
% res       softly wavelet-thresholded image
% nonzero  ratio of coefficients *not* put to zero (real number between 0 and 1)
% 
% Samuli Siltanen July 2016

function [res,nonzero] = Smu_wavelet_oper(h,g,im,D,mu)

% Wavelet transform
tr = wavetrans2D(h,g,im,D);

% Soft threshold the wavelet coefficients
[tr,nonzero] = Smu(tr,mu);

% Inverse wavelet transform
res = wavetrans2D_inv(h,g,tr,D);



