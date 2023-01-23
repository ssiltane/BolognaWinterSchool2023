% This function recovers an image from the four parts of the one-step
% wavelet transform components: LL, HL, LH, HH. This operation is the
% inverse of that implementedin the routine wavetrans2Donce.m.
%
% Arguments:
% h       low-pass wavelet filter
% g       high-pass wavelet filter
% hsmvsm  horizontally and vertically low-passed part of transform
% hdevsm  horizontally high-passed, vertically low-passed part of transform
% hsmvde  horizontally low-passed, vertically high-passed part of transform
% hdevde  horizontally and vertically high-passed part of transform
%
% Returns:
% im      image matrix
%
% Samuli Siltanen July 2016

function im = wavetrans2Donce_inv(h, g, hsmvsm, hdevsm, hsmvde, hdevde)

% Make sure that the convolution kernels h and g are horizontal vectors
h = h(:).';
g = g(:).';

% Record the size of the problem
[row,col] = size(hsmvsm);

% Recover hsm from hsmvsm and hsmvde using upsampling and convolution
hsmvsm2            = zeros(2*row,col);
hsmvsm2(2:2:end,:) = hsmvsm;
hsmvsm2            = conv2(hsmvsm2,h.','same');
hsmvde2            = zeros(2*row,col);
hsmvde2(2:2:end,:) = hsmvde;
hsmvde2            = conv2(hsmvde2,g.','same');
hsm2               = hsmvsm2 + hsmvde2;

% Recover hde from hdevsm and hdevde using upsampling and convolution
hdevsm2            = zeros(2*row,col);
hdevsm2(2:2:end,:) = hdevsm;
hdevsm2            = conv2(hdevsm2,h.','same');
hdevde2            = zeros(2*row,col);
hdevde2(2:2:end,:) = hdevde;
hdevde2            = conv2(hdevde2,g.','same');
hde2               = hdevsm2 + hdevde2;

% Recover s from hsm and hde using upsampling and convolution
sm            = zeros(2*row,2*col);
sm(:,2:2:end) = hsm2;
sm            = conv2(sm,h,'same');
de            = zeros(2*row,2*col);
de(:,2:2:end) = hde2;
de            = conv2(de,g,'same');
im            = sm + de;
