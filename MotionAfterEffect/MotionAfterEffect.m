clear all
close all

Screen('Preference', 'SkipSyncTests', 1);

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

Screen('BlendFunction',w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);  % Must have for alpha values for some reason

% Load in the Nevada picture into a texture
nevada = imread('Nevada_N_RGB.jpg');
nevadaTexture = Screen('MakeTexture', w, nevada);

% Load in the Mackay picture
mackay = imread('MackaySchoolofMines.jpg');
mackayTexture = Screen('MakeTexture', w, mackay);

% Polygon vars
numPoints=30;
numSegs = 21;
segLength = rect(4)/numSegs;
thisr=y0;
pointArray=zeros(numPoints,2);

% Movement variables
velocity = 5;
totalDist = 0;

numSecs = 10;
picTime = 5;
fixCrossLength = 40;

this=1;

for i=1:numPoints
    for j=1:numSegs+2
        if j==1
            pointArray(i,:,j)=[x0,y0];
        else
            thisr = (j-1)*(y0/(numSegs));
            pointArray(i,:,j)=[x0+(thisr)*cos((i*pi)/(numPoints/2)),y0+(thisr)*sin((i*pi)/(numPoints/2))];
        end
    end
end

origArray = pointArray;

% Vars for displaying the picture after the motion
flipCounter = 0;
flipStatus = 1;
numIterations = 4;

% Movie Vars
counter=1; %absoulutely necessary. Keeps track of your movie frames
movieMaker = 0;
lengthNoMotion = 5;

