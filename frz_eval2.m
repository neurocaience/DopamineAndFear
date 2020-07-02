%% frz_eval2() This is frz_eval from c6_plotall.m; not the same frz_eval as above!
function [frz_or, frz_om, frz_ostd, frz_yr, frz_ym, frz_ystd] = frz_eval2(d_opto,d_yfp,a,b,tones, num_cs)

tones = load('tones.mat');
tones = tones.tones;

frz_o = nan(size(d_opto,2), size(d_opto,1), num_cs);   % during CS
frz_y = nan(size(d_yfp,2), size(d_yfp,1), num_cs);

for m=1:max(size(d_opto,2),size(d_yfp,2))
    for extd = 1:4
        for cs = 1:num_cs
            cs_st = tones(cs,extd)+a;      % time relative to CS where you want data
            cs_end = tones(cs,extd)+b;  % time relative to CS where you end data


            if isnan(cs_st) == 1   % skip if NaN 
            else
                if (m > size(d_opto,2))
                else
                    frz_o(m,extd,cs) = nanmean(d_opto(extd,m,cs_st:cs_end));
                end
                if (m > size(d_yfp,2))
                else
                    frz_y(m,extd,cs) = nanmean(d_yfp(extd,m,cs_st:cs_end));
                end
            end
        end
    end
end

frz_op = permute(frz_o,[1 3 2]);  % permute the matrix 
frz_or = reshape(frz_op,[size(frz_o,1), size(frz_o,2)*num_cs]);  % reshape

frz_yp = permute(frz_y,[1 3 2]);  % permute the matrix 
frz_yr = reshape(frz_yp,[size(frz_y,1), size(frz_y,2)*num_cs]);  % reshape

%imagesc(frz_or)  % check permute
%imagesc(frz_yr)

frz_om = nanmean(frz_or,1);
frz_ostd = nanstd(frz_or)/sqrt(size(d_opto,2));

frz_ym = nanmean(frz_yr,1);
frz_ystd = nanstd(frz_yr)/sqrt(size(d_yfp,2));

end
