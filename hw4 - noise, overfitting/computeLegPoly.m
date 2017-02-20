function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated at the corresponding x value in the input

% Expects x to be a column vector
N = length(x);

% Preallocating z to avoid changing size in every iteration (faster)
z = [ones(N, 1), zeros(N, Q)];
if Q > 0
    z(:, 2) = x;
end

% Calculate Legendre polinomials for q > 1
for q = 2:Q
    L = ((2*q-1)/q * x .* z(:, q)) - ((q-1)/q * z(:, q-1));
    z(:, q+1) = L;
end

end

