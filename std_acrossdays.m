function stdev = std_acrossdays(mvta_gc)

stdev = nanmean(1,size(mvta_gc,1));

for m = 1:size(mvta_gc,1)
    temp = mvta_gc(m,:,4,:);   % dF/F data is in column 4
    temp = temp(:);
    stdev(m) = nanstd(temp);
end


end