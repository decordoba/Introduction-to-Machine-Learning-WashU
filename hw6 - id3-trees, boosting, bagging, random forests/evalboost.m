function preds=evalboost(BDT,xTe)
% function preds=evalboost(BDT,xTe);
%
% Evaluates a boosted decision tree on a test set xTe.
%
% input:
% BDT | Boosted Decision Trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe
%

% Get number of trees and number of examples
[~, nt] = size(BDT);
[~, n]  = size(xTe);
% Initialize preds
preds = zeros(nt, n);
alpha = zeros(nt, 1);
% Get predictions for xTe for every tree
for i = 1:nt
    preds(i, :) = evaltree(BDT{1, i}, xTe);
    alpha(i) = BDT{2, i};
end
% Get all possible labels
labels = unique(preds);
% Get weighted sum for each label
best_labels = zeros(size(labels, 1), n);
for i = 1:size(labels, 1)
    best_labels(i, :) = sum(bsxfun(@times, (preds == labels(i)), alpha));
end
% Decide best prediction
[~, labels_pos] = max(best_labels);
preds = labels(labels_pos)';