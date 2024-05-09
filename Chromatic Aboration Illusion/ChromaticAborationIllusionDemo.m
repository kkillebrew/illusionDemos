% Chromatic aboration illusion?

clear all; close all;

Screen('Preference', 'SkipSyncTests', 1);

KbName('UnifyKeyNames');

ListenChar(2);
HideCursor;

%% Monitor Vars
[w,rect] = Screen('OpenWindow',1,[128 128 128]);
screenWide=1024;
screenHigh=768;
hz=60;

white=WhiteIndex(w);
black=BlackIndex(w);
gray=round((white+black)/2);
if gray == white
    gray=white / 2;
end
inc=white-gray;

backColor = gray;
tColor = black;

% PPD stuff
mon_width_cm = 40;
mon_dist_cm = 73;
mon_width_deg = 2 * (180/pi) * atan((mon_width_cm/2)/mon_dist_cm);
PPD = (screenWide/mon_width_deg);

x0 = rect(3)/2;
y0 = rect(4)/2;

Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

[nums, names] = GetKeyboardIndices;
dev_ID=nums(1);

buttonEscape = KbName('Escape');
buttonUp = KbName('UpArrow');
buttonDown = KbName('DownArrow');
buttonLeft = KbName('LeftArrow');
buttonRight = KbName('RightArrow');
buttonGreat = KbName(',<');
buttonLess = KbName('.>');
buttonQ = KbName('Q');
buttonA = KbName('A');
buttonF = KbName('F');
buttonM = KbName('M');
buttonR = KbName('R');
buttonO = KbName('O');
buttonJ = KbName('J');

%% Stimulus Vars

circSize = 200;   % Diameter of the circle
numCircs = 2;
for i=1:numCircs
    circPositionArray(:,i) = [x0-(circSize*(numCircs+1-i))/2 y0-(circSize*(numCircs+1-i))/2, x0+(circSize*(numCircs+1-i))/2, y0+(circSize*(numCircs+1-i))/2]';
end

circColor(:,1) = [255 0 0]';
circColor(:,2) = [0 0 255]';
circColorArray = [circColor(:,1), circColor(:,2)];
circColorOrig(:,1) = circColor(:,1);
circColorOrig(:,2) = circColor(:,2) ;

colorOrder = 1;   % Which circles will be red/blue
flipColor = 0;

outlineColor = black;
outlineMod = 1;
outlineThickness = 5;

% Speed at which one full modulation from red to blue
modSpeed = 255/1;   % number of color units per second
modRate = modSpeed/hz;   % Number of color units per flip
modColors = 0;
modColorsStart = 1;

jitterMax = 10;
jitterMin = -10;

