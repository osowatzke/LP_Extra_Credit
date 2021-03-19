%% part (i) 

% load stock market data
load('djiaw_2019.mat');

% size of predicted data set
N = 520;

% different values of p to try
p = 1:10;

% array to hold total squared prediction error vs different values of P
E = zeros(1,length(p));

% loop through different values of p
for k = 1:length(p)
    
    % initialize empty matrix for X
    X = zeros(N-p,p);
    
    % form matrix X from dataset
    for m = 1:N-p(k)
        for n = 1:p(k)
            X(m,n) = djiaw_2019(m+n-1,2);
        end
    end
    
    % form vector x from dataset
    x = djiaw_2019(p(k)+1:N,2)';
    
    % determine predictor coefficients
    a = -X\x;
    
    % determine error with linear predictor coefficients
    e = x+X*a;
    
    % determine total squared predicted error for value of p
    E(k) = e'*e;
end

% plot E vs p
figure(1)
plot(E,p);
xlabel('p');
ylabel('E');
title('Plot of Total Squared Prediction Error vs p');


