function coinFlipPlotter(numReps, numCoins, numTosses)
%coinFlipPlotter Code for doing the following experiment numReps times:
%                flipping numCoins fair coins, each numTosses times, and
%                plotting some results and the Hoeffding bound

%% Check number of inputs.
if nargin < 1
    numReps = 10000;
end
if nargin < 2
    numCoins = 1000;
end
if nargin < 3
    numTosses = 10;
end

%% Print relevant values
numCoins
numTosses
numReps

%% Calculate simulation numReps times
v = [];
for i = 1:numReps
    v = [v coinFlip(numCoins, numTosses)'];
end

% Plot results
close all;
plot(v');
title('Frequency of heads when tossing 1000 coins 10 times');
legend('\nu_{1}','\nu_{rand}','\nu_{min}');

% Define mu and epsilon
u = 0.5;
epsilon = (0:0.001:0.5)';

% Calculate 
diff = abs(v - u);
u1 = diff(1,:);
urand = diff(2,:);
umin = diff(3,:);

U1 = repmat(u1, length(epsilon), 1);
Urand = repmat(urand, length(epsilon), 1);
Umin = repmat(umin, length(epsilon), 1);
Epsilon = repmat(epsilon, 1, length(u1));

hoeffU1A = mean(U1 > Epsilon, 2);
hoeffUrandA = mean(Urand > Epsilon, 2);
hoeffUminA = mean(Umin > Epsilon, 2);
hoeffB = 2*exp(-2*(epsilon.^2)*numTosses);

% Plot results
figure;
plot(epsilon, [hoeffU1A hoeffB]);
title('Hoeffding inequality comparison for c_{1}');
legend('| \nu - \mu | > \epsilon','2e^{- 2\epsilon^2N}');
xlabel('\epsilon');

% Plot results
figure;
plot(epsilon, [hoeffUrandA hoeffB]);
title('Hoeffding inequality comparison for c_{rand}');
legend('| \nu - \mu | > \epsilon','2e^{- 2\epsilon^2N}');
xlabel('\epsilon');

% Plot results
figure;
plot(epsilon, [hoeffUminA hoeffB]);
title('Hoeffding inequality comparison for c_{min}');
legend('| \nu - \mu | > \epsilon','2e^{- 2\epsilon^2N}');
xlabel('\epsilon');

% Plot results
figure;
plot(epsilon, [hoeffU1A hoeffUrandA hoeffUminA hoeffB]);
title('Hoeffding inequality comparison for c_1, c_rand and c_{min}');
legend('| \nu_{1} - \mu_{1} | > \epsilon', '| \nu_{rand} - \mu_{rand} | > \epsilon', '| \nu_{min} - \mu_{min} | > \epsilon', '2e^{- 2\epsilon^2N}');
xlabel('\epsilon');

function result = coinFlip(numCoins, numTosses)

% heads = 1, tails = 0
coins = sum(randi([0 1], numTosses, numCoins))/numTosses;

V1 = coins(1);
Vrand = coins(randi([1, numCoins]));
Vmin = min(coins);

result = [V1 Vrand Vmin];
