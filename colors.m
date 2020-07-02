function [rose, darkrose, darkdarkrose, ...
    grey, darkgrey, ...
    blue, darkblue, darkdarkblue, ...
    r2b, b2b, p2b, g2b, lg2b, lavendar, lightgreen, limegreen] = colors()

rose = [255/255 200/255 200/255];
darkrose = [255/255 110/255 110/255];
darkdarkrose = [250/255 50/255 50/255];
grey = [.6 .6 .6];
darkgrey = [.3 .3 .3];
blue = [198/255 226/255 238/255];
darkblue = [150/255 180/255 238/255];
darkdarkblue = [100/255 100/255 238/255];
teal = [187/255 1 1];
lavendar = [209/255 210/255 249/255];
lightgreen = [168/255 239/255 189/255];
limegreen = [200/255 237/255 142/255];

r2b = cmap_red2black;
b2b = cmap_blue2black;
p2b = cmap_purple2black;
g2b = cmap_green2black;
lg2b = cmap_limegreen2black;
end

