clear

Screen('Preference', 'SkipSyncTests', 1);

[w,rect]=Screen('OpenWindow',0,[255 255 255],[0 0 1920 1080]);
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
ListenChar(2);

escape=KbName('escape');
space=KbName('space');
up=KbName('uparrow');
down=KbName('downarrow');

% Load in the Nevada picture into a texture
nevada = imread('nevada.jpg');
nevadaTexture = Screen('MakeTexture', w, nevada);

movieMaker = 1;

xc=rect(3)/2;
yc=rect(4)/2;

thick=10;

numlines=floor(yc/(thick));

dist=10;

bound=200;

startjitx=randi(2*bound-1)-bound;
startjity=randi(2*bound-1)-bound;

% Where the moving set of rings starts (must ensure that at the end of the
% movie, the rings ends up at this position to loop)
x=xc+startjitx;
y=yc+startjity;

xOrig=x;
yOrig=y;

dirx=((-1)^randi(2));
diry=((-1)^randi(2));

dirxOrig=dirx;
diryOrig=diry;

numBounces = 10;
counter = 1;
imageCounter = 1;

[~,~,keycode]=KbCheck;
% while ~keycode(escape)
while counter <= numBounces
    [~,~,keycode]=KbCheck;
    
    if x+dist*(dirx)>xc+bound || x+dist*(dirx)<xc-bound
        dirx=-dirx+(1+(-1-1)*rand(1));
        counter = counter + 1;
    end
    x=x+dist*(dirx);
    
    if y+dist*(diry)>yc+bound || y+dist*(diry)<yc-bound
        diry=-diry+(1+(-1-1)*rand(1));
        counter = counter + 1;
    end
    y=y+dist*(diry);
    
    for i=2:2:numlines
        Screen('FrameOval',w,[0 0 100],[xc-thick*i,yc-thick*i,xc+thick*i,yc+thick*i],thick);
    end
    
    for i=2:2:numlines
        Screen('FrameOval',w,[200 200 200],[x-thick*i,y-thick*i,x+thick*i,y+thick*i],thick);
    end
    
    % Create a dot at the starting location
    Screen('FillOval',w,[255 0 0],[xOrig-5, yOrig-5, xOrig+5, yOrig+5]);
    
    if movieMaker == 1
        % Add text and unr pic to bottom left of screen
        rectX1 = 0;
        rectX2 = (rect(3)*.25);
        rectY1 = rect(4)-(rect(4)*.2);
        rectY2 = rect(4);
        imageBuffer = 5;
        
        Screen('FillRect',w, [255 255 255], [rectX1, rectY1, rectX2, rectY2]);
        Screen('FrameRect',w, [0 0 0], [rectX1, rectY1, rectX2, rectY2], 5);
        
        % Large tittle
        Screen('TextSize',w,30);
        text='Motion Aftereffect';
        tHeight1=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer, [0 0 0]);
        
        % Second tittle
        Screen('TextSize',w,19);
        text='Kyle W. Killebrew & Gideon P. Caplovitz';
        tHeight2=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer+tHeight1, [0 0 0]);
        
        % Second tittle
        text='Department of Psychology';
        tHeight3=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer/2), rectY1+imageBuffer+tHeight1+tHeight2, [0 0 0]);
        
        % Text under the N
        Screen('TextSize',w,20);
        text='Do you see the curved lines appearing between';
        tHeight4=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2, [0 0 0]);
        
        % Text under the N
        Screen('TextSize',w,20);
        text='these rings? Come explore the mysteries of the';
        tHeight5=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4, [0 0 0]);
        
        % Text under the N
        text='mind in the Cognitive and Brain Sciences';
        tHeight6=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5, [0 0 0]);
        
        % Text under the N
        text='Program in the Department of Psychology!';
        tHeight7=RectHeight(Screen('TextBounds',w,text));
        Screen('DrawText',w, text,...
            rectX1+imageBuffer+2, (rectY2-(rectY2-rectY1)/2)-imageBuffer+2+tHeight4+tHeight5+tHeight6, [0 0 0]);
        
        % The nevada logo should be drawn from the top corner of box and extend
        % its full height and width.
        Screen('DrawTexture',w,nevadaTexture,[],[rectX1+imageBuffer, rectY1+imageBuffer,...
            ((rectY2-(rectY2-rectY1)/2)-imageBuffer)-(rectY1+imageBuffer), (rectY2-(rectY2-rectY1)/2)-imageBuffer]);
        
        %         imagetemp(counter).image = Screen('GetImage',w);
        %         imageCounter=imageCounter+1;
    end
    
    Screen('Flip',w);
end


KbWait;
ListenChar(0);
Screen('CloseAll');

% vidObj = VideoWriter('sizetestvid','Uncompressed AVI');%set up movie name and type.%be sure to give a new name for each movie, or it will overwrite.
% vidObj.FrameRate = 60; %set framerate
%
% open(vidObj);   %all of this should remain the same
% for i=1:length(imagetemp)
%     writeVideo(vidObj,imagetemp(i).image);%writes the current frame to vidObj.
% end
%
% %Once we've written our video, close it.
% close(vidObj);





