function avgs = lastngames(games, n, varargin)
%function which takes a vector of structures as input and a number n, and
%returns the average numbers of all categories over n games.

endgame = false;

if nargin == 3
    format = varargin{1};
else
    format = '';
end

%counter to track number of games played
count = 1;

%gamenum, in conjunction with count, is used to skip games which the player
%has not played
gamenum = length(games);

%preallocation
% minutes = zeros(1,n);
% fgmade = zeros(1,n);
% fgatmpt = zeros(1,n);
% threeptmade = zeros(1,n);
% threeptatmpt = zeros(1,n);
% ftmade = zeros(1,n);
% ftatmpt = zeros(1,n);
% rebounds = zeros(1,n);
% assists = zeros(1,n);
% steals = zeros(1,n);
% blocks = zeros(1,n);
% to = zeros(1,n);
% pts = zeros(1,n);

while (count ~= n+1) || (endgame)
    %only retrieves information if player has played in the current game
    if ~isempty(games(gamenum).G)
        
        %the constraints below ensure that if home/away games are desired,
        %games not in that format change a boolean such that it skips the
        %current game
        
        pass = false;
        
        if strcmp(format,'away') && isempty(games(gamenum).At)
            pass = true;
        elseif strcmp(format,'home') && ~isempty(games(gamenum).At)
            pass = true;
        end
        
        if ~pass
            %Converts minutes to decimal format
            [min, sec] = strtok(games(gamenum).MP,':');
            sec = sec(2:3);
            totaltime = str2double(sec)/60 + str2double(min);
            minutes(count) = totaltime;
        
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
            if gamenum == 1
                count = n + 1;
            else
                gamenum = gamenum - 1;
            end
        else
            if gamenum == 1
                count = n + 1;
            else
                gamenum = gamenum - 1;
            end
        end
    else
        if gamenum == 1
            count = n + 1;
        else
            gamenum = gamenum - 1;
        end
    end
    if gamenum == length(games)
        endgame = true;
    end
end


%anonymous function used to quickly refer to the formula for calculating
%show percentage
calcavg = @(made, attempt) sum(made)/sum(attempt);

minutes = mean(minutes);
minstr = sprintf('%.1f', minutes);

fgp = calcavg(fgmade,fgatmpt);
fgpstr = sprintf('%.2f', fgp);

threepp = calcavg(threeptmade,threeptatmpt);
threeppstr = sprintf('%.2f', threepp);

ftp = calcavg(ftmade,ftatmpt);
ftpstr = sprintf('%.2f', ftp);

rebounds = mean(rebounds);
rbdstr = sprintf('%.1f', rebounds);

assists = mean(assists);
aststr = sprintf('%.1f', assists);

steals = mean(steals);
stlstr = sprintf('%.1f', steals);

blocks = mean(blocks);
blkstr = sprintf('%.1f', blocks);

to = mean(to);
tostr = sprintf('%.1f', to);

pts = mean(pts);
ptsstr = sprintf('%.1f', pts);

avgs = struct('MP', minstr, 'FGp', fgpstr, 'ThreePtp', threeppstr, 'FTp', ftpstr, 'Rebounds',...
    rbdstr, 'Assists', aststr, 'Steals', stlstr, 'Blocks', blkstr,...
    'TO', tostr, 'Pts', ptsstr);

end

