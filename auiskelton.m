%This is the skelton gui, consisting of an opening ui to pick whether
%looking at one player or comparing two players, editable text boxes to
%search for players, a figure to show a single player's stats and a figure
%to compare two players.



function uiskelton

players = parsePlayer();
fullplayerindex = zeros(1);
currentplayer1 = struct('team', '', 'posit', '', 'first', '', 'last', '',...
    'filename', '', 'fullname', '');
currentplayer2 = struct('team', '', 'posit', '', 'first', '', 'last', '',...
    'filename', '', 'fullname', '');

%First, creates opening screen ui
openf = figure('Visible','off','color','white','Units','Normalized',...
    'Position',[0,0,1,1]);
set(openf,'Name','Welcome to Our Awesome Project')
movegui(openf,'center') %Can now probably get rid of this

logo = imread('nba-logo-on-wood.jpg');
background = image(logo);
set(gca,'Visible','off')

%Create popup menu to allow user to change background to their fave team
team_names = {'No preference', 'Lakers','Suns','Twolves','Pelicans','Nuggets','Kings','Jazz',...
    'Rockets','Grizzlies','Mavs','Blazers','Clippers','Thunder','Spurs',...
    'Warriors','Nets','Knicks','Bucks','Magic','Wizards','Bulls',...
    'Pistons','Pacers','Hornets','Celtics','Hawks','Heat','Raptors','Cavs'};
team_names(2:end) = sort(team_names(2:end));
r = 0;
g = 0;
b = 0;

faveteamtext = uicontrol(openf, 'Style', 'text', 'Visible', 'on', 'Units', 'Normalize', 'BackgroundColor', 'white', 'Position', [.018 .76 .1 .03], 'String', 'Pick your favorite team!');
favoriteteam = uicontrol(openf, 'Style', 'popupmenu', 'Visible', 'on', 'Units', 'Normalize', 'Position', [.015 .7 .1 .05], 'String', team_names, 'Callback', @setteamlogo);

function setteamlogo(hObject,~)
    teamfilename = hObject.String{hObject.Value};
    if ~strcmp(teamfilename, 'No preference')
        [logo, r, g, b] = faveteam(teamfilename);
        background = image(logo);
        set(gca,'Visible','off')
        set([faveteamtext favoriteteam], 'Visible', 'off');
        set(openf, 'Color', [r/255 g/255 b/255]);
    else
        set([faveteamtext favoriteteam], 'Visible', 'off');
    end
end

%Create instructions text box as well as push buttons for single player
%stats path or compare two players path

%Create button group for path options
% optionpbg = uibuttongroup('Visible','off','Units','Normalized',...
%     'Position',[0 0 .2 1],'backgroundcolor','white','BorderType','none');

%Textbox with instructions on which button to push
searchinstruct = uicontrol(openf,'Style','text',...
    'BackgroundColor','white','Units','Normalized',...
    'Position',[.022 .5 .08 .03],'String','Would you like to:','FontSize',12);

%Pushbutton for looking at single player
singleplayer = uicontrol(openf,'Style','pushbutton',...
    'String','Look at single player','Units','Normalized',...
    'Position',[.015 .45 .1 .05],'Callback',@spchosen);%callback function to open search box
%Pushbutton for comparing two players
twoplayers = uicontrol(openf,'Style','pushbutton',...
    'String','Compare two players','Units','Normalized',...
    'Position',[.015 .40 .1 .05],'Callback',@tpchosen);%callback function to open player-1 search box

%Create figure to show single player stats
singleplayerfig = figure('Visible','off','color','white',...
    'Units','Normalized','Position',[0 0 1 1]);
set(singleplayerfig,'Name','Welcome to Our Awesome Project')
movegui(singleplayerfig,'center')


%Create figure to show two player comparison
compare2fig = figure('Visible','off','color','white',...
    'Units','Normalized','Position',[0 0 1 1]);
set(compare2fig,'Name','Welcome to Our Awesome Project')
movegui(compare2fig,'center')

%Getting rid of back button to go opening figure

%Create back button to go back to opening figure from single display figures
%    back2openfigfromspfig = uicontrol(singleplayerfig,'Style','pushbutton',...
%         'String','Start Over','Units','Normalized','Position',[0 .95 .05 .05],...
%            'Callback',@back2start);%Callback function that goes back to the opening figure

