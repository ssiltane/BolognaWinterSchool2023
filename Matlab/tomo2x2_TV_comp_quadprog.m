% Reconstruct phantom using TV regularization. For details of computation,
% please see Chapter 6.2 of the book "Linear and nonlinear inverse problems
% with practical applications" by Jennifer Mueller and Samuli Siltanen
% (SIAM 2012).
%
% Samuli Siltanen Oct 2020

% Regularization parameter. You can experiment with different positive real
% values for alpha. Larger alpha means stronger regularization.
alpha = 1;

% Construct the 2x2 pixel image target as a vertical vector of length 4
target = [2;2;6;7];

% Construct the matrix modeling row sums ans column sums of the 2x2 pixel image target
A = [...
    1 0 1 0;...
    0 1 0 1;...
    1 1 0 0;...
    0 0 1 1];

% Construct prior matrices, implementing horizontal (LH) and vertical (LV) 
% differences between neighboring pixels 
LH = [...
    1 0 -1 0;...
    0 1 0 -1];
LV = [...
    1 -1 0 0;...
    0 0 1 -1]; 

% Build an ideal (non-noisy) right-hand side
rhs = A*target;

% Record the size of the unknown. Here M*M=n, since the unknown is a MxM
% pixel image.
n = 4;
M = 2;    

% Construct the quadratic optimization problem matrix
H = zeros(n+4*M*(M-1));
H(1:n,1:n) = 2*A.'*A;

% Construct the vector h of the linear term
h = alpha*ones(n+4*M*(M-1),1);
h(1:n) = -2*(A.')*rhs(:);

% Construct input arguments for quadprog.m
Aeq         = [...
    [LH,-eye(M*(M-1)),eye(M*(M-1)),zeros(M*(M-1)),zeros(M*(M-1))];...
    [LV,zeros(M*(M-1)),zeros(M*(M-1)),-eye(M*(M-1)),eye(M*(M-1))]];
beq         = zeros(2*M*(M-1),1);
lb          = zeros(n+4*M*(M-1),1);
ub          = Inf(5*n,1);
AA          = -eye(n+4*M*(M-1));
AA(1:n,1:n) = zeros(n,n);
iniguess    = zeros(n+4*M*(M-1),1);
b           = [repmat(10,n,1);zeros(4*M*(M-1),1)];
QPopt   = optimset('quadprog');
QPopt   = optimset(QPopt,'Algorithm','interior-point-convex','Display','iter');

% Compute reconstruction using quadprog
[uvv,val,ef,output] = quadprog(H,h,AA,b,Aeq,beq,lb,ub,iniguess,QPopt);

% Pick out the reconstructed image
recn = uvv(1:n);

disp(reshape(recn,M,M))

disp(['TV: Data penalty ', num2str(norm(A*recn-rhs))])

disp(reshape(recn,M,M))

disp(['TV: Data penalty ', num2str(norm(A*recn-rhs))])
% disp(['TV: Prior penalty ',num2str(...
%     abs(recn(1)-recn(3))+...
%     abs(recn(2)-recn(4))+...
%     abs(recn(1)-recn(2))+...
%     abs(recn(3)-recn(4)))]) 
disp(['TV: Prior penalty ',num2str(sum(abs(LH*recn))+sum(abs(LV*recn)))]) 
 
recn2 = [2.25;2.25;6.25;6.25];

disp(['TV: Data penalty ', num2str(norm(A*recn2-rhs))])
% disp(['TV: Prior penalty ',num2str(...
%     abs(recn2(1)-recn2(3))+...
%     abs(recn2(2)-recn2(4))+...
%     abs(recn2(1)-recn2(2))+...
%     abs(recn2(3)-recn2(4)))]) 
disp(['TV: Prior penalty ',num2str(sum(abs(LH*recn2))+sum(abs(LV*recn2)))]) 


% uHp2 = max(0,LH*recn2);
% uHm2 = max(0,-LH*recn2);
% uVp2 = max(0,LV*recn2);
% uVm2 = max(0,-LV*recn2);
% uvv2 = [recn2(:);uHp2;uHm2;uVp2;uVm2];
% 
% disp([uvv(:).';uvv2(:).'])
% 
% .5*(uvv.')*H*uvv + (h.')*uvv
% .5*(uvv2.')*H*uvv2 + (h.')*uvv2
% 
% Aeq*uvv
% Aeq*uvv2