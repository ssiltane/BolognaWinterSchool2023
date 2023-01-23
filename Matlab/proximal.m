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

function v = proximal(u, alpha, p)
% solves v + alpha*v^(p-1) = u for non-negative u

if (p == 2)
    % case p == 2 is simplest
    v = u/(1+alpha);
    return;
end
if (p < 2)
    % p < 2: requires special initial values
    v = min(u, (u/(alpha*(2-p))).^(1/(p-1))/2);
    for i=1:10
        v = v + (u - v - alpha*v.^(p-1))./(1 + alpha*(p-1)*v.^(p-2));
    end
    return;
end
if (p > 2)
    % p > 2: best guess is neglecting x term
    v = (u/alpha).^(1/(p-1));
    for i=1:10
        v = v + (u - v - alpha*v.^(p-1))./(1 + alpha*(p-1)*v.^(p-2));
    end
    return;
end
end
