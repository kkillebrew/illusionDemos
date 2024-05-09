clear
Screen('Preference', 'SkipSyncTests', 1);
[w,rect]=Screen('OpenWindow',0,[255 255 255]);
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
ListenChar(2);

xc=rect(3)/2;
yc=rect(4)/2;

escape=KbName('escape');
up=KbName('uparrow');
down=KbName('downarrow');

xcen=xc;
ycen=yc;



gap=4;

arraysize=(rect(4));

checksize=round(rect(4)/13);
arraysize=checksize*13;

checkarray=zeros(arraysize,arraysize);

dotsize=round(checksize/3-gap*2);

checkcen=arraysize/2;
maxout=(arraysize/checksize-1)/2-1;


for i=1:checksize*2:length(checkarray)-(checksize-1)
    for j=1:checksize*2:length(checkarray)-(checksize-1)
        checkarray(i:i+(checksize-1),j:j+(checksize-1))=255;
        if i<length(checkarray)-(checksize)*2 && j<length(checkarray)-(checksize)*2
            checkarray(i+checksize:i+checksize+(checksize-1),j+checksize:j+checksize+(checksize-1))=255;
        end
    end
end

checkarray=abs(checkarray-255);

ct=Screen('MakeTexture',w,checkarray);

modamount=5;
colmod1=0;


[~,~,keycode]=KbCheck;
while ~keycode(escape)
    [~,~,keycode]=KbCheck;
    
    if keycode(up)
        colmod1=colmod1+modamount;
        if colmod1>255;
            colmod1=255;
        end
    elseif keycode(down)
        colmod1=colmod1-modamount;
        if colmod1<0;
            colmod1=0;
        end
    end
    
    placecolor=[255 255 255];
    color=[255 255 255];
    
    Screen('DrawTexture',w,ct);
    colswitch1=1;
    for i=1:maxout
        
        color=abs(color-255);
        
        switch colswitch1
            case 1
                modcolor1=color+colmod1;
                colswitch1=2;
            case 2
                modcolor1=color-colmod1;
                colswitch1=1;
        end

        placecolor=abs(placecolor-255);
        
        Screen('FillRect',w,modcolor1,[xcen-checksize/2+gap,ycen-checksize/2-gap-dotsize-checksize*(i-1),xcen-checksize/2+gap+dotsize,ycen-checksize/2-gap-checksize*(i-1)]);
        Screen('FillRect',w,modcolor1,[xcen+checksize/2-gap-dotsize,ycen-checksize/2-gap-dotsize-checksize*(i-1),xcen+checksize/2-gap,ycen-checksize/2-gap-checksize*(i-1)]);
        
        Screen('FillRect',w,modcolor1,[xcen-checksize/2+gap,ycen+checksize/2+gap+checksize*(i-1),xcen-checksize/2+gap+dotsize,ycen+checksize/2+gap+dotsize+checksize*(i-1)]);
        Screen('FillRect',w,modcolor1,[xcen+checksize/2-gap-dotsize,ycen+checksize/2+gap+checksize*(i-1),xcen+checksize/2-gap,ycen+checksize/2+gap+dotsize+checksize*(i-1)]);
        
        Screen('FillRect',w,modcolor1,[xcen-checksize/2-gap-dotsize-checksize*(i-1),ycen-checksize/2+gap,xcen-checksize/2-gap-checksize*(i-1),ycen-checksize/2+gap+dotsize]);
        Screen('FillRect',w,modcolor1,[xcen-checksize/2-gap-dotsize-checksize*(i-1),ycen+checksize/2-gap-dotsize,xcen-checksize/2-gap-checksize*(i-1),ycen+checksize/2-gap]);
        
        Screen('FillRect',w,modcolor1,[xcen+checksize/2+gap+checksize*(i-1),ycen-checksize/2+gap,xcen+checksize/2+gap+dotsize+checksize*(i-1),ycen-checksize/2+gap+dotsize]);
        Screen('FillRect',w,modcolor1,[xcen+checksize/2+gap+checksize*(i-1),ycen+checksize/2-gap-dotsize,xcen+checksize/2+gap+dotsize+checksize*(i-1),ycen+checksize/2-gap]);
        
        color2=placecolor;
        
        colswitch2=1;
        
        for j=1:maxout-(i-1)
            
            color2=abs(color2-255);
            switch colswitch1
                case 1
                    switch colswitch2
                        case 1
                            modcolor2=color2+colmod1;
                            colswitch2=2;
                        case 2
                            modcolor2=color2-colmod1;
                            colswitch2=1;
                    end
                case 2
                    switch colswitch2
                        case 1
                            modcolor2=color2-colmod1;
                            colswitch2=2;
                        case 2
                            modcolor2=color2+colmod1;
                            colswitch2=1;
                    end
            end
            
            Screen('FillRect',w,modcolor2,[xcen-checksize*1.5+gap-checksize*(i-1),ycen-checksize/2-gap-dotsize-checksize*(j-1),...
                xcen-checksize*1.5+gap+dotsize-checksize*(i-1),ycen-checksize/2-gap-checksize*(j-1)]);
            Screen('FillRect',w,modcolor2,[xcen-checksize*.5-gap-checksize*(i-1)-dotsize,ycen-checksize*1.5+gap-checksize*(j-1),...
                xcen-checksize*.5-gap-checksize*(i-1),ycen-checksize*1.5+gap+dotsize-checksize*(j-1)]);
            
            Screen('FillRect',w,modcolor2,[xcen+checksize*1.5-gap-dotsize+checksize*(i-1),ycen-checksize/2-gap-dotsize-checksize*(j-1),...
                xcen+checksize*1.5-gap+checksize*(i-1),ycen-checksize/2-gap-checksize*(j-1)]);
            Screen('FillRect',w,modcolor2,[xcen+checksize*.5+gap+checksize*(i-1),ycen-checksize*1.5+gap-checksize*(j-1),...
                xcen+checksize*.5+gap+checksize*(i-1)+dotsize,ycen-checksize*1.5+gap+dotsize-checksize*(j-1)]);
            
            Screen('FillRect',w,modcolor2,[xcen-checksize*1.5+gap-checksize*(i-1),ycen+checksize/2+gap+checksize*(j-1),...
                xcen-checksize*1.5+gap+dotsize-checksize*(i-1),ycen+checksize/2+gap+checksize*(j-1)+dotsize]);
            Screen('FillRect',w,modcolor2,[xcen-checksize*.5-gap-checksize*(i-1)-dotsize,ycen+checksize*1.5-gap+checksize*(j-1)-dotsize,...
                xcen-checksize*.5-gap-checksize*(i-1),ycen+checksize*1.5-gap+checksize*(j-1)]);
            
            Screen('FillRect',w,modcolor2,[xcen+checksize*1.5-gap-dotsize+checksize*(i-1),ycen+checksize/2+gap+checksize*(j-1),...
                xcen+checksize*1.5-gap+checksize*(i-1),ycen+checksize/2+gap+checksize*(j-1)+dotsize]);
            Screen('FillRect',w,modcolor2,[xcen+checksize*.5+gap+checksize*(i-1),ycen+checksize*1.5-gap+checksize*(j-1)-dotsize,...
                xcen+checksize*.5+gap+checksize*(i-1)+dotsize,ycen+checksize*1.5-gap+checksize*(j-1)]);
            
        end
        
    end
    
    Screen('Flip',w);
end
KbWait;
ListenChar(0);
Screen('CloseAll');