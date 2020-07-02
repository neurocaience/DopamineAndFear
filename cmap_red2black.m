%RED to blue colormap
function map = cmap_red2black(varargin)
rmap = [0:.01:1]'; omap = ones(size(rmap)); 
map  = [rmap rmap rmap; flipud(omap) flipud(rmap) flipud(rmap)];

% alternate map:
rmap = [0:.01:1]'; omap = ones(size(rmap)); 
bmap1 = linspace(.25, 1, 101)'; 
bmap2 = linspace(.25, 1, 101)';
bmap3 = linspace(1, 1, 101)';

map  = [rmap rmap rmap; flipud(bmap3) flipud(bmap2) flipud(bmap1)];

end
%map = colormap_helper(map, varargin{:});