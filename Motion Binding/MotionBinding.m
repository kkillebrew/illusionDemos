clear all
close all

% Screen('Preference', 'SkipSyncTests', 1);

%BASIC WINDOW/SCREEN SETUP
% PPD stuff
mon_width_cm = 40;
mon_dist_cm = 73;
mon_width_deg = 2 * (180/pi) * atan((mon_width_cm/2)/mon_dist_cm);
PPD = (1024/mon_width_deg);

% Color vars
backColor = [128 128 128];
polyColor{1} = [255 255 255];
polyColor{2} = [0 0 0];

[w, rect] = Screen('Openwindow', 0, backColor, [0 0 1920 1080]);
x0 = rect(3)/2;
y0 = rect(4)/2;HideCursor;
ListenChar(2);

buttonEscape = KbName('escape');
buttonEnter = KbName('return');
buttonRight = KbName('rightarrow');
buttonLeft = KbName('leftarrow');

% Screen('BlendFunction',w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);  % Must have for alpha values for some reason

% % Load in the Nevada picture into a texture
% nevada = imread('nevada.jpg');
% nevadaTexture = Screen('MakeTexture', w, nevada);

% Spacing and size variables
lineLength = 200;
moveDist = 30;     %  Diameter for the circular rotation of the square (also the offset of the starting location from the center of the occluders)
moveVel = .1;
occSize = 100;
rotAngle = 45;
rotDistance = 0:moveVel:2*pi;
occAlpha = 1;

% Create the texture that you will draw the lines onto
imageArray = zeros(lineLength)+(backColor(1));
imageTexture = Screen('MakeTexture',w,imageArray);

% Create textures for the occluders so you can make them transparent
occArray(:,:,1) = zeros(occSize)+backColor(1);
occArray(:,:,2) = zeros(occSize)+255;
occArray(:,:,3) = zeros(occSize)+backColor(1);
occTexture = Screen('MakeTexture',w,occArray);

% Determine the centerpoints of the occluding squares
% Up
occX1 = x0;
occY1 = y0-(.5*(sqrt((lineLength^2)+(lineLength^2))));
% Left
occX2 = x0-(.5*(sqrt((lineLength^2)+(lineLength^2))));
occY2 = y0;
% Down
occX3 = x0;
occY3 = y0+(.5*(sqrt((lineLength^2)+(lineLength^2))));
% Right
occX4=x0+(.5*(sqrt((lineLength^2)+(lineLength^2))));
occY4=y0;

% Stating points of the image texture
x1 = x0-lineLength/2;
y1 = y0-lineLength/2;
x2 = x0+lineLength/2;
y2 = y0+lineLength/2;

[keyIsDown, secs, keycode] = KbCheck;
counter = 0;
while ~keycode(buttonEscape)
    [keyIsDown, secs, keycode] = KbCheck;
    counter=counter+1;
    if counter > length(rotDistance)
        counter = 1;
    end
    
    % Calculate and update the location of the image texture as it moves in
    % a circular path
    distx = x0+sin(rotDistance(counter))*(moveDist/2);
    disty = y0+cos(rotDistance(counter))*(moveDist/2);
    distx1 = x1+sin(rotDistance(counter))*(moveDist/2);
    disty1 = y1+cos(rotDistance(counter))*(moveDist/2);
    distx2 = x2+sin(rotDistance(counter))*(moveDist/2);
    disty2 = y2+cos(rotDistance(counter))*(moveDist/2);
    
    % Draw the texture
    Screen('DrawTexture',w,imageTexture,[],[distx1,disty1,distx2,disty2],rotAngle);
    
    % Draw the lines onto the texture
    Screen('DrawLine',imageTexture,[0 0 0],0,0,lineLength,0,10);
    Screen('DrawLine',imageTexture,[0 0 0],lineLength,0,lineLength,lineLength,10);
    Screen('DrawLine',imageTexture,[0 0 0],lineLength,lineLength,0,lineLength,10);
    Screen('DrawLine',imageTexture,[0 0 0],0,lineLength,0,0,10);
    
    % Draw the occluders
    Screen('DrawTexture',w,occTexture,[],[occX1-occSize/2,occY1-occSize/2,occX1+occSize/2,occY1+occSize/2],rotAngle,[],occAlpha);
    Screen('DrawTexture',w,occTexture,[],[occX2-occSize/2,occY2-occSize/2,occX2+occSize/2,occY2+occSize/2],rotAngle,[],occAlpha);
    Screen('DrawTexture',w,occTexture,[],[occX3-occSize/2,occY3-occSize/2,occX3+occSize/2,occY3+occSize/2],rotAngle,[],occAlpha);
    Screen('DrawTexture',w,occTexture,[],[occX4-occSize/2,occY4-occSize/2,occX4+occSize/2,occY4+occSize/2],rotAngle,[],occAlpha);
    
    % Allow for increase in contrast of the occluders 
    
    % Plot the center points of the occluders
    Screen('FillOval',w,[255 0 0],[occX1-2,occY1-2,occX1+2,occY1+2]);
    Screen('FillOval',w,[255 0 0],[occX2-2,occY2-2,occX2+2,occY2+2]);
    Screen('FillOval',w,[255 0 0],[occX3-2,occY3-2,occX3+2,occY3+2]);
    Screen('FillOval',w,[255 0 0],[occX4-2,occY4-2,occX4+2,occY4+2]);
    
    % Plot the center of the image
    Screen('FillOval',w,[255 0 0],[distx-2,disty-2,distx+2,disty+2]);
    
    % Fixation
    Screen('FillOval',w, [255 0 0], [x0-5, y0-5, x0+5, y0+5]);
    
    
    
    Screen('Flip',w);
end

ShowCursor;
ListenChar(0);
Screen('CloseAll')






