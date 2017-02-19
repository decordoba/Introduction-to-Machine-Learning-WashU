function [] = problem24b (num_samples)
%% Create constants and global variables
minX = -1;
maxX = +1;

%% Calculate a, b, g_bar
a = zeros(1, num_samples);
b = zeros(1, num_samples);
for i = 1:num_samples
    x1 = minX + (maxX-minX)*rand();
    x2 = minX + (maxX-minX)*rand();
    a(i) = x1 + x2;
    b(i) = -x1*x2;
end
a_bar = mean(a)
b_bar = mean(b)

%% Calculate Eout
Eout = zeros(1, num_samples);
for i = 1:num_samples
    x = minX + (maxX-minX)*rand();
    Eout(i) = mean((a*x + b - x*x).^2); 
end
Eout = mean(Eout)

%% Calculate bias
bias = zeros(1, num_samples);
for i = 1:num_samples
    x = minX + (maxX-minX)*rand();
    bias(i) = (a_bar*x + b_bar - x^2)^2; 
end
bias = mean(bias)

%% Calculate variance
var = zeros(1, num_samples);
a_diff = a - a_bar;
b_diff = b - b_bar;
for i = 1:num_samples
    x = minX + (maxX-minX)*rand();    
    var(i) = mean((a_diff*x + b_diff).^2); 
end
var = mean(var)

%% Plot of g_bar(x) and f(x)
axis = (-1:0.001:1);
fx = axis.^2;
gx = axis*a_bar + b_bar;
close all;
plot(axis, [fx; gx]);
title('g-bar(x) and f(x)');
ylabel('y');
xlabel('x');
legend('f(x)','g-bar(x)');
