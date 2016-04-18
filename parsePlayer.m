%parsePlayer.m

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
        player(count).team = txt(j,1);
        player(count).posit = heading{i};
        player(count).first = txt(j,i+1);
        player(count).last = txt(j,i+3);
        count = count + 1;
    end
end