% Compute discrete inverse wavelet transform of an image.
%
% Boundaries are taken into account simply by zero extension, leading to
% artefacts near the boundaries.
%
% This routine is the inverse of wavetrans2D.m.
%
% Arguments:
% h       low-pass wavelet filter, horizontal vector
% g       high-pass wavelet filter, horizontal vector
% tr_im   transform image such as constructed by wavetrans2D.m
% D       number of scales used; M and N must both be divisible by 2^D
%
% Returns:
% im      image resulting from the inverse wavelet transform
%
% Calls to: wavetrans2Donce_inv.m
%
% Samuli Siltanen June 2016

function im = wavetrans2D_inv(h,g,tr_im,D)

% Make sure that the convolution kernels h and g are horizontal vectors
h = h(:).';
g = g(:).';

% Record image size and perform checks
tmp = size(tr_im);
row = tmp(1);
col = tmp(2);
if length(tmp)>2
    error('Error: Input transform image "tr_im" is not monochromatic')
end
if (mod(col,2^D)>0) | (mod(row,2^D)>0)
    error('Error: Transform image size is not divisible by 2^D')
end

% Loop over transformation levels (scales)
im = tr_im;
for ddd = D:-1:1
    
    % Calculate transform image at current scale
    cur_tr = im(1:row/2^(ddd-1), 1:col/2^(ddd-1));
    
    % Extract the four transform components at current scale
    hsmvsm = cur_tr(1:end/2,1:end/2);
    hdevsm = cur_tr((end/2+1):end,1:end/2);
    hsmvde = cur_tr(1:end/2,(end/2+1):end);
    hdevde = cur_tr((end/2+1):end,(end/2+1):end);
    
    
    % Perform the one-step inverse transform at the current scale
    im(1:row/2^(ddd-1), 1:col/2^(ddd-1)) =...
        wavetrans2Donce_inv(h, g, hsmvsm, hdevsm, hsmvde, hdevde);
   
end


