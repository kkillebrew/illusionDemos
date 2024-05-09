clear all

Screen('Preference', 'SkipSyncTests', 1);

movieMaker = 1;

a=20;
moveamount=.5;

wider=30;
geardeep=40;

baserad=300;

rads1=[baserad,baserad+geardeep];
rads2=[rads1(2)+wider,rads1(2)+wider+geardeep];
rads3=[rads2(2)+wider,rads2(2)+wider+geardeep];

backcolor=[255 255 255];
stillcolor=[0 0 70];
gearcolor=[200 200 200];

[w,rect]=Screen('OpenWindow',0,backcolor,[0 0 1920 1080]);
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
ListenChar(2);

escape=KbName('escape');
space=KbName('space');
up=KbName('uparrow');
down=KbName('downarrow');

xc=rect(3)/2;
yc=rect(4)/2;

[blank, ~, alpha] = imread('blank.png');
blank(:,:,4)=alpha(:,:);

wolf = imread('wolf.jpeg');

[wy,wx,wz]=size(wolf);
wrat=wy/wx;

wwide=rads1(1)*.75;
whigh=wwide*wrat;

wt=Screen('MakeTexture',w,wolf);

% Load in the Nevada picture into a texture
nevada = imread('nevada.jpg');
nevadaTexture = Screen('MakeTexture', w, nevada);

centblank=blank(101:100+rads1(2)*2,101:100+rads1(2)*2,:);
midblank=blank(101:100+rads2(2)*2,101:100+rads2(2)*2,:);
outblank=blank(101:100+rads3(2)*2,101:100+rads3(2)*2,:);

ct=Screen('MakeTexture',w,centblank);
mt=Screen('MakeTexture',w,midblank);
ot=Screen('MakeTexture',w,outblank);

cc=rads1(2);
mc=rads2(2);
oc=rads3(2);

shapearray=zeros(a*2,2,3);
movearray=zeros(a*2,2,2);
move=0;

salpha=1;
malpha=1;

counter1=0;
counter2=0;
imageCounter=0;

for i=1:a*2
    if mod(i,2)
        counter1=counter1+1;
        shapearray(i,:,1)=[cc+(rads1(1))*cos((counter1*pi)/(a/2)),cc+(rads1(1))*sin((counter1*pi)/(a/2))];
        shapearray(i,:,2)=[oc+(rads2(1))*cos((counter1*pi)/(a/2)),oc+(rads2(1))*sin((counter1*pi)/(a/2))];
        shapearray(i,:,3)=[oc+(rads3(1))*cos((counter1*pi)/(a/2)),oc+(rads3(1))*sin((counter1*pi)/(a/2))];
        movearray(i,:,1)=[mc+(rads2(1))*cos(((counter1+move)*pi)/(a/2)),mc+(rads2(1))*sin(((counter1+move)*pi)/(a/2))];
        movearray(i,:,2)=[mc+(rads1(1))*cos(((counter1+move)*pi)/(a/2)),mc+(rads1(1))*sin(((counter1+move)*pi)/(a/2))];
    else
        counter2=counter2+1;
        shapearray(i,:,1)=[cc+(rads1(2))*cos(((counter2+1/2)*pi)/(a/2)),cc+(rads1(2))*sin(((counter2+1/2)*pi)/(a/2))];
        shapearray(i,:,2)=[oc+(rads2(2))*cos(((counter2+1/2)*pi)/(a/2)),oc+(rads2(2))*sin(((counter2+1/2)*pi)/(a/2))];
        shapearray(i,:,3)=[oc+(rads3(2))*cos(((counter2+1/2)*pi)/(a/2)),oc+(rads3(2))*sin(((counter2+1/2)*pi)/(a/2))];
        movearray(i,:,1)=[mc+(rads2(2))*cos(((counter2+1/2+move)*pi)/(a/2)),mc+(rads2(2))*sin(((counter2+1/2+move)*pi)/(a/2))];
        movearray(i,:,2)=[mc+(rads1(2))*cos(((counter2+1/2+move)*pi)/(a/2)),mc+(rads1(2))*sin(((counter2+1/2+move)*pi)/(a/2))];
    end
end

Screen('FillPoly',ot,stillcolor,shapearray(:,:,3));
Screen('FillPoly',ot,backcolor,shapearray(:,:,2));
Screen('FillPoly',mt,gearcolor,movearray(:,:,1));
Screen('FillPoly',mt,backcolor,movearray(:,:,2));
Screen('FillPoly',ct,stillcolor,shapearray(:,:,1));

[~,~,keycode]=KbCheck;
while ~keycode(escape)
    [~,~,keycode]=KbCheck;
    move=move+moveamount;
    
    if keycode(up)
        salpha=salpha+.01;
        if salpha>1
            salpha=1;
        end
    elseif keycode(down)
        salpha=salpha-.01;
        if salpha<0
            salpha=0;
        end
    end
    
    Screen('DrawTexture',w,ot,[],[xc-oc,yc-oc,xc+oc,yc+oc],[],[],salpha);
    Screen('DrawTexture',w,mt,[],[xc-mc,yc-mc,xc+mc,yc+mc],move,[],malpha);
    Screen('DrawTexture',w,ct,[],[xc-cc,yc-cc,xc+cc,yc+cc],[],[],salpha);
    Screen('DrawTexture',w,wt,[],[xc-wwide,yc-whigh,xc+wwide,yc+whigh]);
    
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