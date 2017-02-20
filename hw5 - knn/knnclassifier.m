function preds = knnclassifier(xTr, yTr, xTe, k)
% function preds=knnclassifier(xTr,yTr,xTe,k);
%
% k-nn classifier 
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% yTr = input vector of length n with classification for xTr
% xTe = dxm input matrix with n column-vectors of dimensionality d
% k = number of nearest neighbors to be found
%
% Output:
%
% preds = predicted labels, ie preds(i) is the predicted label of xTe(:,i)
%

%% Get sizes of input matrices
[~, n] = size(xTe);
[~, ntr] = size(xTr);
%% Make sure k <= number of training examples
if k > ntr
    k = ntr;
end
%% Get k nearest neighbors
[indices, ~] = findknn(xTr, xTe, k);
%% Get the labels for each of the neighbors
labels = zeros(k, n);
for i = 1:n
    labels(:, i) = yTr(1, indices(:, i));
end
%% Save the most common label. In case of tie, keep the smaller label
[preds, ~, others] = mode(labels, 1);
%% Check for ties, and reduce k until there is no doubt
for i = 1:n
    tmp_k = k - 1;
    while length(others{:, i}) > 1
        tmp_indices = indices(1:tmp_k, i);
        tmp_label = yTr(1, tmp_indices);
        [preds(:, i), ~, others(:, i)] = mode(tmp_label);
        tmp_k = tmp_k - 1;
    end
end

end