% Here we construct a tomographic X-ray measurement model using a sparse 
% matrix A. (This is not very effective numerically, but it is used only 
% for demonstration purposes.) 
%
% Samuli Siltanen January 2023

% Build and save phantom
N = 12;
target = double(imread('data/BunnyPhantomD_12.png'));
target = target/max(target(:));
save data/thephantom N target

% Select and save rotation angles (both in degrees and in radians)
% for the image
Nang        = 11;  % Number of angles
measang_deg = -90+([0:(Nang-1)]/Nang)*360;
measang_rad = (measang_deg/360)*2*pi;
save data/theangles Nang measang_rad measang_deg
rotangs = measang_rad;

% Initialize measurement matrix of size (Nang*P) x N^2, where Nang is the number of
% X-ray directions and P is the number of pixels that Matlab's Radon
% function gives.
P  = length(radon(target,0));
A = sparse(Nang*P,N^2);

% Construct measurement matrix column by column. The trick is to construct
% targets with elements all 0 except for one element that equals 1.
for mmm = 1:Nang
    for iii = 1:N^2
        tmpvec                  = zeros(N^2,1);
        tmpvec(iii)             = 1;
        A((mmm-1)*P+(1:P),iii) = radon(reshape(tmpvec,N,N),measang_deg(mmm));
        if mod(iii,100)==0
            disp([mmm, Nang, iii, N^2])
        end
    end
end

% Test the result
Rtemp = radon(target,measang_deg);
Rtemp = Rtemp(:);
Mtemp = A*target(:);
disp(['If this number is small, then the matrix A is OK: ', num2str(max(max(abs(Mtemp-Rtemp))))]);

% Save the result to file (with filename containing the resolution N)
eval(['save data/RadonMatrix_', num2str(N), '_', num2str(Nang), ' A measang_deg target N P Nang']);


