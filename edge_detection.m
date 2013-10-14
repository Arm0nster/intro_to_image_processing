function edge_detection()
% threshold value
thresh = 15;

% kernel size
n = 3;

% read in image
I = imread('spiderman.jpg');

% convert to YUV and take out V channel, which is the grayscale image
I = rgb2gray(I);

% smoothing 
K = make_gaussian_kernel(n);
I = conv2(double(I), K, 'same');

% strength of edge y
dx = conv2(I, [-1 0 1], 'same');

% strength of edge x
dy = conv2(I, [-1; 0; 1], 'same');

% find all edges
mag = sqrt(dx.^2 + dy.^2);

% threshold 
I = 255 * (mag>thresh);

% render image
imshow(I);

end

% creates a 2D kernel used for filtering
function K = make_gaussian_kernel(n)
% begin convolution chain
K = [1 1];

% chain convolution
for i=3:n
    K = conv([1 1], K);
end

% make 1D kernel into 2D kernel
K = conv2(K, K');

% normalize
K = K/sum(sum(K));

end
