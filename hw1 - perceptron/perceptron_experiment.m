function [ num_iters bounds] = perceptron_experiment ( N, d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bound_minus_ni is the difference between the theoretical bound
%               and the actual number of iterations
%      (both the outputs should be num_samples long)

%% Create constants and global variables
minX = -1;
maxX = +1;
num_iters = [];
bounds = [];

%% Repeat experiment num_samples times
for i = 1:num_samples

% Generate weight vector w* (we will call it wx)
wx = [0 rand(1, d)];

% Generate training set
x = [ones(N, 1) minX+(maxX-minX).*rand(N, d)];
y = sign(x*wx');
trainingSet = [x y];

% Run perceptron learning algorithm
[w, iterations] = perceptron_learn(trainingSet);
num_iters = [num_iters iterations];

% Calculate bound R^2||W*||^2/p^2
R = sqrt(max(sum(x.*x, 2))); % We calculate sqrt after max to reduce cost
p = min(y.*(x*wx'));
normW = sqrt(sum(wx.*wx));
bound = (R^2)*(normW^2)/(p^2);
bounds = [bounds bound];

% % Uncomment to see every example plotted with w and w* (d needs to be 1)
% % The difference between w* and w is more evident using a random initial w vector
% if d < 2
%    close all;
%    fakew = [0.85:0.01:0.95 1.05:0.01:1.15; -w(1)/w(2)*(0.85:0.01:0.95) -w(1)/w(2)*(1.05:0.01:1.15)];
%    fakewx = [0.85:0.01:0.95 1.05:0.01:1.15; -wx(1)/wx(2)*(0.85:0.01:0.95) -wx(1)/wx(2)*(1.05:0.01:1.15)];
%    plotpv([x', fakew, fakewx], [(y'+1)/2, ones(1,length(fakew)), zeros(1,length(fakewx))]);
%    title('Samples classified');
%    iterations
%    disp('Press a key to continue!'); % Press a key here
%    pause;
% end

end

%% plot results
close all;
subplot(3,1,1);
plot(num_iters);
title('Number of iterations used in every sample');
ylabel('iterations');
xlabel('samples');

subplot(3,1,2);
hist(num_iters, 20);
title('Histogram of number of iterations required');
ylabel('samples');
xlabel('iterations');

subplot(3,1,3);
hist(log10(bounds./num_iters), 20);
title('Histogram of log comparison between bound of required iterations and actual number of iterations');
ylabel('samples');
xlabel('log( bound / iterations )');