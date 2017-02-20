function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2

overfit_m = zeros(num_expts, 1);

for i = 1:num_expts
    [train_set, test_set] = generate_dataset(true_Q_f, N_train, N_test, sqrt(var));
    
    x_train = train_set(:, 1);
    y_train = train_set(:, 2);
    
    x_train_02 = computeLegPoly(x_train, 2);
    x_train_10 = computeLegPoly(x_train, 10);
    
    w02 = glmfit(x_train_02, y_train, 'normal', 'constant', 'off');
    w10 = glmfit(x_train_10, y_train, 'normal', 'constant', 'off');
    
    x_test = test_set(:, 1);
    y_test = test_set(:, 2);
    
    x_test_02 = computeLegPoly(x_test, 2);
    x_test_10 = computeLegPoly(x_test, 10);

    Etest02 = sum((x_test_02*w02 - y_test).^2) / N_test;
    Etest10 = sum((x_test_10*w10 - y_test).^2) / N_test;
    
    overfit_m(i) = Etest10 - Etest02;
end

end