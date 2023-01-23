% Tomographic reconstruction using Besov B111 regularization
% implemented via wavelets and soft thresholding as described in
% Daubechies, Defrise and De Mol 2004. Use the ISTA iteration
% f{n} = S_mu (f{n-1} + A^T(m - A f{n-1})).
%
% Samuli Siltanen, October 2022

% Graphical parameters
fsize     = 16;
thinline  = 1;
thickline = 2;

% Load the measurement matrix and noisy data from file.
load data/RadonMatrix A measang N 
[Arow,Acol] = size(A);
n = N^2; % Number of pixels in the reconstruction
load data/sinograms mn sino_row sino_col

% Normalize measurement matrix so that its norm is one. Normalize 
% measurement similarly
normA = normest(A);
A = A/normA; 
mn = mn/normA; 

% Number of iterations
Niter = 1500;

% Desired ratio of nonzero wavelet coefficients 
a_priori_sparsity = .04;

% Initial threshold mu used in the transform. The value of mu will change
% dynamically during the iteration
mu = .0005;

% Parameter for the control algorithm
beta = .0001;

% "Landweber iteration" type relaxation factor
omega = .1;

% Convolution kernels for the Daubechies 2 wavelet
% h = [1+sqrt(3) 3+sqrt(3) 3-sqrt(3) 1-sqrt(3)]/(4*sqrt(2));
% g = [h(4)      -h(3)     h(2)      -h(1)];

% Convolution kernels for the Daubechies 1 (Haar) wavelet
h = [ 1 1]/sqrt(2);
g = [-1 1]/sqrt(2);

% Wavelet transform depth
Wdepth = 4;

% Initialize iteration
recn = zeros(N);
sparvec = zeros(1,Niter);

% Perform iteration
for nnn = 1:Niter
    % Update norm vector (Besov space B111 norm)
    tr = wavetrans2D(h,g,recn,Wdepth);
    
    % Forward projection of the current iterate
    Arecn = A*recn(:);
    %Arecn = radon(recn,measang); % Matrix-free option
    
    % Back-projection of the residual
    tmp = (A.')*(mn(:)-Arecn);
    tmp = reshape(tmp,[N,N]);
    %     tmp = iradon(reshape(mn,[sino_row,sino_col]) - reshape(Arecn,[sino_row,sino_col]),measang,'none'); % Matrix-free option
    %     tmp = 2*N/pi*tmp2(2:end-1,2:end-1); % Matrix-free option
    
    % ISTA iteration f{n} = S_mu (f{n-1} + A^T(m - A f{n-1}))
    [recn,nonzero] = Smu_wavelet_oper(h,g,recn+omega*tmp,Wdepth,mu);
    sparvec(nnn) = nonzero;
    
    % Adjust threshold mu dynamically. See
    % Purisha Z, Rimpeläinen J, Bubba T and Siltanen S 2018,
    % Controlled Wavelet Domain Sparsity for X-ray Tomography.
    % Measurement Science and Technology 29(1), 014002.
    % https://arxiv.org/abs/1703.09798
    mu = mu + beta*(nonzero-a_priori_sparsity);
    
    % Monitor the run
    if (mod(nnn,17)==0)|(nnn==Niter)
        figure(20)
        clf
        subplot(1,2,1)
        imagesc(reshape(recn,[N,N]))
        axis square
        axis off
        colormap gray
        subplot(1,2,2)
        plot(sparvec,'linewidth',thickline)
        title('Ratio of nonzero coefficients','fontsize',fsize)
        ylim([0 1])
        set(gca,'xtick',[0:500:Niter],'fontsize',fsize)
        axis square
    end
end

% Save results to disc
save data/XR10_B111 recn omega mu Niter

% Show the result
XR10_B111_plot





