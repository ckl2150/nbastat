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
openf = figure('Visible','off','color','white',...
    'Position',[300,500,1200,800]);
set(openf,'Name','Welcome to Our Awesome Project')
movegui(openf,'center')

logo = imread('nba-logo-on-wood.jpg');
nbalogo = image(logo);
set(gca,'Visible','off')

%Create instructions text box as well as push buttons for single player
%stats path or compare two players path

%Create button group for path options
optionpbg = uibuttongroup('Visible','off','Position',[0 0 .25 1],...
    'backgroundcolor','white','BorderType','none');

%Textbox with instructions on which button to push
searchinstruct = uicontrol(optionpbg,'Style','text',...
    'BackgroundColor','white','Position',[01 425 200 30],...
    'String','Would you like to:','FontSize',18);

%Pushbutton for looking at single player
singleplayer = uicontrol(optionpbg,'Style','pushbutton',...
    'String','Look at single player','Position',[01 350 200 30],...
    'Callback',@spchosen);%callback function to open search box
%Pushbutton for comparing two players
twoplayers = uicontrol(optionpbg,'Style','pushbutton',...
    'String','Compare two players','Position',[01 250 200 30],...
    'Callback',@tpchosen);%callback function to open player-1 search box

%Create figure to show single player stats
singleplayerfig = figure('Visible','off','color','white',...
    'Position',[300,500,1200,800]);
set(singleplayerfig,'Name','Welcome to Our Awesome Project')
movegui(singleplayerfig,'center')


%Create figure to show two player comparison
compare2fig = figure('Visible','off','color','white',...
    'Position',[300,500,1200,800]);
set(compare2fig,'Name','Welcome to Our Awesome Project')
movegui(compare2fig,'center')



%Open gui is turned on
set(openf,'Visible','on')
set(optionpbg,'Visible','on')

%global function which error checks user input of players

%Callback function if searching single player
function spchosen(~,~)
set(optionpbg,'Visible','off');
%Create button group for single player search 
oneplayersearch = uibuttongroup('Visible','off','Position',[0 0 .25 1],...
    'backgroundcolor','white','BorderType','none');
%Search for player editable textbox and instruction
oneplayersearchbox = uicontrol(oneplayersearch,'Style','edit', 'Position', [01 300 200 20], ...
    'Callback', @confirm);%callback function to open fig for single player
oneplayerinstruct = uicontrol(oneplayersearch,'Style','text',...
    'Position',[01 350 200 20],'String','Enter player''s last name');

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
                
%                 if length(namearr) == 1
%                     currentplayer = players(fullplayerindex(1));
%                     singleplayerfig.Visible = 'on';
%                     h = guihandles(openplayerstatfig);
%                 else
                %Add if statement later? if there's only one hit
                    oneplayerinstruct.String = 'Did you mean:';
                    oneplayersearchbox.Visible = 'off';
                    didyoumean = uicontrol(oneplayersearch, 'Style', 'popupmenu', 'Position', [01 300 200 20],'String', namearr, 'Callback', @openplayerstatfig);
                %end
            end
        end
    end

    function openplayerstatfig(hObject,~)%Cbfn to open single player fig window
        currentplayer1 = players(fullplayerindex(hObject.Value));
        set(openf,'Visible','off')
        set(singleplayerfig,'Name',currentplayer1.fullname)
        set(singleplayerfig,'Visible','on')
        %games = parseStatLine(players.filename);
        %MORE TO COME
    end
end


%Callback function if comparing two players
function tpchosen(~,~)
set(optionpbg,'Visible','off')
%Create button groups for two player search;one to get the first player and
%next to get the second player
twoplayersearch_a = uibuttongroup('Visible','off','Position',[0 0 .25 1],...
    'backgroundcolor','white','BorderType','none');
twoplayersearch_b = uibuttongroup('Visible','off','Position',[0 0 .25 1],...
    'backgroundcolor','white','BorderType','none');

%Search for player one editable textbox and instruction
twoplayersearchbox1 = uicontrol(twoplayersearch_a,'Style','edit',...
    'Position',[01 300 200 20],'Callback',@confirm);
twoplayersearchbox2 = uicontrol(twoplayersearch_b,'Style', 'edit', ...
    'Position', [01 300 200 20], 'Callback', @confirm);
set(twoplayersearchbox1,'Position',[01 300 200 20]);
compare2playersinstruct1 = uicontrol(twoplayersearch_a,'Style','text',...
    'Position',[01 350 200 20],'String','Enter player one''s last name');
%Search for player two instruction
compare2playersinstruct2 = uicontrol(twoplayersearch_b,'Style','text',...
    'Position',[01 350 200 20],'String','Enter second player''s last name');

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
                
%                if length(namearr) == 1
%                    currentplayer = players(fullplayerindex(1));
%                    singleplayerfig.Visible = 'on';
%                    h = guihandles(openplayerstatfig);
%                else
                 %Add if statement later? if there's only one hit
                 if hObject == twoplayersearchbox1
                     compare2playersinstruct1.String = 'Did you mean:';
                     twoplayersearchbox1.Visible = 'off';
                     didyoumean = uicontrol(twoplayersearch_a, 'Style', 'popupmenu', 'Position', [01 300 200 20],'String', namearr, 'Callback', @getplayer2);
                     disp(didyoumean.Value)
                 else
                     compare2playersinstruct2.String = 'Did you mean:';
                     twoplayersearchbox2.Visible = 'off';
                     didyoumean = uicontrol(twoplayersearch_b, 'Style', 'popupmenu', 'Position', [01 300 200 20],'String', namearr, 'Callback', @opencomp2playerfig);
                 end
            end
        end

    
    function getplayer2 (~,~) %Cbfn to print first player's name and prompt for 2nd player FIX THIS SHIT
        currentplayer1 = players(fullplayerindex(hObject.Value));
        set(twoplayersearch_a,'Visible','off');
        player1display = uicontrol(twoplayersearch_b,'Style','text',...
            'String',currentplayer1.fullname,'Position',[01 400 200 20]); %FIX THIS LINE
        twoplayersearch_b.Visible = 'on';
%         twoplayersearchbox2 = uicontrol(twoplayersearch_b,'Style','edit',...
%             'Position',[01 300 200 20],'Callback',@confirm);
        
        function opencomp2playerfig(~,~)%Cbfn to open 2 player comparison fig
            currentplayer2 = players(fullplayerindex(hObject.Value));
            set(openf,'Visible','off')
            player2name = get(twoplayersearchbox2,'String');
            comptitle = sprintf('%s vs. %s Comparison',player1name,player2name);
            set(compare2fig,'Name',comptitle)
            set(compare2fig,'Visible','on')
        end
    end
    end
end
end