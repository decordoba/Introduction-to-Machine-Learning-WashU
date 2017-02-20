function preds = evalforest(F, xTe)
% function preds=evalforest(F,xTe);
%
% Evaluates a random forest on a test set xTe.
%
% input:
% F   | Forest of decision trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe
%

% Get number of trees and number of examples
[~, ~, nt] = size(F);
[~, n] = size(xTe);
% Initialize preds
preds = zeros(nt, n);
% Get predictions for xTe for every tree
for i = 1:nt
    preds(i, :) = evaltree(F(:, :, i), xTe);
end
% Keep most common predictions for each feature
preds = mode(preds);