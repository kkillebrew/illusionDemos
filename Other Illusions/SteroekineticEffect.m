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
backColor = [0 0 0];
circColor{1} = [0 0 100];
circColor{2} = [200 200 200];

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

% Movie Vars
counter=1; %absoulutely necessary. Keeps track of your movie frames
movieMaker = 1;

% Circ vars
numCirc2Out = 6;
numCirc2Inn = 3;
circSize = rect(4);
circRatio = [.4 .5 .6 .7 .8 .9];
innerCircRatio = [.2 .5 .8];
% circRatio = [.9 .8 .7 .6 .5 .4];
circColStatus = 1;
angleHolder = 0;
rotVel = 3;
x1Orig = x0-(circSize/2);

[keyIsDown, secs, keycode] = KbCheck;
while ~keycode(buttonEscape)
    [keyIsDown, secs, keycode] = KbCheck;
    
    % Draw all the circles to the top
    % Remember that each circle is a precentage of the last circle and that
    % the top y position of each is the same
    x1 = x0-(circSize/2);
    y1 = 0;
    x2 = x0+(circSize/2);
    y2 = circSize;
    xc = ((x1+x2)/2);
    yc = ((y1+y2)/2);
    circColStatus = 1;
    
    for i=1:numCirc2Out
        
        if circColStatus == 1
            circColStatus = 2;
        elseif circColStatus == 2
            circColStatus = 1;
        end
        
        Screen('FillOval',w,circColor{circColStatus}, [x1, y1, x2, y2]);
        Screen('FrameOval',w,[0 0 0], [x1, y1, x2, y2],3);
        
        % Similar to chris's except instead of using the center point as
        % the center of the screen, you use the center of the previous
        % circle drawn
        thisr = (circSize/2)*circRatio((numCirc2Out+1)-i);
        %         x = cx + r * cosd(a)
        %         y = cy + r * sind(a)
        
        x = xc   +   (circSize/2)  *    cosd(angleHolder);
        y = yc   +   (circSize/2)   *    sind(angleHolder);
        
        p1x = xc;
        p2x = xc   +   thisr  *    cosd(angleHolder);
        p3x = x;
        p1y = yc;
        p2y = yc   +   thisr  *    sind(angleHolder);
        p3y = y;
        
        p4x = p1x+((p1x-p2x)-(p1x-p3x));
        p4y = p1y+((p1y-p2y)-(p1y-p3y));
        
        x1 = p4x-thisr;
        y1 = p4y-thisr;
        x2 = p4x+thisr;
        y2 = p4y+thisr;
        
        if i == numCirc2Out-1
            xc2 = (x1+x2)/2;
            yc2 = (y1+y2)/2;
            circSize2 = thisr*2;
        end
        
    end
    
    for j=1:numCirc2Inn
        if circColStatus == 1
            circColStatus = 2;
        elseif circColStatus == 2
            circColStatus = 1;
        end
        
        %         Screen('FillOval',w,circColor{circColStatus}, [x1, y1, x2, y2]);
        %         Screen('FrameOval',w,[0 0 0], [x1, y1, x2, y2],3);
        
        % Similar to chris's except instead of using the center point as
        % the center of the screen, you use the center of the previous
        % circle drawn
        thisr = (circSize2/2)*innerCircRatio((numCirc2Inn+1)-j);
        %         x = cx + r * cosd(a)
        %         y = cy + r * sind(a)
        
        x = xc2   -   (circSize2/2)  *    cosd(angleHolder);
        y = yc2   -   (circSize2/2)   *    sind(angleHolder);
        
        p1x = xc2;
        p2x = xc2   -   thisr  *    cosd(angleHolder);
        p3x = x;
        p1y = yc2;
        p2y = yc2   -   thisr  *    sind(angleHolder);
        p3y = y;
        
        p4x = p1x+((p1x-p2x)-(p1x-p3x));
        p4y = p1y+((p1y-p2y)-(p1y-p3y));
        
        x1 = p4x-thisr;
        y1 = p4y-thisr;
        x2 = p4x+thisr;
        y2 = p4y+thisr;
        
        Screen('FillOval',w,circColor{circColStatus}, [x1, y1, x2, y2]);
        Screen('FrameOval',w,[0 0 0], [x1, y1, x2, y2],3);
        
        
    end
    angleHolder = angleHolder+rotVel;
    if movieMaker == 1
        if angleHolder == 366
            break
        end
    end
    
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
    text='The Stereokinetic Effect';
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
    Screen('TextSize',w,20);
    text='Is this image really popping out of the screen?';
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


ShowCursor;
ListenChar(0);
Screen('CloseAll')

if movieMaker == 1
    vidObj = VideoWriter('StereokineticEffect','Uncompressed AVI');%set up movie name and type.%be sure to give a new name for each movie, or it will overwrite.
    vidObj.FrameRate = 60; %set framerate
    
    open(vidObj);   %all of this should remain the same
    
    for i=1:length(imagetemp)
        
        writeVideo(vidObj,imagetemp(i).image);%writes the current frame to vidObj.
    end
    
    %Once we've written our video, close it.
    
    close(vidObj);
end



