%% 
% Lili X. Cai, 3/8/2020

%% Load data
addpath('..\Data')
addpath('helpfer_functions')

load lvta_opto_rtpp_baseline   % Ethovision data for Dat-Cre mice with DIO-NpHR inj and optic fiber in lvta during baseline
load lvta_yfp_rtpp_baseline    % Ethovision data for Dat-Cre mice with DIO-YFP inj and optic fiber in lvta during baseline
load mvta_opto_rtpp_baseline   % Ethovision data for Dat-Cre mice with DIO-NpHR inj and optic fiber in lvta during baseline
load mvta_yfp_rtpp_baseline    % Ethovision data for Dat-Cre mice with DIO-YFP inj and optic fiber in lvta during baseline

load mvta_opto_rtpp   % Ethovision data for Dat-Cre mice with DIO-NpHR inj and optic fiber in mvta
load mvta_yfp_rtpp    % Ethovision data for Dat-Cre mice with DIO-YFP inj and optic fiber in mvta
load lvta_opto_rtpp   % Ethovision data for Dat-Cre mice with DIO-NpHR inj and optic fiber in lvta
load lvta_yfp_rtpp    % Ethovision data for Dat-Cre mice with DIO-YFP inj and optic fiber in lvta

load snc_opto_rtpp   % Ethovision data for Dat-Cre mice with DIO-NpHR inj and optic fiber in snc
load snc_yfp_rtpp    % Ethovision data for Dat-Cre mice with DIO-YFP inj and optic fiber in snc
load snc_opto_rtpp_baseline   % Ethovision data for Dat-Cre mice with DIO-NpHR inj and optic fiber in snc during baseline
load snc_yfp_rtpp_baseline    % Ethovision data for Dat-Cre mice with DIO-YFP inj and optic fiber in snc during baseline


% About Ethovision data
% Acq = 30 FPS  
% column 1 = trial time                     --> raw data
%        2 = recording time                 --> raw data
%        3 = x center                       --> raw data
%        4 = y center                       --> raw data
%        5 = area                           --> raw data
%        6 = areachange                     --> raw data
%        7 = elongation                     --> raw data
%        8 = distance moved                 --> raw data
%        9 = velocity                       --> raw data
%        10 = in zone right/center point    --> raw data
%        11 = in zone left/center point     --> raw data
%        12 = in zone 2 arena/center point  --> raw data
%        13 = in zone 2(Right/center point) --> raw data
%        14 = in zone 2(left/center point)  --> raw data
%        15 = result                        --> raw data
%        16 = Is in Light chamber           --> calculated 
%        17 = Is in No Light chamber        --> calculated
%        18 = Velocity in Light chamber     --> calculated
%        19 = Velocity in No Light chamber  --> calculated
%        20 = Velocity in Right chamber     --> calculated (baseline only)
%        21 = Velocity in Left chamber      --> calculated (baseline only)

% define constant variables
type = 'NpHR';
fs = 7;   % font size
col = [1 127/255 0];               % Set opto color
cohort = '';

rose = [255/255 200/255 200/255];
darkrose = [255/255 110/255 110/255];
darkdarkrose = [250/255 50/255 50/255];
yel = 'y';
grey = [.6 .6 .6];
darkgrey = [.3 .3 .3];
blue = [198/255 226/255 238/255];
darkblue = [150/255 180/255 238/255];
darkdarkblue = [100/255 100/255 238/255];
lightgreen = [168/255 239/255 189/255];
green = [21/255 122/255 21/255];
%% Calculate baseline ANOVA ==================================================
ylab = '% Total Time Spent in Chamber';
xtic = {'Light'; 'No Light'};
cap = 'Light vs No Light';
colo = 0;
% mVTA

[light_yfp6_14, nolight_yfp6_14, light6_14, nolight6_14] = myplot2(mvta_opto_rtpp_baseline,mvta_yfp_rtpp_baseline,16,17,ylab,xtic, cap, ...
    cohort, 1:size(mvta_opto_rtpp_baseline,1), 1:size(mvta_yfp_rtpp_baseline,1), type, col, fs, 30, colo); ylim([0 1])

[vel_light_yfp6_14, vel_nolight_yfp6_14, vel_light6_14, vel_nolight6_14] = myplot2(mvta_opto_rtpp_baseline,mvta_yfp_rtpp_baseline,18,19,'Velocity (mm/s)',xtic, cap, ...
    cohort, 1:size(mvta_opto_rtpp_baseline,1), 1:size(mvta_yfp_rtpp_baseline,1), type, col, fs, 31, colo); ylim([0 140])

