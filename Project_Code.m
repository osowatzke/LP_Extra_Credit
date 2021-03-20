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
    X = zeros(N-p(k),p(k));
    
    % form matrix X from dataset
    for m = 1:N-p(k)
        for n = 1:p(k)
            X(m,n) = djiaw_total(m+n-1,2);
        end
    end
    
    % form vector x from dataset
    x = djiaw_total(p(k)+1:N,2);
    
    % determine predictor coefficients
    a = -X\x;
    
    % determine error with linear predictor coefficients
    e = X*a+x;
    
    % determine total squared predicted error for value of p
    E(k) = e'*e;
end

% plot E vs p
figure
plot(p,E);
xlabel('p');
ylabel('E');
title('Plot of Total Squared Prediction Error vs p');

% chosen value of p from plot
p = 10;

% determine filter coefficient for chosen value of p

% initialize empty matrix for X
X = zeros(N-p,p);
    
% form matrix X from dataset
for m = 1:N-p
    for n = 1:p
        X(m,n) = djiaw_total(m+n-1,2);
    end
end

% form vector x from dataset
x = djiaw_total(p+1:N,2);
  
% determine predictor coefficients
a = -X\x;

% determine starting and ending indices
jan1 = datenum(2018,1,1);
diff = djiaw_total(:,1)-jan1.*ones(length(djiaw_total(:,1)),1);
valid = diff >= 0;
abc = diff.*valid + (~valid).*(8);
[~,start_index] = min(diff.*valid + (~valid).*(8));
end_index = start_index + 52;
start_index;

% determine 2018 predicted data using filter command
% predictor coefficients must be flipped
xhat = filter(-[0;flip(a)],1,djiaw_total(:,2));
xhat = xhat(start_index:end_index);

% actual 2018 data
x = djiaw_total(start_index:end_index,2);

% date range for plotting
date_range = djiaw_total(start_index:end_index,1);

% plot predicted vs actual values
figure
plot(date_range, x, date_range, xhat);
xlim([date_range(1) date_range(end)]);
datetick('x',2)
legend('True Data', 'Predicted Data', 'Location', 'southwest');
xlabel('Date');
ylabel('Dow Jones Industrial Average');

% calculate the squared error of the predicted data
e = x-xhat;
E = e'*e;

% output squared error of the predicted data
fprintf("Part (i): Squared Error of the Predicted Data: %g\n", E);


% deteremine 