%Create back button to go back to single player search from singleplayerfig
back2spchosenbutton = uicontrol(singleplayerfig,'Style','pushbutton',...
    'String','Back to Search','Units','Normalized','Position',[0 .95 .075 .05],...
    'Callback',@go2spchosen);%Callback function that goes back to single player search

%Create back button to go to 2 player search from singleplayer fig
go2tpchosenbutton = uicontrol(singleplayerfig,'Style','pushbutton',...
    'String','Compare two Players','Units','Normalized','Position',[.075 .95 .1 .05],...
    'Callback',@go2tpchosen);%Callback function that goes back to the opening figure

%getting rid of back button to go to opening figure

%Create back button to go back to opening figure from two display figure
%    back2openfigfromc2fig = uicontrol(compare2fig,'Style','pushbutton',...
%        'String','Start Over','Units','Normalized','Position',[0 .95 .05 .05],...
%        'Callback',@back2start);%Callback function that goes back to the opening figure

%Create back button to go back to tpchosen from two display figure
back2tpchosenbutton = uicontrol(compare2fig,'Style','pushbutton',...
    'String','Back to Search','Units','Normalized','Position',[0 .95 .075 .05],...
    'Callback',@go2tpchosen);%Callback function that goes to tpchosen

%Create back button to go to spchosen from 2 player compare fig
go2spchosenbutton = uicontrol(compare2fig,'Style','pushbutton',...
    'String','Look at Single Player','Units','Normalized','Position',[.075 .95 .1 .05],...
    'Callback',@go2spchosen);%Callback function that goes back to single player search

%Open gui is turned on
set(openf,'Visible','on')
set([searchinstruct singleplayer twoplayers],'Visible','on')

%global function which error checks user input of players

%Create button group for single player search 
oneplayersearch = uibuttongroup('Visible','off','Units','Normalized',...
    'Position',[0 0 .15 1],'backgroundcolor','white','BorderType','none');
disp(favoriteteam.Value)
if favoriteteam.Value > 1
    oneplayersearch.BackgroundColor = [r/255 g/255 b/255];
end

%Callback function if searching single player
function spchosen(~,~)
    set([searchinstruct singleplayer twoplayers],'Visible','off');
