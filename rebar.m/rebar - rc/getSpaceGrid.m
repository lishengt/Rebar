function [ obstacles ] = getSpaceGrid( XLENGTH, YLENGTH, ZLENGTH, step )

nLayers = XLENGTH / step + 1;
nrows = YLENGTH / step + 1;
ncols = ZLENGTH / step + 1;

obstacles = zeros(nLayers, nrows, ncols);
end

