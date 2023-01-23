% Compute discrete wavelet transform of an image.
%
% Boundaries are taken into account simply by zero extension, leading to
% artefacts near the boundaries.
%
% Arguments:
% h       low-pass wavelet filter, horizontal vector
% g       high-pass wavelet filter, horizontal vector
% im      image, a real-valued MxN square matrix
% D       number of scales used; M and N must both be divisible by 2^D
%
% Returns:
% tr   wavelet coefficients as a transformed image of size NxN
%
% Calls to: wavetrans2Donce.m
%
% Samuli Siltanen June 2016

function tr = wavetrans2D(h,g,im,D)

% Make sure that the convolution kernels h and g are horizontal vectors
h = h(:).';
g = g(:).';

% Record image size and perform checks
tmp = size(im);
row = tmp(1);
col = tmp(2);
if length(tmp)>2
    error('Error: Input image "im" is not monochromatic')
end
if (mod(col,2^D)>0) | (mod(row,2^D)>0)
    error('Error: Image size is not divisible by 2^D')
end

% Initialize transform image
tr = zeros(size(im));

% Loop over transformation levels (scales)
tmpim = im;
for ddd = 1:D
    
    % Form the one-step transform image at the current scale
    [hsmvsm, hdevsm, hsmvde, hdevde] = wavetrans2Donce(h, g, tmpim);
    tmptr = zeros(row/2^(ddd-1),col/2^(ddd-1));
    tmptr(1:end/2,1:end/2) = hsmvsm;
    tmptr((end/2+1):end,1:end/2) = hdevsm;
    tmptr(1:end/2,(end/2+1):end) = hsmvde;
    tmptr((end/2+1):end,(end/2+1):end) = hdevde;
    
    % Update the transform image
    tr(1:row/2^(ddd-1), 1:col/2^(ddd-1)) = tmptr;
    
    % Denote now recursively the low-passed quadrant as tmpim
    tmpim = hsmvsm;
end


