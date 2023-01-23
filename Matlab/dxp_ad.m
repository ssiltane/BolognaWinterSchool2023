% Copyright (c) 2012 Kristian Bredies
%
%   kristian.bredies@uni-graz.at
%
% If you use parts of this code, please cite:
%
% Kristian Bredies. Recovering piecewise smooth multichannel
% images by minimization of convex functionals with total
% generalized variation penalty. Lecture Notes in Computer
% Science, 8293:44-77, 2014.

function [dx] = dxp_ad(u)
[M N] = size(u);
dx = [u(:,2:end) zeros(M,1)] - [zeros(M,1) u(:,2:end)];
end