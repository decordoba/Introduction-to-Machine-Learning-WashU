function F = forest(X, y, nt)
% function F=forest(x,y,nt)
%
% INPUT:
% X  | input vectors dxn
% y  | input labels 1xn
% nt | number of trees
%
% OUTPUT:
% F | Forest
%

% Initialize F
[~, n] = size(X);
q = 2 * n - 1;
F = zeros(6, q, nt);
max_length = 0;

% Generate forest
for i = 1:nt
    % Sample X and y with replacement n times
    idx = randsample(1:n, n, true);
    tmp_X = X(:, idx);
    tmp_y = y(idx);
    % Generate tree and save in forest
    tree = id3tree(tmp_X, tmp_y);
    [~, wtree] = size(tree);
    F(:, :, i) = [tree, zeros(6, q - wtree)];
    % Record max_length of all trees to remove zero columns later
    max_length = max(max_length, size(tree, 2));
end

% Remove columns with all zeros in F
F(:, max_length+1:end, :) = [];