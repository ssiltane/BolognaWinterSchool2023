% Plot the results of BunnyTomo2_SVD_comp.m.
%
% Arguments:
% N    resolution of the image is N x N
% Nang   number of tomographic measurement directions
%
% Samuli Siltanen January 2023

% Load the phantom size parameter 
load data/thephantom N 

% Load measurement angles 
load data/theangles Nang 

% Plot parameters
msize  = 8;
fsize  = 20;
lwidth = 3;
smallfsize  = 14;
largefsize  = 22;

% Load precomputed results. 
eval(['load data/BunnyTomo2_SVD', num2str(N), '_', num2str(Nang), ' U D V A measang_deg target N P Nang']);
svals1 = full(diag(D));
[row,col] = size(A);

% Show nonzero elements of the measurement matrix
figure(1)
clf
spy(A)
axis equal
axis([1 col 1 row])
set(gca,'xtick',[1 round(col/2) col],'fontsize',fsize)
set(gca,'ytick',[1 round(row/4) round(row/2) round(3*row/4) row],'fontsize',fsize)
xlabel([])


% Plot singular values of A on a logarithmic scale
figure(3)
clf
semilogy(svals1,'r','linewidth',lwidth)
axis([1 min(row,col) svals1(end) svals1(1)])
set(gca,'plotboxaspectratio',[1 1.5 1]);
set(gca,'xtick',[1 50 100 min(row,col)],'fontsize',fsize)
set(gca,'ytick',10.^[-16:2:0],'fontsize',fsize)


