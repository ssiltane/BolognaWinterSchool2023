% Example computations related to X-ray tomography. For demonstration,
% we compute naive inversion of the Play-Doh phantom from non-noisy
% data *containing inverse crime*.
%
% Note: Routines XR01_matrix_comp.m and XR02_data_comp.m must be computed 
% before this file.
%
% Jennifer Mueller and Samuli Siltanen, October 2022

load data/RadonMatrix A measang N P Nang
load data/sinograms m_IC  m mn strange_angle groundtruth groundtruth_rot sino_row sino_col

% Naive reconstruction from inverse-crime data. We use Matlab's operator
% '\' that provides a least-squares solution of a matrix equation.
naive_recon = A\m_IC(:);
naive_recon = reshape(naive_recon,N,N);
relerr      = norm(naive_recon(:)-groundtruth(:))/norm(groundtruth(:));
disp(['Relative error (ideal data): ',num2str(100*relerr),'%'])

% Save results to file
save data/naiverecon naive_recon relerr

% Take a look
XR03_naive_plot