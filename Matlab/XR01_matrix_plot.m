% Here we construct a tomographic X-ray measurement model using a sparse 
% matrix A. (This is not very effective numerically, but it is used only 
% for demonstration purposes.) 
%
% Jennifer Mueller and Samuli Siltanen, October 2022

% Graphical parameters
fsize = 20;

% Load the matrix
load data/RadonMatrix A measang N P Nang

% Show nonzero elements in matrix A
figure(1000)
clf
spy(A)
set(gca,'xtick',[2000:2000:size(A,2)],'fontsize',fsize)