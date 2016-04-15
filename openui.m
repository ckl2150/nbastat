function openui
%Creating opening page GUI and centering it

f = figure('Visible','off','color','white','Position',[300,500,800,600]);
set(f,'Name','Conrad hearts farts')
movegui(f,'center')

%Create two objects: a box with instructions and radio buttons to choose if
%searhing for one player or comparing multiple players at once


%Creating radio buttons in botton group

optionbg = uibuttongroup('Visible','off','Position',[0 0 .2 1],...
    'backgroundcolor','white','SelectionChangedFcn',@searchselection);

byplayer = uicontrol(optionbg,'Style','radiobutton',...
    'String','Search by player','Position',[10 350 200 30],...
    'HandleVisibility', 'off');

compare2 = uicontrol(optionbg,'Style','radiobutton',...
    'String','Compare two players','backgroundcolor','white',...
    'Position',[10 250 200 30],'HandleVisibility', 'off');

%Gui is turned on
set(f,'Visible', 'on')
set(optionbg,'Visible','on')
end