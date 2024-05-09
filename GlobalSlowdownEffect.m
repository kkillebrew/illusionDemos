clear all
close all

HideCursor;
ListenChar(1);

Screen('Preference', 'SkipSyncTests', 1);

%BASIC WINDOW/SCREEN SETUP
% PPD stuff
mon_width_cm = 40;
mon_dist_cm = 73;
mon_width_deg = 2 * (180/pi) * atan((mon_width_cm/2)/mon_dist_cm);
PPD = (1024/mon_width_deg);

% Color vars
backColor = [128 128 128];

[w, rect] = Screen('Openwindow', 0, backColor, [0 0 1920 1080]);
x0 = rect(3)/2;
y0 = rect(4)/2;HideCursor;
ListenChar(2);

buttonEscape = KbName('escape');

Screen('BlendFunction',w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);  % Must have for alpha values for some reason

% Determine what refresh rate your monitor is and/or set to what you want
hz = 120;

%Flicker Frequency Rates (3 Hz, 5 Hz, 12 Hz, 20 Hz)
stim_rates(1) = 2; %F1
stim_rates(2) = 2.4; %F2

% Sizing/spacing vars
circRad = 10;    % Radius of the circles
circDist = 50;   % Distance between each dot pair
textDist = 150;  % Distance from the center of the texture to the center of the screen

% Make the texture that includes two cirlces
circArray = zeros(circRad*2,circRad*4+circDist) + backColor(1);
circText = Screen('MakeTexture',w,circArray);
Screen('FillOval',circText,[0 255 0],[0,0,circRad*2,circRad*2]);
Screen('FillOval',circText,[0 255 0],[size(circArray,2)-circRad*2,0,size(circArray,2),size(circArray,1)]);

% Calculate the center positions of each texture
counter = 0;
for i=[-1 1]
    for j=[-1 1]
        counter = counter+1;
        xCoord(counter) = x0 + textDist*i;
        yCoord(counter) = y0 + textDist*j;
    end
end

% Initialize flicker variables
flip1 = 1;
flip2 = 1;
rotDistance = 0:moveVel:2*pi;

% How many times should the lines be flickering per second
trial_rates=randperm(2);
rate(1)=1/(2*stim_rates(trial_rates(1)));
rate(2)=1/(2*stim_rates(trial_rates(2)));

[keyIsDown, secs, keycode] = KbCheck;
while ~keycode(buttonEscape)
    [keyIsDown, secs, keycode] = KbCheck;
    
    % Preform a screen flip and sync the screen presentation times
    sync_time = Screen('Flip',w,[],2);
    
    % Plot the textures
    Screen('DrawTextures',w,[circText,circText,circText,circText],[],...
        [xCoord(1)-(size(circArray,2)/2),yCoord(1)-(size(circArray,1)/2),xCoord(1)+(size(circArray,2)/2),yCoord(1)+(size(circArray,1)/2);...
        xCoord(2)-(size(circArray,2)/2),yCoord(2)-(size(circArray,1)/2),xCoord(2)+(size(circArray,2)/2),yCoord(2)+(size(circArray,1)/2);...
        xCoord(3)-(size(circArray,2)/2),yCoord(3)-(size(circArray,1)/2),xCoord(3)+(size(circArray,2)/2),yCoord(3)+(size(circArray,1)/2);...
        xCoord(4)-(size(circArray,2)/2),yCoord(4)-(size(circArray,1)/2),xCoord(4)+(size(circArray,2)/2),yCoord(4)+(size(circArray,1)/2)]',...
        [rotAngle1,rotAngle2,rotAngle1,rotAngle2]);
    Screen('DrawingFinished',w,2);
    
    % Initialize the first screen flip
    run_start=Screen('Flip',w,sync_time,2);
    
    % Keep track of the time to ensure proper flicker timing
    t1 = run_start;
    t2 = t1;
    
    % Updated the rotation andgle

    
    Screen('Flip',w);
    
end

Screen('CloseAll')
ShowCursor;
ListenChar(0);
