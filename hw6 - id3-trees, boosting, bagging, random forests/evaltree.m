function ypredict = evaltree(T, xTe)
% function [ypredict]=evaltree(T,xTe);
%
% input:
% T0  | tree structure
% xTe | Test data (dxn matrix)
%
% output:
%
% ypredict : predictions of labels for xTe
%

[~, n] = size(xTe);
ypredict = zeros(1, n);
for i = 1:n
    pos = 1;
    while T(4, pos) ~= 0
        if xTe(T(2, pos), i) <= T(3, pos)
            pos = T(4, pos);
        else
            pos = T(5, pos);
        end
    end
    ypredict(i) = T(1, pos);
end