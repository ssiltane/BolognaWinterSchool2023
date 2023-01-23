% primal/dual tomography (originally deconvolution) algorithm with total variation
%
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
%
% Modification for tomography by
% Samuli Siltanen (samuli.siltanen@helsinki.fi) August 2016

function u = tomo_tv(m, A, q_exp, lambda, maxits, fignum)
    q_exp_dual = q_exp/(q_exp - 1);
        
% Size of tomographic image is N^2
N = sqrt(size(A,2)); 

u   = zeros(N); 
u_  = u;
v   = zeros(size(m));
px  = zeros(N);
py  = zeros(N);

    % Lipschitz parameter and step length
    L2 = 8;
    sigma = 1/sqrt(L2);
    tau = 1/sqrt(L2);
    
    for k=1:maxits
        % ascend step for v
        v = v + sigma*(reshape(A*u(:),size(m)) - m);
        vabs = abs(v);
        vabsnew = proximal(vabs, sigma, q_exp_dual);
        I = vabs > 0;
        v(I) = v(I)./vabs(I).*vabsnew(I);
       
        % ascend step for p
        ux = dxp(u_);
        uy = dyp(u_);
        
        px = px + sigma*ux;
        py = py + sigma*uy;
        
        % proximal mapping w.r.t. p^*-norm
        pabsm = max(1, sqrt(px.^2 + py.^2)/lambda);
        px = px./pabsm;
        py = py./pabsm;
        
        % descend step
        uold = u;
        adjoint = reshape(A.'*v(:),N,N);
        div = dxm_ad(px) + dym_ad(py);
        
        u = u - tau*(adjoint - div);
        u = max(0,u);

        % leading point
        u_ = 2*u - uold;
        
    if (mod(k,50) == 1)
        figure(fignum);
        imagesc(u); 
        colormap gray(256);
        title(['Iteration ',num2str(k), ' out of ', num2str(maxits)])
        axis square;
        drawnow;
        end
    end 
end
