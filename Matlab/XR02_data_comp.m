% Here we construct a tomographic X-ray measurement model using a sparse 
% matrix A. (This is not very effective numerically, but it is used only 
% for demonstration purposes.) 
%
% Jennifer Mueller and Samuli Siltanen, October 2022


% Load matrix and parameters
load data/RadonMatrix A measang N P Nang

% Measurement WITH inverse crime
groundtruth = imread('pics/PlayDohPhantom_128.png','png');
groundtruth = double(groundtruth);
groundtruth = groundtruth/max(max(groundtruth));
m_IC = A*groundtruth(:);

% Measurement WITHOUT inverse crime, containing some (simulated) modeling
% error and random noise. The modeling error is implemented by 
% (a) rotating the image by an angle so weird that it will not be part of 
%     the tomographic measurement geometry,
% (b) measuring tomographic data using radon.m and projection angles equal
%     to the original angles plus the weird angle,
% (c) interpreting the sinogram from (b) to be a distorted sinogram that
%     includes modelling error caused by approximations from the image 
%     rotation
strange_angle = 10*exp(1)*sqrt(3)/pi;
groundtruth_rot = imrotate(groundtruth,strange_angle,'crop');
sinogram = radon(groundtruth_rot,measang+strange_angle);
[sino_row,sino_col] = size(sinogram);
m = sinogram(:);

% Add noise
% noise_amplitude = 0.01;
% mn = m + noise_amplitude*max(m(:))*randn(size(m));
empty_space_photon_count = 7000; 
sinoMAX = max(sinogram(:));
measurement = empty_space_photon_count * exp(-sinogram/sinoMAX);
approximate_Poisson_noise = sqrt((measurement)).*randn(size(measurement));
mn = log(empty_space_photon_count)-log(measurement+approximate_Poisson_noise);
mn = max(0,mn);
mn = sinoMAX*mn;
% figure(101)
% imshow([sinogram,mn,abs(sinogram-mn)], []);
% axis square

% Save reaults to disc
save data/sinograms m_IC empty_space_photon_count m mn strange_angle groundtruth groundtruth_rot sino_row sino_col

% Take a look
XR02_data_plot