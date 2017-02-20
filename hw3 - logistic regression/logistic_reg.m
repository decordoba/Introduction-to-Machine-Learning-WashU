function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta , tolerance)
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
%       tolerance: (optional) tolerance to accept w
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)

% If tolerance is not chosen, it is set to infinite
if nargin < 6
   tolerance = -Inf;
end

% Add ones column to X and set w to w_init
[N, ~] = size(X);
x = [ones(N, 1) X];
w = w_init;

% Run logistic regression
for t = 1:max_its
    % We multiply each row in X (Xn) by (yn)./(1 + exp(y.*(x*w'))
    g = bsxfun(@times, x, y./(1 + exp(y.*(x*w'))));
    v = sum(g)/N;
    w = w + eta*v;
    if max(abs(v)) < tolerance
        fprintf('After %d iterations, w varies less than %f\n', t, tolerance);
        break;
    end
end

% Calculate Ein
e_in = sum(log(1 + exp(-y.*(x*w'))))/N;

end

