%% plot s-by-s freezing
function [] = plotOptoFig(oo1, oo2, oo3, yy1, yy2, yy3, ym, om, ystd, ostd, ...
    y1m, y1std, o1m, o1std, y2m, y2std, o2m, o2std, y3m, y3std, ...
    o3m, o3std, mID_opto, mID_yfp, regionStim)

figure(7), clf, set(gcf, 'color','white')
gold2 = [1 140/255 0];

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
title(regionStim), hold on
plot(x+.4,ym,'ko','markersize',3,'markerfacecolor','k')
plot(x, om, 'o', 'markersize',3,'color',gold2, 'markerfacecolor',gold2)
errorbar(x+.4,ym, ystd, 'ko','markersize',1, 'markerfacecolor','k','capsize',0), hold on
errorbar(x,om,ostd, 'o', 'markersize',1,'markerfacecolor',gold2, 'color',gold2, 'capsize',0), hold on
plot([21 42.5 63.5; 21 42.5 63.5],[0 0 0; 100 100 100],'--','color',[.5 .5 .5])
box off
ylim([0 100])
xlim([1 85])
ylabel('%Frz During CS')
legend(['YFP n=' num2str(size(mID_yfp,1))],['NpHR n=' num2str(size(mID_opto,1))])
legend boxoff

%
xp_diff = .07;
xp_diff_ext = .03;
xp_d2 = .15;

subplot('position',[xp_d+xp+xp_diff yp xp_d2 yp_d]), hold on
title('Ext 1')
ylim([0 100])
plotbars
errorbar(xx,y1m,y1std,'.','markerfacecolor','k','color','k','capsize',0)
errorbar(xx+.1,o1m,o1std,'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y1m, 'color','k', 'linewidth',1)
plot(xx+.1,o1m, 'color',gold2, 'linewidth',1)
ylabel('%Frz per Second')

subplot('position',[xp_d+xp+xp_diff+xp_diff_ext+xp_d2 yp xp_d2 yp_d]), hold on
title('Ext 2')
ylim([0 100])
plotbars
errorbar(xx,y2m,y2std,'.','markerfacecolor','k','color','k','capsize',0)
errorbar(xx+.1,o2m,o2std,'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y2m, 'color','k', 'linewidth',1)
plot(xx+.1,o2m, 'color',gold2, 'linewidth',1)

subplot('position',[xp_d+xp+xp_diff++xp_diff_ext*2+xp_d2*2 yp xp_d2 yp_d]), hold on
title('Ext 3')
ylim([0 100])
plotbars
errorbar(xx,y3m,y3std,'.','markerfacecolor','k','color','k','capsize',0)
errorbar(xx+.1,o3m,o3std,'.','markerfacecolor',gold2,'color',gold2,'capsize',0)
plot(xx,y3m, 'color','k', 'linewidth',1)
plot(xx+.1,o3m, 'color',gold2, 'linewidth',1)

end