%    set(back2openspchosengroup,'Visible','on');

    %Search for player editable textbox and instruction
    oneplayersearchbox = uicontrol(oneplayersearch,'Style','edit',...
        'Units','Normalized','Position',[.05 .35 .8 .05],...
        'Callback', @confirm);%callback function to open fig for single player
    oneplayerinstruct = uicontrol(oneplayersearch,'Style','text',...
        'Units','Normalized','Position',[.05 .45 .8 .05],...
        'String','Enter player''s last name:');
   
    %Back button to go tpchosen from spchosen
    oneplayerbackbutton = uicontrol(oneplayersearch,'Style','pushbutton',...
    'String','Compare two Players','Units','Normalized','Position',[0 .95 .5 .05],...
    'Callback',@go2tpchosen);%Callback function that goes to tpchosen
    
    
    %Make search for player visible
    set(oneplayersearch,'Visible','on');
        
    function confirm(hObject,~)
        %Stores string from user input
        lastname = lower(hObject.String);
        
        %Error checks to ensure at least 2 letters are entered
        if length(lastname) == 1
            oneplayerinstruct.String = 'Please enter at least two letters';
        else
            %Finds all matches of the user string with database of players
            fullplayerindex = strfind({players.last}, lastname);
            for i = 1:length(players)
                if isempty(fullplayerindex{i})
                    fullplayerindex{i} = 0;
                end
            end
            fullplayerindex = find(cell2mat(fullplayerindex)); 
            if isempty(fullplayerindex)
                oneplayerinstruct.String = sprintf('Sorry, no player''s name starts with %c%s.', upper(lastname(1)),lastname(2:end));
            else
                %Uses the index vector to retrieve player names, and store
                %in a cell array
                namearr = cell(1,length(fullplayerindex));
                for i = 1:length(fullplayerindex)
                    namearr{i} = players(fullplayerindex(i)).fullname;
                end
                    oneplayerinstruct.String = 'Did you mean:';
                    oneplayersearchbox.Visible = 'off';
                    didyoumean = uicontrol(oneplayersearch, 'Style', 'popupmenu', 'Units', 'Normalize', 'Position', [.05 .35 .8 .05],'String', namearr, 'Callback', @openplayerstatfig);
                %end
            end
        end
        function openplayerstatfig(hObject,~)%Cbfn to open single player fig window
            currentplayer1 = players(fullplayerindex(hObject.Value));
            
            set([openf didyoumean],'Visible','off')
            set(singleplayerfig,'Name',currentplayer1.fullname)
            
            set(singleplayerfig, 'Color', [r/255 g/255 b/255]);
            set(gca,'Visible','off')
            
            set(singleplayerfig,'Visible','on')
            
            
            %Shows player headshot and positions it to the side
             phsname = imread(lower(strcat(currentplayer1.last,currentplayer1.first,'.jpg')));           
             set(gca,'Visible','off')
              ha = axes('Units', 'Normalized', 'Position', [0 .5 .25 .25]);
              im = imshow(phsname);
              ha.HandleVisibility = 'off';
              ha.Visible = 'off';
            
            
            
            games = parseStatLine(currentplayer1.filename);
            n=length(games);
            d=struct2cell(lastngames(games,n));
            rnames={'<html><font size=+15>Minutes Played','<html><font size=+15>Field Goal Percentage','<html><font size=+15>Three Pointer Percentage','<html><font size=+15>Free Throws Percentage','<html><font size=+15>Rebounds',...
                '<html><font size=+15>Assists','<html><font size=+15>Steals','<html><font size=+15>Blocks','<html><font size=+15>Turnovers','<html><font size=+15>Total Points'};
            cname=sprintf('<html><font size=+15>%s Stats',currentplayer1.fullname);
            t=uitable(singleplayerfig,'Data',d,'RowName',rnames,'ColumnName',cname,...
                'Units','normalized','FontSize', 40, 'Position',[.3,.2,.64,.748]);
             t.Position(3)=t.Extent(3);
             t.Position(4)=t.Extent(4);
             
            popup1 = uicontrol('Style', 'popup',...
                  'String', {'Last 5 Games','Last 10 Games',...
                  'Last 20 Games','Last 30 Games','All Games'},...
                  'Units','normalized', 'Position', [.5 .08 .1 .4],...
                  'Value', 5, 'Visible','off', 'Callback', @popfun1);
            popup2 = uicontrol('Style', 'popup',...
                  'String', {'Home','Away','All Games'},...
                  'Units','normalized', 'Visible','off',...    
                  'Position', [.35 .08 .1 .4], 'Value', 3,...   
                  'Callback', @popfun2);
             
