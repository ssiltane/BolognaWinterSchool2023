% Plot the results of XR04_SVD_comp.m.
%
% Jennifer Mueller and Samuli Siltanen, October 2022


% Plot parameters
msize  = 8;
lwidth = 3;
fsize  = 20;

% Load precomputed results. 
load data/Xtomo_SVD svals
load data/RadonMatrix A 

% Show nonzero elements of the measurement matrix
figure(1)
clf
spy(A)
axis equal
[row,col] = size(A);
axis([1 col 1 row])
set(gca,'xtick',[1 round(col/2) col],'fontsize',fsize)
set(gca,'ytick',[1 round(row/4) round(row/2) round(3*row/4) row],'fontsize',fsize)
title('Nonzero elements of the measurement matrix A','fontsize',fsize)
axis square

% Plot singular values of A on a logarithmic scale
figure(3)
clf
semilogy(svals,'r','linewidth',lwidth)
xlim([1 length(svals)])
set(gca,'xtick',[500:500:col],'fontsize',fsize)
title('Singular values of A','fontsize',fsize)

