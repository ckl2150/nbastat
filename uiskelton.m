%This is the skelton gui, consisting of an opening ui to pick whether
%looking at one player or comparing two players, editable text boxes to
%search for players, a figure to show a single player's stats and a figure
%to compare two players.

function uiskelton

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

%Callback function if searching single player
function spchosen(~,~)
set(optionpbg,'Visible','off');
%Create button group for single player search 
oneplayersearch = uibuttongroup('Visible','off','Position',[0 0 .25 1],...
    'backgroundcolor','white','BorderType','none');
%Search for player editable textbox and instruction
oneplayersearchbox = uicontrol(oneplayersearch,'Style','edit',...
    'Callback',@openplayerstatfig);%callback function to open fig for single player
oneplayerinstruct = uicontrol(oneplayersearch,'Style','text',...
    'Position',[01 350 200 20],'String','Enter player''s last name');
set(oneplayersearchbox,'Position',[01 300 200 20]);

%Make search for player visible
set(oneplayersearch,'Visible','on');

    %function confirm
        %error check
        %parsePlayer();
        %find({player.last}) figure out if this is ok, if not use for loop
        %parsegames(filenametzt)
        %gamemanip(games, 'away')
        %this would either all away games or home games (probably an if
        %function because there are all only 2 cases, but as we add more a
        %menu function would presumably make more sense

    function openplayerstatfig(~,~)%Cbfn to open single player fig window
        set(openf,'Visible','off')
        singleplayername = get(oneplayersearchbox,'String');
        set(singleplayerfig,'Name',singleplayername)
        set(singleplayerfig,'Visible','on')
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
    'Position',[01 300 200 20],'Callback',@getplayer2);
set(twoplayersearchbox1,'Position',[01 300 200 20]);
compare2playersinstruct1 = uicontrol(twoplayersearch_a,'Style','text',...
    'Position',[01 350 200 20],'String','Enter player one''s last name');
%Search for player two instruction
compare2playersinstruct2 = uicontrol(twoplayersearch_b,'Style','text',...
    'Position',[01 350 200 20],'String','Enter second player''s last name');

%Make search for player 1 visible
set(twoplayersearch_a,'Visible','on');

    function getplayer2 (~,~) %Cbfn to print first player's name and prompt for 2nd player
        set(twoplayersearch_a,'Visible','off');
        player1name = get(twoplayersearchbox1,'String');
        player1display = uicontrol(twoplayersearch_b,'Style','text',...
            'String',player1name,'Position',[01 400 200 20]);
        twoplayersearchbox2 = uicontrol(twoplayersearch_b,'Style','edit',...
    'Position',[01 300 200 20],'Callback',@opencomp2playerfig);
        set(twoplayersearch_b,'Visible','on')
        
        function opencomp2playerfig(~,~)%Cbfn to open 2 player comparison fig
        set(openf,'Visible','off')
        player2name = get(twoplayersearchbox2,'String');
        comptitle = sprintf('%s vs. %s Comparison',player1name,player2name);
        set(compare2fig,'Name',comptitle)
        set(compare2fig,'Visible','on')
        end
    end
end
end
