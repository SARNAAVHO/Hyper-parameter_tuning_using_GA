% Load the built-in fisheriris dataset
load fisheriris;  % This loads the dataset into the workspace
X = meas;  % Features (150x4)
Y = categorical(species);  % Labels (150x1)

% Split the data into training and validation sets
cv = cvpartition(Y, 'HoldOut', 0.3);
XTrain = X(cv.training, :);
YTrain = Y(cv.training, :);
XVal = X(cv.test, :);
YVal = Y(cv.test, :);

% Define the search space for hyperparameters
% Learning rate: [0.0001, 0.1], Batch size: [16, 256]
lb = [0.0001, 16];  % Lower bounds
ub = [0.1, 256];    % Upper bounds

% Define the fitness function
fitnessFunction = @(params) evaluateModel(XTrain, YTrain, XVal, YVal, params);

% Set GA options
options = optimoptions('ga', ...
    'PopulationSize', 10, ...
    'MaxGenerations', 20, ...
    'CrossoverFraction', 0.8, ...
    'MutationFcn', @mutationadaptfeasible, ...
    'Display', 'iter');

% Run the Genetic Algorithm
[bestParams, bestFitness] = ga(fitnessFunction, 2, [], [], [], [], lb, ub, [], options);

% Display the best hyperparameters
fprintf('Best Learning Rate: %f\n', bestParams(1));
fprintf('Best Batch Size: %d\n', round(bestParams(2)));

% Train the final model with the best hyperparameters
finalLearningRate = bestParams(1);
finalBatchSize = round(bestParams(2));
finalModel = trainFinalModel(XTrain, YTrain, finalLearningRate, finalBatchSize);

% Evaluate the final model on the validation set
YPred = classify(finalModel, XVal);
accuracy = mean(YPred == YVal);
fprintf('Validation Accuracy with Best Hyperparameters: %.2f%%\n', accuracy * 100);

% Fitness function to evaluate the model
function fitness = evaluateModel(XTrain, YTrain, XVal, YVal, params)
    learningRate = params(1);
    batchSize = round(params(2));  % Batch size must be an integer
    
    % Define a simple neural network architecture
    layers = [
        featureInputLayer(4)  % Input layer (4 features)
        fullyConnectedLayer(10)  % Hidden layer with 10 neurons
        reluLayer  % Activation function
        fullyConnectedLayer(3)  % Output layer (3 classes)
        softmaxLayer
        classificationLayer];
    
    % Define training options
    options = trainingOptions('sgdm', ...
        'InitialLearnRate', learningRate, ...
        'MiniBatchSize', batchSize, ...
        'MaxEpochs', 10, ...
        'Shuffle', 'every-epoch', ...
        'Verbose', false);
    
    % Train the model
    net = trainNetwork(XTrain, YTrain, layers, options);
    
    % Evaluate the model on the validation set
    YPred = classify(net, XVal);
    accuracy = mean(YPred == YVal);
    
    % Since GA minimizes the fitness function, use negative accuracy
    fitness = -accuracy;
end

% Function to train the final model with the best hyperparameters
function net = trainFinalModel(XTrain, YTrain, learningRate, batchSize)
    % Define the same neural network architecture
    layers = [
        featureInputLayer(4)  % Input layer (4 features)
        fullyConnectedLayer(10)  % Hidden layer with 10 neurons
        reluLayer  % Activation function
        fullyConnectedLayer(3)  % Output layer (3 classes)
        softmaxLayer
        classificationLayer];
    
    % Define training options with the best hyperparameters
    options = trainingOptions('sgdm', ...
        'InitialLearnRate', learningRate, ...
        'MiniBatchSize', batchSize, ...
        'MaxEpochs', 20, ...
        'Shuffle', 'every-epoch', ...
        'Verbose', false);
    
    % Train the final model
    net = trainNetwork(XTrain, YTrain, layers, options);
end