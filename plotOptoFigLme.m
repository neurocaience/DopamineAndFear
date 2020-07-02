%% plot s-by-s freezing
function [] = plotOptoFigLme(oo1, oo2, oo3, yy1, yy2, yy3, ym, om, ystd, ostd, ...
    y1m, y1std, o1m, o1std, y2m, y2std, o2m, o2std, y3m, y3std, ...
    o3m, o3std, mID_opto, mID_yfp, regionStim, res1, res2, res3, resall, nphr, cueon, ...
    o_real, y_real)

figure(8), clf, set(gcf, 'color','white')
if nphr == 1
    %gold2 = [1 140/255 0];
    gold2 = [185/255 211/255 238/255]; % [198/255 226/255 238/255] ;  % latVTA (blue)
    gold2_line = [61/255 89/255 171/255];
else
    %gold2 = [0 0 1];
    gold2 = [255/255 200/255 200/255]; % mVTA (pink)
    gold2_line = [205/255 92/255 92/255];
    
end
gray = [.7 .7 .7];
ymax = 80;
yellow = [1 231/255 186/255];

if cueon == 1 
    areax = [10.5 16.5];
    areay = [100 100];
else
    areax = [29.5 35.5];
    areay = [100 100];
end


xx = 1:80;

% If we want to plot mean across extinction days: 
o = [oo1 oo2 oo3];
y = [yy1 yy2 yy3];

% subplot(1,4,1), ylim([0 100]), hold on
% title('All Ext Days')
% om = squeeze(nanmean(nanmean(o,2),1));
% os = squeeze(std(nanmean(o,2))./sqrt(size(mID_opto,1)));
% ym = squeeze(nanmean(nanmean(y,2),1));
% ys = squeeze(std(nanmean(y,2))./sqrt(size(mID_yfp,1)));
% errorbar(xx,ym,ys,'.','markerfacecolor','k','color','k','capsize',0)
% errorbar(xx+.1,om,os, '.','markerfacecolor',gold2,'color',gold2,'capsize',0)
% plotbars

% 20 s CS
xp = .05;
yp = .1;
xp_d = .35;
yp_d = .8;

subplot('position',[xp yp xp_d yp_d])
x = 1:84;
title(regionStim), 
area([21 85.5], [100 100], 'facecolor',yellow, 'linestyle','none'), hold on
plot(x+.4,ym,'ko','markersize',3,'markerfacecolor','k')
plot(x, om, 'o', 'markersize',3,'color',gold2_line, 'markerfacecolor',gold2_line)
plot([21 42.5 63.5; 21 42.5 63.5],[0 0 0; 100 100 100],'--','color',[.5 .5 .5])

errorbar(x+.4,ym, ystd, 'o','color',gray, 'markersize',1, 'markerfacecolor','k','capsize',0), hold on
errorbar(x,om,ostd, 'o', 'markersize',1,'markerfacecolor',gold2, 'color',gold2, 'capsize',0), hold on
plot(x+.4,ym,'ko','markersize',3,'markerfacecolor','k')
plot(x, om, 'o', 'markersize',3,'color',gold2_line, 'markerfacecolor',gold2_line)
set(gca,'xtick',[])

box off
ylim([0 ymax])
xlim([.5 85])
ylabel('%Frz During Cue')
legend(['YFP n=' num2str(size(mID_yfp,1))],['NpHR n=' num2str(size(mID_opto,1))])
legend boxoff
if resall(5).pvalue(2) <= .05
    text(20,20,['group: p=' num2str(resall(5).pvalue(2),'%.3f') '*'])
end
if resall(5).pvalue(4) <= .05
    text(20,10,['group:trialN p=' num2str(resall(5).pvalue(4), '%.3f') '*'])
end

%
xp_diff = .07;
xp_diff_ext = .03;
xp_d2 = .15;