[light_yfp6_14, nolight_yfp6_14, light6_14, nolight6_14] = myplot2(mvta_opto_rtpp_baseline,mvta_yfp_rtpp_baseline,10,11,ylab,{'Right','Left'}, 'Right vs Left', ...
    cohort, 1:size(mvta_opto_rtpp_baseline,1), 1:size(mvta_yfp_rtpp_baseline,1), type, col, fs, 32, colo); ylim([0 1])

[vel_light_yfp6_14, vel_nolight_yfp6_14, vel_light6_14, vel_nolight6_14] = myplot2(mvta_opto_rtpp_baseline,mvta_yfp_rtpp_baseline,20,21,'Velocity (mm/s)',{'Right','Left'}, cap, ...
    cohort, 1:size(mvta_opto_rtpp_baseline,1), 1:size(mvta_yfp_rtpp_baseline,1), type, col, fs, 33, colo); ylim([0 140])

% lVTA
ylab = '% Total Time Spent in Chamber';
xtic = {'Light'; 'No Light'};
cap = 'Light vs No Light';
colo = 1;
[light_yfp, nolight_yfp, light, nolight] = myplot2(lvta_opto_rtpp_baseline,lvta_yfp_rtpp_baseline,16,17,ylab,xtic, cap, ...
    cohort,  1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 30, colo); ylim([0 1])

[vel_light_yfp, vel_nolight_yfp, vel_light, vel_nolight] = myplot2(lvta_opto_rtpp_baseline,lvta_yfp_rtpp_baseline,18,19,'Velocity (mm/s)',xtic, cap, ...
    cohort, 1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 31, colo); ylim([0 140])

[light_yfp, nolight_yfp, light, nolight] = myplot2(lvta_opto_rtpp_baseline,lvta_yfp_rtpp_baseline,10,11,ylab,{'Right','Left'}, 'Right vs Left', ...
    cohort, 1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 32, colo); ylim([0 1])

[vel_light_yfp, vel_nolight_yfp, vel_light, vel_nolight] = myplot2(lvta_opto_rtpp_baseline,lvta_yfp_rtpp_baseline,20,21,'Velocity (mm/s)',{'Right','Left'}, cap, ...
    cohort, 1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 33, colo); ylim([0 140])

% SNc
ylab = '% Total Time Spent in Chamber';
xtic = {'Light'; 'No Light'};
cap = 'Light vs No Light';
colo = 1;

[snc_light_yfp, snc_nolight_yfp, snc_light, snc_nolight] = myplot2(snc_opto_rtpp_baseline,snc_yfp_rtpp_baseline,16,17,ylab,xtic, cap, ...
    cohort,  1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 30, colo); ylim([0 1])

[snc_vel_light_yfp, snc_vel_nolight_yfp, snc_vel_light, snc_vel_nolight] = myplot2(snc_opto_rtpp_baseline,snc_yfp_rtpp_baseline,18,19,'Velocity (mm/s)',xtic, cap, ...
    cohort, 1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 31, colo); ylim([0 140])

[snc_light_yfp, snc_nolight_yfp, snc_light, snc_nolight] = myplot2(snc_opto_rtpp_baseline,snc_yfp_rtpp_baseline,10,11,ylab,{'Right','Left'}, 'Right vs Left', ...
    cohort, 1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 32, colo); ylim([0 1])

[snc_vel_light_yfp, snc_vel_nolight_yfp, snc_vel_light, snc_vel_nolight] = myplot2(snc_opto_rtpp_baseline,snc_yfp_rtpp_baseline,20,21,'Velocity (mm/s)',{'Right','Left'}, cap, ...
    cohort, 1:size(lvta_opto_rtpp_baseline,1), 1:size(lvta_opto_rtpp_baseline,1), type, col, fs, 33, colo); ylim([0 140])

% ANOVA: medial vs. lateral VTA only: ------------------------------------
y_time2 = [(light_yfp-nolight_yfp)' (light-nolight)' (light_yfp6_14-nolight_yfp6_14)' (light6_14-nolight6_14)']; % difference in time spent in chamber
y_vel2 = [(vel_light_yfp-vel_nolight_yfp)' (vel_light-vel_nolight)' (vel_light_yfp6_14-vel_nolight_yfp6_14)' (vel_light6_14-vel_nolight6_14)']; % difference btwn light and no light chamber (velocity)

