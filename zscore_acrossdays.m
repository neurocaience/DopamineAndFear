function mvta_gc = zscore_acrossdays(mvta_gc)

stdev = std_acrossdays(mvta_gc);

for m = 1:size(mvta_gc,1)
    for day = 1:4
        mvta_gc(m, day, 6, :) = mvta_gc(m, day, 4, :) / stdev(m);  % dF/F data is in column 4
    end
end


end