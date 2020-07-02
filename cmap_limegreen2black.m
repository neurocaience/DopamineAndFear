function map = cmap_limegreen2black(varargin)

rmap = [0:.01:1]'; omap = ones(size(rmap)); 
map1 = linspace(250,167,length(rmap));
map2 = linspace(255,239,length(rmap));
map3 = linspace(250,53,length(rmap));

map1 = map1/255;
map2 = map2/255;
map3 = map3/255;

map  = [rmap rmap rmap; map1' map2' map3'];

%Alternate map:

%rmap = [0:.01:1]'; omap = ones(size(rmap)); 
%bmap1 = linspace(.4, 1, 101)'; 
%bmap2 = linspace(.5, 1, 101)';
%bmap3 = linspace(.93, 1, 101)';
%map  = [rmap rmap rmap; flipud(bmap1) flipud(bmap2) flipud(bmap3)];

end