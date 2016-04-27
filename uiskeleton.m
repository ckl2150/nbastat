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

%This sets the default nba logo on the opening screen
logo = imread('nba-logo-on-wood.jpg');
background = image(logo);
set(gca,'Visible','off')
r = 0;
g = 0;
b = 0;

%Create popup menu to allow user to change background to their favorite team
team_names = {'No preference', 'Lakers','Suns','Twolves','Pelicans','Nuggets','Kings','Jazz',...
    'Rockets','Grizzlies','Mavs','Blazers','Clippers','Thunder','Spurs',...
    'Warriors','Nets','Knicks','Bucks','Magic','Wizards','Bulls',...
    'Pistons','Pacers','Hornets','Celtics','Hawks','Heat','Raptors','Cavs'};

%THE DATABASE OF TEAM LOGOS IS UNSORTED; CALLING THE SORT FUNCTION ALLOWS
%FOR ALPHABETICAL ORDERING OF TEAM NAMES. THE USER CAN THEN EASILY SEARCH
%FOR HIS OR HER PREFERRED TEAM

team_names(2:end) = sort(team_names(2:end));

faveteamtext = uicontrol(openf, 'Style', 'text', 'Visible', 'on',...
    'Units','Normalize', 'BackgroundColor', 'white', 'Position',...
    [.018 .76 .1 .03], 'String', 'Pick your favorite team!');
favoriteteam = uicontrol(openf, 'Style', 'popupmenu', 'Visible',...
    'on', 'Units', 'Normalize', 'Position', [.015 .7 .1 .05],...
    'String', team_names, 'Callback', @setteamlogo);

%Sets team logo

%THIS FUNCTION PROCESSES AN INCOMING IMAGE BY CALLING THE FAVETEAM
%FUNCTION. SPECIFICALLY, IT CONVERTS THE IMAGE INTO A MATRIX, AND FINDS
%THE MEAN OF ITS RED, GREEN, AND BLUE DIMENSIONS. THE RESULTING COLOR IS
%USED AS THE BACKGROUND COLOR OF THE OPENING PAGE.

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

%Textbox with instructions on which button to push
searchinstruct = uicontrol(openf,'Style','text',...
    'BackgroundColor','white','Units','Normalized',...
    'Position',[.022 .5 .08 .03],'String','Would you like to:','FontSize',12);

%THE CONSTRUCTS BELOW CONSTITUTE A MENU-DRIVEN PROGRAM. IN THIS CASE, A
%USER CAN CHOOSE WHETHER TO LOOK UP STATSITICS FOR A SINGLE PLAYER, OR
%A COMPARISON OF TWO PLAYER'S STATISTICS

%Pushbutton for looking at single player
singleplayer = uicontrol(openf,'Style','pushbutton',...
    'String','Look at single player','Units','Normalized',...
    'Position',[.015 .45 .1 .05],'Callback',@spchosen); 
    %callback function to open search box

%Pushbutton for comparing two players
twoplayers = uicontrol(openf,'Style','pushbutton',...
    'String','Compare two players','Units','Normalized',...
    'Position',[.015 .40 .1 .05],'Callback',@tpchosen);
    %callback function to open player-1 search box

%Create figure to show single player stats
singleplayerfig = figure('Visible','off','color','black',...
    'Units','Normalized','Position',[0 0 1 1]);
set(singleplayerfig,'Name','Welcome to Our Awesome Project')
movegui(singleplayerfig,'center')


%Create figure to show two player comparison
compare2fig = figure('Visible','off','color','black',...
    'Units','Normalized','Position',[0 0 1 1]);
set(compare2fig,'Name','Welcome to Our Awesome Project')
movegui(compare2fig,'center')

%Create figure to display player stat graphs, one for each category
plotstatfig1 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig2 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig3 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig4 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig5 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig6 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig7 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig8 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig9 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);
plotstatfig10 = figure('Visible','off','Units','Normalized',...
    'Position',[0 1 1 1]);

%Create back button to go back to single player search from singleplayerfig
back2spchosenbutton = uicontrol(singleplayerfig,'Style','pushbutton',...
    'String','Back to Search','Units','Normalized','Position',[0 .95 .075 .05],...
    'Callback',@go2spchosen);%Callback function that goes back to single player search

