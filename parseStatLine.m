function games = parseStatLine(filename)

fid = fopen(filename);

%specify the delimiter for regexp
expression = ',';

%files begin with an empty line, so script must skip first line
fgetl(fid);
line = fgetl(fid);

%obtaining categories and placing into a struct as fieldnames; renaming as
%necessary due to MATLAB constraints
splitcats = regexp(line, expression, 'split');
splitcats{6} = 'At';
splitcats{8} = 'Line';
splitcats{13} = 'FGp';
splitcats{14} = 'Threept';
splitcats{15} = 'ThreePtAmpt';
splitcats{16} = 'ThreePtp';
splitcats{19} = 'FTp';
splitcats{30} = 'PlusMinus';

%To iterate through the creation of games structures
count = 1;

while feof(fid) == 0
    line = fgetl(fid);
    
    %if line begins with R, skip the line since it is not a statline
    if line(1) ~= 'R'
        stats = regexp(line, expression, 'split');
        games(count) = cell2struct(stats, splitcats, 2);
        %iterate count to use as the index when creating next game structure
        count = count + 1;
    end
end


done = fclose('all');
end