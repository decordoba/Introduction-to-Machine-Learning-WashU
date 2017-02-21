function Evect = calcE(N)
    Evect = zeros(1, N);
    for n = 1:N
        E = 0;
        for m = 1:n
            E = E + m * pn(m, n, n);
        end
        E = E / n;
        Evect(n) = E;
        n
    end
    plot(Evect);
    xlabel('n');
    ylabel('E_{k=n}[m/n]');
end

function p = pn(m, k, n)
if m > k
    p = 0;
elseif m == 1
    p = n^-(k-1);
else
    p = (m * pn(m, k - 1, n) + (n - m + 1) * pn(m - 1, k - 1, n)) / n;
end
end