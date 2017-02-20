xB = [0 2 4]';
yB = [1 3 4]';
% Uncomment for b)
%yB = yB * 5;
% Replace uncommented by commented for c)
xR = [2 5 6]'; %xR = [2 5 6 1 2]';
% Replace uncommented by commented for c)
yR = [0 2 3]'; %yR = [0 2 3 1 2]';
% Uncomment for b)
%yR = yR * 5;

xS = [];
yS = [];
minX = min([xB; xR]);
maxX = max([xB; xR]);
minY = min([yB; yR]);
maxY = max([yB; yR]);
for i = minX:0.05:maxX
    % Replace uncommented by commented for b)
    for j = minY:0.033:maxY %for j = minY:0.166:maxY
       xS = [xS i];
       yS = [yS j];
    end
end

k = 3;
xTe = [xS; yS];
xTr = [xB yB; xR yR]';
yTr = [zeros(1, length(xB)) ones(1, length(xR))];
preds = knnclassifier(xTr, yTr, xTe, k);

xZero = []; %b
xOne = []; %r
for i = 1:length(preds)
    if preds(i) == 0
        xZero = [xZero xTe(:, i)];
    else
        xOne = [xOne xTe(:, i)];
    end
end

%close all;
plot(xOne(1, :), xOne(2, :), '.b', xZero(1, :), xZero(2, :), '.r', xR, yR, 'ob', xB, yB, 'or', xR, yR, '*b', xB, yB, '*r', xR, yR, 'sb', xB, yB, 'sr', xR, yR, 'db', xB, yB, 'dr', 'markersize', 5, 'markersize', 5, 'linewidth', 1);
