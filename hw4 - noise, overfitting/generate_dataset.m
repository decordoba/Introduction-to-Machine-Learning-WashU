function [ train_set, test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair

% Create training set
x_train = rand(N_train, 1)*2 - 1;

L = computeLegPoly(x_train, Q_f);
a = normrnd(0, 1, 1, Q_f+1) / sqrt(sum(1./(2*(0:Q_f)+1)));
f = sum(bsxfun(@times, L, a), 2);
noise = normrnd(0, 1, N_train, 1);
y_train = f + noise*sigma;
train_set = [x_train y_train];

% Create test set
x_test = rand(N_test, 1)*2 - 1;
L = computeLegPoly(x_test, Q_f);
% We use same a as when generating training set
% a = normrnd(0, 1, 1, Q_f+1) / sqrt(sum(1./(2*(0:Q_f)+1)));
f = sum(bsxfun(@times, L, a), 2);
noise = normrnd(0, 1, N_test, 1);
y_test = f + noise*sigma;
test_set = [x_test y_test];

end

