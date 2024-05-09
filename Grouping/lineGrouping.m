close all
clear all

HideCursor;
ListenChar(1);

Screen('Preference', 'SkipSyncTests', 1);

buttonEscape = KbName('escape');

% Color variables
backColor = [128 128 128];
lineColor{1} = [255 0 0];
lineColor{2} = [0 255 0];
lineColor{3} = [0 0 255];
lineColor{4} = [255 0 255];
lineColor{5} = [255 255 0];
lineColor{6} = [0 255 255];

% Line sizing variables
lineLength = 6;
lineNum = 5000;
totalArea = 1000;

[w, rect] = Screen('Openwindow', 0, backColor, [0 0 1920 1080]);
x0 = rect(3)/2;
y0 = rect(4)/2;

% Line texture variables
transVal = 0;
lineTextArray(:,:,1) = zeros(totalArea,totalArea)+backColor(1);
lineTextArray(:,:,2) = zeros(totalArea,totalArea)+backColor(2);
lineTextArray(:,:,3) = zeros(totalArea,totalArea)+backColor(3);
lineTextArray(:,:,4) = zeros(totalArea,totalArea)+transVal;
lineText = Screen('MakeTexture',w,lineTextArray);

% Circle sizing variables
circRad = 200;
numCircSegs = 100;
circCenterX = totalArea/2;
circCenterY = totalArea/2;
circLineJitter = 30;

% Circle texture variables
transVal = 0;
circTextArray(:,:,1) = zeros(totalArea,totalArea)+backColor(1);
circTextArray(:,:,2) = zeros(totalArea,totalArea)+backColor(2);
circTextArray(:,:,3) = zeros(totalArea,totalArea)+backColor(3);
circTextArray(:,:,4) = zeros(totalArea,totalArea)+transVal;
circText = Screen('MakeTexture',w,circTextArray);

Screen('BlendFunction',w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);  % Must have for alpha values for some reason

% Create the background textures (and their black counterparts
for i=1:lineNum
   % Calculate the line position (center point) (make sure none of the lines overlap)
   % lineCoord: x1,y1;x2,y2
   lineCoord(1,1) = randi(totalArea)-(lineLength/2);
   lineCoord(1,2) = randi(totalArea)-(lineLength/2);
   lineCoord(2,1) = lineCoord(1,1)+lineLength;
   lineCoord(2,2) = lineCoord(1,2)+lineLength;
   
   % Calculate the line orientation
   rotAngle = randi(359);
   rotRadians = rotAngle*(pi/180);
   xCenter = (lineCoord(2,1)+lineCoord(1,1))/2;
   yCenter = (lineCoord(2,2)+lineCoord(1,2))/2;
   
   pointArray = [lineCoord(:,1)';lineCoord(:,2)'];
   centerArray = repmat([xCenter; yCenter], 1, 2);
   
   rotationDist = [cos(rotRadians), -sin(rotRadians); sin(rotRadians), cos(rotRadians)];
   
   % Rotate the line
   newCoords(:,:,i) = rotationDist*(pointArray - centerArray) + centerArray;
   
   % Randomly assign colors to the lines
   lineColorIndex = randi(6);
   
   Screen('DrawLine',lineText,lineColor{lineColorIndex},newCoords(1,1,i),newCoords(2,1,i),newCoords(1,2,i),newCoords(2,2,i)); 
    
end

% Create the circle textures
for i=1:numCircSegs
    % Calculate the postions of the line segments along the circle edge
    circCoords(:,i) = [circCenterX+(circRad)*cos((i*pi)/(numCircSegs/2)),circCenterY+(circRad)*sin((i*pi)/(numCircSegs/2))];
    
%     thisSlope = (circCoord(1,
    
    % Randomly assign colors to the lines
    lineColorIndex = randi(6);
    
    Screen('DrawLine',circText,lineColor{lineColorIndex},circCoords(1,i)-lineLength/2,circCoords(2,i)-lineLength/2,circCoords(1,i)+lineLength/2,circCoords(2,i)+lineLength/2);
    
end

[keyIsDown, secs, keycode] = KbCheck;
while ~keycode(buttonEscape)
    [keyIsDown, secs, keycode] = KbCheck;
    
    Screen('DrawTextures',w,[lineText,circText],[],...
        [x0-(totalArea/2),y0-(totalArea/2),x0+(totalArea/2),y0+(totalArea/2);...
        x0-(totalArea/2),y0-(totalArea/2),x0+(totalArea/2),y0+(totalArea/2)]');
    
    Screen('Flip',w);
end

Screen('CloseAll')
ShowCursor;
ListenChar(0);




