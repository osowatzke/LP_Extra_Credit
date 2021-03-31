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

% determine first 2018 index
[~,start_index] = min(abs(datenum(2018,1,1)-djiaw_total(:,1)));
if djiaw_total(start_index,1) < datenum(2018,1,1)
    start_index = start_index + 1;
end

% determine last 2018 index
[~,end_index] = min(abs(datenum(2018,12,31)-djiaw_total(:,1)));
if djiaw_total(end_index,1) > datenum(2018,12,31)
    end_index = end_index - 1;
end

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
title('Plot of Predicted and Actual 2018 Stock Market Data');

% calculate the squared error of the predicted data
e = x-xhat;
E = e'*e;

% output squared error of the predicted data
fprintf("Part (i): Squared Error of the Predicted Data: %g\n", E);

%% part (ii)

% use 2006 - 2007 data to predict the 2018 data
% the p value from part (i) is used
p = 10;

% number of weeks used to train predictor
N = 104;

% determine starting index for 2006 data
[~,start_index] = min(abs(datenum(2006,1,1)-djiaw_total(:,1)));
if djiaw_total(start_index,1) < datenum(2006,1,1)
    start_index = start_index + 1;
end

% initialize empty matrix for X
X = zeros(N-p,p);
    
% form matrix X from dataset
for m = 1:N-p
    for n = 1:p
        X(m,n) = djiaw_total(start_index+m+n-2,2); 
    end
end

%size(X)
% form vector x from dataset
x = djiaw_total(start_index+p:start_index+N-1,2); 
  
% determine predictor coefficients
a = -X\x;

% determine first 2018 index
[~,start_index] = min(abs(datenum(2018,1,1)-djiaw_total(:,1)));
if djiaw_total(start_index,1) < datenum(2018,1,1)
    start_index = start_index + 1;
end

% determine last 2018 index
[~,end_index] = min(abs(datenum(2018,12,31)-djiaw_total(:,1)));
if djiaw_total(end_index,1) > datenum(2018,12,31)
    end_index = end_index - 1;
end

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
title('Plot of Predicted and Actual 2018 Stock Market Data');

% calculate the squared error of the predicted data
e = x-xhat;
E = e'*e;

% output squared error of the predicted data
fprintf("Part (ii): Squared Error of the Predicted Data: %g\n", E);

%% part (iii)

% use two linear predictors trained with last 6 months of data
% to predict the 2018 data

% the p value from part (i) is used
p = 10;

% First week in July 2017
[~,start_index] = min(abs(datenum(2017,7,1)-djiaw_total(:,1)));
if djiaw_total(start_index,1) < datenum(2017,7,1)
    start_index = start_index + 1;
end

% Last week in December 2017
[~,end_index] = min(abs(datenum(2017,12,31)-djiaw_total(:,1)));
if djiaw_total(end_index,1) > datenum(2017,12,31)
    end_index = end_index - 1;
end

% number of weeks used to train predictor
N = end_index-start_index+1;

% initialize empty matrix for X
X = zeros(N-p,p);
    
% form matrix X from dataset
for m = 1:N-p
    for n = 1:p
        X(m,n) = djiaw_total(start_index+m+n-2,2);
    end
end

% form vector x from dataset
x = djiaw_total(start_index+p:start_index+N-1,2);
  
% determine predictor coefficients
a = -X\x;

% First week in January 2018
[~,start_index] = min(abs(datenum(2018,1,1)-djiaw_total(:,1)));
if djiaw_total(start_index,1) < datenum(2018,1,1)
    start_index = start_index + 1;
end

% Last week in June 2018
[~,end_index] = min(abs(datenum(2018,6,30)-djiaw_total(:,1)));
if djiaw_total(end_index,1) > datenum(2018,6,30)
    end_index = end_index - 1;
end

% determine first set of 2018 predicted data using filter command
% predictor coefficients must be flipped
xhat1 = filter(-[0;flip(a)],1,djiaw_total(:,2));
xhat1 = xhat1(start_index:end_index);

% actual data over first 6 months
x = djiaw_total(start_index:end_index,2);

% date range for plotting
date_range = djiaw_total(start_index:end_index,1);

% plot predicted vs actual values
figure
plot(date_range, x, date_range, xhat1);
xlim([date_range(1) date_range(end)]);
datetick('x',2)
legend('True Data', 'Predicted Data', 'Location', 'southwest');
xlabel('Date');
ylabel('Dow Jones Industrial Average');
title('Plot of Predicted and Actual Stock Market Data from Jan-June 2018');

% calculate the squared error of the predicted data
e = x-xhat1;
E = e'*e;

% output squared error of first set predicted data
fprintf("Part (iii): Squared Error for first 6 months of Predicted Data\n");
fprintf("\twhen last 6 months of data is used to train predictor: %g\n", E);

% Start and End indices have already been initialized

% number of weeks used to train predictor
N = end_index-start_index+1;

% initialize empty matrix for X
X = zeros(N-p,p);
    
% form matrix X from dataset
for m = 1:N-p
    for n = 1:p
        X(m,n) = djiaw_total(start_index+m+n-2,2);
    end
end

% form vector x from dataset
x = djiaw_total(start_index+p:start_index+N-1,2);
  
% determine predictor coefficients
a = -X\x;

% First week in July 2018
[~,start_index] = min(abs(datenum(2018,7,1)-djiaw_total(:,1)));
if djiaw_total(start_index,1) < datenum(2018,7,1)
    start_index = start_index + 1;
end

% Last week in December 2018
[~,end_index] = min(abs(datenum(2018,12,31)-djiaw_total(:,1)));
if djiaw_total(end_index,1) > datenum(2018,12,31)
    end_index = end_index - 1;
end

% determine second set of 2018 predicted data using filter command
% predictor coefficients must be flipped
xhat2 = filter(-[0;flip(a)],1,djiaw_total(:,2));
xhat2 = xhat2(start_index:end_index);

% actual data over first 6 months
x = djiaw_total(start_index:end_index,2);

% date range for plotting
date_range = djiaw_total(start_index:end_index,1);

% plot predicted vs actual values
figure
plot(date_range, x, date_range, xhat2);
xlim([date_range(1) date_range(end)]);
datetick('x',2)
legend('True Data', 'Predicted Data', 'Location', 'southwest');
xlabel('Date');
ylabel('Dow Jones Industrial Average');
title('Plot of Predicted and Actual Stock Market Data from July-Dec 2018');

% calculate the squared error of the predicted data
e = x-xhat2;
E = e'*e;

% output squared error of first set predicted data
fprintf("Part (iii): Squared Error for second 6 months of Predicted Data\n");
fprintf("\twhen last 6 months of data is used to train predictor: %g\n", E);

% determine total 2018 predicted dataset
xhat = [xhat1; xhat2];

% First week in January 2018
[~,start_index] = min(abs(datenum(2018,1,1)-djiaw_total(:,1)));
if djiaw_total(start_index,1) < datenum(2018,1,1)
    start_index = start_index + 1;
end

% Last week in December 2018
[~,end_index] = min(abs(datenum(2018,12,31)-djiaw_total(:,1)));
if djiaw_total(end_index,1) > datenum(2018,12,31)
    end_index = end_index - 1;
end

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
title('Plot of Predicted and Actual 2018 Stock Market Data');

% calculate the squared error of the predicted data
e = x-xhat;
E = e'*e;

% output squared error of the predicted data
fprintf("Part (iii): Squared Error of the Predicted Data ");
fprintf("when last 6 months\n");
fprintf("\tof data is used to train predictor: %g\n", E);


