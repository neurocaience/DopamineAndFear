function [light_yfp, nolight_yfp, light, nolight] = myplot2(data,data_yfp,c1,c2,ylab,xtic, cap, ...
    cohort, mice, mice_yfp, type, col, fs, fig_num, colo)

    % colo = 1, use blue color

    %calculate velocity / light / bias
    light_yfp = nanmean(data_yfp(:,c1,:),3);
    nolight_yfp = nanmean(data_yfp(:,c2,:),3);
    m_y(1) = mean(light_yfp);   
    m_y(2) = mean(nolight_yfp);
    sd_y(1) = std(light_yfp)/sqrt(length(mice_yfp));
    sd_y(2) = std(nolight_yfp)/sqrt(length(mice_yfp));
    %calculate velocity / light / bias
    light = nanmean(data(:,c1,:),3);
    nolight = nanmean(data(:,c2,:),3);
    m_(1) = mean(light);   
    m_(2) = mean(nolight);
    sd_(1) = std(light)/sqrt(length(mice));
    sd_(2) = std(nolight)/sqrt(length(mice));
    
    %%
    %fig_num = 30;
    %ylab = '% Total Time Spent in Chamber';
    %xtic = {'Light'; 'No Light'};
    
    rose = [255/255 200/255 200/255];
    darkrose = [255/255 110/255 110/255];
    yel = 'y';
    grey = [.6 .6 .6];
    darkgrey = [.3 .3 .3];
    blue = [198/255 226/255 238/255];
    darkdarkrose = [250/255 50/255 50/255];
    
    if colo == 1
        rose = blue;
        darkrose = [150/255 180/255 238/255];
        darkdarkrose = [100/255 100/255 238/255];
    end
    
    
    x1=1; x2=2; y1=3.5; y2=4.5;
    xx_yfp = ones(length(light_yfp),1);
    xx_opto = ones(length(light),1);
    
    figure(fig_num), clf, hold on
    set(gcf,'color','white')

    %bar(x1, m_(1), 'facecolor', rose, 'edgecolor','y')
    %bar(x2, m_(2), 'facecolor', rose, 'edgecolor','k')    
    bar([x1 x2], m_, 'facecolor', rose,        'edgecolor','none')
    bar([y1 y2], m_y, 'facecolor', grey, 'edgecolor', 'none')
    
    plot([y1*xx_yfp'; y2*xx_yfp'], [light_yfp'; nolight_yfp'],'o-', 'color',darkgrey, ...
        'markerfacecolor', 'k', 'markeredgecolor', 'none')
    plot([x1*xx_opto'; x2*xx_opto'], [light'; nolight'],'o-', 'color', darkrose, ...
        'markerfacecolor', darkdarkrose, 'markeredgecolor', 'none')
    
    %errorbar([y1 y2], m_y, sd_y, '.', 'color', grey, 'capsize',0, 'linewidth',2)   
    %errorbar([x1 x2], m_, sd_,   '.', 'color', rose, 'capsize',0, 'linewidth',2)       
    
    set(gca,'xtick',[x1 x2 y1 y2], 'xticklabel', xtic)
    %set(gca,'ytick',[0 .5 1])
    ylabel(ylab);
    

    xlim([.25 5.25])
   
    %ylim([0 5])
end
