function [tabl1] = totable(mID_opto, mID_yfp, d_opto, d_yfp, var_region, tones)

% This file creates a table of opto files to input to LME. Table includes:
%   X1 = ones   (just a row of ones) mID region (latVTA or mVTA) group
%   (opto or yfp) extD (extinction day) tN  (1:21) ttN  (1:63) frz_cs
%   (freezing during CS) frz_light (freezing during light) frz_iti
%   (freezing during ITI not light)

num_opto = size(mID_opto,1);
num_yfp = size(mID_yfp,1);
num_mice = num_opto + num_yfp;
num_trials_tot = 63;
num_trials_day = 21;
num_rows = num_mice*num_trials_tot;   % total number of rows for the table

% Create a column of ones -------------------------------------------------
X1 = ones(num_rows,1);

% Create a column for region -------------------------------------------
roi = cell(num_rows,1);
roi(:) = {var_region};

% Create variable for mID ----------------------------------------------
% Each mouse has 63 trials. So, list each mID 63 times from opto to yfp
mID_o = repmat(mID_opto', [num_trials_tot 1]);      % rows = n_trials, col = size mID
mID_o = reshape(mID_o, [num_opto*num_trials_tot 1]);

mID_y = repmat(mID_yfp', [num_trials_tot 1]);      % rows = n_trials, col = size mID
mID_y = reshape(mID_y, [num_yfp*num_trials_tot 1]);

mID = {[mID_o; mID_y]};   % combine opto and yfp mice names
mID = mID{1};

% Create variable for group --------------------------------------------
group_o = cell(num_opto*num_trials_tot,1);
group_o(:) = {'opto'};
group_y = cell(num_yfp*num_trials_tot,1);
group_y(:) = {'yfp'};

group = {[group_o; group_y]};
group = group{1};

% Create variable for extinction day -----------------------------------
ext = [1 2 3];
ext63 = repmat(ext, [21 1]);
ext63 = ext63(:);
extD = repmat(ext63,[num_mice 1]);   % repeat this matrix for # mice

% Create variable for tN (trial num) -----------------------------------
tn = 1:num_trials_day; tn = tn';
tN = repmat(tn,[num_mice*3 1]);    % repeat matrix for each mouse, for each extinctiond day (3)

% Create variable for ttN (total trial number for extinction) ----------
ttn = 1:num_trials_tot; ttn = ttn';
ttN = repmat(ttn,[num_mice 1]);


%% Calculate frz(CS) for each mouse, on each trial -----------------------
[frz_or, frz_om, frz_ostd, frz_yr, frz_ym, frz_ystd] = frz_eval(d_opto,d_yfp,0,18,tones, 21);   % for CS
[frz_or5, frz_om5, frz_ostd5, frz_yr5, frz_ym5, frz_ystd5] = frz_eval(d_opto,d_yfp,0,5,tones, 21);   % for CS first 5 seconds
[frz_or1, frz_om1, frz_ostd1, frz_yr1, frz_ym1, frz_ystd1] = frz_eval(d_opto,d_yfp,19,24,tones, 21);  % 'light'  
[frz_or2, frz_om2, frz_ostd2, frz_yr2, frz_ym2, frz_ystd2] = frz_eval(d_opto,d_yfp,25,30,tones, 21);  % 'postlight' original: 26-31 or 26-45
[frz_or3, frz_om3, frz_ostd3, frz_yr3, frz_ym3, frz_ystd3] = frz_eval(d_opto,d_yfp,20,39,tones, 21);   % 'immediate iti' original: 32-45
[frz_or4, frz_om4, frz_ostd4, frz_yr4, frz_ym4, frz_ystd4] = frz_eval(d_opto,d_yfp,25,43,tones, 21);   % 'iti_20s'  20 s post light 
[frz_or5, frz_om5, frz_ostd5, frz_yr5, frz_ym5, frz_ystd5] = frz_eval(d_opto,d_yfp,31,60,tones, 21);   % 'iti_20s'  30 s post post light 
[frz_orpre, frz_ompre, frz_ostdpre, frz_yrpre, frz_ympre, frz_ystdpre] = frz_eval(d_opto,d_yfp,-10,-1,tones, 21);  

%%
% Create variable for frz_cs ---------------------------------------------
frz_cs = nan(num_mice*num_trials_tot,1);
frz_cs(1:num_opto*num_trials_tot) = reshape(frz_or',[num_opto*num_trials_tot 1]);
frz_cs((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yr', [num_yfp*num_trials_tot 1]);

% Create variable for frz_cs first 5 seconds ---------------------------------------------
frz_cs5 = nan(num_mice*num_trials_tot,1);
frz_cs5(1:num_opto*num_trials_tot) = reshape(frz_or5',[num_opto*num_trials_tot 1]);
frz_cs5((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yr5', [num_yfp*num_trials_tot 1]);

% Create variable for light inhibition
frz_light = nan(num_mice*num_trials_tot,1);
frz_light(1:num_opto*num_trials_tot) = reshape(frz_or1',[num_opto*num_trials_tot 1]);
frz_light((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yr1', [num_yfp*num_trials_tot 1]);

% Create variable for post light inhibition
frz_postlight6s = nan(num_mice*num_trials_tot,1);
frz_postlight6s(1:num_opto*num_trials_tot) = reshape(frz_or2',[num_opto*num_trials_tot 1]);
frz_postlight6s((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yr2', [num_yfp*num_trials_tot 1]);

% Create variable for general ITI
frz_iti = nan(num_mice*num_trials_tot,1);
frz_iti(1:num_opto*num_trials_tot) = reshape(frz_or3',[num_opto*num_trials_tot 1]);
frz_iti((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yr3', [num_yfp*num_trials_tot 1]);

% Create variable for general ITI
frz_postlightiti = nan(num_mice*num_trials_tot,1);
frz_postlightiti(1:num_opto*num_trials_tot) = reshape(frz_or4',[num_opto*num_trials_tot 1]);
frz_postlightiti((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yr3', [num_yfp*num_trials_tot 1]);

% Create variable for general ITI
frz_31_50 = nan(num_mice*num_trials_tot,1);
frz_31_50(1:num_opto*num_trials_tot) = reshape(frz_or5',[num_opto*num_trials_tot 1]);
frz_31_50((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yr3', [num_yfp*num_trials_tot 1]);

% Create variable for pre_cs
frz_pre = nan(num_mice*num_trials_tot,1);
frz_pre(1:num_opto*num_trials_tot) = reshape(frz_orpre',[num_opto*num_trials_tot 1]);
frz_pre((num_opto*num_trials_tot+1):num_mice*num_trials_tot) = reshape(frz_yrpre', [num_yfp*num_trials_tot 1]);



% Create table 
tabl1 = table(X1, mID, roi, group, extD, tN, ttN, frz_cs, frz_light, frz_postlight6s, frz_iti, frz_cs5, frz_pre, frz_postlightiti, frz_31_50, ...
    'VariableNames', {'ones','mID','roi','group','extD','tN','ttN','f_cs','f_light','f_postlight','f_iti','f_cs5', 'f_pre', 'f_postlightiti', 'f_31_60'});


    %%
    function [frz_or, frz_om, frz_ostd, frz_yr, frz_ym, frz_ystd] = frz_eval(d_opto,d_yfp,a,b,tones, num_cs)

    frz_o = nan(size(d_opto,2), size(d_opto,1), num_cs);   % during CS
    frz_y = nan(size(d_yfp,2), size(d_yfp,1), num_cs); 
    for m=1:max(size(d_opto,2),size(d_yfp,2))
        for extd = 1:3  
            for cs = 1:num_cs
                expd = extd+1;                 % Since this is extinction only, we want experiment days 2-4
                cs_st = tones(cs,expd)+a;      % time relative to CS where you want data
                cs_end = tones(cs,expd)+b;  % time relative to CS where you end data

                if isnan(cs_st) == 1   % skip if NaN 
                else
                    if (m > size(d_opto,2))
                    else
                        %size(d_opto)
                        %cs_end
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


end