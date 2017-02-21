function Evect = calcPMclassifiers(n, M)
    Evect = zeros(1, M);
    for m = 1:M
        Evect(m) = calcP(n, m);
        m
    end
    plot(Evect);
    xlabel('M');
    ylabel('Prob that one or more input pairs are never picked');
end

function p = calcP(n, M)
E = zeros(n * M, n);
for k = 1:n * M
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
p = 1 - E(n * M, n);
end