roi2 = [make_cell(light_yfp,'lVTA')', make_cell(light, 'lVTA')', ...
         make_cell(light_yfp6_14, 'mVTA')', make_cell(light6_14, 'mVTA')'];
roi2 = roi2';

group2 = [make_cell(light_yfp,'yfp')', make_cell(light, 'nphr')', ...
         make_cell(light_yfp6_14, 'yfp')',make_cell(light6_14, 'nphr')'];
group2 = group2';

% dependent variable: time spent in chamber
p = anovan(y_time2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way group (nphr vs. yfp) vs. subregion 

% dependent varaible: velocity in chamber
p = anovan(y_vel2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way (nphr vs. yfp) vs. subregion

% ANOVA: medial vs. lateral vta vs. SNc ---------------------------------
y_time2 = [(light_yfp-nolight_yfp)' (light-nolight)' (light_yfp6_14-nolight_yfp6_14)' (light6_14-nolight6_14)' (snc_light_yfp-snc_nolight_yfp)' (snc_light-snc_nolight)']; % difference in time spent in chamber
y_vel2 = [(vel_light_yfp-vel_nolight_yfp)' (vel_light-vel_nolight)' (vel_light_yfp6_14-vel_nolight_yfp6_14)' (vel_light6_14-vel_nolight6_14)' (snc_vel_light_yfp-snc_vel_nolight_yfp)' (snc_vel_light-snc_vel_nolight)']; % difference btwn light and no light chamber (velocity)

roi2 = [make_cell(light_yfp,'lVTA')', make_cell(light, 'lVTA')', ...
         make_cell(light_yfp6_14, 'mVTA')', make_cell(light6_14, 'mVTA')', ...
         make_cell(snc_light_yfp,'SNc')', make_cell(snc_light, 'SNc')'];
roi2 = roi2';

group2 = [make_cell(light_yfp,'yfp')', make_cell(light, 'nphr')', ...
         make_cell(light_yfp6_14, 'yfp')',make_cell(light6_14, 'nphr')', ...
         make_cell(snc_light_yfp,'yfp')', make_cell(snc_light, 'nphr')'];
group2 = group2';

% dependent variable: time spent in chamber
p = anovan(y_time2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way group (nphr vs. yfp) vs. subregion 

% dependent varaible: velocity in chamber
p = anovan(y_vel2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way (nphr vs. yfp) vs. subregion



%% Plot baseline data

% chmaber preference - {mvta, lvta} {opto, yfp}
lvta_yfp_vel = light_yfp - nolight_yfp;
lvta_opto_vel =light - nolight;
mvta_yfp_vel = light_yfp6_14 - nolight_yfp6_14;
mvta_opto_vel = light6_14 - nolight6_14;
snc_yfp_vel = snc_light_yfp - snc_nolight_yfp;
snc_opto_vel = snc_light - snc_nolight;

x_mvta_opto =ones(length(mvta_opto_vel),1);
x_mvta_yfp =ones(length(mvta_yfp_vel),1) + .5;
x_lvta_opto =ones(length(lvta_opto_vel),1) + 1.5;
x_lvta_yfp =ones(length(lvta_yfp_vel),1) + 2;
x_snc_opto =ones(length(snc_opto_vel),1) + 3;
x_snc_yfp =ones(length(snc_yfp_vel),1) + 3.5;

figure(41), clf, set(gcf, 'color','white'), hold on
plot([.5 5], [0 0], 'k--')
    
plot(x_lvta_yfp, lvta_yfp_vel, 'o', 'color', blue, 'markerfacecolor', 'w')
plot(x_lvta_opto, lvta_opto_vel, 'o', 'color', blue, 'markerfacecolor', blue)
plot(x_mvta_yfp, mvta_yfp_vel, 'o', 'color', rose, 'markerfacecolor', 'w')
plot(x_mvta_opto, mvta_opto_vel, 'o', 'color', rose, 'markerfacecolor', rose)
plot(x_snc_yfp, snc_yfp_vel, 'o', 'color', lightgreen, 'markerfacecolor', 'w')
plot(x_snc_opto, snc_opto_vel, 'o', 'color', lightgreen, 'markerfacecolor', lightgreen)

errorbar(1, mean(mvta_opto_vel), std(mvta_opto_vel), 'capsize', 0, 'color', darkrose)
errorbar(1.5, mean(mvta_yfp_vel), std(mvta_yfp_vel), 'capsize', 0, 'color', darkrose)
errorbar(2.5, mean(lvta_opto_vel), std(lvta_opto_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(3, mean(lvta_yfp_vel), std(lvta_yfp_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(4, mean(snc_opto_vel), std(snc_opto_vel), 'capsize', 0, 'color', green)
errorbar(4.5, mean(snc_yfp_vel), std(snc_yfp_vel), 'capsize', 0, 'color', green)

plot(1, mean(mvta_opto_vel), 'o', 'markersize', 10, 'color', darkrose, 'markerfacecolor', darkrose)
plot(1.5, mean(mvta_yfp_vel), 'o', 'markersize', 10,'color', darkrose, 'markerfacecolor', 'w')
plot(2.5, mean(lvta_opto_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', darkdarkblue)
plot(3, mean(lvta_yfp_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', 'w')
plot(4, mean(snc_opto_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', green)
plot(4.5, mean(snc_yfp_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', 'w')


xlim([.5 5])
set(gca, 'xtick', [])

% velocity - baseline {mvta, lvta} {opto, yfp}
lvta_yfp_vel = vel_light_yfp - vel_nolight_yfp;
lvta_opto_vel = vel_light - vel_nolight;
mvta_yfp_vel = vel_light_yfp6_14 - vel_nolight_yfp6_14;
mvta_opto_vel = vel_light6_14 - vel_nolight6_14;
snc_yfp_vel = snc_vel_light_yfp - snc_vel_nolight_yfp;
snc_opto_vel = snc_vel_light - snc_vel_nolight;

x_mvta_opto =ones(length(mvta_opto_vel),1);
x_mvta_yfp =ones(length(mvta_yfp_vel),1) + .5;
x_lvta_opto =ones(length(lvta_opto_vel),1) + 1.5;
x_lvta_yfp =ones(length(lvta_yfp_vel),1) + 2;
x_snc_opto =ones(length(snc_opto_vel),1) + 3;
x_snc_yfp =ones(length(snc_yfp_vel),1) + 3.5;

figure(42), clf, set(gcf, 'color','white'), hold on
plot([.5 5], [0 0], 'k--')
    
plot(x_lvta_yfp, lvta_yfp_vel, 'o', 'color', blue, 'markerfacecolor', 'w')
plot(x_lvta_opto, lvta_opto_vel, 'o', 'color', blue, 'markerfacecolor', blue)
plot(x_mvta_yfp, mvta_yfp_vel, 'o', 'color', rose, 'markerfacecolor', 'w')
plot(x_mvta_opto, mvta_opto_vel, 'o', 'color', rose, 'markerfacecolor', rose)
plot(x_snc_yfp, snc_yfp_vel, 'o', 'color', lightgreen, 'markerfacecolor', 'w')
plot(x_snc_opto, snc_opto_vel, 'o', 'color', lightgreen, 'markerfacecolor', lightgreen)

errorbar(1, mean(mvta_opto_vel), std(mvta_opto_vel), 'capsize', 0, 'color', darkrose)
errorbar(1.5, mean(mvta_yfp_vel), std(mvta_yfp_vel), 'capsize', 0, 'color', darkrose)
errorbar(2.5, mean(lvta_opto_vel), std(lvta_opto_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(3, mean(lvta_yfp_vel), std(lvta_yfp_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(4, mean(snc_opto_vel), std(snc_opto_vel), 'capsize', 0, 'color', green)
errorbar(4.5, mean(snc_yfp_vel), std(snc_yfp_vel), 'capsize', 0, 'color', green)

plot(1, mean(mvta_opto_vel), 'o', 'markersize', 10, 'color', darkrose, 'markerfacecolor', darkrose)
plot(1.5, mean(mvta_yfp_vel), 'o', 'markersize', 10,'color', darkrose, 'markerfacecolor', 'w')
plot(2.5, mean(lvta_opto_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', darkdarkblue)
plot(3, mean(lvta_yfp_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', 'w')
plot(4, mean(snc_opto_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', green)
plot(4.5, mean(snc_yfp_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', 'w')


xlim([.5 5])
set(gca, 'xtick', [])

%% Calculate RTPA ANOVA ======================================================

% mVTA
colo = 0;
[light_yfp6_14, nolight_yfp6_14, light6_14, nolight6_14] = myplot2(mvta_opto_rtpp,mvta_yfp_rtpp,16,17,ylab,xtic, cap, ...
    cohort, 1:size(mvta_opto_rtpp,1), 1:size(mvta_yfp_rtpp), type, col, fs, 30, colo); ylim([0 1])

[vel_light_yfp6_14, vel_nolight_yfp6_14, vel_light6_14, vel_nolight6_14] = myplot2(mvta_opto_rtpp,mvta_yfp_rtpp,18,19,'Velocity (mm/s)',xtic, cap, ...
    cohort, 1:size(mvta_opto_rtpp_baseline,1), 1:size(mvta_yfp_rtpp_baseline,1), type, col, fs, 31, colo); ylim([0 140])

[rl_light_yfp6_14, rl_nolight_yfp6_14, rl_light6_14, rl_nolight6_14] = myplot2(mvta_opto_rtpp,mvta_yfp_rtpp,10,11,ylab,{'Right','Left'}, 'Right vs Left', ...
    cohort, 1:size(mvta_opto_rtpp,1), 1:size(mvta_yfp_rtpp), type, col, fs, 32, colo); ylim([0 1])

% lVTA
colo = 1;
[light_yfp, nolight_yfp, light, nolight] = myplot2(lvta_opto_rtpp,lvta_yfp_rtpp,16,17,ylab,xtic, cap, ...
    cohort, 1:size(lvta_opto_rtpp,1),  1:size(lvta_opto_rtpp,1), type, col, fs, 30, colo); ylim([0 1])

[vel_light_yfp, vel_nolight_yfp, vel_light, vel_nolight] = myplot2(lvta_opto_rtpp,lvta_yfp_rtpp,18,19,'Velocity (mm/s)',xtic, cap, ...
    cohort, 1:size(lvta_opto_rtpp,1),  1:size(lvta_opto_rtpp,1), type, col, fs, 31, colo); ylim([0 80])

[rl_light_yfp, rl_nolight_yfp, rl_light, rl_nolight] = myplot2(lvta_opto_rtpp,lvta_yfp_rtpp,10,11,ylab,{'Right','Left'}, 'Right vs Left', ...
    cohort, 1:size(lvta_opto_rtpp,1),  1:size(lvta_opto_rtpp,1), type, col, fs, 32, colo); ylim([0 1])

% SNc
colo = 1;
[snc_light_yfp, snc_nolight_yfp, snc_light, snc_nolight] = myplot2(snc_opto_rtpp,snc_yfp_rtpp,16,17,ylab,xtic, cap, ...
    cohort, 1:size(lvta_opto_rtpp,1),  1:size(lvta_opto_rtpp,1), type, col, fs, 30, colo); ylim([0 1])

[snc_vel_light_yfp, snc_vel_nolight_yfp, snc_vel_light, snc_vel_nolight] = myplot2(snc_opto_rtpp,snc_yfp_rtpp,18,19,'Velocity (mm/s)',xtic, cap, ...
    cohort, 1:size(lvta_opto_rtpp,1),  1:size(lvta_opto_rtpp,1), type, col, fs, 31, colo); ylim([0 80])

[snc_rl_light_yfp, snc_rl_nolight_yfp, snc_rl_light, snc_rl_nolight] = myplot2(snc_opto_rtpp,snc_yfp_rtpp,10,11,ylab,{'Right','Left'}, 'Right vs Left', ...
    cohort, 1:size(lvta_opto_rtpp,1),  1:size(lvta_opto_rtpp,1), type, col, fs, 32, colo); ylim([0 1])

%%
% ANOVA: medial vs. lateral VTA only: ------------------------------------
y_time2 = [(light_yfp-nolight_yfp)' (light-nolight)' (light_yfp6_14-nolight_yfp6_14)' (light6_14-nolight6_14)']; % difference in time spent in chamber
y_vel2 = [(vel_light_yfp-vel_nolight_yfp)' (vel_light-vel_nolight)' (vel_light_yfp6_14-vel_nolight_yfp6_14)' (vel_light6_14-vel_nolight6_14)']; % difference btwn light and no light chamber (velocity)

roi2 = [make_cell(light_yfp,'lVTA')', make_cell(light, 'lVTA')', ...
         make_cell(light_yfp6_14, 'mVTA')', make_cell(light6_14, 'mVTA')'];
roi2 = roi2';

group2 = [make_cell(light_yfp,'yfp')', make_cell(light, 'nphr')', ...
         make_cell(light_yfp6_14, 'yfp')',make_cell(light6_14, 'nphr')'];
group2 = group2';

% dependent variable: time spent in chamber
p = anovan(y_time2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way group (nphr vs. yfp) vs. subregion 

% dependent varaible: velocity in chamber
p = anovan(y_vel2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way (nphr vs. yfp) vs. subregion

% ANOVA: medial vs. lateral vta vs. SNc ---------------------------------
y_time2 = [(light_yfp-nolight_yfp)' (light-nolight)' (light_yfp6_14-nolight_yfp6_14)' (light6_14-nolight6_14)' (snc_light_yfp-snc_nolight_yfp)' (snc_light-snc_nolight)']; % difference in time spent in chamber
y_vel2 = [(vel_light_yfp-vel_nolight_yfp)' (vel_light-vel_nolight)' (vel_light_yfp6_14-vel_nolight_yfp6_14)' (vel_light6_14-vel_nolight6_14)' (snc_vel_light_yfp-snc_vel_nolight_yfp)' (snc_vel_light-snc_vel_nolight)']; % difference btwn light and no light chamber (velocity)

roi2 = [make_cell(light_yfp,'lVTA')', make_cell(light, 'lVTA')', ...
         make_cell(light_yfp6_14, 'mVTA')', make_cell(light6_14, 'mVTA')', ...
         make_cell(snc_light_yfp,'SNc')', make_cell(snc_light, 'SNc')'];
roi2 = roi2';

group2 = [make_cell(light_yfp,'yfp')', make_cell(light, 'nphr')', ...
         make_cell(light_yfp6_14, 'yfp')',make_cell(light6_14, 'nphr')', ...
         make_cell(snc_light_yfp,'yfp')', make_cell(snc_light, 'nphr')'];
group2 = group2';

% dependent variable: time spent in chamber
p = anovan(y_time2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way group (nphr vs. yfp) vs. subregion 

% dependent varaible: velocity in chamber
p = anovan(y_vel2, {roi2, group2}, 'model', 'interaction', 'varnames',{'roi','group'}); % ANOVA: 2-way (nphr vs. yfp) vs. subregion


%% Plot RTPA  
%% chamber preference - {mvta, lvta} {opto, yfp}
lvta_yfp_vel = light_yfp - nolight_yfp;
lvta_opto_vel =light - nolight;
mvta_yfp_vel = light_yfp6_14 - nolight_yfp6_14;
mvta_opto_vel = light6_14 - nolight6_14;
snc_yfp_vel = snc_light_yfp - snc_nolight_yfp;
snc_opto_vel = snc_light - snc_nolight;

x_mvta_opto =ones(length(mvta_opto_vel),1);
x_mvta_yfp =ones(length(mvta_yfp_vel),1) + .5;
x_lvta_opto =ones(length(lvta_opto_vel),1) + 1.5;
x_lvta_yfp =ones(length(lvta_yfp_vel),1) + 2;
x_snc_opto =ones(length(snc_opto_vel),1) + 3;
x_snc_yfp =ones(length(snc_yfp_vel),1) + 3.5;

figure(43), clf, set(gcf, 'color','white'), hold on
plot([.5 5], [0 0], 'k--')
    
plot(x_lvta_yfp, lvta_yfp_vel, 'o', 'color', blue, 'markerfacecolor', 'w')
plot(x_lvta_opto, lvta_opto_vel, 'o', 'color', blue, 'markerfacecolor', blue)
plot(x_mvta_yfp, mvta_yfp_vel, 'o', 'color', rose, 'markerfacecolor', 'w')
plot(x_mvta_opto, mvta_opto_vel, 'o', 'color', rose, 'markerfacecolor', rose)
plot(x_snc_yfp, snc_yfp_vel, 'o', 'color', lightgreen, 'markerfacecolor', 'w')
plot(x_snc_opto, snc_opto_vel, 'o', 'color', lightgreen, 'markerfacecolor', lightgreen)

errorbar(1, mean(mvta_opto_vel), std(mvta_opto_vel), 'capsize', 0, 'color', darkrose)
errorbar(1.5, mean(mvta_yfp_vel), std(mvta_yfp_vel), 'capsize', 0, 'color', darkrose)
errorbar(2.5, mean(lvta_opto_vel), std(lvta_opto_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(3, mean(lvta_yfp_vel), std(lvta_yfp_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(4, mean(snc_opto_vel), std(snc_opto_vel), 'capsize', 0, 'color', green)
errorbar(4.5, mean(snc_yfp_vel), std(snc_yfp_vel), 'capsize', 0, 'color', green)

plot(1, mean(mvta_opto_vel), 'o', 'markersize', 10, 'color', darkrose, 'markerfacecolor', darkrose)
plot(1.5, mean(mvta_yfp_vel), 'o', 'markersize', 10,'color', darkrose, 'markerfacecolor', 'w')
plot(2.5, mean(lvta_opto_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', darkdarkblue)
plot(3, mean(lvta_yfp_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', 'w')
plot(4, mean(snc_opto_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', green)
plot(4.5, mean(snc_yfp_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', 'w')


xlim([.5 5])
set(gca, 'xtick', [])

% velocity - baseline {mvta, lvta} {opto, yfp}
lvta_yfp_vel = vel_light_yfp - vel_nolight_yfp;
lvta_opto_vel = vel_light - vel_nolight;
mvta_yfp_vel = vel_light_yfp6_14 - vel_nolight_yfp6_14;
mvta_opto_vel = vel_light6_14 - vel_nolight6_14;
snc_yfp_vel = snc_vel_light_yfp - snc_vel_nolight_yfp;
snc_opto_vel = snc_vel_light - snc_vel_nolight;

x_mvta_opto =ones(length(mvta_opto_vel),1);
x_mvta_yfp =ones(length(mvta_yfp_vel),1) + .5;
x_lvta_opto =ones(length(lvta_opto_vel),1) + 1.5;
x_lvta_yfp =ones(length(lvta_yfp_vel),1) + 2;
x_snc_opto =ones(length(snc_opto_vel),1) + 3;
x_snc_yfp =ones(length(snc_yfp_vel),1) + 3.5;

figure(44), clf, set(gcf, 'color','white'), hold on
plot([.5 5], [0 0], 'k--')
    
plot(x_lvta_yfp, lvta_yfp_vel, 'o', 'color', blue, 'markerfacecolor', 'w')
plot(x_lvta_opto, lvta_opto_vel, 'o', 'color', blue, 'markerfacecolor', blue)
plot(x_mvta_yfp, mvta_yfp_vel, 'o', 'color', rose, 'markerfacecolor', 'w')
plot(x_mvta_opto, mvta_opto_vel, 'o', 'color', rose, 'markerfacecolor', rose)
plot(x_snc_yfp, snc_yfp_vel, 'o', 'color', lightgreen, 'markerfacecolor', 'w')
plot(x_snc_opto, snc_opto_vel, 'o', 'color', lightgreen, 'markerfacecolor', lightgreen)

errorbar(1, mean(mvta_opto_vel), std(mvta_opto_vel), 'capsize', 0, 'color', darkrose)
errorbar(1.5, mean(mvta_yfp_vel), std(mvta_yfp_vel), 'capsize', 0, 'color', darkrose)
errorbar(2.5, mean(lvta_opto_vel), std(lvta_opto_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(3, mean(lvta_yfp_vel), std(lvta_yfp_vel), 'capsize', 0, 'color', darkdarkblue)
errorbar(4, mean(snc_opto_vel), std(snc_opto_vel), 'capsize', 0, 'color', green)
errorbar(4.5, mean(snc_yfp_vel), std(snc_yfp_vel), 'capsize', 0, 'color', green)

plot(1, mean(mvta_opto_vel), 'o', 'markersize', 10, 'color', darkrose, 'markerfacecolor', darkrose)
plot(1.5, mean(mvta_yfp_vel), 'o', 'markersize', 10,'color', darkrose, 'markerfacecolor', 'w')
plot(2.5, mean(lvta_opto_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', darkdarkblue)
plot(3, mean(lvta_yfp_vel), 'o', 'markersize', 10,'color', darkdarkblue, 'markerfacecolor', 'w')
plot(4, mean(snc_opto_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', green)
plot(4.5, mean(snc_yfp_vel), 'o', 'markersize', 10,'color', green, 'markerfacecolor', 'w')


xlim([.5 5])
set(gca, 'xtick', [])




