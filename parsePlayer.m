function player = parsePlayer()

%Retrieves player bio such as name, team, and position by converting an
%Excel file into a vector of structures, where each element is a different
%player.

%Extract info from Excel spreadsheet
[num,txt,raw] = xlsread('data.xlsx');
[r c] = size(txt);

heading = txt(1,:);
count = 1;

%Remove whitespace; changes elements to remove whitespace; allows for
%proper fieldnames
heading = strrep(heading, ' ', '');

%first loop iterates through columns, since data sheet is split into 4
%sections, each spanning 4 columns

%second loop iterates through rows
for i = 2:4:18
    for j = 2:r
        team = heading{1};
        posit = heading{2};
        first = heading{3};
        last = 'LastName';
        player(count).team = txt{j,1};
        player(count).posit = heading{i};
        
        %pulls out first and last name into variables for manipulation
        firstn = lower(txt{j,i+1});
        firstupper = strcat(upper(firstn(1)), firstn(2:end));
        
        firstn = strrep(firstn,'.','');

        
        player(count).first = firstn;
        
        lastn = lower(strtrim(txt{j,i+3}));
        player(count).last = lastn;
        
   
        lastupper = strcat(upper(lastn(1)), lastn(2:end));
        full = sprintf('%s %s', firstupper, lastupper);
        player(count).fullname = full;
        
        %The following if/else statement creates the name of player
        %data filenames in the correct format. In this format, up to the
        %first 5 letters of the last name are used, and the first 2 letters
        %of the first name. This filename is stored in the fieldname
        %filename, which can be used to point to a file sitting in the
        %database.
        
        if length(lastn) <= 5
            file = sprintf('players_%c_%s%s01_gamelog_2016__pgl_basic.csv',...
                lastn(1), lastn, firstn(1:2));
            player(count).filename = file;
        else
            file = sprintf('players_%c_%s%s01_gamelog_2016__pgl_basic.csv',...
                lastn(1), lastn(1:5), firstn(1:2));
            player(count).filename = file;
        end
        
        %while loop checks for filenames which could potentially be the
        %same. By default, files have a default '1' appended to it. If
        %duplicates are found, this number is incremented until it is a
        %unique filename.
        
        while sum(strcmp(file, {player.filename})) > 1;
            file(end-29:end-28) = sprintf('%.2d', ...
                str2double(file(end-29:end-28)) + 1);
        end
            
        count = count + 1;
    end
end