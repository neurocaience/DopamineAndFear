% Script for plotting figures: 
%   Figure 1D, Supplementary Figure B-E
%
% Author: Lili Cai, last update 2/26/2020

% Organization of 'Data' folder hierarchy paths: 
% F1: Data
%     F2: xFCgc | xFCopto | xEXTgc | xEXTopto
%           F3: test mouse IDs
%               .csv file in each F3 folder

% Data in .csv is plotted as: 
% column 1: epoch
% column 2: training loss (from 0 to 1)
% column 3: validation loss (from 0 to 1)
% column 4: percent correct (accuracy %)
% column 5: false negative (total number)
% column 6: falso positive (total number)
% column 7: true negative (total number)
% column 8: true positive (total number)

% Added to matrix: 
% column 9: false negative (%)
% column 10: false positive (%)
% column 11: true negative (%)
% column 12: true positive (%)
% column 13: FPR
% column 14: FNR

% Dependent functions: 
% extractCSV
% plotLossAccFNRFCR
% find_meanAndSEM

%% Extract + Plot Fear Condtioning & GCaMP context
f1 = 'Data';
f2d = {'xFCgc'}; %,'xFCopto','xEXTgc','xEXTopto'};
argsf2a.epoch = 19;
argsf2a.title = char(f2d);
argsf2a.figNum = 20;
[FCgc_res, FCgc_stat, FCgc_filename] = get_matrix(f1,f2d);

% Plots
plot_bar7(FCgc_res,FCgc_stat,argsf2a)     % Bar plots (Figure 1D)
plotLossAccFNRFPR(40, FCgc_stat, argsf2a, 20, 'Context: Fear Conditioning GCaMP')   % Supplementary plots (Supplementary Figure 1B) 

%% Extract + Plot Fear Conditioning & Opto context
f1 = 'Data';
f2d = {'xFCopto'}; %,'xFCopto','xEXTgc','xEXTopto'};
argsf2b.epoch = 20;
argsf2b.title = char(f2d);
argsf2b.figNum = 30;
[FCopto_res, FCopto_stat, FCopto_filename] = get_matrix(f1,f2d);

%% Plots
plot_bar7(FCopto_res,FCopto_stat,argsf2b)  % Bar plots (Figure 1D)
plotLossAccFNRFPR(20, FCopto_stat, argsf2b, 30, 'Context: Fear Conditioning Opto')   % Supplementary plots (Supplementary Figure 1D) 

%% Extract + Plot Fear Extinction & GCaMP context
f1 = 'Data';
f2d = {'xEXTgc'}; %,'xFCopto','xEXTgc','xEXTopto'};
argsf2c.epoch = 20;
argsf2c.title = char(f2d);
argsf2c.figNum = 40;
[EXTgc_res, EXTgc_stat, EXTgc_filename] = get_matrix(f1,f2d);

%% Plots
plot_bar7(EXTgc_res,EXTgc_stat,argsf2c)  % Bar plots (Figure 1D)
plotLossAccFNRFPR(20, EXTgc_stat, argsf2c, 40, 'Context: Fear Extinction GCaMP')   % Supplementary plots (Supplementary Figure 1D) 

%% Extract + Plot Fear Extinction & Opto context
f1 = 'Data';
f2d = {'xEXTopto'}; %,'xFCopto','xEXTgc','xEXTopto'};
argsf2d.epoch = 20;
argsf2d.title = char(f2d);
argsf2d.figNum = 50;
[EXTopto_res, EXTopto_stat, EXTopto_filename] = get_matrix(f1,f2d);

% Plots
plot_bar7(EXTopto_res,EXTopto_stat,argsf2d)  % Bar plots (Figure 1D)
plotLossAccFNRFPR(20, EXTopto_stat, argsf2d, 50, 'Context: Fear Extinction Opto')   % Supplementary plots (Supplementary Figure 1D) 

