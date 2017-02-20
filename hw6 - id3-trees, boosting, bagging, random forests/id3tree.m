function T = id3tree(xTr, yTr, maxdepth, weights)
% function T=id3tree(xTr,yTr,maxdepth,weights)
%
% The maximum tree depth is defined by "maxdepth" (maxdepth=2 means one split).
% Each example can be weighted with "weights".
%
% Builds an id3 tree
%
% Input:
% xTr | dxn input matrix with n column-vectors of dimensionality d
% yTr | 1xn input matrix
% maxdepth = maximum tree depth
% weights = 1xn vector where weights(i) is the weight of example i
%
% Output:
% T = decision tree
%

% Fill maxdepth and weights if they have not been entered
[~, n] = size(xTr);
if nargin < 4
    weights = ones(1, n);
end
if nargin < 3
    maxdepth = Inf;
end

% Initialize tree, and put root node on stack
q = 2 * n - 1;
T = zeros(6, q);
stack = {xTr; yTr; weights; 1; 0};
pos = 1;
while ~isempty(stack)
    % Pop from stack
    node = stack(:, end);
    stack(:, end) = [];
    % Extract xTr, yTr, weights, depth and parent from node
    tmp_xTr = node{1};
    tmp_yTr = node{2};
    tmp_weights = node{3};
    depth = node{4};
    parent = node{5};
    [feature, cutoff, H] = entropysplit(tmp_xTr, tmp_yTr, tmp_weights);
    % Put node on tree
    T(:, pos) = [mode(tmp_yTr); feature; cutoff; 0; 0; parent];
    % Modify children in parent
    if parent > 0
        if T(4, parent) == 0
            T(4, parent) = pos;
        else
            T(5, parent) = pos;
        end
    end
    if depth >= maxdepth
        % Fill leaf prediction (current node is a leaf)
        T(2, pos) = 0;
        T(3, pos) = 0;
    elseif H == 0
        % Fill leaf prediction (children are leafs)
        feature_row = tmp_xTr(feature, :);
        L_idx = feature_row  <= cutoff;
        R_idx = feature_row  >  cutoff;
        L_yTr = tmp_yTr(:, L_idx);
        R_yTr = tmp_yTr(:, R_idx);
        L_label = mode(L_yTr);
        R_label = mode(R_yTr);
        if L_label ~= R_label
            % Create children and update children indexs for parent
            T(:, pos + 1) = [L_label; 0; 0; 0; 0; pos];
            T(:, pos + 2) = [R_label; 0; 0; 0; 0; pos];
            T(4, pos) = pos + 1;
            T(5, pos) = pos + 2;
            pos = pos + 2;
        else
            % Both children have same label, we keep only parent
            T(2, pos) = 0;
            T(3, pos) = 0;
        end
    elseif H == Inf
        % All training examples are the same (current node is a leaf)
        T(2, pos) = 0;
        T(3, pos) = 0;
    else
        % Create children nodes and push them to stack (first R, then L)
        feature_row = tmp_xTr(feature, :);
        L_idx = feature_row  <= cutoff;
        R_idx = feature_row  >  cutoff;
        L_xTr = tmp_xTr(:, L_idx);
        L_yTr = tmp_yTr(:, L_idx);
        L_weights = tmp_weights(:, L_idx);
        R_xTr = tmp_xTr(:, R_idx);
        R_yTr = tmp_yTr(:, R_idx);
        R_weights = tmp_weights(:, R_idx);
        L_node = {L_xTr; L_yTr; L_weights; depth+1; pos};
        R_node = {R_xTr; R_yTr; R_weights; depth+1; pos};
        stack = [stack, R_node, L_node];
    end
    pos = pos + 1;    
end
% Remove empty columns
T(:, pos:end) = [];
end
