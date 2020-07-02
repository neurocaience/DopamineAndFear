function [amean] = array_mean(data, bins)
% Lili X. Cai, 3/30/2020

% input: array of length X
% bins of length Y < X

% output: array of length mod(X/Y)
% for each value, the mean of Y values of X

% example
% input:  data = [1 2 3 4 5 6 7 8 9 10 11];
%         bins = 5
% output: amean = [3 8];

data = data(1:floor(length(data)/bins)*bins);   % shorten the data to the roundable number of bins

len_mean = length(data)/bins;  % size of new data array

amean = nan(len_mean,1);       % create empty array

for n = 1:len_mean
    a = (n-1)*bins + 1;
    b = a + bins - 1;
    amean(n) = nanmean(data(a:b));
end


end