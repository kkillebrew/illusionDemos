clear all
close all

Screen('Preference', 'SkipSyncTests', 1);

videoMaker = 0;

%BASIC WINDOW/SCREEN SETUP
% PPD stuff
mon_width_cm = 40;
mon_dist_cm = 73;
mon_width_deg = 2 * (180/pi) * atan((mon_width_cm/2)/mon_dist_cm);
PPD = (1024/mon_width_deg);

% Color vars
backColor = [0 0 0];
crossColor = [0 0 200];
circColor = [150 150 150];
fixColor = [0 255 0];
[w, rect] = Screen('Openwindow', 0, backColor, [0 0 1920 1080]);
x0 = rect(3)/2;
y0 = rect(4)/2;HideCursor;
ListenChar(2);

buttonEscape = KbName('escape');
buttonEnter = KbName('return');

Screen('BlendFunction',w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);  % Must have for alpha values for some reason

% Load in the Nevada picture into a texture
nevada = imread('Nevada_N_RGB.jpg');
nevadaTexture = Screen('MakeTexture', w, nevada);

% How many crosses do you want
numCrosses = 13;

% What size are crosses
crossSize = 30;

% size of the array of rotating crosses
crossArraySize = rect(4);

% Make the texture that you can draw on and rotate
crossArray = zeros([crossArraySize, crossArraySize]);
crossArrayText = Screen('MakeTexture',w,crossArray);

rotAng = 1;
angHolder = 0;

numCirc = 10;
circSize = 40;
thisr = y0/2;

fixCounter = 0;
fixState = 0;

% Movie vars
if videoMaker == 1   % do we want to make a video or not
    counter=1; %absoulutely necessary. Keeps track of your movie frames
end

[keyIsDown, secs, keycode] = KbCheck;
while angHolder<=360
   fixCounter = fixCounter+1;
   [keyIsDown, secs, keycode] = KbCheck;
   
   % Draw the crosses on the texture. Make sure to draw them according to
   % the size of the texture or [0 0 crossArraySize crossArraySize]
   Screen('FillRect',crossArrayText,backColor, [0, 0, crossArraySize, crossArraySize]);

   spacingArray = linspace(crossSize,crossArraySize-crossSize,numCrosses);
   for i=1:numCrosses
       for j=1:numCrosses
           % Find the center of the cross. Make sure they are evenly
           % spaced.
           crossLoc{i,j} = [spacingArray(i),spacingArray(j),spacingArray(i),spacingArray(j)];
           
           Screen('DrawLine', crossArrayText, crossColor,crossLoc{i,j}(1)+(-crossSize), crossLoc{i,j}(2),...
               crossLoc{i,j}(3)+(crossSize), crossLoc{i,j}(4),5);
           Screen('DrawLine', crossArrayText, crossColor,crossLoc{i,j}(1), crossLoc{i,j}(2)+(-crossSize),...
               crossLoc{i,j}(3), crossLoc{i,j}(4)+(crossSize),5);
           
