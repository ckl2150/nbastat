function [mat, r, g, b, row, col] = faveteam(filename)
    cd('~/Github/nbastattrack/TeamLogos');
    filename = strcat(filename, '.jpg');
    mat = imread(filename);
    r = mean(mean(mat(:,:,1)));
    g = mean(mean(mat(:,:,2)));
    b = mean(mean(mat(:,:,3)));
    [row col] = size(mat);
    cd('~/Github/nbastattrack');
    
end