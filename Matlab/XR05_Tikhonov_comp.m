% Example computations related to X-ray tomography. Here we apply Tikhonov 
% regularization and solve the normal equations using the conjugate 
% gradient method. The approach uses sparse matrix A and is much more
% efficient computationally than the singular value decomposition approach.
%
% Jennifer Mueller and Samuli Siltanen, October 2022

% Load the measurement matrix and noisy data from file.
load data/RadonMatrix A measang N P Nang
load data/sinograms   mn 

% Choose regularization parameter
alpha = 50;

% Maximum number of iterations
MAXITER = 3000;               


% Construct system matrix and first-order term for the minimization problem
%         min (x^T H x - 2 b^T x), 
% where 
%         H = A^T A + alpha*I
% and 
%         b = A^T mn.
% The positive constant alpha is the regularization parameter.o
b     = A.'*mn(:);

% Solve the minimization problem using conjugate gradient method.
% See Kelley: "Iterative Methods for Optimization", SIAM 1999, page 7.
x   = b;          % initial iterate is the backprojected data
rho = zeros(MAXITER,1); % initialize parameters
% Compute residual using sparse matrices. NOTE CAREFULLY: it is important
% to write (A.')*(A*x) on the next line instead of ((A.')*A)*x, 
% because (A.')*A may be a full matrix and in that case we lose 
% the advantage of the iterative solution method!
Hx     = (A.')*(A*x) + alpha*x; 
r      = b-Hx;
rho(1) = r.'*r;
% Start iteration
for kkk = 1:MAXITER
    if kkk==1
        p = r;
    else
        beta = rho(kkk)/rho(kkk-1);
        p    = r + beta*p;
    end
    w          = (A.')*(A*p) + alpha*p;
    a          = rho(kkk)/(p.'*w);
    x          = x + a*p;
    r          = r - a*w;
    rho(kkk+1) = r.'*r;
    if mod(kkk,100)==0
        disp([kkk MAXITER])
    end
end
recn = reshape(x,N,N);

% Compute relative errors
% err_sup = max(max(abs(target-recn)))/max(max(abs(target)));
% err_squ = norm(target(:)-recn(:))/norm(target(:));

% Save results to disc
save data/XR05_Tikhonov recn alpha MAXITER

% View the results
XR05_Tikhonov_plot