%Create back button to go to 2 player search from singleplayer fig
go2tpchosenbutton = uicontrol(singleplayerfig,'Style','pushbutton',...
    'String','Compare two Players','Units','Normalized','Position',[.075 .95 .1 .05],...
    'Callback',@go2tpchosen);%Callback function that goes back to the opening figure

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

%Create button group for single player search 
oneplayersearch = uibuttongroup('Visible','off','Units','Normalized',...
    'Position',[0 0 .15 1],'backgroundcolor','white','BorderType','none');

%Callback function if searching single player
function spchosen(~,~)
    set([searchinstruct singleplayer twoplayers],'Visible','off');

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
        %This callback function error checks the user's input
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
                oneplayerinstruct.String = sprintf...
                    ('Sorry, no player''s name starts with %c%s.',...
                    upper(lastname(1)),lastname(2:end));
            else
                %Uses the index vector to retrieve player names, and store
                %in a cell array
                namearr = cell(1,length(fullplayerindex));
                for i = 1:length(fullplayerindex)
                    namearr{i} = players(fullplayerindex(i)).fullname;
                end
                oneplayerinstruct.String = 'Did you mean:';
                oneplayersearchbox.Visible = 'off';
                didyoumean = uicontrol(oneplayersearch, 'Style',...
                    'popupmenu', 'Units', 'Normalize', 'Position',...
                    [.05 .35 .8 .05],'String', namearr, 'Callback',...
                    @openplayerstatfig);
            end
        end
        
        %Cbfn to open single player fig window; this presents one player's
        %stats in a table format
        %It utilizes the functions lastngames (with variable parameters),
        %parseStatLine, plotStats
        function openplayerstatfig(hObject,~)
            currentplayer1 = players(fullplayerindex(hObject.Value));
            
            set([openf didyoumean],'Visible','off')
            set(singleplayerfig,'Name',currentplayer1.fullname)
            
            set(singleplayerfig, 'Color', 'black');
            set(gca,'Visible','off')
            
            %THE VARIABLE GAMES IS A VECTOR OF STRUCTURES, AND REFERS TO A
            %DATABASE OF PLAYED GAMES FOR ONE PLAYER. THIS VARIABLE IS USED
            %THROUGHOUT THE PROGRAM TO PROVIDE STATISTICAL DATA FOR
            %DISPLAY. IT IS CREATED USING THE PARSESTATLINE FUNCTION
            
            %THE FUNCTION WHICH OUTPUTS VARIABLE GAMES IS PARSESTATLINE.
            %THIS FUNCTION READS IN A FILE INPUT (IN THIS CASE, IN .CSV
            %FORMAT), AND RETURNS ITS INFORMATION TO A DATABASE FOR EASY
            %USE BY THE PROGRAM
            
            %games is a vector of games structures, used to access a
            %player's stats
            games = parseStatLine(currentplayer1.filename);
            n=length(games);
            d=struct2cell(lastngames(games,n));
            rnames={'<html><font size=+15>Minutes Played',...
                '<html><font size=+15>Field Goal Percentage',...
                '<html><font size=+15>Three Pointer Percentage',...
                '<html><font size=+15>Free Throws Percentage',...
                '<html><font size=+15>Rebounds',...
                '<html><font size=+15>Assists',...
                '<html><font size=+15>Steals',...
                '<html><font size=+15>Blocks',...
                '<html><font size=+15>Turnovers',...
                '<html><font size=+15>Total Points'};
            cname=sprintf('<html><font size=+15>%s Stats',currentplayer1.fullname);
            t=uitable(singleplayerfig,'Data',d,'RowName',rnames,'ColumnName',cname,...
                'Units','normalized','FontSize', 40, 'Position',[.3,.1,.64,.9]);
             t.Position(3)=t.Extent(3);
             t.Position(4)=t.Extent(4);
            
            
             
            popup1 = uicontrol(singleplayerfig,'Style', 'popup',...
                  'String', {'Last 5 Games','Last 10 Games',...
                  'Last 20 Games','Last 30 Games','All Games'},...
                  'Units','normalized', 'Position', [.74 .5 .1 .4],...
                  'Value', 5,'Callback', @popfun1);
            popup2 = uicontrol(singleplayerfig,'Style', 'popup',...
                  'String', {'Home','Away','All Games'},...
                  'Units','normalized',...    
                  'Position', [.43 .5 .1 .4], 'Value', 3,...   
                  'Callback', @popfun2);
            
            %These are 10 push buttons that plot a different stat in a
            %separate figure window
            pb1=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Minutes Played','Units','normalized',...
               'Position', [.235 .734 .065 .07],'Callback', @pbfun1);
            pb2=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Field Goal Pct','Units','normalized',...
               'Position', [.235 .664 .065 .07],'Callback', @pbfun2);
            pb3=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Three Pointer Pct','Units','normalized',...
               'Position', [.235 .594 .065 .071],'Callback', @pbfun3);
            pb4=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Free Throw Pct','Units','normalized',...
                'Position', [.235 .524 .065 .07],'Callback', @pbfun4);
            pb5=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Rebounds','Units','normalized',...
                'Position', [.235 .454 .065 .071],'Callback', @pbfun5);
            pb6=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Assists','Units','normalized',...
                'Position', [.235 .384 .065 .07],'Callback', @pbfun6);
            pb7=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Steals','Units','normalized',...
                'Position', [.235 .314 .065 .07],'Callback', @pbfun7);
            pb8=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Blocks','Units','normalized',...
                'Position', [.235 .244 .065 .07],'Callback', @pbfun8);
            pb9=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Turnovers','Units','normalized',...
                'Position', [.235 .174 .065 .07],'Callback', @pbfun9);
            pb10=uicontrol(singleplayerfig,'Style','pushbutton','String',...
                'Plot Total Points','Units','normalized',...
                'Position', [.235 .104 .065 .07],'Callback', @pbfun10);
            
            %The following comments apply to all variations of pbfun
            function pbfun1(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off');
                set(plotstatfig1, 'Visible', 'on');
                tit=sprintf('%s Minutes Played',currentplayer1.fullname);
                plotstatfig1.Name = currentplayer1.fullname;
                plotstatfig1.Units = 'normalized';
                plotstatfig1.Position = [0 0 1 1];
                
                backbutton=uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                pb1.Parent = plotstatfig1;
                pb2.Parent = plotstatfig1;
                pb3.Parent = plotstatfig1;
                pb4.Parent = plotstatfig1;
                pb5.Parent = plotstatfig1;
                pb6.Parent = plotstatfig1;
                pb7.Parent = plotstatfig1;
                pb8.Parent = plotstatfig1;
                pb9.Parent = plotstatfig1;
                pb10.Parent = plotstatfig1;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                val1 = popup1.Value;
                val2 = popup2.Value;
                
                %The following switch statements modify the input
                %parameters when calling lastngames and plotStats, eg
                %plotting 10 vs 20 vs 30 games, or plotting home vs away
                %games
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'min','home');
                    case 2
                        [x,y]=plotStats(games,n,'min','away');
                    case 3    
                        [x,y]=plotStats(games,n,'min');
                end
      
                %THE ABOVE SWITCH STATEMENT UTILIZES THE PLOTSTATS FUNCTION
                %TO RECEIVE AN X AND Y VECTOR. THESE VECTORS ARE THEN
                %PLOTTED ONTO A FIGURE WINDOW.
                
                plot(x,y)
                title(tit);
                plotstatfig1.Visible = 'on';
            end
            function pbfun2(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off');
                set(plotstatfig2, 'Visible', 'on');
                tit=sprintf('%s Field Goal Percentage',currentplayer1.fullname);
                
                plotstatfig2.Name = currentplayer1.fullname;
                plotstatfig2.Units = 'normalized';
                plotstatfig2.Position = [0 0 1 1];
                pb1.Parent = plotstatfig2;
                pb2.Parent = plotstatfig2;
                pb3.Parent = plotstatfig2;
                pb4.Parent = plotstatfig2;
                pb5.Parent = plotstatfig2;
                pb6.Parent = plotstatfig2;
                pb7.Parent = plotstatfig2;
                pb8.Parent = plotstatfig2;
                pb9.Parent = plotstatfig2;
                pb10.Parent = plotstatfig2;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton',...
                    'String','Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'fgp','home');
                    case 2
                        [x,y]=plotStats(games,n,'fgp','away');
                    case 3    
                        [x,y]=plotStats(games,n,'fgp');
                end
                plot(x,y)
                title(tit);
                plotstatfig2.Visible='on';
            end
            function pbfun3(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig3, 'Visible', 'on');
                tit=sprintf('%s Three Point Percentages',currentplayer1.fullname);
                
                plotstatfig3.Name = currentplayer1.fullname;
                plotstatfig3.Units = 'normalized';
                plotstatfig3.Position = [0 0 1 1];
                pb1.Parent = plotstatfig3;
                pb2.Parent = plotstatfig3;
                pb3.Parent = plotstatfig3;
                pb4.Parent = plotstatfig3;
                pb5.Parent = plotstatfig3;
                pb6.Parent = plotstatfig3;
                pb7.Parent = plotstatfig3;
                pb8.Parent = plotstatfig3;
                pb9.Parent = plotstatfig3;
                pb10.Parent = plotstatfig3;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'3pp','home');
                    case 2
                        [x,y]=plotStats(games,n,'3pp','away');
                    case 3    
                        [x,y]=plotStats(games,n,'3pp');
                end
                plot(x,y)
                title(tit);
                plotstatfig3.Visible='on';
            end
            function pbfun4(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig4, 'Visible', 'on');
                tit=sprintf('%s Free Throw Percentage',currentplayer1.fullname);

                plotstatfig4.Name = currentplayer1.fullname;
                plotstatfig4.Units = 'normalized';
                plotstatfig4.Position = [0 0 1 1];
                
                pb1.Parent = plotstatfig4;
                pb2.Parent = plotstatfig4;
                pb3.Parent = plotstatfig4;
                pb4.Parent = plotstatfig4;
                pb5.Parent = plotstatfig4;
                pb6.Parent = plotstatfig4;
                pb7.Parent = plotstatfig4;
                pb8.Parent = plotstatfig4;
                pb9.Parent = plotstatfig4;
                pb10.Parent = plotstatfig4;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'ftp','home');
                    case 2
                        [x,y]=plotStats(games,n,'ftp','away');
                    case 3    
                        [x,y]=plotStats(games,n,'ftp');
                end
                plot(x,y)
                title(tit);
                plotstatfig4.Visible='on';
            end
            function pbfun5(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig5, 'Visible', 'on');
                tit=sprintf('%s Rebounds',currentplayer1.fullname);
                
                plotstatfig5.Name = currentplayer1.fullname;
                plotstatfig5.Units = 'normalized';
                plotstatfig5.Position = [0 0 1 1];
                
                pb1.Parent = plotstatfig5;
                pb2.Parent = plotstatfig5;
                pb3.Parent = plotstatfig5;
                pb4.Parent = plotstatfig5;
                pb5.Parent = plotstatfig5;
                pb6.Parent = plotstatfig5;
                pb7.Parent = plotstatfig5;
                pb8.Parent = plotstatfig5;
                pb9.Parent = plotstatfig5;
                pb10.Parent = plotstatfig5;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'rebound','home');
                    case 2
                        [x,y]=plotStats(games,n,'rebound','away');
                    case 3    
                        [x,y]=plotStats(games,n,'rebound');
                end
                plot(x,y)
                title(tit);
                plotstatfig5.Visible='on';
            end
            function pbfun6(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig6, 'Visible', 'on');
                tit=sprintf('%s Assists',currentplayer1.fullname);
                
                plotstatfig6.Name = currentplayer1.fullname;
                plotstatfig6.Units = 'normalized';
                plotstatfig6.Position = [0 0 1 1];
                
                pb1.Parent = plotstatfig6;
                pb2.Parent = plotstatfig6;
                pb3.Parent = plotstatfig6;
                pb4.Parent = plotstatfig6;
                pb5.Parent = plotstatfig6;
                pb6.Parent = plotstatfig6;
                pb7.Parent = plotstatfig6;
                pb8.Parent = plotstatfig6;
                pb9.Parent = plotstatfig6;
                pb10.Parent = plotstatfig6;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'ast','home');
                    case 2
                        [x,y]=plotStats(games,n,'ast','away');
                    case 3    
                        [x,y]=plotStats(games,n,'ast');
                end
                plot(x,y)
                title(tit);
                plotstatfig6.Visible='on';
            end
            function pbfun7(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig7, 'Visible', 'on');
                tit=sprintf('%s Steals',currentplayer1.fullname);
                
                plotstatfig7.Name = currentplayer1.fullname;
                plotstatfig7.Units = 'normalized';
                plotstatfig7.Position = [0 0 1 1];
                
                pb1.Parent = plotstatfig7;
                pb2.Parent = plotstatfig7;
                pb3.Parent = plotstatfig7;
                pb4.Parent = plotstatfig7;
                pb5.Parent = plotstatfig7;
                pb6.Parent = plotstatfig7;
                pb7.Parent = plotstatfig7;
                pb8.Parent = plotstatfig7;
                pb9.Parent = plotstatfig7;
                pb10.Parent = plotstatfig7;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton',...
                    'String','Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'stl','home');
                    case 2
                        [x,y]=plotStats(games,n,'stl','away');
                    case 3    
                        [x,y]=plotStats(games,n,'stl');
                end
                plot(x,y)
                title(tit);
                plotstatfig7.Visible='on';
            end
            function pbfun8(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig8, 'Visible', 'on');
                tit=sprintf('%s Blocks',currentplayer1.fullname);
                
                plotstatfig8.Name = currentplayer1.fullname;
                plotstatfig8.Units = 'normalized';
                plotstatfig8.Position = [0 0 1 1];
                
                pb1.Parent = plotstatfig8;
                pb2.Parent = plotstatfig8;
                pb3.Parent = plotstatfig8;
                pb4.Parent = plotstatfig8;
                pb5.Parent = plotstatfig8;
                pb6.Parent = plotstatfig8;
                pb7.Parent = plotstatfig8;
                pb8.Parent = plotstatfig8;
                pb9.Parent = plotstatfig8;
                pb10.Parent = plotstatfig8;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'blk','home');
                    case 2
                        [x,y]=plotStats(games,n,'blk','away');
                    case 3    
                        [x,y]=plotStats(games,n,'blk');
                end
                plot(x,y)
                title(tit);
                plotstatfig8.Visible='on';
            end
            function pbfun9(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig9, 'Visible', 'on');
                tit=sprintf('%s Turnovers',currentplayer1.fullname);
                
                plotstatfig9.Name = currentplayer1.fullname;
                plotstatfig9.Units = 'normalized';
                plotstatfig9.Position = [0 0 1 1];
                
                pb1.Parent = plotstatfig9;
                pb2.Parent = plotstatfig9;
                pb3.Parent = plotstatfig9;
                pb4.Parent = plotstatfig9;
                pb5.Parent = plotstatfig9;
                pb6.Parent = plotstatfig9;
                pb7.Parent = plotstatfig9;
                pb8.Parent = plotstatfig9;
                pb9.Parent = plotstatfig9;
                pb10.Parent = plotstatfig9;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton=uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'to','home');
                    case 2
                        [x,y]=plotStats(games,n,'to','away');
                    case 3    
                        [x,y]=plotStats(games,n,'to');
                end
                plot(x,y)
                title(tit);
                plotstatfig9.Visible='on';
            end
            function pbfun10(~,~)
                plotstatfig1.Visible = 'off';
                plotstatfig2.Visible = 'off';
                plotstatfig3.Visible = 'off';
                plotstatfig4.Visible = 'off';
                plotstatfig5.Visible = 'off';
                plotstatfig6.Visible = 'off';
                plotstatfig7.Visible = 'off';
                plotstatfig8.Visible = 'off';
                plotstatfig9.Visible = 'off';
                plotstatfig10.Visible = 'off';
                set(singleplayerfig,'Visible','off')
                set(plotstatfig10, 'Visible', 'on');
                tit=sprintf('%s Total Points',currentplayer1.fullname);

                plotstatfig10.Name = currentplayer1.fullname;
                plotstatfig10.Units = 'normalized';
                plotstatfig10.Position = [0 0 1 1];
                
                pb1.Parent = plotstatfig10;
                pb2.Parent = plotstatfig10;
                pb3.Parent = plotstatfig10;
                pb4.Parent = plotstatfig10;
                pb5.Parent = plotstatfig10;
                pb6.Parent = plotstatfig10;
                pb7.Parent = plotstatfig10;
                pb8.Parent = plotstatfig10;
                pb9.Parent = plotstatfig10;
                pb10.Parent = plotstatfig10;
                
                pb1.Position = [.03 .734 .065 .07];
                pb2.Position = [.03 .664 .065 .07];
                pb3.Position = [.03 .594 .065 .07];
                pb4.Position = [.03 .524 .065 .07];
                pb5.Position = [.03 .454 .065 .07];
                pb6.Position = [.03 .384 .065 .07];
                pb7.Position = [.03 .314 .065 .07];
                pb8.Position = [.03 .244 .065 .07];
                pb9.Position = [.03 .174 .065 .07];
                pb10.Position = [.03 .104 .065 .07];
                backbutton = uicontrol('Style','pushbutton','String',...
                    'Back to Player Page','Units','normalized',...
                    'Position', [0 .95 .1 .05],'Callback', @back69);
                val1 = popup1.Value;
                val2 = popup2.Value;
                switch val1
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
                switch val2
                    case 1
                        [x,y]=plotStats(games,n,'pts','home');
                    case 2
                        [x,y]=plotStats(games,n,'pts','away');
                    case 3    
                        [x,y]=plotStats(games,n,'pts');
                end
                plot(x,y)
                title(tit);
                plotstatfig10.Visible='on';
            end
            
            %this function is called by all pbfun variations. It displays a
            %push button on the plot figure, and takes you back to the
            %player's original statline
            function back69(~,~)
                pb1.Parent = singleplayerfig;
                pb2.Parent = singleplayerfig;
                pb3.Parent = singleplayerfig;
                pb4.Parent = singleplayerfig;
                pb5.Parent = singleplayerfig;
                pb6.Parent = singleplayerfig;
                pb7.Parent = singleplayerfig;
                pb8.Parent = singleplayerfig;
                pb9.Parent = singleplayerfig;
                pb10.Parent = singleplayerfig;
                plotstatfig1.Visible='off';
                pb1.Position = [.235 .734 .065 .07];
                plotstatfig2.Visible='off';
                pb2.Position = [.235 .664 .065 .07];
                plotstatfig3.Visible='off';
                pb3.Position = [.235 .594 .065 .07];
                plotstatfig4.Visible='off';
                pb4.Position = [.235 .524 .065 .07];
                plotstatfig5.Visible='off';
                pb5.Position = [.235 .454 .065 .07];
                plotstatfig6.Visible='off';
                pb6.Position = [.235 .384 .065 .07];
                plotstatfig7.Visible='off';
                pb7.Position = [.235 .314 .065 .07];
                plotstatfig8.Visible='off';
                pb8.Position = [.235 .244 .065 .07];
                plotstatfig9.Visible='off';
                pb9.Position = [.235 .174 .065 .07];
                plotstatfig10.Visible='off';
                pb10.Position = [.235 .104 .065 .07];
                singleplayerfig.Visible='on';
                
            end

            %Shows some basic information about the player
            vitalstr = sprintf('Team: %s\n\nPosition: %s\n\nAge: %s',...
                currentplayer1.team, currentplayer1.posit,...
                games(end).Age(1:2));
            team = uicontrol(singleplayerfig,'Style','text','String',...
                vitalstr,'Units','Normalized','Position',[.025 .4 .2 .14],...
                'BackgroundColor','w','FontSize',14);
        
            %THE FOLLOWING FUNCTION IS A CALLBACK FUNCTION. IN THIS CASE,
            %POPFUN1 IS BEING CALLED BY POPUP1. FOR A DESCRIPTION OF ITS
            %PURPOSE, REFER TO THE COMMENTS BELOW
            
            %Both popfun1 and popfun2 exist to update the data in the UI tables
            %when the values in popfun are changed
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
            
            %Turns figure on after generating all objects other than the
            %player picture
            set(singleplayerfig,'Visible','on')
            
            
            %Shows player headshot and positions it to the side
            phsname = imread(lower(strcat(currentplayer1.last,...
                currentplayer1.first,'.jpg')));           
            set(gca,'Visible','off')
            a = axes('Units', 'Normalized', 'Position', [0 .5 .25 .25]);
            im = imshow(phsname);
            ha.HandleVisibility = 'off';
            ha.Visible = 'off';
        end
    end
