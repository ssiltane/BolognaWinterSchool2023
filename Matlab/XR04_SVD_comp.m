% Compute the SVD of the matrix A. 
% (This is not very effective numerically, but it is used only 
% for demonstration purposes.) 
%
% Jennifer Mueller and Samuli Siltanen, October 2022


% Load precomputed results 
load data/RadonMatrix A 

% Compute SVD of A using full-matrix algorithms
[U,D,V] = svd(full(A));
svals = diag(D);
D       = sparse(D);

% Save the result to file 
save data/Xtomo_SVD svals
