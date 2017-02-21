function Evect = calcEfast(N, n0)
    if nargin < 2
        n0 = 1;
    end
    Evect = zeros(1, N);
    for n = n0:N
        Evect(n) = calcE(n);
        n
    end
    plot(Evect);
    xlabel('n');
    ylabel('E_{k=n}[m/n]');
end

function E = calcE(n)
E = zeros(n, n);
for k = 1:n
    for m = 1:n
        if m > k
            E(k, m) = 0;
        elseif m == 1
            E(k, m) = 1/n^(k-1);
        else
            E(k, m) = (m * E(k-1, m) + (n - m + 1) * E(k-1, m-1)) / n;
        end
    end
end
E = E(n, :) * (1:m)' / n;
end