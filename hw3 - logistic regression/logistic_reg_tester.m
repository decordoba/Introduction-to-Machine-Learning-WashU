function [] = logistic_reg_tester(learn_rate, normalize, tolerance)
%LOGISTIC_REG_TESTER tests logistic regressions 3 times with 1e4, 1e5 and
% 1e6 iterations and compares the result with gmlfit
%   Inputs:
%       learn_rate : learning rate of logistic_reg
%       normalize : whether to normalize X or not
%       tolerance : the tolerance to stop logistic_reg

%% Manage optionan parmaters
if nargin < 3
   tolerance = -Inf;
end
if nargin < 2
   normalize = 0;
end
if nargin < 1
   learn_rate = 1e-5;
end

%% Get trainining set and initilize w_init
M1 = csvread('clevelandtrain.csv', 1, 0);
[N, d] = size(M1);
y = (M1(:, d) > 0)*2 - 1;
X = M1(:, 1:d-1);
if normalize == 1
    X = zscore(X);
end
w_init = zeros(1, d);

%% Compute w for the 4 tests and measure Ein and time
tic;
[w1, Ein1] = logistic_reg(X, y, w_init, 10000, learn_rate, tolerance);
time1 = toc;
disp('Search 1 finished');

tic;
[w2, Ein2] = logistic_reg(X, y, w_init, 100000, learn_rate, tolerance);
time2 = toc;
disp('Search 2 finished');

tic;
[w3, Ein3] = logistic_reg(X, y, w_init, 1000000, learn_rate, tolerance);
time3 = toc;
disp('Search 3 finished');

tic;
w4 = glmfit(X, (y+1)/2, 'binomial')';
time4 = toc;
Ein4 = sum(log(1 + exp(-y.*([ones(N, 1) X]*w4'))))/N;
disp('Search 4 finished');

%% Measure Etrain
Etrain1 = find_test_error(w1, X, y);
Etrain2 = find_test_error(w2, X, y);
Etrain3 = find_test_error(w3, X, y);
Etrain4 = find_test_error(w4, X, y);

%% Get test set
M2 = csvread('clevelandtest.csv', 1, 0);
[~, d] = size(M2);
ytest = (M2(:, d) > 0)*2 - 1;
Xtest = M2(:, 1:d-1);
if normalize == 1
    Xtest = zscore(Xtest);
end

%% Measure Etest
Etest1 = find_test_error(w1, Xtest, ytest);
Etest2 = find_test_error(w2, Xtest, ytest);
Etest3 = find_test_error(w3, Xtest, ytest);
Etest4 = find_test_error(w4, Xtest, ytest);

%% Print results
Ein = [Ein1; Ein2; Ein3; Ein4];
Etrain = [Etrain1; Etrain2; Etrain3; Etrain4];
Etest = [Etest1; Etest2; Etest3; Etest4];
Time = [time1; time2; time3; time4];
results = table(Ein, Etrain, Etest, Time, 'RowNames', {'1e4 it.'; '1e5 it.'; '1e6 it.'; 'glmfit'})

end