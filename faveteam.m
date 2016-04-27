function [mat, r, g, b] = faveteam(filename)
%This function prompts a user for a favorite team upon first loading. The
%player's background is set to that team's team logo. Alternatively, users
%can opt to stay with the default background
    filename = strcat(filename,'.jpg');
    mat = imread(filename);
    r = mean(mean(mat(:,:,1)));
    g = mean(mean(mat(:,:,2)));
    b = mean(mean(mat(:,:,3)));
    [row col] = size(mat);
end