subplot('position',[xp_d+xp+xp_diff yp xp_d2 yp_d]), 
area(areax, areay, 'facecolor',yellow, 'linestyle','none'), hold on, box off
title('Ext 1')
ylim([0 ymax])
plotbars
errorbar(xx,y1m,y1std,'.','markerfacecolor',gray,'color',gray,'capsize',0)
errorbar(xx+.1,o1m,o1std,'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y1m, 'color','k', 'linewidth',1)
plot(xx+.1,o1m, 'color',gold2_line, 'linewidth',1)
ylabel('%Frz per Second')
plot_tone()

%plotlme(res1)

subplot('position',[xp_d+xp+xp_diff+xp_diff_ext+xp_d2 yp xp_d2 yp_d]), 
area(areax, areay, 'facecolor',yellow, 'linestyle','none'), hold on, box off
title('Ext 2')
ylim([0 ymax])
plotbars
errorbar(xx,y2m,y2std,'.','markerfacecolor',gray,'color',gray,'capsize',0)
errorbar(xx+.1,o2m,o2std,'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y2m, 'color','k', 'linewidth',1)
plot(xx+.1,o2m, 'color',gold2_line, 'linewidth',1)
plot_tone()

%plotlme(res2)

subplot('position',[xp_d+xp+xp_diff++xp_diff_ext*2+xp_d2*2 yp xp_d2 yp_d]), 
area(areax, areay, 'facecolor',yellow, 'linestyle','none'), hold on, box off
title('Ext 3')
ylim([0 ymax])
area(areax, areay, 'facecolor',yellow, 'linestyle','none')
plotbars
errorbar(xx,y3m,y3std,'.','markerfacecolor',gray,'color',gray,'capsize',0)
errorbar(xx+.1,o3m,o3std,'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y3m, 'color','k', 'linewidth',1)
plot(xx+.1,o3m, 'color',gold2_line, 'linewidth',1)
plot_tone()
%plotlme(res3)

%%
% Plot the first few seconds of each trial
figure(9), clf, set(gcf, 'color','white'), % make figure of just first 5 seconds
ts = 5;
te = 16;  %20
te_trial = 50;

xx = ts:te;
xx_trial = ts:te_trial;
xp = .05;
yp = .1;
xp_d = .35;
yp_d = .8;
xp_diff = .07;
xp_diff_ext = .03;
xp_d2 = .15;

% First trial only
subplot('position',[xp yp xp_d yp_d]), hold on
title([regionStim ', Ext 1: 1st Trial'])
xlim([ts te_trial])
ylim([0 ymax])
plot([15.5,15.5],[0 100],'--','color',[.5 .5 .5])
plotbars
yt1 = squeeze(nanmean(yy1(:,1,:)));
yt1std = squeeze(nanstd(oo1(:,1,:)))./sqrt(size(mID_yfp,1));
ot1 = squeeze(nanmean(oo1(:,1,:)));
ot1std = squeeze(nanstd(oo1(:,1,:)))./sqrt(size(mID_opto,1));

errorbar(xx_trial,yt1(ts:te_trial),yt1std(ts:te_trial),'.','markerfacecolor','k','color','k','capsize',0)
errorbar(xx_trial+.1,ot1(ts:te_trial),ot1std(ts:te_trial),'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx_trial,yt1(ts:te_trial), 'color','k', 'linewidth',1)
plot(xx_trial+.1,ot1(ts:te_trial), 'color',gold2_line, 'linewidth',1)
plot([10.5 29.5], [2 2], 'b-','linewidth',1)
ylabel('%Frz per Second')

% Ext 1
subplot('position',[xp_d+xp+xp_diff yp xp_d2 yp_d]), 
area(areax, areay, 'facecolor',yellow, 'linestyle','none'), hold on, box off
title('Ext 1')
xlim([ts te])
ylim([0 ymax])
plot([16.5,16.5],[0 100],'--','color',[.5 .5 .5])
plotbars
errorbar(xx,y1m(ts:te),y1std(ts:te),'.','markerfacecolor','k','color','k','capsize',0)
errorbar(xx+.1,o1m(ts:te),o1std(ts:te),'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y1m(ts:te), 'color','k', 'linewidth',1)
plot(xx+.1,o1m(ts:te), 'color',gold2_line, 'linewidth',1)
ylabel('%Frz per Second')
plotlme(res1)
plot([10.5 29.5], [2 2], 'b-','linewidth',1)
set(gca,'xtick',[10 20],'xticklabel',[0 20])
% Ext 2
subplot('position',[xp_d+xp+xp_diff+xp_diff_ext+xp_d2 yp xp_d2 yp_d]),
area(areax, areay, 'facecolor',yellow, 'linestyle','none'), hold on, box off
title('Ext 2')
xlim([ts te])
ylim([0 ymax])
plot([16.5,16.5],[0 100],'--','color',[.5 .5 .5])
plotbars
errorbar(xx,y2m(ts:te),y2std(ts:te),'.','markerfacecolor','k','color','k','capsize',0)
errorbar(xx+.1,o2m(ts:te),o2std(ts:te),'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y2m(ts:te), 'color','k', 'linewidth',1)
plot(xx+.1,o2m(ts:te), 'color',gold2_line, 'linewidth',1)
plotlme(res2)
plot([10.5 29.5], [2 2], 'b-','linewidth',1)
set(gca,'xtick',[10 20],'xticklabel',[0 20])
% Ext 3
subplot('position',[xp_d+xp+xp_diff++xp_diff_ext*2+xp_d2*2 yp xp_d2 yp_d]), 
area(areax, areay, 'facecolor',yellow, 'linestyle','none'), hold on, box off
title('Ext 3')
plotbars
xlim([ts te])
ylim([0 ymax])
plot([10.5 29.5], [2 2], 'b-','linewidth',1)
set(gca,'xtick',[10 20],'xticklabel',[0 20])
plot([16.5,16.5],[0 100],'--','color',[.5 .5 .5])

errorbar(xx,y3m(ts:te),y3std(ts:te),'.','markerfacecolor','k','color','k','capsize',0)
errorbar(xx+.1,o3m(ts:te),o3std(ts:te),'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y3m(ts:te), 'color','k', 'linewidth',1)
plot(xx+.1,o3m(ts:te), 'color',gold2_line, 'linewidth',1)
plotlme(res3)

% Plot extra figure
figure(10), clf, set(gcf, 'color','white')
x = 1:84;
title(regionStim), 
%area([21 85.5], [100 100], 'facecolor',yellow, 'linestyle','none'), hold on
plot(x+.4,ym,'ko','markersize',3,'markerfacecolor','k')
plot(x, om, 'o', 'markersize',3,'color',gold2_line, 'markerfacecolor',gold2_line)
plot([21 42.5 63.5; 21 42.5 63.5],[0 0 0; 100 100 100],'--','color',[.5 .5 .5])

errorbar(x+.4,ym, ystd, 'o','color',gray, 'markersize',1, 'markerfacecolor','k','capsize',0), hold on
errorbar(x,om,ostd, 'o', 'markersize',1,'markerfacecolor',gold2, 'color',gold2, 'capsize',0), hold on
plot(x+.4,ym,'ko','markersize',3,'markerfacecolor','k')
plot(x, om, 'o', 'markersize',3,'color',gold2_line, 'markerfacecolor',gold2_line)
set(gca,'xtick',[])

% t-test for every trial
h = nan(size(o_real,2),1);
p = nan(size(o_real,2),1);
for t = 1:size(o_real,2)
    [h(t), p(t)] = ttest2(o_real(:,t),y_real(:,t));
end

h(h<1) = NaN;
length(h)
plot(1:84, h*80,'.')


box off
ylim([0 ymax])
xlim([.5 85])
ylabel('%Frz During Cue')
legend(['YFP n=' num2str(size(mID_yfp,1))],['NpHR n=' num2str(size(mID_opto,1))])
legend boxoff

%if resall(5).pvalue(2) <= .05
%    text(20,20,['group: p=' num2str(resall(5).pvalue(2),'%.3f') '*'])
%end
%if resall(5).pvalue(4) <= .05
%    text(20,10,['group:trialN p=' num2str(resall(5).pvalue(4), '%.3f') '*'])
%end



%% added 4/14/2020
% plot all of extinction trials as one
oo = [oo1 oo2 oo3]; oo_m = squeeze(nanmean(oo,2)); oo_mm = nanmean(oo_m,1);
yy = [yy1 yy2 yy3]; yy_m = squeeze(nanmean(yy,2)); yy_mm = nanmean(yy_m,1);
oo_sem = nanstd(oo_m)./sqrt(size(oo,1));
yy_sem = nanstd(yy_m)./sqrt(size(yy,1));

%% Optional figure: All extinctions 
% figure(11), clf, set(gcf, 'color', 'white')
% 
% area(areax, areay, 'facecolor',yellow, 'linestyle','none'), hold on, box off
% ylim([0 ymax])
% plotbars
% xx = 1:80;
% errorbar(xx,yy_mm,yy_sem,'.','markerfacecolor',gray,'color',gray,'capsize',0)
% errorbar(xx+.1,oo_mm,oo_sem,'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
% plot(xx,yy_mm, 'color','k', 'linewidth',1)
% plot(xx+.1,oo_mm, 'color',gold2_line, 'linewidth',1)
% plot_tone()
% xlim([0 80])



%%

    function [] = plotlme(res)
        % Assumes pvalue(2) is the value of "group" effect
        % Assumes lme numbers (res(X)) is models 1-4 of LME output from
        % run_lmes() function
        
        if res(1).pvalue(2) <= .05   % CS
            text(20,77,'*','fontsize',15)
            %else
            %    text(20,77,'*','fontsize',15)
        end
        if res(2).pvalue(2) <= .05   % CS
            text(31,77,'*','fontsize',15)
        end
        if res(3).pvalue(2) <= .05   % CS
            text(37,77,'*','fontsize',15)
        end
        if res(4).pvalue(2) <= .05   % CS
            text(50,77,'*','fontsize',15)
        end
        if res(9).pvalue(2) <= .05
           text(12.5,5,'#','color','b','fontsize',15)
        end
        if res(10).pvalue(4) <= .05
           text(12.5,5,'*','color','b','fontsize',15) 
        end
        
    end
       
    function [] = plot_tone()
        plot([10.5 30.5], [5 5], 'b-', 'linewidth',1)
        set(gca,'xtick',[10 30 50 70])
        set(gca,'xticklabel',[0 20 40 60])
    end

end