%% Imbedded functions
% Barplot of Acc,TP, TN, FP, FN, FPR, FNR --------------------------
function [] = plot_bar7(res, stat, args)
    figure(args.figNum)
    
    e = args.epoch;
    bardata(1,1) = stat.m_acc(args.epoch);
    bardata(1,2) = stat.sem_acc(args.epoch);
    bardata(2,1) = stat.m_tp(args.epoch);
    bardata(2,2) = stat.sem_tp(args.epoch);
    bardata(3,1) = stat.m_tn(args.epoch);
    bardata(3,2) = stat.sem_tn(args.epoch);
    bardata(4,1) = stat.m_fp(args.epoch);
    bardata(4,2) = stat.sem_fp(args.epoch);
    bardata(5,1) = stat.m_fn(args.epoch);
    bardata(5,2) = stat.sem_fn(args.epoch);
    
    bardata(6,1) = stat.m_fpr(args.epoch);
    bardata(6,2) = stat.sem_fpr(args.epoch);
    bardata(7,1) = stat.m_fnr(args.epoch);
    bardata(7,2) = stat.sem_fnr(args.epoch);

    clf, hold on
    % plot bar data
    set(gcf,'color','white')
    errorbar(bardata(:,1),bardata(:,2),'k.', 'capsize',0)
    bar(bardata(:,1), 'FaceColor','k','barwidth',.7)
    
    set(gca,'xtick',1:7)
    set(gca,'xticklabel',{'Acc','TP','TN','FP','FN','FPR','FNR'})
    xlim([.5 7.5]) 
    for b=1:7 
        if b == 1
            text(b-.2,bardata(b,1)-20,[num2str(round(bardata(b,1))) '%'],'color','white')
        elseif b >= 2 && b <= 5
            text(b-.1,bardata(b,1)+10,[num2str(round(bardata(b,1))) '%'])
        else
            text(b-.3,bardata(b,1)+20,[num2str(round(bardata(b,1))) '%'])
        end
    end
    
    errorbar(bardata(:,1),bardata(:,2),'k.', 'capsize',0)
    
    title(args.title)
end

%%
function [res, stat, filename] = get_matrix(f1,f2)
% Given folder 1, and subfolder 2, get the resulting matrix .csv file from
% all subfolders 3

% Calculate extra columns

% Calculate the mean and SEM of those extra columns

    % Obtain folder files for relevant f2
    f3 = dir(fullfile(f1,f2{1}));

    % Extract CSV file from each f3 folder (a folder that is not '.' or '..')
    filename = {};
    res = nan(size(f3,1),200,8);

    for f = 1:size(f3,1)   % NOTE! Starts at 3, because other 2 indexes don't give anything
        if strfind(f3(f).name, 'mouse') >= 1
            disp(char(fullfile(f1,f2,f3(f).name)))
            [filename{f}, res_] = extractCSV(char(fullfile(f1,f2,f3(f).name)));
            res(f,1:length(res_),:) = res_;
        end
    end

    % Calculate additional values:
    tot = res(:,:,5) + res(:,:,6) + res(:,:,7) + res(:,:,8);

    res(:,:,9) = res(:,:,5) *100 ./ tot;
    res(:,:,10) = res(:,:,6) *100 ./ tot;
    res(:,:,11) = res(:,:,7) *100 ./ tot;
    res(:,:,12) = res(:,:,8) *100 ./ tot;

    res(:,:,13) = res(:,:,10) *100 ./ ( res(:,:,10) + res(:,:,11) );  % FPR = FP / (FP + TN)
    res(:,:,14) = res(:,:,9) *100 ./ ( res(:,:,9) + res(:,:,12) );  % FNR = FN / (FN + TP)
    res(:,:,15) = res(:,:,8) ./ ( res(:,:,6) + res(:,:,8) );  % Precision = TP / (TP + FP)
    res(:,:,16) = res(:,:,8) ./ ( res(:,:,5) + res(:,:,8) );  % Recall = TP / (TP + FN)    

    % find mean and SEM for relevant columns
    [stat.m_acc, stat.sem_acc] = find_meanAndSEM(res, 4); % in percentage
    [stat.m_fn, stat.sem_fn] = find_meanAndSEM(res, 9);
    [stat.m_fp, stat.sem_fp] = find_meanAndSEM(res, 10);
    [stat.m_tn, stat.sem_tn] = find_meanAndSEM(res, 11);
    [stat.m_tp, stat.sem_tp] = find_meanAndSEM(res, 12);
    [stat.m_fpr, stat.sem_fpr] = find_meanAndSEM(res, 13);
    [stat.m_fnr, stat.sem_fnr] = find_meanAndSEM(res, 14);
    [stat.m_test, stat.sem_test] = find_meanAndSEM(res, 3);
    [stat.m_train, stat.sem_train] = find_meanAndSEM(res, 2);   
    
    disp('done')
end

function [] = plotNice(m_f0,color)
    plot(m_f0, 'o','color', color, 'markersize',1, 'markerfacecolor',color)
end
function []= eb(x, m, sem, color)
    errorbar(x, m, sem, '.', 'color', color,'markersize',1, 'markerfacecolor', color,'capsize',0)
end