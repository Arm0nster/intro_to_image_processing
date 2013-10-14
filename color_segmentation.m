function color_segmentation()
% threshold scale factor
n = 5;

% read in image
I = imread('spiderman.jpg');

% separate out color channels
r_pix = I(:,:,1);
g_pix = I(:,:,2);
b_pix = I(:,:,3);

% get mask of of desired color
%
% the area which you select will be the tracked color
% you only need a sample of the color
%
% this extracts the set of desired indices

mask = roipoly(I);

% get the values at these selected indices
r_ = r_pix(mask);
g_ = g_pix(mask);
b_ = b_pix(mask);

% plot the selected points
plot3(r_, g_, b_, 'r.');
axis([0 255 0 255 0 255]);

% average r, g, and b values
mean_ = [mean(r_) mean(g_) mean(b_)];

% values of selected region
roi = [r_ g_ b_];

% covariance of the values
cov_ = cov(double(roi));

% thresholding with ellipse
bin_im = (r_pix > mean_(1) - n*sqrt(cov_(1,1))) & (r_pix < mean_(1) + n*sqrt(cov_(1,1))) ...
    & (g_pix > mean_(2) - n*sqrt(cov_(2,2))) & (g_pix < mean_(2) + n*sqrt(cov_(2,2))) ... 
    & (b_pix > mean_(3) - n*sqrt(cov_(3,3))) & (b_pix < mean_(3) + n*sqrt(cov_(3,3)));

% make bw image
bin_im = 255 * bin_im;

colormap gray;

% render image
imshow(bin_im);

end
