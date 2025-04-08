function error = fitnessFunction(params)
    learningRate = params(1);
    batchSize = round(params(2));  % Ensure batch size is an integer

    % Load MNIST dataset
    data = load('mnist.mat');  
    XTrain = double(data.trainImages) / 255;
    YTrain = categorical(data.trainLabels);  
    XTest = double(data.testImages) / 255;
    YTest = categorical(data.testLabels);
    XTrain = reshape(XTrain, [28 28 1 size(XTrain, 2)]);
    XTest = reshape(XTest, [28 28 1 size(XTest, 2)]);

    % Define Neural Network Layers
    layers = [
        imageInputLayer([28 28 1])
        fullyConnectedLayer(128)
        reluLayer
        fullyConnectedLayer(10)
        softmaxLayer
        classificationLayer];

    % Training Options
    options = trainingOptions('sgdm', ...
        'InitialLearnRate', learningRate, ...
        'MaxEpochs', 3, ...
        'MiniBatchSize', batchSize, ...
        'Shuffle', 'every-epoch', ...
        'Verbose', false);

    % Train the model
    net = trainNetwork(XTrain, YTrain, layers, options);

    % Evaluate the model
    YPred = classify(net, XTest);
    accuracy = sum(YPred == YTest) / numel(YTest);

    % GA minimizes the function, so return negative accuracy
    error = -accuracy;
end
