% Here we compute the SVD of the sparse tomographic measurement matrix A 
% using full matrix algorithms. This is not very efficient coding, and it 
% is done only for educational purposes.
%
% Samuli Siltanen January 2023

% Load the phantom and its size parameter 
load data/thephantom N target

% Load measurement angles 
load data/theangles Nang measang_deg

% Load precomputed results
eval(['load data/RadonMatrix_', num2str(N), '_', num2str(Nang), ' A measang_deg target N P Nang']);

% Compute SVD of A using full matrix algorithms
[U,D,V] = svd(full(A));
D       = sparse(D);

% Save the result to file (with filename containing the resolution N)
eval(['save data/BunnyTomo2_SVD', num2str(N), '_', num2str(Nang), ' U D V A measang_deg target N P Nang']);

% View the results
BunnyTomo2_SVD_plot
