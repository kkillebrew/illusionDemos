% Script to create the chromatic aboration video for the illusion contest
% 061818

clear all; close all;

Screen('Preference', 'SkipSyncTests', 1);

KbName('UnifyKeyNames');

%% Monitor Vars
[w,rect] = Screen('OpenWindow',1,[128 128 128],[],[],[],[],100);
screenWide=1024;
screenHigh=768;

% Determine the number of frames (corresponding to flips) you want to show
% per second of movie time.
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

%% Stim vars

movieMaker = 1;

circSize = 200;   % Diameter of the circle
numCircs = 2;
for i=1:numCircs
    circPositionArray(:,i) = [x0-(circSize*(numCircs+1-i))/2 y0-(circSize*(numCircs+1-i))/2, x0+(circSize*(numCircs+1-i))/2, y0+(circSize*(numCircs+1-i))/2]';
end
circPositionArrayOutline = circPositionArray;
circPositionArrayOutline(1:2,2) = circPositionArray(1:2,2);
circPositionArrayOutline(3:4,2) = circPositionArray(3:4,2);

% Draw a black circle behind the inner blue circle
circPositionArray(:,3) = circPositionArray(:,2);

% Create a texture so you can move the inner dark blue circle while
% occluding the edges.
apLength = circSize;
apHeight = circSize;
n = rect(4); % size of matrix, odd
n2 = floor(n/2) ;
[x,y] = meshgrid(-n2:n2);

Rl = apLength/2; % width
Rh = apHeight/2; % length
M = ((x - 0) / Rh) .^2    +   ((y - 0) / Rl) .^2     <= 1;
M = double(M) ; % convert from logical to double
alphaLayer = ~double(M)*255;
circleApertureArray(:,:,1) = zeros(length(alphaLayer))+gray;
circleApertureArray(:,:,2) = zeros(length(alphaLayer))+gray;
circleApertureArray(:,:,3) = zeros(length(alphaLayer))+gray;
circleApertureArray(:,:,4) = alphaLayer;
apTexture = Screen('MakeTexture',w,circleApertureArray);

% figure()
% imshow(circleApertureArray(:,:,4))

circColor(:,1) = [255 0 0]';
circColor(:,2) = [0 0 0]';
circColor(:,3) = [0 0 255]';
circColorArray = [circColor(:,1), circColor(:,2), circColor(:,3)];
circColorOrig(:,1) = circColor(:,1);
circColorOrig(:,2) = circColor(:,3) ;

colorOrder = 1;   % Which circles will be red/blue
flipColor = 0;

% Speed at which one full modulation from red to blue
modSpeed = 255/1;   % number of color units per second
modRate = modSpeed/hz;   % Number of color units per flip
modColors = 0;
modColorsStart = 1;

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

% Load in and create the glasses texture
[glasses,map,alpha] = imread('nerd-glasses.png','PNG');
glasses(:,:,4) = alpha;
glassesSize = size(glasses);
glassesTexture = Screen('MakeTexture', w, glasses);

movieCounter=1; %absoulutely necessary. Keeps track of your movie frames

%% Draw and record video
% Title sceen
for i=1:hz*3
    Screen('DrawTexture',w,glassesTexture,[],[x0-glassesSize(1)/2, y0-glassesSize(1)/2, x0+glassesSize(1)/2, y0+glassesSize(1)/2]);
    
    Screen('TextSize',w,50);
    Screen('TextFont',w,'BookmanOldStyle');
    text='Revenge of the Nerds: Chromatic Aboration Strikes Back';
    width=RectWidth(Screen('TextBounds',w,text));
    Screen('DrawText',w,text,x0-width/2,y0-350,tColor); 
    
    Screen('TextSize',w,30);
    Screen('TextFont',w,'BookmanOldStyle');
    text='By: Dr. Gideon P. Caplovitz & Kyle W. Killebrew';
    width=RectWidth(Screen('TextBounds',w,text));
    Screen('DrawText',w,text,x0-width/2,y0+300,tColor); 
    
    Screen('TextSize',w,30);
    Screen('TextFont',w,'BookmanOldStyle');
    text='Music By: Dr. Jean-Paul Perrotte';
    width=RectWidth(Screen('TextBounds',w,text));
    Screen('DrawText',w,text,x0-width/2,y0+350,tColor);
    
    Screen('TextSize',w,30);
    Screen('TextFont',w,'BookmanOldStyle');
    text='The University of Nevada, Reno';
    width=RectWidth(Screen('TextBounds',w,text));
    Screen('DrawText',w,text,x0-width/2,y0+400,tColor);
    
    Screen('Flip',w);
    
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end

