function [x,y] = plotStats(games, n, stat, varargin)
%This function returns a vector x and y for use in plotting

    if nargin == 4
        format = varargin{1};
    else
        format = '';        
    end

    count = 1;
    gamenum = length(games);
    
%Will not preallocate since we do not know ahead of time, the number of
%elements in our vectors
    
    while count ~= n+1
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
    end
    
    minutes = fliplr(minutes);
    fgmade = fliplr(fgmade);
    fgatmpt = fliplr(fgatmpt);
    threeptmade = fliplr(threeptmade);
    threeptatmpt = fliplr(threeptatmpt);
    ftmade = fliplr(ftmade);
    ftatmpt = fliplr(ftatmpt);
    rebounds = fliplr(rebounds);
    assists = fliplr(assists);
    steals = fliplr(steals);
    blocks = fliplr(blocks);
    to = fliplr(to);
    pts = fliplr(pts);
    
    %If input parameters match these conditions, the y vector will be
    %assigned to its associated stat
    
    if strcmp(stat,'min')
        y = minutes;
    elseif strcmp(stat,'fgp')
        y = fgmade./fgatmpt;
    elseif strcmp(stat,'3pp')
        y = threeptmade./threeptatmpt;
    elseif strcmp(stat,'ftp')
        y = ftmade./ftatmpt;
    elseif strcmp(stat,'rebound')
        y = rebounds;
    elseif strcmp(stat,'ast')
        y = assists;
    elseif strcmp(stat,'stl')
        y = steals;
    elseif strcmp(stat,'blk')
        y = blocks;
    elseif strcmp(stat,'to')
        y = to;
    elseif strcmp(stat,'pts')
        y = pts;
    end
    
    x = 1:length(y);
end