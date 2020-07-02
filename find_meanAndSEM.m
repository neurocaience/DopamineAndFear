% For a given 3D matrix, find the mean and sem of a 'column'

function [m, sem] = find_meanAndSEM(res, col)
    % mat is 3D matrix (A,B,C), find mean and SEM of a column (col) in dimension C
    m = nanmean(squeeze(res(:,:,col)));
    num_mice = size(res,1);
    sem = nanstd(squeeze(res(:,:,col)),[],1)/sqrt(num_mice);
end