function avgs = lastngames(games, n)
%function which takes a vector of structures as input and a number n, and
%returns the average numbers of all categories over n games.

count = 1;

gamenum = length(games);

minutes = zeros(1,n);
fgmade = zeros(1,n);
fgatmpt = zeros(1,n);
threeptmade = zeros(1,n);
threeptatmpt = zeros(1,n);
ftmade = zeros(1,n);
ftatmpt = zeros(1,n);
rebounds = zeros(1,n);
assists = zeros(1,n);
steals = zeros(1,n);
blocks = zeros(1,n);
to = zeros(1,n);
pts = zeros(1,n);

while count ~= n+1
    if ~isempty(games(gamenum).G)

        %[hours min] = strtok(games(gamenum).MP,':'); %NOT CORRECT
        %totaltime = str2double(min/60) + str2double(hours);
        %minutes(count) = totaltime;
        fgmade(count) = str2double(games(gamenum).FG);
        fgatmpt(count) = str2double(games(gamenum).FGA);
        threeptmade(count) = str2double(games(gamenum).Threept);
        threeptatmpt(count) = str2double(games(gamenum).ThreePtAmpt);
        ftmade(count) = str2double(games(gamenum).FT);
        ftatmpt(count) = str2double(games(gamenum).FTA);
        rebounds(count) = str2double(games(gamenum).TRB);
        assists(count) = str2double(games(gamenum).AST);
        steals(count) = str2double(games(gamenum).STL);
        blocks(count) = str2double(games(gamenum).BLK);
        to(count) = str2double(games(gamenum).TOV);
        pts(count) = str2double(games(gamenum).PTS);
        count = count + 1;
        gamenum = gamenum - 1;
    else
        gamenum = gamenum - 1;
    end
end

%minutes = mean(minutes);
fgmade = sum(fgmade);
fgatmpt = sum(fgatmpt);
fgp = fgmade/fgatmpt;
threeptmade = sum(threeptmade);
threeptatmpt = sum(threeptatmpt);
threepp = threeptmade/threeptatmpt;
ftmade = sum(ftmade);
ftatmpt = sum(ftatmpt);
ftp = ftmade/ftatmpt;
rebounds = mean(rebounds);
assists = mean(assists);
steals = mean(steals);
blocks = mean(blocks);
to = mean(to);
pts = mean(pts);

%haven't included minutes yet
avgs = struct('TP', minutes, 'FGp', fgp, 'ThreePtp', threepp, 'FTp', ftp, 'Rebounds',...
    rebounds, 'Assists', assists, 'Steals', steals, 'Blocks', blocks,...
    'TO', to, 'Pts', pts);

end

