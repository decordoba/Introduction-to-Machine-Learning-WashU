function T = prunetree(T, xTe, y)
% function T=prunetree(T,xTe,y)
%
% Prunes a tree to minimal size such that performance on data xTe,y does not
% suffer.
%
% Input:
% T = tree
% xTe = validation data x (dxn matrix)
% y = labels (1xn matrix)
%
% Output:
% T = pruned tree
%

% Create ordered_T with leafs, ordered from least depth to most depth
ordered_T = [];
queue = [1];
while ~isempty(queue)
    % Pop from queue
    pos = queue(:, 1);
    queue(:, 1) = [];
    % If leaf, add to ordered_T
    if T(4, pos) == 0
        ordered_T = [ordered_T, pos];
    % If node, add children to queue
    else
        queue = [queue, T(4, pos), T(5, pos)];
    end
end

% Calculate original error
error0 = sum((evaltree(T, xTe) - y).^2);

% Compute nodes to prune, and modify T to prune such nodes
nodes_pruned = [];
nodes_not_pruned = [];
while ~isempty(ordered_T)
    parent = T(6, ordered_T(end));
    % Root node (can't be pruned)
    if parent == 0
        ordered_T(end) = [];
    % Parent already pruned
    elseif T(4, parent) == 0
        nodes_pruned = [nodes_pruned ordered_T(end)];
        ordered_T(end) = [];
    % Parent already checked, not pruned
    elseif ~isempty(find(nodes_not_pruned == parent, 1))
        ordered_T(end) = [];
    else
        % Modify parent but keep copy of old parent
        tmp_node = T(:, parent);
        T(2, parent) = 0;
        T(3, parent) = 0;
        T(4, parent) = 0;
        T(5, parent) = 0;
        % Calculate error
        error1 = sum((evaltree(T, xTe) - y).^2);
        % Pruning does not increase the error
        if error1 <= error0
            error0 = error1;
            % Add node to pruned list and substitute son by parent in ordered_T
            nodes_pruned = [nodes_pruned ordered_T(end)];
            ordered_T(end) = parent;
        % Pruning makes the error worse
        else
            % Undo changes in T
            T(:, parent) = tmp_node;
            % Save parent as not pruned, to avoid repeating test for sibiling
            nodes_not_pruned = [nodes_not_pruned parent];
            ordered_T(end) = [];
        end
    end
end

% Sort nodes_pruned by value
nodes_pruned = sort(nodes_pruned);

% Fix references in tree before removing pruned branches
for i = 1:size(T, 2)
    % Don't waste time modifying nodes that will be pruned
    if ~isempty(find(nodes_pruned == i, 1))
        continue
    end
    T(4, i) = T(4, i) - length(find(nodes_pruned < T(4, i)));
    T(5, i) = T(5, i) - length(find(nodes_pruned < T(5, i)));
    T(6, i) = T(6, i) - length(find(nodes_pruned < T(6, i)));
end

% Remove pruned branches
T(:, nodes_pruned) = [];