[keyIsDown, secs, keycode] = KbCheck;
for z=1:numIterations
    [keyIsDown, secs, keycode] = KbCheck;
    flipCounter = 0;
    blankCounter = 1;
    while flipCounter <= numSegs
        %     while ~keycode(buttonEscape)
        %     while flipStatus == 1
        %         flipCounter = flipCounter + 1;
        
        if pointArray(1,1,2) <= origArray(1,1,1)
            flipCounter = flipCounter + 1;
            pointArray = origArray;
            totalDist = 0;
            if polyColor{1} == [0 0 0]
                polyColor{1} = [255 255 255];
                polyColor{2} = [0 0 0];
            elseif polyColor{2} == [0 0 0]
                polyColor{1} = [0 0 0];
                polyColor{2} = [255 255 255];
            end
        end
        
        
        Screen('FillPoly', w, polyColor{1}, origArray(:,:,numSegs+1));
        
        for i=1:numPoints
            for j=1:2:numSegs+1
                
                if this == 0
                    if i~=numPoints
                        Screen('FillPoly', w, polyColor{2}, [pointArray(i,:,j); pointArray(i+1,:,j); pointArray(i+1,:,j+1); pointArray(i,:,j+1)]);
                    else
                        Screen('FillPoly', w, polyColor{2}, [pointArray(i,:,j); pointArray(1,:,j); pointArray(1,:,j+1); pointArray(i,:,j+1)]);
                    end
                else
                    if i~=numPoints
                        Screen('FillPoly', w, polyColor{2}, [pointArray(i,:,j+1); pointArray(i+1,:,j+1); pointArray(i+1,:,j+2); pointArray(i,:,j+2)]);
                    else
                        Screen('FillPoly', w, polyColor{2}, [pointArray(i,:,j+1); pointArray(1,:,j+1); pointArray(1,:,j+2); pointArray(i,:,j+2)]);
                    end
                end
                
            end
            if this==1
                this=0;
            elseif this==0
                this=1;
            end
        end
        
        if movieMaker == 0
            totalDist = totalDist+velocity;
        elseif movieMaker == 1
            if z==numIterations
                % When making a movie make sure to include a non-motion
                % portion that lasts for x amount of seconds
                if blankCounter == lengthNoMotion*60
                   flipCounter = numSegs+1; 
                end
                blankCounter = blankCounter + 1;
            else
                totalDist = totalDist+velocity;
            end
        end
        
        for i=1:numPoints
            for j=1:numSegs+2
                if j==1
                    pointArray(i,:,j)=[x0,y0];
                else
                    thisr = ((j-1)*(y0/(numSegs)))-totalDist;
                    pointArray(i,:,j)=[x0+(thisr)*cos((i*pi)/(numPoints/2)),y0+(thisr)*sin((i*pi)/(numPoints/2))];
                end
            end
        end
        
        for i=1:numPoints
            if i~=numPoints
                Screen('FillPoly', w, backColor, [origArray(i,:,size(origArray,3)-1); origArray(i+1,:,size(origArray,3)-1); origArray(i+1,:,size(origArray,3)); origArray(i,:,size(origArray,3))]);
            else
                Screen('FillPoly', w, backColor, [origArray(i,:,size(origArray,3)-1); origArray(1,:,size(origArray,3)-1); origArray(1,:,size(origArray,3)); origArray(i,:,size(origArray,3))]);
            end
        end
        
        Screen('FillOval',w, [0 0 255], [x0-segLength, y0-segLength, x0+segLength, y0+segLength]);      % fixation
        Screen('DrawLine',w, [255 0 0], x0-fixCrossLength/2, y0, x0+fixCrossLength/2, y0, 5);
        Screen('DrawLine',w, [255 0 0], x0, y0-fixCrossLength/2, x0, y0+fixCrossLength/2, 5);
        
        % Include text near the fixation that ensures the participant is
        % fixating
        Screen('TextSize',w,20);
        text='Look';
        tHeight1=RectHeight(Screen('TextBounds',w,text));
        tWidth1=RectWidth(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            x0-tWidth1/2,y0-fixCrossLength/2-tHeight1, [255 255 255]);
        
        Screen('TextSize',w,20);
        text='Here';
        tHeight2=RectHeight(Screen('TextBounds',w,text));
        tWidth2=RectWidth(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            x0-tWidth2/2, y0+fixCrossLength/2, [255 255 255]);
        
        
        %         if flipCounter == 60*numSecs
        %             if flipStatus == 1
        %                 flipStatus = 2;
        %             elseif flipStatus == 2
        %                 flipStatus = 1;
        %             end
        %         end
        
        
        % Add text and unr pic to bottom left of screen
        %     Screen('FrameRect',w, [255 255 255], [0, rect(4)-(rect(4)*.2), (rect(3)*.25), rect(4)], 5);
        %     AddText(w, 'Four images will briefly appear on the screen, one in each quadrant.', [rect(3)+(rect(3)*.125), rect(4)-(rect(4)*.18)], [255 255 255], 11.2, 10);
        %
        
        % Add text and unr pic to bottom left of screen
        nineScreenEdge = 25;
        rectX1 = 0+nineScreenEdge;
        rectX2 = (rect(3)*.25)+nineScreenEdge;
        rectY1 = rect(4)-(rect(4)*.2)-nineScreenEdge;
        rectY2 = rect(4)-nineScreenEdge;
        imageBuffer = 5;
        
        Screen('FillRect',w, [0 0 0], [rectX1, rectY1, rectX2, rectY2]);
        Screen('FrameRect',w, [255 255 255], [rectX1, rectY1, rectX2, rectY2], 5);
        
        % Large tittle
        Screen('TextSize',w,30);
        text='Motion Aftereffect';
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
        
        %    % Text
        %    Screen('TextSize',w,15);
        %    text='Fixate on the central green/red circle.';
        %    tHeight3=RectHeight(Screen('TextBounds',w,text));
        %    Screen('DrawText',w, text,...
        %        ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer+tHeight1+tHeight2, [255 255 255]);
        %
        
        % Text under the N
        Screen('TextSize',w,20);
        text='Does the checkerboard change direction?';
        tHeight4=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2, [255 255 255]);
        
        % Text under the N
        Screen('TextSize',w,20);
        text='Come explore the mysteries of the mind';
        tHeight5=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4, [255 255 255]);
        
        % Text under the N
        text='in the Cognitive and Brain Sciences';
        tHeight6=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5, [255 255 255]);
        
        % Text under the N
        text='Program in the Department of Psychology!';
        tHeight7=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5+tHeight6, [255 255 255]);
        
        % The nevada logo should be drawn from the top corner of box and extend
        % its full height and width.
        Screen('DrawTexture',w,nevadaTexture,[],[rectX1+imageBuffer, rectY1+imageBuffer,...
            rectX2*.25-imageBuffer, (rectY2-(rectY2-rectY1)/2)-imageBuffer]);
        
        
        Screen('Flip', w);
        if movieMaker == 1
            imagetemp(counter).image = Screen('GetImage',w);
            counter=counter+1;
        end
        
    end
    
    %     % Draw the picture for 5 seconds
    %     for i=1:picTime*60
    %         Screen('DrawTexture',w,mackayTexture,[],[x0-y0, 0, x0+y0, rect(4)]);
    %
    %         % Add text and unr pic to bottom left of screen
    %         rectX1 = 0;
    %         rectX2 = (rect(3)*.25);
    %         rectY1 = rect(4)-(rect(4)*.2);
    %         rectY2 = rect(4);
    %         imageBuffer = 5;
    %
    %         Screen('FillRect',w, [0 0 0], [rectX1, rectY1, rectX2, rectY2]);
    %         Screen('FrameRect',w, [255 255 255], [rectX1, rectY1, rectX2, rectY2], 5);
    %
    %         % Large tittle
    %         Screen('TextSize',w,30);
    %         text='Motion Aftereffect';
    %         tHeight1=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer, [255 255 255]);
    %
    %         % Second tittle
    %         Screen('TextSize',w,19);
    %         text='Kyle W. Killebrew & Gideon P. Caplovitz';
    %         tHeight2=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer+tHeight1, [255 255 255]);
    %
    %         % Second tittle
    %         text='Department of Psychology';
    %         tHeight3=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer+tHeight1+tHeight2, [255 255 255]);
    %
    %         %    % Text
    %         %    Screen('TextSize',w,15);
    %         %    text='Fixate on the central green/red circle.';
    %         %    tHeight3=RectHeight(Screen('TextBounds',w,text));
    %         %    Screen('DrawText',w, text,...
    %         %        ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer+tHeight1+tHeight2, [255 255 255]);
    %         %
    %         % Text under the N
    %         Screen('TextSize',w,17);
    %         text='Fixate on the central red cross. Make sure not to';
    %         tHeight4=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2, [255 255 255]);
    %
    %         % Text under the N
    %         text='look away! Do you notice anything strange about';
    %         tHeight5=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4, [255 255 255]);
    %
    %         % Text under the N
    %         text='the Mackay Statue? Come explore the mysteries';
    %         tHeight6=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5, [255 255 255]);
    %
    %         % Text under the N
    %         text='of the mind In the Cognitive and Brain';
    %         tHeight7=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5+tHeight6, [255 255 255]);
    %
    %         % Text under the N
    %         text='Sciences Program in the Department of Psychology.';
    %         tHeight8=RectHeight(Screen('TextBounds',w,text));
    %         Screen('DrawText',w, text,...
    %             rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5+tHeight6+tHeight7, [255 255 255]);
    %
    %         % The nevada logo should be drawn from the top corner of box and extend
    %         % its full height and width.
    %         Screen('DrawTexture',w,nevadaTexture,[],[rectX1+imageBuffer, rectY1+imageBuffer,...
    %             ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer), (rectY2-(rectY2-rectY1)/2)-imageBuffer]);
    %
    %         Screen('Flip',w);
    %         imagetemp(counter).image = Screen('GetImage',w);
    %         counter=counter+1;
    %
    %     end
    %     if flipStatus == 1
    %         flipStatus = 2;
    %     elseif flipStatus == 2
    %         flipStatus = 1;
    %     end
    %     flipCounter = 0;
    
end

ShowCursor;
ListenChar(0);
Screen('CloseAll')

if movieMaker == 1
    vidObj = VideoWriter('MotionAftereffect','Uncompressed AVI');%set up movie name and type.%be sure to give a new name for each movie, or it will overwrite.
    vidObj.FrameRate = 60; %set framerate
    
    open(vidObj);   %all of this should remain the same
    
    for i=1:length(imagetemp)
        
        writeVideo(vidObj,imagetemp(i).image);%writes the current frame to vidObj.
    end
    
    %Once we've written our video, close it.
    
    close(vidObj);
end