end


%Create button groups for two player search; one to get the first player
% and next to get the second player
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
    'Callback',@go2spchosen);
%Callback function that goes to spchosen
comp2playerbackbutton_b = uicontrol(twoplayersearch_b,'Style','pushbutton',...
    'String','Look at one Player','Units','Normalized','Position',[0 .95 .5 .05],...
    'Callback',@go2spchosen);

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

    %See previous comment at the confirm function for its description
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

    
        %Cbfn to print first player's name and prompt for 2nd player
        function getplayer2 (hObject,~) 
            currentplayer1 = players(fullplayerindex(hObject.Value));
            set([didyoumean twoplayersearch_a],'Visible','off');
            player1display = uicontrol(twoplayersearch_b,'Style','text',...
                'String',currentplayer1.fullname,'Units','Normalized',...
                'Position',[.05 .5 .8 .05]);
            twoplayersearch_b.Visible = 'on';
        end
        
        %Cbfn to open 2 player comparison fig
        function opencomp2playerfig(hObject,~)
            currentplayer2 = players(fullplayerindex(hObject.Value));
            set([openf didyoumean],'Visible','off')
            comptitle = sprintf('%s vs. %s Comparison',...
                currentplayer1.fullname,currentplayer2.fullname);
            set(compare2fig,'Name',comptitle)
            games1 = parseStatLine(currentplayer1.filename);
            games2 = parseStatLine(currentplayer2.filename);
            n1=length(games1);
            d1=struct2cell(lastngames(games1,n1));
            n2=length(games1);
            d2=struct2cell(lastngames(games2,n2));
            d=[d1,d2];
            rnames={'<html><font size=+8>Minutes Played',...
                '<html><font size=+8>Field Goal Percentage',...
                '<html><font size=+8>Three Pointer Percentage',...
                '<html><font size=+8>Free Throws Percentage',...
                '<html><font size=+8>Rebounds',...
                '<html><font size=+8>Assists',...
                '<html><font size=+8>Steals',...
                '<html><font size=+8>Blocks',...
                '<html><font size=+8>Turnovers',...
                '<html><font size=+8>Total Points'};
            cname={sprintf('<html><font size=+8>%s',...
                currentplayer1.fullname),...
                sprintf('<html><font size=+8>%s',currentplayer2.fullname)};
            t=uitable(compare2fig,'Data',d,'RowName',rnames,...
                'ColumnName',cname,'Units','normalized','FontSize',...
                38,'Position',[.02 .12 .4 .4]);
            t.Position(3)=t.Extent(3);
            t.Position(4)=t.Extent(4);
            popup1 = uicontrol(compare2fig,'Style', 'popup',...
                'String', {'Last 5 Games','Last 10 Games',...
                'Last 20 Games','Last 30 Games','All Games'},...
                'Units','normalized', 'Position', [.90 .4 .1 .4],...
                'Value', 5, 'Callback', @popfun1);
            popup2 = uicontrol(compare2fig,'Style', 'popup',...
                'String', {'Home','Away','All Games'},...
                'Units','normalized',...  
                'Position', [.80 .4 .1 .4], 'Value', 3,...   
                'Callback', @popfun2);
            
              
              vs = uicontrol(compare2fig,'Style','text','Units','Normalized',...
                  'Position',[.52 .8 .02 .02],'String','VS.',...
                  'FontSize',14);
              
            %See previous popfun1 and popfun2 descriptions, defined
            %previously
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
            
            %Open compare2fig after objects have been created
            set(compare2fig,'Visible','on')
            
            %Shows player headshot for player1 and positions it 
            p1name = imread(lower(strcat(currentplayer1.last,currentplayer1.first,'.jpg')));           
            set(gca,'Visible','off')
            ha1 = axes('Units', 'Normalized', 'Position', [.35 .75 .15 .15]);
            im1 = imshow(p1name);
            ha1.HandleVisibility = 'off';
            ha1.Visible = 'off';
            
            %Shows player headshot for player2 and positions it 
            p2name = imread(lower(strcat(currentplayer2.last,currentplayer2.first,'.jpg')));           
            set(gca,'Visible','off')
            ha2 = axes('Units', 'Normalized', 'Position', [.55 .75 .15 .15]);
            im2 = imshow(p2name);
            ha2.HandleVisibility = 'off';
            ha2.Visible = 'off';
        end
    end
end

    %Pushback button which takes the user to the 1-player stat window
    function go2spchosen(~,~)
        set([singleplayerfig compare2fig twoplayersearch_a twoplayersearch_b],...
            'Visible','off');
        set(openf,'Visible','on');
        spchosen;
    end

    %Pushback button which takes the user to the 2-player comparison window
    function go2tpchosen(~,~)
        set([singleplayerfig compare2fig twoplayersearch_a twoplayersearch_b],...
            'Visible','off');
        set(openf,'Visible','on');
        tpchosen;
    end
        
end
