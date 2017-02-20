function BDT = boosttree(X, y, nt, maxdepth)
% function BDT=boosttree(x,y,nt,maxdepth)
%
% Learns a boosted decision tree on data X with labels y.
% It performs at most nt boosting iterations. Each decision tree has maximum depth "maxdepth".
%
% INPUT:
% X  | input vectors dxn
% y  | input labels 1xn
% nt | number of trees (default = 100)
% maxdepth | depth of each tree (default = 3)
%
% OUTPUT:
% BDT | Boosted DTree
%

if nargin < 3
    nt = 100;
end
if nargin < 4
    maxdepth = 3;
end

% We assume that there are only two classes. We convert y to -1, +1
classes = unique(y);
ymod = y;
ymod(y == classes(1)) = -1;
ymod(y == classes(2)) = +1;

[~, n] = size(X);
weights = ones(1,n) ./ n;
BDT = {};
for t = 1:nt
    h = id3tree(X, ymod, maxdepth, weights);
    ypred = evaltree(h, X);
    epsilon = sum(weights .* (ypred ~= ymod));
    % If classif was not binary, k=#labels, epsilon > (1 - 1/k)
    if epsilon > 0.5
        break
    end
    if epsilon == 0
        epsilon = 1e-20;
    end
    % If classif was not binary, k=#labels, alpha = 0.5*log((1-epsilon)/epsilon) + log(k-1)
    alpha = 0.5*log((1-epsilon)/epsilon);
    weights = weights .* exp(-alpha * ypred .* ymod);
    weights = weights / sum(weights);
    
    % Turn -1 and +1 labels to original labels
    truepreds = h(1,:);
    truepreds(h(1,:) == -1) = classes(1);
    truepreds(h(1,:) == +1) = classes(2);
    h(1,:) = truepreds;
    
    % Add tree to BTD
    BDT = [BDT, {h; alpha}];
end