% First draw the simple circle in a circle.
% Present text that will be spoken: 'This is an illusion that only works
% with glasses.'
for i=1:hz*3
    
    % Draw
    Screen('FillOval',w,circColorArray,circPositionArray);
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    
    Screen('Flip',w);
    
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end

% % Create new circles that will show the new overlap colors (light  blue and
% % dark green). Draw them behind the initial dark blue circle. 
% circPositionArray(:,3) = circPositionArray(:,2);
% circPositionArray(:,4) = [(rect(4)/2)-circSize/2,(rect(4)/2)-circSize/2,(rect(4)/2)+circSize/2,(rect(4)/2)+circSize/2,];   % Coordinates in texture space
% 
% circColorArray(:,4) = circColorArray(:,2);
% circColorArray(:,2) = [0 255 0];
% circColorArray(:,3) = [0 255 255];

% Demonstate effect
for i=1:hz*9
    
    % Draw
    Screen('FillOval',w,circColorArray(:,[1 2]),circPositionArray(:,[1 2])); 
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    Screen('FillOval',w,circColorArray(:,3),[circPositionArray(1,3)+2,circPositionArray(2,3)+2,circPositionArray(3,3)-2,circPositionArray(4,3)-2]);
%     Screen('FillOval',w,circColorArray(:,3),circPositionArray(:,3));   % Inner light blue overlap circle
%     apTexture = Screen('MakeTexture',w,circleApertureArray);
%     Screen('FillOval',apTexture,circColorArray(:,4),circPositionArray(:,4));
%     Screen('FrameRect',apTexture,[255 0 0],[0,0,rect(4),rect(4)])
%     Screen('DrawTexture',w,apTexture,[],[x0-rect(4)/2,0,x0+rect(4)/2,rect(4)]);
    
    % Move the inner dark blue circle
    if circPositionArray(3,3) < (x0+circSize/2)+20
       circPositionArray([1,3],3) =  circPositionArray([1,3],3)+1;
    end
    
    Screen('Flip',w);
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end
 % Demonstrate effect in the opposite direction
for i=1:hz*4
    
    % Draw
    Screen('FillOval',w,circColorArray(:,[1 2]),circPositionArray(:,[1 2]));   
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    Screen('FillOval',w,circColorArray(:,3),[circPositionArray(1,3)+2,circPositionArray(2,3)+2,circPositionArray(3,3)-2,circPositionArray(4,3)-2]);
    
    % Move the inner dark blue circle
    if circPositionArray(1,3) > (x0-circSize/2)-20
       circPositionArray([1,3],3) =  circPositionArray([1,3],3)-1;
    end
 
    
    Screen('Flip',w);
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end

% Move circle back
for i=1:hz*1
    
    % Draw
    Screen('FillOval',w,circColorArray(:,[1 2]),circPositionArray(:,[1 2]));   
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    Screen('FillOval',w,circColorArray(:,3),[circPositionArray(1,3)+2,circPositionArray(2,3)+2,circPositionArray(3,3)-2,circPositionArray(4,3)-2]);
    
    % Move the inner dark blue circle
    if circPositionArray(1,3) < (x0-circSize/2)
       circPositionArray([1,3],3) =  circPositionArray([1,3],3)+1;
    end
 
    
    Screen('Flip',w);
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end

clear circColo circColorArray circPositionArray

for i=1:numCircs
    circPositionArray(:,i) = [x0-(circSize*(numCircs+1-i))/2 y0-(circSize*(numCircs+1-i))/2, x0+(circSize*(numCircs+1-i))/2, y0+(circSize*(numCircs+1-i))/2]';
end
circPositionArrayOutline = circPositionArray;

circColor(:,1) = [255 0 0]';
circColor(:,2) = [0 0 255]';
circColorArray = [circColor(:,1), circColor(:,2)];

% Try it yourself
for i=1:hz*13
    
    % Draw
    Screen('FillOval',w,circColorArray,circPositionArray);
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    
    Screen('Flip',w);
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
end

% Alternating colors
for i=1:hz*8
    
    % Draw
    Screen('FillOval',w,circColorArray,circPositionArray);
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    
    % FLip the colors every 1 second
    if rem(i,60) == 0
        if colorOrder == 1
            colorOrder = 2;
        elseif colorOrder == 2
            colorOrder = 1;
        end
        
        flipColor = 1;
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
        circColorArray = [circColor(:,1), circColor(:,2)];
        flipColor = 0;
    end
    
    Screen('Flip',w);
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end