%             popup1 = uicontrol('Style', 'popup',...
%                 'String', {'Last 5 Games','Last 10 Games',...
%                 'Last 20 Games','Last 30 Games','All Games'},...
%                 'Units','normalized', 'Position', [.5 .08 .1 .4],...
%                 'Value', 5, 'Visible','off', 'Callback', @popfun1);
%             popup2 = uicontrol('Style', 'popup',...
%                 'String', {'Home','Away','All Games'},...
%                 'Units','normalized', 'Visible','off',...    
%                 'Position', [.35 .08 .1 .4], 'Value', 3,...   
%                 'Callback', @popfun2);
%            popup1.Visible='on';
%            popup2.Visible='on';
%            t.Visible='on';
            pb1=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
               'Position', [.25 .825 .05 .07],'Callback', @pbfun1);
            pb2=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
               'Position', [.25 .754 .05 .07],'Callback', @pbfun2);
            pb3=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
               'Position', [.25 .683 .05 .071],'Callback', @pbfun3);
            pb4=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
                'Position', [.25 .612 .05 .07],'Callback', @pbfun4);
            pb5=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
                'Position', [.25 .541 .05 .071],'Callback', @pbfun5);
            pb6=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
                'Position', [.25 .47 .05 .07],'Callback', @pbfun6);
            pb7=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
                'Position', [.25 .4 .05 .07],'Callback', @pbfun7);
            pb8=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
                'Position', [.25 .33 .05 .07],'Callback', @pbfun8);
            pb9=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
                'Position', [.25 .26 .05 .07],'Callback', @pbfun9);
            pb10=uicontrol('Style','pushbutton','String','Plot Stat','Units','normalized',...
                'Position', [.25 .19 .05 .07],'Callback', @pbfun10);
            function pbfun1(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Minutes Played',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'min');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun2(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Field Goal Percentages',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'fgp');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun3(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Three Point Percentages',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'3pp');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun4(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Free Throw Percentages',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'ftp');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun5(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Rebounds',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'rebound');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun6(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Assists',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'ast');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun7(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Steals',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'stl');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun8(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Blocks',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'blk');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun9(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Turnovers',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'to');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function pbfun10(~,~)
                set(singleplayerfig,'Visible','off')
                tit=sprintf('%s Total Points',currentplayer1.fullname);
                plotstatfig=figure('Visible','off')
                backbutton=uicontrol('Style','pushbutton','String','Back to Player Page','Units','normalized',...
                'Position', [.1 .9 .05 .07],'Callback', @back69);
                backbutton.Position(3)=backbutton.Extent(3);
                backbutton.Position(4)=backbutton.Extent(4);
                [x,y]=plotStats(games,length(games),'pts');
                plot(x,y,'*')
                title(tit);
                plotstatfig.Visible='on'
            end
            function back69(~,~)
                plotstatfig.Visible='off'
                singleplayerfig.Visible='on'
            end
            
            

            

            
                         %Shows some basic information about the player
            vitalstr = sprintf('Team: %s\n\nPosition: %s\n\nAge: %s',...
                currentplayer1.team, currentplayer1.posit, games.Age); %see note below
            team = uicontrol('Style','text','String',vitalstr,...
                'Units','Normalized','Position',[.01 .4 .25 .1],...
                'BackgroundColor','w','FontSize',14);
            
            %Trying to access the first two columns of the last row to
            %display age at last game but forgetting how to do this
            % age = games.Age(82)
            
            function popfun1(source,~)
                val = source.Value;
                switch val
                    case 1
                        n=5;
                    case 2
                        n=10;
                    case 3
                        n=20;
                    case 4
                        n=30;
                    case 5
                        n=length(games);
                end
                val2=popup2.Value;
                switch val2
                    case 1
                        d=struct2cell(lastngames(games,n,'home'));
                        t.Data=d;
                    case 2
                        d=struct2cell(lastngames(games,n,'away'));
                        t.Data=d;
                    case 3    
                        d=struct2cell(lastngames(games,n));
                        t.Data=d;
                end
            end
            function popfun2(source,~)
                val = source.Value;
                switch val
                    case 1
                    d=struct2cell(lastngames(games,n,'home'));
                    t.Data=d;
                case 2
                    d=struct2cell(lastngames(games,n,'away'));
                    t.Data=d;
                case 3
                    d=struct2cell(lastngames(games,n));
                    t.Data=d;
                end
            end    
        end
    end
end


%Create button groups for two player search;one to get the first player and
%next to get the second player
twoplayersearch_a = uibuttongroup('Visible','off','Units','Normalized',...
    'Position',[0 0 .15 1],'backgroundcolor','white','BorderType','none');
twoplayersearch_b = uibuttongroup('Visible','off','Units','Normalized',...
    'Position',[0 0 .15 1],'backgroundcolor','white','BorderType','none');

%Callback function if comparing two players
function tpchosen(~,~)
set([searchinstruct singleplayer twoplayers],'Visible','off')


%Back buttons to go to spchosen
comp2playerbackbutton_a = uicontrol(twoplayersearch_a,'Style','pushbutton',...
    'String','Look at one Player','Units','Normalized','Position',[0 .95 .5 .05],...
    'Callback',@go2spchosen);%Callback function that goes to spchosen
comp2playerbackbutton_b = uicontrol(twoplayersearch_b,'Style','pushbutton',...
    'String','Look at one Player','Units','Normalized','Position',[0 .95 .5 .05],...
    'Callback',@go2spchosen);%Callback function that goes to spchosen

%Search for player one editable textbox and instruction
twoplayersearchbox1 = uicontrol(twoplayersearch_a,'Style','edit',...
    'Units','Normalized','Position',[.05 .35 .8 .05],'Callback',@confirm);
twoplayersearchbox2 = uicontrol(twoplayersearch_b,'Style','edit',...
    'Units','Normalized','Position',[.05 .33 .8 .05],...
    'Callback', @confirm);
compare2playersinstruct1 = uicontrol(twoplayersearch_a,'Style','text',...
    'Units','Normalized','Position',[.05 .45 .8 .05],...
    'String','Enter player one''s last name:');
%Search for player two instruction
compare2playersinstruct2 = uicontrol(twoplayersearch_b,'Style','text',...
    'Units','Normalized','Position',[.05 .4 .8 .05],...
    'String','Enter second player''s last name:');
%Make search for player 1 visible
set(twoplayersearch_a,'Visible','on');

    function confirm(hObject,~)
        lastname = lower(hObject.String);
        
        %Error checks to ensure at least 2 letters are entered
        if length(lastname) == 1
            hObject.String = 'Please enter at least two letters';
        else
            %Finds all matches of the user string with database of players
            fullplayerindex = strfind({players.last}, lastname);
            for i = 1:length(players)
                if isempty(fullplayerindex{i})
                    fullplayerindex{i} = 0;
                end
            end
            fullplayerindex = find(cell2mat(fullplayerindex)); 
            if isempty(fullplayerindex)
                if hObject == twoplayersearchbox1  
                    compare2playersinstruct1.String = sprintf('Sorry, no player''s name starts with %c%s.', upper(lastname(1)),lastname(2:end));
                else
                    compare2playersinstruct2.String = sprintf('Sorry, no player''s name starts with %c%s.', upper(lastname(1)), lastname(2:end));
                end
            else
                %Uses the index vector to retrieve player names, and store
                %in a cell array
                namearr = cell(1,length(fullplayerindex));
                for i = 1:length(fullplayerindex)
                    namearr{i} = players(fullplayerindex(i)).fullname;
                    end
                
                if hObject == twoplayersearchbox1
                    compare2playersinstruct1.String = 'Did you mean:';
                    twoplayersearchbox1.Visible = 'off';
                    didyoumean = uicontrol(twoplayersearch_a, 'Style', 'popupmenu', 'Units', 'Normalize', 'Position', [.05 .33 .8 .05],'String', namearr, 'Callback', @getplayer2);
                else
                    compare2playersinstruct2.String = 'Did you mean:';
                    twoplayersearchbox2.Visible = 'off';
                    didyoumean = uicontrol(twoplayersearch_b, 'Style', 'popupmenu', 'Units', 'Normalize', 'Position', [.05 .33 .8 .05],'String', namearr, 'Callback', @opencomp2playerfig);
                end
            end
        end

    

        function getplayer2 (hObject,~) %Cbfn to print first player's name and prompt for 2nd player FIX THIS SHIT
            currentplayer1 = players(fullplayerindex(hObject.Value));
            set([didyoumean twoplayersearch_a],'Visible','off');
            player1display = uicontrol(twoplayersearch_b,'Style','text',...
                'String',currentplayer1.fullname,'Units','Normalized',...
                'Position',[.05 .5 .8 .05]); %FIX THIS LINE
            twoplayersearch_b.Visible = 'on';
        end
        
        function opencomp2playerfig(hObject,~)%Cbfn to open 2 player comparison fig
            currentplayer2 = players(fullplayerindex(hObject.Value));
            set([openf didyoumean],'Visible','off')
            comptitle = sprintf('%s vs. %s Comparison',currentplayer1.fullname,currentplayer2.fullname);
            set(compare2fig,'Name',comptitle)
            set(compare2fig,'Visible','on')
            games1 = parseStatLine(currentplayer1.filename);
            games2 = parseStatLine(currentplayer2.filename);
            n1=length(games1);
            d1=struct2cell(lastngames(games1,n1));
            n2=length(games1);
            d2=struct2cell(lastngames(games2,n2));
            d=[d1,d2];
            rnames={'Minutes Played','Field Goal Percentage','Three Pointer Percentage','Free Throws Percentage','Rebounds',...
                'Assists','Steals','Blocks','Turnovers','Total Points'};
            cname={sprintf('%s Stats',currentplayer1.fullname),sprintf('%s Stats',currentplayer2.fullname)};
            t=uitable(compare2fig,'Data',d,'RowName',rnames,'ColumnName',cname,...
                'Units','normalized','Position',[.35,.5,.30,.30]);
            t.Position(3)=t.Extent(3);
            t.Position(4)=t.Extent(4);
            popup1 = uicontrol('Style', 'popup',...
                'String', {'Last 5 Games','Last 10 Games',...
                'Last 20 Games','Last 30 Games','All Games'},...
                'Units','normalized', 'Position', [.5 .08 .1 .4],...
                'Value', 5, 'Visible','off', 'Callback', @popfun1);
            popup2 = uicontrol('Style', 'popup',...
                'String', {'Home','Away','All Games'},...
                'Units','normalized', 'Visible','off',...    
                'Position', [.35 .08 .1 .4], 'Value', 3,...   
                'Callback', @popfun2);
            
            %Can play around with where this is so that loading it doesn't
            %look as fucked up
            
            %Shows player headshot for player1 and positions it 
             p1name = imread(lower(strcat(currentplayer1.last,currentplayer1.first,'.jpg')));           
             set(gca,'Visible','off')
              ha1 = axes('Units', 'Normalized', 'Position', [.4 .8 .15 .15]);
              im1 = imshow(p1name);
              ha1.HandleVisibility = 'off';
              ha1.Visible = 'off';
            
            %Shows player headshot for player2 and positions it 
             p2name = imread(lower(strcat(currentplayer2.last,currentplayer2.first,'.jpg')));           
             set(gca,'Visible','off')
              ha2 = axes('Units', 'Normalized', 'Position', [.6 .8 .15 .15]);
              im2 = imshow(p2name);
              ha2.HandleVisibility = 'off';
              ha2.Visible = 'off';
              
              vs = uicontrol('Style','text','Units','Normalized',...
                  'Position',[.565 .82 .02 .02],'String','VS.',...
                  'FontSize',14);
              
              
            popup1.Visible='on';
            popup2.Visible='on';
            t.Visible='on';
            function popfun1(source,~)
                val = source.Value;
                switch val
                    case 1
                        n1=5;
                        n2=5;
                    case 2
                        n1=10;
                        n2=10;
                    case 3
                        n1=20;
                        n2=20;
                    case 4
                        n1=30;
                        n2=30;
                    case 5
                        n1=length(games1);
                        n2=length(games2);
                end
                val2=popup2.Value;
                switch val2
                    case 1
                        d1=struct2cell(lastngames(games1,n1,'home'));
                        d2=struct2cell(lastngames(games2,n2,'home'));
                        d=[d1,d2];
                        t.Data=d;
                    case 2
                        d1=struct2cell(lastngames(games1,n1,'away'));
                        d2=struct2cell(lastngames(games2,n2,'away'));
                        d=[d1,d2];
                        t.Data=d;
                    case 3    
                        d1=struct2cell(lastngames(games1,n1));
                        d2=struct2cell(lastngames(games2,n2));
                        d=[d1,d2];
                        t.Data=d;
                end
            end
            function popfun2(source,~)
                val = source.Value;
                switch val
                    case 1
                    d1=struct2cell(lastngames(games1,n1,'home'));
                    d2=struct2cell(lastngames(games2,n2,'home'));
                    d=[d1,d2];
                    t.Data=d;
                case 2
                    d1=struct2cell(lastngames(games1,n1,'away'));
                    d2=struct2cell(lastngames(games2,n2,'away'));
                    d=[d1,d2];
                    t.Data=d;
                case 3
                    d1=struct2cell(lastngames(games1,n1));
                    d2=struct2cell(lastngames(games2,n2));
                    d=[d1,d2];
                    t.Data=d;
                end
            end
        end
    end
end

    function back2start (~,~)
        set([singleplayerfig compare2fig oneplayersearch ...
            twoplayersearch_a twoplayersearch_b],'Visible','off')
        set([openf searchinstruct singleplayer twoplayers],'Visible','on')
    end

    function go2spchosen(~,~)
        set([singleplayerfig compare2fig twoplayersearch_a twoplayersearch_b],...
            'Visible','off');
        set(openf,'Visible','on');
        spchosen;
    end

    function go2tpchosen(~,~)
        set([singleplayerfig compare2fig twoplayersearch_a twoplayersearch_b],...
            'Visible','off');
        set(openf,'Visible','on');
        tpchosen;
    end
        
end
