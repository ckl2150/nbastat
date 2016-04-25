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
        [logo r g b] = faveteam(teamfilename);
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

%Create back button to go back to opening figure from single display figures
back2openfigfromspfig = uicontrol(singleplayerfig,'Style','pushbutton',...
    'String','Start Over','Units','Normalized','Position',[0 .95 .05 .05],...
    'Callback',@back2start);%Callback function that goes back to the opening figure

%Create back button to go back to opening figure from two display figures
back2openfigfromc2fig = uicontrol(compare2fig,'Style','pushbutton',...
    'String','Start Over','Units','Normalized','Position',[0 .95 .05 .05],...
    'Callback',@back2start);%Callback function that goes back to the opening figure

%Open gui is turned on
set(openf,'Visible','on')
set([searchinstruct singleplayer twoplayers],'Visible','on')

%global function which error checks user input of players

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
            
%             set(singleplayerfig, 'Color', image(logo));
%             set(openf, 'Color', [r/255 g/255 b/255]);
%             set(gca,'Visible','off')
            
            set(singleplayerfig,'Visible','on')
            disp(currentplayer1.filename)
            games = parseStatLine(currentplayer1.filename);
            n=length(games);
            d=struct2cell(lastngames(games,n));
            rnames={'<html><font size=+30>Minutes Played','<html><font size=+30>Field Goal Percentage','<html><font size=+30>Three Pointer Percentage','<html><font size=+30>Free Throws Percentage','<html><font size=+30>Rebounds',...
                '<html><font size=+30>Assists','<html><font size=+30>Steals','<html><font size=+30>Blocks','<html><font size=+30>Turnovers','<html><font size=+30>Total Points'};
            cname=sprintf('%s Stats',currentplayer1.fullname);
            t=uitable(singleplayerfig,'Data',d,'RowName',rnames,'ColumnName',cname,...
                'Units','normalized','FontSize', 40, 'Position',[.5,.2,.30,.50]);
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
            popup1.Visible='on';
            popup2.Visible='on';
            t.Visible='on';
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
                    compare2playersinstruct2.String = sprintf('Sorry, no player''s name starts wiht %c%s.', upper(lastname(1)), lastname(2:end));
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
                'Assists','Steals','Blocks','Time Outs?','Total Points'};
            cname={sprintf('%s Stats',currentplayer1.fullname),sprintf('%s Stats',currentplayer2.fullname)};
            t=uitable(singleplayerfig,'Data',d,'RowName',rnames,'ColumnName',cname,...
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
            twoplayersearch_a twoplayersearch_b ],'Visible','off')
        set([openf searchinstruct singleplayer twoplayers],'Visible','on')
    end
end
