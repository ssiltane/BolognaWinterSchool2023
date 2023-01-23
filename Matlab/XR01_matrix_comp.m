% Here we construct a tomographic X-ray measurement model using a sparse 
% matrix A. (This is not very effective numerically, but it is used only 
% for demonstration purposes.) 
%
% Jennifer Mueller and Samuli Siltanen, October 2022

% Construct phantom. You can modify the resolution parameter N.
N      = 128;
target = ones(N);

% Choose measurement angles (given in degrees, not radians). 
Nang    = 20; 
angle0  = -90;
measang = angle0 + [0:(Nang-1)]/Nang*180;

% Initialize measurement matrix of size (M*P) x N^2, where M is the number of
% X-ray directions and P is the number of pixels that Matlab's Radon
% function gives.
P  = length(radon(target,0));
M  = length(measang);
A = sparse(M*P,N^2);

% Construct measurement matrix column by column. The trick is to construct
% targets with elements all 0 except for one element that equals 1.
for mmm = 1:M
    for iii = 1:N^2
        tmpvec                  = zeros(N^2,1);
        tmpvec(iii)             = 1;
        A((mmm-1)*P+(1:P),iii) = radon(reshape(tmpvec,N,N),measang(mmm));
        if mod(iii,100)==0
            disp([mmm, M, iii, N^2])
        end
    end
end

% Test the result
Rtemp = radon(target,measang);
Rtemp = Rtemp(:);
Mtemp = A*target(:);
disp(['If this number is small, then the matrix A is OK: ', num2str(max(max(abs(Mtemp-Rtemp))))]);

% Save the result to file
save data/RadonMatrix A measang N P Nang

% Take a look at the matrix
XR01_matrix_plot


