function D=l2distance(X,Z)
% function D=l2distance(X,Z)
%	
% Computes the Euclidean distance matrix. 
% Syntax:
% D=l2distance(X,Z)
% Input:
% X: dxn data matrix with n vectors (columns) of dimensionality d
% Z: dxm data matrix with m vectors (columns) of dimensionality d
%
% Output:
% Matrix D of size nxm 
% D(i,j) is the Euclidean distance of X(:,i) and Z(:,j)
%
% call with only one input:
% l2distance(X)=l2distance(X,X)
%

if (nargin==1) % case when there is only one input (X)
	%% Get X dimensions
    [d, n] = size(X); % number of input vectors in X
    %% Create ones matrix for multiplication
    onesX = ones(n, d);
    %% Calculate euclidian distance    
    D = sqrt(abs(onesX*X'.^2' + X'.^2*onesX' - 2*(X')*X));
else  % case when there are two inputs (X,Z)
	%% Get X and Z dimensions
    [d, n] = size(X); % number of input vectors in X
    [~, m] = size(Z); % number of input vectors in Z
    %% Create ones matrices for multiplication
    onesX = ones(n, d);
    onesZ = ones(d, m);
    %% Calculate euclidian distance
    D = sqrt(abs(onesX*Z'.^2' + X'.^2*onesZ - 2*X'*Z));
    %% This works because (xi - zi)^2 = xi^2 + zi^2 - 2*xi*zi
end;