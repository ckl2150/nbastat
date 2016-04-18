%Creating opening page GUI and centering it
function openui

openf = figure('Visible','off','color','white','Position',[300,500,1200,800]);
set(openf,'Name','Conrad hearts farts')
movegui(openf,'center')

logo = imread('nba-logo-on-wood.jpg');
nbalogo = image(logo);
set(nbalogo,'Clipping','off')

%Create two objects: a box with instructions and radio buttons to choose if
%searhing for one player or comparing multiple players at once

%Creating radio buttons in botton group

optionbg = uibuttongroup('Visible','off','Position',[0 0 .25 1],...
    'backgroundcolor','white','BorderType','none',...
    'SelectionChangedFcn',@searchselection);

%Probably a really shitty way to program this but not sure if can use
%radio buttons without having one selected originally by default.
%Might have to not use radio buttons


hiddenradio = uicontrol(optionbg,'Style','radiobutton',...
    'String','throwaway','Position',[100 1000 200 30],...
    'HandleVisibility', 'off');

byplayer = uicontrol(optionbg,'Style','radiobutton',...
    'String','Search by player','Position',[10 350 200 30],...
    'backgroundcolor','white','FontSize',14,'HandleVisibility', 'off',...
    'Callbackfn');

compare2 = uicontrol(optionbg,'Style','radiobutton',...
    'String','Compare two players','backgroundcolor','white',...
    'Position',[10 250 200 30],'FontSize',14,'HandleVisibility', 'off');

searchinstruct = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[01 425 200 30],'String','Would you like to:',...
    'FontSize',18);

enterplayer = uicontrol('Style','edit','Position',[10 300 200 30],...
    'Callback','@

%Gui is turned on
set(openf,'Visible', 'on')
set(optionbg,'Visible','on')

    function searchselection(source,callbackdata,handles)
        set(openf,'Visible','off')
        set(optionbg,'Visible','off')
        %Opens new figure for search by player
       
        playerstatf = figure('Visible','off','color','white',...
            'Position',[300,500,1200,800]);
        playerstatstr = sprintf('%s Stats',player)
        set(compare2f,'Name','playerstatstr')
        movegui(compare2f,'center')
        set(compare2f,'Visible','on')
        
        %Opens new figure for compare two players
        
        compare2f = figure('Visible','off','color','white',...
            'Position',[300,500,1200,800]);
        comp2pstr = sprintf('%s vs. %s',player1,player2)
        set(compare2f,'Name','comp2pstr')
        movegui(compare2f,'center')
        set(compare2f,'Visible','on')


    end

end