%            Screen('FillOval',crossArrayText, [0 255 0], crossLoc{i,j} + [-10, -10, 10, 10]);
       end
   end
   
   angHolder = angHolder + rotAng;
   Screen('DrawTexture', w, crossArrayText, [], [x0-crossArraySize/2, y0-crossArraySize/2, x0+crossArraySize/2, y0+crossArraySize/2],angHolder);
   spacingArray = linspace(circSize,crossArraySize-circSize,numCirc);
   
   % Draw the circles on top of the texture. 
   for i=1:numCirc
       pointArray(i,:)=[x0+(thisr)*cos((i*pi)/(numCirc/2)),y0+(thisr)*sin((i*pi)/(numCirc/2))];
       
       Screen('FillOval',w, circColor, [pointArray(i,1)-circSize, pointArray(i,2)-circSize, pointArray(i,1)+circSize, pointArray(i,2)+circSize])
   end
   
   Screen('FillOval',w, fixColor, [x0-5, y0-5, x0+5, y0+5]);      % fixation
   
   if fixCounter == 60
       if fixState == 0
           fixState = 1;
           fixColor = [255 0 0];
       elseif fixState == 1
           fixState = 0;
           fixColor = [0 255 0];
       end
       fixCounter = 0;
   end
   
   % Add text and unr pic to bottom left of screen
   nineScreenEdge = 25;
   rectX1 = 0+nineScreenEdge;
   rectX2 = (rect(3)*.25)+nineScreenEdge;
   rectY1 = rect(4)-(rect(4)*.2)-nineScreenEdge;
   rectY2 = rect(4)-nineScreenEdge;
   imageBuffer = 5;
   
   Screen('FillRect',w, backColor, [rectX1, rectY1, rectX2, rectY2]);
   Screen('FrameRect',w, [255 255 255], [rectX1, rectY1, rectX2, rectY2], 5);
   
   % Large tittle
   Screen('TextSize',w,30);
   text='Motion Induced Blindness';
   tHeight1=RectHeight(Screen('TextBounds',w,text));
   Screen('DrawText',w, text,...
       rectX2*.25+imageBuffer, rectY1+imageBuffer, [255 255 255]);
   
   % Second tittle
   Screen('TextSize',w,19);
   text='Kyle W. Killebrew & Gideon P. Caplovitz';
   tHeight2=RectHeight(Screen('TextBounds',w,text));
   Screen('DrawText',w, text,...
       rectX2*.25+imageBuffer, rectY1+imageBuffer+tHeight1, [255 255 255]);
   
   % Second tittle
   text='Department of Psychology';
   tHeight3=RectHeight(Screen('TextBounds',w,text));
   Screen('DrawText',w, text,...
       rectX2*.25+imageBuffer, rectY1+imageBuffer+tHeight1+tHeight2, [255 255 255]);
 
   % Text under the N
   Screen('TextSize',w,17);
   text='Fixate on the central green/red circle. Are the';
   tHeight4=RectHeight(Screen('TextBounds',w,text));
   Screen('DrawText',w, text,...
       rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2, [255 255 255]);
   
   % Text under the N
   text='grey circles actually dissapearing? Come explore';
   tHeight5=RectHeight(Screen('TextBounds',w,text));
   Screen('DrawText',w, text,...
       rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4, [255 255 255]);
   
   % Text under the N
   text='the mysteries of the mind in the Cognitive and Brain';
   tHeight6=RectHeight(Screen('TextBounds',w,text));
   Screen('DrawText',w, text,...
       rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5, [255 255 255]);
    
   % Text under the N
   text='Sciences Program in the Department of Psychology.';
   tHeight7=RectHeight(Screen('TextBounds',w,text));
   Screen('DrawText',w, text,...
       rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5+tHeight6, [255 255 255]);

   % The nevada logo should be drawn from the top corner of box and extend
   % its full height and width.
   Screen('DrawTexture',w,nevadaTexture,[],[rectX1+imageBuffer, rectY1+imageBuffer,...
       rectX2*.25-imageBuffer, (rectY2-(rectY2-rectY1)/2)-imageBuffer]);
   
   Screen('Flip',w);
   
   if videoMaker == 1
       imagetemp(counter).image = Screen('GetImage',w); %Put this command after every Flip command.
       counter=counter+1;                               %Put this after every frame grab to make sure
       %the next frame is appended, and doesn't overwrite.
   end
   
end


ShowCursor;
ListenChar(0);
Screen('CloseAll')

if videoMaker == 1
    vidObj = VideoWriter('MotionInducedBlindness','Uncompressed AVI');%set up movie name and type.%be sure to give a new name for each movie, or it will overwrite.
    vidObj.FrameRate = 60; %set framerate
    
    open(vidObj);   %all of this should remain the same
    
    for i=1:length(imagetemp)
        writeVideo(vidObj,imagetemp(i).image);%writes the current frame to vidObj.
    end
    
    %Once we've written our video, close it.
    
    close(vidObj);
end




