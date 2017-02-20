function [indices, dists] = findknn(xTr, xTe, k)
% function [indices,dists]=findknn(xTr,xTe,k);
%
% Finds the k nearest neighbors of xTe in xTr.
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with n column-vectors of dimensionality d
% k = number of nearest neighbors to be found
% 
% Output:
% indices = kxm matrix, where indices(i,j) is the i^th nearest neighbor of xTe(:,j)
% dists = Euclidean distances to the respective nearest neighbors
%

%% Get sizes of input matrices
[~, ntr] = size(xTr);
%% Make sure k <= number of training examples
if k > ntr
    k = ntr;
end
%% Sort distances and keep only k smaller distances
[d, i] = sort(l2distance(xTr, xTe));
dists = d(1:k, :);
indices = i(1:k, :);

end