% Truncated SVD as a regularized inversion method
%
% Samuli Siltanen January 2023

% Plot parameters
fsize      = 30;
smallfsize = 20;
msize      = 8;
lwidth     = 2;
thinline   = 1;
gammacorr = .5;

% Load the phantom and its size parameter
load data/thephantom N target

% Load number of measurement angles
load data/theangles Nang

% Load precomputed SVD
eval(['load data/BunnyTomo2_SVD', num2str(N), '_', num2str(Nang), ' U D V A measang_deg target N P Nang']);
svals1 = full(diag(D));
[row,col] = size(A);

% Record singular values in a vector
svals1 = full(diag(D));

% Simulate data (with inverse crime!)
m = A*target(:);

% Add noise to data
noise_amplitude = 0.05*max(abs(m));
mn = m + noise_amplitude*randn(size(m));

% Demonstration of inversion by truncated SVD
Ns = 10; % How many singular vectors to use

% Reconstruct from noisy data
[row,col]        = size(D.');
Dplus            = sparse(row,col);
svals            = diag(D);
Dplus(1:Ns,1:Ns) = diag(1./svals(1:Ns));
recn             = V*Dplus*U.'*mn(:);
recn             = reshape(recn,N,N);
relerr           = round(norm(recn(:)-target(:))/norm(target(:))*100);

disp([Ns relerr])

% Take a look at the reconstruction
recn = max(recn,0);
recn = recn/max(recn(:));
figure(2)
clf
imagesc(recn.^gammacorr,[0,1])
colormap gray
axis square
axis off
text(54,27,[num2str(relerr),'%'],'fontsize',fsize)
title('Reconstruction')

% Take a look at the singular vector
figure(3)
clf
imagesc(reshape(V(:,Ns),N,N))
colormap gray
axis square
axis off
title('The last singular vector used')


% Show true target
target = target-min(target(:));
target = target/max(target(:));
figure(4)
clf
imagesc(target.^gammacorr,[0,1])
colormap gray
axis square
axis off
title('Ground truth')


