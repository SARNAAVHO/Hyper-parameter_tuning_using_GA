% Data from Run 1
generations = 1:20;
bestFitness_run1 = [-0.9333, -0.9111, -0.9778, -0.9778, -0.9778, -0.9778, -0.9778, -1, ...
                   -0.9778, -0.9778, -0.9778, -0.9778, -0.9778, -0.9778, -0.9778, -0.9778, -1, -1, -1, -0.9778];
meanFitness_run1 = [-0.7378, -0.6533, -0.7156, -0.6378, -0.7133, -0.7844, -0.8356, -0.7689, ...
                   -0.7867, -0.8578, -0.9044, -0.7978, -0.8022, -0.7489, -0.8644, -0.72, -0.84, -0.7756, -0.8133, -0.8044];

% Data from Run 2 (Best Run)
bestFitness_run2 = [-0.8444, -0.9556, -1, -0.9556, -0.9556, -0.9556, -0.9778, -0.9778, ...
                   -0.9778, -0.9778, -0.9333, -1, -0.9778, -0.8889, -0.9556, -0.9556, -0.9778, -0.9778, -0.9556, -1];
meanFitness_run2 = [-0.7156, -0.7622, -0.8067, -0.7511, -0.8333, -0.7667, -0.8022, -0.7511, ...
                   -0.8689, -0.7956, -0.7133, -0.8489, -0.7089, -0.7133, -0.7422, -0.7289, -0.7511, -0.84, -0.74, -0.7644];

% Data from Run 3
bestFitness_run3 = [-0.9111, -0.9556, -0.9333, -0.7333, -0.9778, -0.9556, -0.9556, -0.8667, ...
                   -0.7556, -0.8444, -0.8889, -0.9333, -0.9111, -0.9333, -0.9556, -0.9778, -0.9556, -0.7556, -0.9556, -0.9778];
meanFitness_run3 = [-0.6444, -0.6178, -0.6267, -0.4733, -0.5711, -0.5511, -0.6178, -0.62, ...
                   -0.6089, -0.6222, -0.6578, -0.6489, -0.6733, -0.6867, -0.6933, -0.7111, -0.7911, -0.6556, -0.7289, -0.6933];

% Plot all runs together
figure;
hold on;

% Run 1 (Blue)
plot(generations, -bestFitness_run1, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 8);
plot(generations, -meanFitness_run1, 'b--s', 'LineWidth', 1, 'MarkerSize', 6);

% Run 2 (Red - Best Run)
plot(generations, -bestFitness_run2, 'r-o', 'LineWidth', 1.5, 'MarkerSize', 8);
plot(generations, -meanFitness_run2, 'r--s', 'LineWidth', 1, 'MarkerSize', 6);

% Run 3 (Green)
plot(generations, -bestFitness_run3, 'g-o', 'LineWidth', 1.5, 'MarkerSize', 8);
plot(generations, -meanFitness_run3, 'g--s', 'LineWidth', 1, 'MarkerSize', 6);

hold off;

% Labels and title
xlabel('Generation');
ylabel('Validation Accuracy');
title('GA Fitness Convergence Across Three Runs');
legend('Run 1 (Best)', 'Run 1 (Mean)', 'Run 2 (Best)', 'Run 2 (Mean)', 'Run 3 (Best)', 'Run 3 (Mean)', 'Location', 'southeast');
grid on;

% Adjust axes
xlim([1, 20]);
ylim([0.6, 1.0]);

% Save the figure
saveas(gcf, 'GA_Convergence_AllRuns.png');