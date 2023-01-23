% Computational test for the minimum of the 2x2 pixel tomography problem
% with TV penalty. Brute-force style approach.
%
% Samuli Siltanen Oct 2021

% Choose number of random samples
N = 400000000;

% Initialize result
value = 100000;

% Loop over samples
for jjj = 1:N
    
    % Evaluate variables
    x1 = 1+6*rand;
    x2 = 1+6*rand;
    x3 = 1+6*rand;
    x4 = 1+6*rand;
    
    % Data fidelity penalty
    DF = (x1+x3-8)^2 + (x2+x4-9)^2 + (x1+x2-4)^2 + (x3+x4-13)^2;
    
    % Total variation penalty
    TV = abs(x1-x3) + abs(x2-x4) + abs(x1-x2) + abs(x3-x4);
    
    % Record total penalty to fifth column
    curr_value = DF+TV;
    
    % Update the results
    if curr_value < value
        value = curr_value;
        x1res = x1;
        x2res = x2;
        x3res = x3;
        x4res = x4;
    end
    % Monitor the run
    if mod(jjj,1000000)==0
        disp([jjj N])
    end
end


% Report the results
disp('Minimizing point is')
disp(['x1=',num2str(x1res)])
disp(['x2=',num2str(x2res)])
disp(['x3=',num2str(x3res)])
disp(['x4=',num2str(x4res)])
disp('')
disp(['Minimizing value is ',num2str(value)])