for i=1:hz*15
    
    % Draw
    Screen('FillOval',w,circColorArray,circPositionArray);
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    
    % Add more circles
    circColorChoose = 2;
    for j=1:numCircs
        circPositionArray(:,j) = [x0-(circSize*(numCircs+1-j))/2 y0-(circSize*(numCircs+1-j))/2, x0+(circSize*(numCircs+1-j))/2, y0+(circSize*(numCircs+1-j))/2]';
        circPositionArrayOutline(:,j) = [x0-(circSize*(numCircs+1-j))/2 y0-(circSize*(numCircs+1-j))/2, x0+(circSize*(numCircs+1-j))/2, y0+(circSize*(numCircs+1-j))/2]';
        %         outlineColor(:,j) = [0 0 0];
        if circColorChoose == 1
            circColorArray(:,(numCircs+1-j)) = circColor(:,circColorChoose);
        elseif circColorChoose == 2
            circColorArray(:,(numCircs+1-j)) = circColor(:,circColorChoose);
        end
        circColorChoose = 3-circColorChoose;
    end
    % Add 4 more circles
    if numCircs < 5
        if rem(i,60) == 0  % Add a circle
            numCircs = numCircs+1;
        end
    end
    
    % Flip color while adding circles
    if numCircs <= 4
        % FLip the colors every 1 second
        if rem(i,60) == 0
            if colorOrder == 1
                colorOrder = 2;
            elseif colorOrder == 2
                colorOrder = 1;
            end
            
            flipColor = 1;
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
    end
    
    % Modulate colors when numcircs is constant
    if numCircs >= 5
        % Modulate the color
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
    
    Screen('Flip',w);
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end

for i=1:hz*4
    
    % Draw
    Screen('FillOval',w,circColorArray,circPositionArray);
    Screen('FrameOval',w,outlineColor,circPositionArrayOutline,outlineThickness);
    
    Screen('TextSize',w,40);
    Screen('TextFont',w,'BookmanOldStyle');
    text='For more information Google ''Chromatic Aboration''';
    width=RectWidth(Screen('TextBounds',w,text));
    Screen('DrawText',w,text,x0-width/2,y0,[255 255 255]);
    
    % Add more circles
    circColorChoose = 2;
    for j=1:numCircs
        circPositionArray(:,j) = [x0-(circSize*(numCircs+1-j))/2 y0-(circSize*(numCircs+1-j))/2, x0+(circSize*(numCircs+1-j))/2, y0+(circSize*(numCircs+1-j))/2]';
        circPositionArrayOutline(:,j) = [x0-(circSize*(numCircs+1-j))/2 y0-(circSize*(numCircs+1-j))/2, x0+(circSize*(numCircs+1-j))/2, y0+(circSize*(numCircs+1-j))/2]';
        %         outlineColor(:,j) = [0 0 0];
        if circColorChoose == 1
            circColorArray(:,(numCircs+1-j)) = circColor(:,circColorChoose);
        elseif circColorChoose == 2
            circColorArray(:,(numCircs+1-j)) = circColor(:,circColorChoose);
        end
        circColorChoose = 3-circColorChoose;
    end
    % Add 4 more circles
    if numCircs < 5
        if rem(i,60) == 0  % Add a circle
            numCircs = numCircs+1;
        end
    end
    
    % Modulate the color
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
    
    Screen('Flip',w);
    if movieMaker == 1
        imagetemp(movieCounter).image = Screen('GetImage',w); %Put this command after every Flip command.
        movieCounter = movieCounter+1;
    end
    
end

Screen('CloseAll') %must be done before the movie is actually made.
ShowCursor;
ListenChar(0);

% imagetemp=imagetemp(1,2:length(imagetemp)); %may or may not be necessary.
% Include if first frame of movie is something other than what was desired.
if movieMaker == 1
    vidObj = VideoWriter('ChromaticAborationIllusion_MotionJPEGAVI','Motion JPEG AVI');%set up movie name and type.%be sure to give a new name for each movie, or it will overwrite.
    vidObj.FrameRate = 60; %set framerate
    vidObj.Quality = 100;
    
    open(vidObj);   %all of this should remain the same
    
    for i=1:length(imagetemp)
        writeVideo(vidObj,imagetemp(i).image);%writes the current frame to vidObj.
    end
    
    %Once we've written our video, close it.
    
    close(vidObj);
end










