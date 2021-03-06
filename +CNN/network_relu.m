% Architecture of the network
% Layer 0: Input Layer, 3 channels @ 33x33px
% Layer 1: Convolution Layer, 16 channels @ 32x32px, 2x2 filters
% Layer 2: MaxPooling Layer, 16 channels @ 16x16px, 2x2 filters
% Layer 3: Convolution Layer, 16 channels @ 14x14px, 3x3 filters
% Layer 4: MaxPooling Layer, 16 channels @ 7x7px, 2x2 filters
% Layer 5: Convolution Layer, 16 channels @ 22x22px, 3x3 filters
% Layer 6: MaxPooling Layer, 16 channels @ 11x11px, 2x2 filters
% Layer 7: Convolution Layer, 16 channels @ 10x10px, 2x2 filters
% Layer 8: MaxPooling Layer, 16 channels @ 5x5px, 2x2 filters
% Layer 9: Convolution Layer, 16 channels @ 4x4px, 2x2 filters
% Layer 10: MaxPooling Layer, 16 channels @ 2x2px, 2x2 filters
% Layer 11 and 12: Fully Connected Network for Classification Using SoftMax
% activation

f = 0.1;
% About filters: [height, width, channels, numFilters] - init with small random
% Single values
% About biases: vector with as much entries as numFilters
net = struct;
net.layers = {} ;
% Layer 1, results in 32x32px
net.layers{end+1} = struct('type', 'conv', ...
                           'filters', f*randn(2,2,3,16, 'single'), ...
                           'biases', zeros(1, 16, 'single'), ...
                           'stride', 1, ...
                           'pad', 0);
% Layer 2, results in 16x16px                       
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;
% Layer 3, results in 14x14px
net.layers{end+1} = struct('type', 'conv', ...
                           'filters', f*randn(3,3,16,16, 'single'), ...
                           'biases', zeros(1, 16, 'single'), ...
                           'stride', 1, ...
                           'pad', 0);
% Layer 4, results in 7x7px                       
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;
% Layer 5, results in 4x4px
net.layers{end+1} = struct('type', 'conv', ...
                           'filters', f*randn(4,4,16,16, 'single'), ...
                           'biases', zeros(1, 16, 'single'), ...
                           'stride', 1, ...
                           'pad', 0);
% Layer 6, results in 2x2px                     
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;
                       
% Layer 7 and Layer 8: Fully Connected Network for classification
net.layers{end+1} = struct('type', 'conv', ...
                           'filters', f*randn(2,2,16,100, 'single'), ...
                           'biases', zeros(1, 100, 'single'), ...
                           'stride', 1, ...
                           'pad', 0);
net.layers{end+1} = struct('type', 'relu');
net.layers{end+1} = struct('type', 'conv', ...
                           'filters', f*randn(1,1,100,2, 'single'), ...
                           'biases', zeros(1, 2, 'single'), ...
                           'stride', 1, ...
                           'pad', 0);
net.layers{end+1} = struct('type', 'relu');
net.layers{end+1} = struct('type', 'softmaxloss') ;

% Other details
net.normalization.imageSize = [33, 33, 3] ;