%% Draw the stimulus
[keyIsDown, secs, keycode] = KbCheck(dev_ID);
while ~keycode(buttonEscape)
    [keyIsDown, secs, keycode] = KbCheck(dev_ID);
    
    % Draw
    Screen('FillOval',w,circColorArray,circPositionArray);
    Screen('FrameOval',w,outlineColor,circPositionArray,outlineThickness);
    Screen('Flip',w);
    
    circColorChoose = 2;
    for i=1:numCircs
        circPositionArray(:,i) = [x0-(circSize*(numCircs+1-i))/2 y0-(circSize*(numCircs+1-i))/2, x0+(circSize*(numCircs+1-i))/2, y0+(circSize*(numCircs+1-i))/2]';
        if circColorChoose == 1
            circColorArray(:,(numCircs+1-i)) = circColor(:,circColorChoose);
        elseif circColorChoose == 2
            circColorArray(:,(numCircs+1-i)) = circColor(:,circColorChoose);
        end
        circColorChoose = 3-circColorChoose;
    end
    
    % Draw moe circles (q=increase a=decrease) - min=2
    if keycode(buttonUp)  % Add a circle
        numCircs = numCircs+1;
        KbReleaseWait;
    end
    if keycode(buttonDown) && numCircs > 2
        numCircs = numCircs-1;
        KbReleaseWait;
    end
    
    % Modulate the colors slowly between blue and red (m=toggle)
    % FIX TO MODULATE IN TERMS OF 'RATE' - HOW FAST SHOULD IT MODULATE
    % BETWEEN RED/BLUE IN TERMS OF TIME - WILL MAKE TRANSITIONS MORE SMOOTH
    if keycode(buttonM)
        if modColors == 1
            modColors = 0;
        elseif modColors == 0
            modColors = 1;
        end
        KbReleaseWait;
    end
    if modColors == 1
        
        if modColorsStart == 1   %   If inner is blue/outer is red
            circColor(1,1) = circColor(1,1) + modRate;   % Modulate inner color from blue to red
            circColor(3,1) = circColor(3,1) - modRate;   
            
            circColor(1,2) = circColor(1,2) - modRate;   % Modulate outer color from red to blue
            circColor(3,2) = circColor(3,2) + modRate;
        elseif modColorsStart == 2   %   If inner is red/outer is blue
            circColor(3,1) = circColor(3,1) + modRate;   % Modulate inner color from red to blue
            circColor(1,1) = circColor(1,1) - modRate;
            
            circColor(3,2) = circColor(3,2) - modRate;   % Modulate outer color from blue to red
            circColor(1,2) = circColor(1,2) + modRate;
        end
        
        
        if circColor(1,1) >= 255   %   When the colors hit their endpoints start modulating in the other direction
            modColorsStart = 2;
        elseif circColor(1,1) <= 0
            modColorsStart = 1;
        end
    end
    
    % Reset colors (r)
    if keycode(buttonR)
        circColor(:,1) = circColorOrig(:,1);
        circColor(:,2) = circColorOrig(:,2);
        
        % Stop modulation
        modColors = 0;
        
        KbReleaseWait;
    end
    
    % FLip the colors (f)
    if keycode(buttonF)
        if colorOrder == 1
            colorOrder = 2;
        elseif colorOrder == 2
            colorOrder = 1;
        end
        
        flipColor = 1;
        
        KbReleaseWait;
    end
    
    if flipColor == 1
        circColorHolder = circColor;
        if colorOrder == 1
            circColor(:,1) = circColorHolder(:,2);
            circColor(:,2) = circColorHolder(:,1);
        elseif colorOrder == 2
            circColor(:,2) = circColorHolder(:,1);
            circColor(:,1) = circColorHolder(:,2);
        end
        flipColor = 0;
    end
    
    % Raise/lower saturation (</>)
    if keycode(buttonGreat)
       circColor(:,1) 
    end
    if keycode(buttonLess)
        
    end
    
    % Change color of outline (to white/black or to the opposite color? (o)
    % Make both circles blue but the outline red?
    if keycode(buttonO)
        if outlineMod == 1
            outlineMod = 2;
        elseif outlineMod == 2
            outlineMod = 3;
        elseif outlineMod == 3
            outlineMod = 4;
        elseif outlineMod == 4
            outlineMod = 1;
        end
        KbReleaseWait;
    end
    if outlineMod == 1
        outlineColor = black;
    elseif outlineMod == 2
        outlineColor = white;
    elseif outlineMod == 3
        outlineColor = gray;
    elseif outlineMod == 4
        outlineColor = mean(circColorOrig,2);   % Average between the two colors 
    end
    
    % Increase the thickness of the outline (up/down arrows)
    if keycode(buttonLeft) && outlineThickness > 2
       outlineThickness = outlineThickness - .2; 
    end
    if keycode(buttonRight)
        outlineThickness = outlineThickness + .2; 
    end
    
%     % Move the inner circle relative to the outer circle? vice versa?
%     % Jitter outer circle like chris's wantering cirlces.
%     if keycode(buttonJ)
%         circPositionArray([1 3],end) = circPositionArray([1 3],end) + randi([jitterMin jitterMax],1);   % x-jitter
%         circPositionArray([2 4],end) = circPositionArray([2 4],end) + randi([jitterMin jitterMax],1);   % y-jitter
%     end
    
end

Screen('CloseAll')
ListenChar(0);
ShowCursor;














