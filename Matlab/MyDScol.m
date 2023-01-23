% Downsample the columns of a matrix.
% We assume that the input matrix has
% an even number of rows.
%
% Samuli Siltanen November 2014

function result = MyDScol(A)

% Check that A has an even number of rows
if mod(size(A,1),2)==1
    error('A should have an even number of rows')
end

% Record the size of A
[row,col] = size(A);

% Reshape A to a form with two rows
A2 = reshape(A,2,col*row/2);

% Take mean of each column
B = mean(A2);

% Collect the result in a matrix of appropriate size
result = reshape(B,row/2,col);