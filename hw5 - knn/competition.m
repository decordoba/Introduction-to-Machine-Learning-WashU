function preds=competition(xTr,yTr,xTe);
% function preds=competition(xTr,yTr,xTe);
%
% A classifier that outputs predictions for the data set xTe based on 
% what it has learned from xTr,yTr
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with n column-vectors of dimensionality d
%
% Output:
%
% preds = predicted labels, ie preds(i) is the predicted label of xTe(:,i)
%

% Choose setup
mink = 1;
maxk = 10;
num_cv = 10;

% Initialize everything 
[~, ntr] = size(xTr);
step = ntr / num_cv;
CV_err = zeros(num_cv, length(mink:maxk));

% Perform num_cv-fold cross validation for k = mink:maxk
for n = 1:num_cv
    split0 = floor(step * (n - 1)) + 1;
    split1 = floor(step * n);
    tmp_xTr = xTr(:, [1:split0-1, split1+1:ntr]);
    tmp_yTr = yTr(:, [1:split0-1, split1+1:ntr]);
    tmp_xCV = xTr(:, split0:split1);
    tmp_yCV = yTr(:, split0:split1);
    for k = mink:maxk
        tmp_preds = knnclassifier(tmp_xTr, tmp_yTr, tmp_xCV, k);
        CV_err(n, k - mink + 1) = analyze('acc', tmp_yCV, tmp_preds);
    end
end

% Get best k (and print it)
[~, best_k] = max(mean(CV_err));
best_k = best_k + mink - 1;
fprintf('Most accurate k = %d (after %d-fold cross validation)\n', best_k, num_cv);

% Calculate prediction for xTe using best_k
preds = knnclassifier(xTr, yTr, xTe, best_k);