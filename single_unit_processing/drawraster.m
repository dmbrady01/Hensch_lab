function [drawnraster] = drawraster(rasters,i)
%A little loop that draws the raster (must have raster cell array already
%made)
%
%Written by D.M. Brady 4/2010

for j = 1:length(rasters{i})
        drawnraster = line([rasters{i}(j) rasters{i}(j)], [i-1 i]); %Draws a line where every spike 
        %occurred. First trial on the bottom
end