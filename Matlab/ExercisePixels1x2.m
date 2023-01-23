% The 1x2 pixel problem
%
% Bologna Winter School Crowd Group Effort 2023

% Here h should be between 0 and 1/2
h_vec = [.001:.001:.4];

% Construct the matrix
%A = [[1 1];[sqrt(5)/2 sqrt(5/4-5*h+5*h^2)]]
det_A_vec = zeros(size(h_vec));
cond_A_vec = zeros(size(h_vec));
for iii = 1:length(h_vec)
    h = h_vec(iii);
    A = [[1 1];[sqrt(5)/2 sqrt(5)/2-sqrt(5)*h]];
    det_A_vec(iii) = det(A);
    cond_A_vec(iii) = cond(A);
end

% Take a look
figure(1)
clf
plot(h_vec,det_A_vec)
figure(2)
clf
plot(h_vec,cond_A_vec,'linewidth',3)

