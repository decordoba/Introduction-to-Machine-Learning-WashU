%Script that runs the set of necessary experiments. This is an example that
%you can use; you should change it as appropriate to answer the question to
%your satisfaction.

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

% Initialize mean and median to zeros to avoid resizing in loops
mean_mat = zeros(length(Q_f), length(N), length(var));
median_mat = zeros(length(Q_f), length(N), length(var));

% Run experiments
for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            tmp = computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500);
            mean_mat(ii,jj,kk) = mean(tmp);
            median_mat(ii,jj,kk) = median(tmp);
            %fprintf('Q: %d N: %d var: %d\n', Q_f(ii), N(jj), var(kk));
            %mean_mat(ii,jj,kk)
            %median_mat(ii,jj,kk)
        end
        fprintf('.');
    end
    fprintf('\n');
end

% Create labels for legend
Q_f_labels = cell(size(Q_f));
for ii = 1:length(Q_f)
    Q_f_labels(ii) = {['Q_f = ' num2str(Q_f(ii))]};
end
N_labels = cell(size(N));
for ii = 1:length(N)
    N_labels(ii) = {['N = ' num2str(N(ii))]};
end
var_labels = cell(size(var));
for ii = 1:length(var)
    var_labels(ii) = {['\sigma^2 = ' num2str(var(ii))]};
end

% Plot everything
close all;
for ii = 1:length(Q_f)
    subplot(ceil(length(Q_f)/2), 2, ii);
    mat = squeeze(mean_mat(ii, :, :));
    plot(N, mat);
    title(['Mean Eout for Q_f = ', num2str(Q_f(ii))]);
    xlabel('N');
    ylabel('Eout');
    legend(var_labels);
end
figure;
for ii = 1:length(Q_f)
    subplot(ceil(length(Q_f)/2), 2, ii);
    mat = squeeze(median_mat(ii, :, :));
    plot(N, mat);
    title(['Median Eout for Q_f = ', num2str(Q_f(ii))]);
    xlabel('N');
    ylabel('Eout');
    legend(var_labels);
end

figure;
for jj = 1:length(N)
    subplot(ceil(length(N)/2), 2, jj);
    mat = squeeze(mean_mat(:, jj, :));
    plot(Q_f, mat);
    title(['Mean Eout for N = ', num2str(N(jj))]);
    xlabel('Q_f');
    ylabel('Eout');
    legend(var_labels);
end
figure;
for jj = 1:length(N)
    subplot(ceil(length(N)/2), 2, jj);
    mat = squeeze(median_mat(:, jj, :));
    plot(Q_f, mat);
    title(['Median Eout for N = ', num2str(N(jj))]);
    xlabel('Q_f');
    ylabel('Eout');
    legend(var_labels);
end

figure;
for kk = 1:length(var)
    subplot(ceil(length(var)/2), 2, kk);
    mat = squeeze(mean_mat(:, :, kk));
    plot(Q_f, mat);
    title(['Mean Eout for var = ', num2str(var(kk))]);
    xlabel('Q_f');
    ylabel('Eout');
    legend(N_labels);
end
figure;
for kk = 1:length(var)
    subplot(ceil(length(var)/2), 2, kk);
    mat = squeeze(median_mat(:, :, kk));
    plot(Q_f, mat);
    title(['Median Eout for var = ', num2str(var(kk))]);
    xlabel('Q_f');
    ylabel('Eout');
    legend(N_labels);
end