clear


[w,rect]=Screen('OpenWindow',0,[255 255 255]);
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
ListenChar(2);

escape=KbName('escape');
space=KbName('space');
up=KbName('uparrow');
down=KbName('downarrow');

xc=rect(3)/2;
yc=rect(4)/2;

offset=70;

linethick=20;

gap=7;

barwide=100;

numbars=floor(rect(3)/((barwide+gap)*2));

positions=((1:numbars)-((numbars)/2+.5))*(rect(3)/numbars);

buffer=50;

a=12;

bartex=200*ones(100,100);
bt=Screen('MakeTexture',w,bartex);

wheeltex=255*ones(rect(4)-buffer,rect(4)-buffer);

wt=Screen('MakeTexture',w,wheeltex);

wc=(rect(4)-buffer)/2;

for i=1:a
    Screen('Drawline',wt,[0 0 100],wc+(wc)*cos((i*pi)/(a/2)),wc+(wc)*sin((i*pi)/(a/2)),wc,wc,linethick);
end
Screen('FrameOval',wt,[0 0 100],[0,0,wc*2,wc*2],linethick);

ang=0;
angdist=1;

balpha=1;

[~,~,keycode]=KbCheck;
while ~keycode(escape)
    [~,~,keycode]=KbCheck;
    
    
    if keycode(up)
        balpha=balpha+.01;
        if balpha>1
            balpha=1;
        end
    elseif keycode(down)
        balpha=balpha-.01;
        if balpha<0
            balpha=0;
        end
    end
    
    ang=ang+angdist;
    
    Screen('DrawTexture',w,wt,[],[],ang);
    
    for i=1:length(positions)
        Screen('DrawTexture',w,bt,[],[xc+positions(i)-barwide+offset,0,xc+positions(i)+barwide+offset,rect(4)],[],[],balpha);
    end
    
    Screen('Flip',w);
end

KbWait;
ListenChar(0);
Screen('CloseAll');