% make contrast detail phantom
N = 4;
I=contrast_detail(N);
[r,c] = size(I);
imshow(I);

% make sinogram for contrast detail phantom
theta = 0:180;
sino1 = radon(I,theta);
[projs, angles] = size(sino1);

% make a second sinogram with additive N(0,0.01) noise
mu = 0;
var = 0.01;
noise = normrnd(mu, sqrt(var), projs, angles); 
sino2 = sino1 + noise;

% make a third sinogram with the gaussina noise added to phantom
noise = normrnd(mu, sqrt(var), r, c); 
sino3 = radon(I+noise, theta);

% reconstruct with FBP
X_F1 = FBP(sino1, theta);
figure
imshow(X_F1);
X_F2 = FBP(sino2, theta);
figure
imshow(X_F2);
X_F3 = FBP(sino3, theta);
figure
imshow(X_F3);

% reconstruct with ART
lambda = 0.01;
iterations = 12;
x0 = zeros(r*c,1);
X_A1=ART(sino1, theta, x0, iterations, lambda);
X_A2=ART(sino2, theta, x0, iterations, lambda);
X_A3=ART(sino3, theta, x0, iterations, lambda);

% display image
% imshow(reshape(X_A1(:,13),r,c));


