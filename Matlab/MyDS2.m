% Downsample a matrix (2x2 into one).
% We assume that the input matrix has
% an even number of rows and columns.
%
% Samuli Siltanen November 2014

function result = MyDS2(A)

% Record the size of A
[row,col] = size(A);

% Check that A has an even number of rows
if (mod(row,2)==1)|(mod(col,2)==1)
    error('A should have an even number of rows and columns')
end

% Downsample the columns
result = MyDScol(A);

% Downsample the rows using transpose
result = MyDScol(result.');
result = result.';