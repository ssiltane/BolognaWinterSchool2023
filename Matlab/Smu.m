% Soft thresholding function S_mu:R->R defined by
%
% S_mu(x) = x+mu/2   if  x  <= -mu/2,
% S_mu(x) = 0        if |x| <   mu/2,
% S_mu(x) = x-mu/2   if  x  >=  mu/2,
%
% where mu is a positive constant.
%
% The formula for S_mu is taken from (1.5) in the reference 
% [Daubechies, Defrise and De Mol 2004] Communications on Pure and Applied 
% Mathematics, Vol. LVII, 1413-1457 (2004)
%
% Arguments:
% x         matrix whose elements are to be softly thresholded
% mu        threshold, a positive real number
%
% Returns:
% res       softly thresholded matrix
% nonzero  ratio of elements *not* put to zero (real number between 0 and 1)
% 
% Samuli Siltanen July 2016

function [res,nonzero] = Smu(x,mu)

% Initialize the result
res = zeros(size(x));

% Insert the values corresponding to |x| being greater than mu/2.
indneg = (x  <= -mu/2);
indpos = (x  >=  mu/2);
res(indneg) = x(indneg)+mu/2;
res(indpos) = x(indpos)-mu/2;

% Determine the ratio of elements in x that were replaced by zero
nonzero = (length(find(indneg))+length(find(indpos)))/length(x(:));