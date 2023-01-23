% This function computes the four parts of the wavelet transformed
% image: LL, HL, LH, HH
%
% Arguments: 
% h       low-pass wavelet filter, horizontal vector
% g       high-pass wavelet filter, horizontal vector
% im      image matrix, size 2^N x 2^N
%
% Returns:
% hsmvsm  horizontally and vertically low-passed part of transform
% hdevsm  horizontally high-passed, vertically low-passed part of transform
% hsmvde  horizontally low-passed, vertically high-passed part of transform
% hdevde  horizontally and vertically high-passed part of transform
%
% Samuli Siltanen July 2016

function [hsmvsm, hdevsm, hsmvde, hdevde] = wavetrans2Donce(h, g, im)

% Make sure that the convolution kernels h and g are horizontal vectors
h = h(:).';
g = g(:).';

% Compute horizontally smooth part of the signal and downsample
hsm = conv2(im,fliplr(h),'same');
hsm = hsm(:,1:2:end);

% Compute vertical details of the horizontally smooth part 
% of the signal and downsample
hsmvde = conv2(hsm,fliplr(g).','same');
hsmvde = hsmvde(1:2:end,:);

% Compute vertically smooth part of the horizontally smooth part 
% of the signal and downsample
hsmvsm = conv2(hsm,fliplr(h).','same');
hsmvsm = hsmvsm(1:2:end,:);

% Compute horizontal details of the signal and downsample
hde = conv2(im,fliplr(g),'same');
hde = hde(:,1:2:end);

% Compute vertical details of the horizontal details
% of the signal and downsample
hdevde = conv2(hde,fliplr(g).','same');
hdevde = hdevde(1:2:end,:);

% Compute vertically smooth part of the horizontal details
% of the signal and downsample
hdevsm = conv2(hde,fliplr(h).','same');
hdevsm = hdevsm(1:2:end,:);



