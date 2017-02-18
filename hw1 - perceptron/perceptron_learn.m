function [ w, iterations ] = perceptron_learn( data_in )
%perceptron_learn Run PLA on the input data
%   Inputs: data_in: Assumed to be a matrix with each row representing an
%                    (x,y) pair, with the x vector augmented with an
%                    initial 1, and the label (y) in the last column
%   Outputs: w: A weight vector (should linearly separate the data if it is
%               linearly separable)
%            iterations: The number of iterations the algorithm ran for

%% Separate x and y
[N, d] = size(data_in);
y = data_in(:, d);
d = d - 1;
x = data_in(:, 1:d);

%% Generate zeros w (random vector could also be used)
w = zeros(1, d); % rand(1, d);

%% Apply perceptron while sign(x*w') and y are different
iterations = 0;
error = y.*(x*w') <= 0; % Get misclassified examples
while any(error) == 1 % Checks if there is any value != 0 in error vector
    idx = find(error, 1); % Find first occurence of a value != 0
    w = w + x(idx,:)*y(idx); % Recalculate w
    error = y.*(x*w') <= 0; % Get new error
    iterations = iterations + 1; % Add 1 to iterations
end