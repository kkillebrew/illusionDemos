% Visual Illusions

%Chromostereopsis
%Vertical/Horizontal Illusion
%Cafe Wall Illusion
%Poggendorf Illusion
%Ponzo Illusion
%Ebbinghaus Illusion
%Simultaneous Contrast
%Shepard's Tables
%Lilac Chaser
%Bar Cross Ellipse
%Motion After Effect

clear all
Screen('Preference', 'SkipSyncTests', 1);
datafile = input('Please Hit Enter','s');
ListenChar(2);
HideCursor;
Priority(9);
[w,rect]=Screen('OpenWindow',0,[255 255 255]);
xc=rect(3)/2;
yc=rect(4)/2;

escape=KbName('escape');
zero=KbName('-_');
one=KbName('1!');
two=KbName('2@');
three=KbName('3#');
four=KbName('4$');
five=KbName('5%');
six=KbName('6^');
seven=KbName('7&');
eight=KbName('8*');
nine=KbName('9(');
ten=KbName('0)');
up=KbName('uparrow');
down=KbName('downarrow');
left=KbName('leftarrow');
right=KbName('rightarrow');
greater=KbName('.>');
lesser=KbName(',<');
skey=KbName('s');
gkey=KbName('g');
bkey=KbName('b');
tkey=KbName('t');

traparray=zeros(500,500);
rtraparray=255*ones(500,500);
rtraparray(:,:,2)=255;
rtraparray(:,:,3)=255;
ba=zeros(1,1);
bt=Screen('MakeTexture',w,ba);
for i=0:255;
    grada(1,i+1)=i;
end
gradt=Screen('MakeTexture',w,grada);

for i=1:250
    for j=1:500-(i*2)+2
        traparray(j,i)=255;
    end
end
x=0;
for a=500:-1:251
    x=x+1;
    for b=1+(x*2)-2:500
        traparray(b,a)=255;
    end
end

for a=1:500
    for b=1:500
        if traparray(a,b)==0
            rtraparray(a,b,1)=255;
            rtraparray(a,b,2)=0;
            rtraparray(a,b,3)=0;
        end
    end
end

tr=Screen('MakeTexture',w,traparray);
rtr=Screen('MakeTexture',w,rtraparray);

ellipse_size = 500;                                                           %draw ellipse shape
for i = 1:ellipse_size;
    for j = 1:ellipse_size;
        if ((i-ellipse_size/2)^2)/(ellipse_size/2)^2 + ((j-ellipse_size/2)^2)/...
                ( ellipse_size/2)^2 <= 1;
            ellipse_array(i,j) = 0;
        else
            ellipse_array(i,j) = 255;
        end
    end
end
pict=ellipse_array;

pict1=zeros(1,1);

xsizeref = (round(rect(4)*0.069444));                              %set up sizes for reference ellipse
ysizeref = (round(rect(4)*0.13889));
occcolor=[255 255 255];

t=Screen('MakeTexture',w,pict);

toggle=1;
illusion=0;
shift=(round(rect(4)*0.03125));
textoffset=rect(3)-(round(rect(4)*0.27778));
theangle=0;
longer=0;
wider=-(round(rect(4)*0.017361));
bob=1;
scale=2;
offset=(round(rect(4)*0.34722));
thick=5;
rad=(round(rect(4)*0.20833));
dr=(round(rect(4)*0.041667));
a=8;
k=1;
start_time=GetSecs;

[keyisdown, secs, keycode] = KbCheck;
while ~keycode(escape)
    [keyisdown, secs, keycode] = KbCheck;
    switch illusion
        case 0
            [keyisdown, secs, keycode] = KbCheck;
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.17361)))-(randi((round(rect(4)*0.27708))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            end
            
            Screen('FillRect',w,[0 0 0],[0,0,rect(3)-1,rect(4)]);
            Screen('DrawLine',w,[0 0 0],rect(3),0,rect(3),rect(4),5);
            Screen('FrameRect',w,[0 0 255],[xc-(round(rect(4)*0.67361)),yc-(round(rect(4)*0.25694)),xc+(round(rect(4)*0.67361)),yc+(round(rect(4)*0.1875))],10);
            Screen('FrameRect',w,[255 0 0],[xc-(round(rect(4)*0.6875)),yc-(round(rect(4)*0.27083)),xc+(round(rect(4)*0.6875)),yc+(round(rect(4)*0.20139))],10);
            
            
            Screen('TextSize',w,200);
            text='Optical Illusions';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2-(round(rect(4)*0.034722)),yc-(round(rect(4)*0.13889)),[0 0 255]);
            Screen('DrawText',w,text,xc-width/2,yc-(round(rect(4)*0.10417)),[255 0 0]);
            Screen('TextSize',w,24);
            text='escape: quit';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,rect(4)-(round(rect(4)*0.10417)),[0 0 255]);
            text='# keys: choose illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,rect(4)-(round(rect(4)*0.069444)),[255 0 0]);
            
        case 1 %vertical horizontal illusion
            [keyisdown, secs, keycode] = KbCheck;
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(right)
                theangle=theangle+1;
                if theangle>= 90
                    theangle=90;
                end
            elseif keycode(left)
                theangle=theangle-1;
                if theangle<=0
                    theangle=0;
                end
            elseif keycode(up)
                longer=longer+5;
                if longer>=(round(rect(4)*0.17361));
                    longer=(round(rect(4)*0.17361));
                end
            elseif keycode(down);
                longer=longer-5;
                if longer<=-(round(rect(4)*0.27708))
                    longer=-(round(rect(4)*0.27708));
                end
            end
            
            Screen('DrawTexture',w,bt,[],[xc-(round(rect(4)*0.27778)),yc+(round(rect(4)*0.27639)),xc+(round(rect(4)*0.27778)),yc+(round(rect(4)*0.27917))]);
            
            Screen('DrawTexture',w,bt,[],[xc-2,yc-(round(rect(4)*0.27778))-longer,xc+2,yc+(round(rect(4)*0.27778))],theangle);
            
            Screen('TextSize',w,100);
            text='Vertical-Horizontal Illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='up/down: adjust vertical bar';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='left/right: rotate vertical bar';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.13889)),[0 0 0]);
            
        case 2 %cafe wall illusion
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(right)
                shift=shift+1;
                if shift>= (round(rect(4)*0.069444))
                    shift=(round(rect(4)*0.069444));
                end
            elseif keycode(left)
                shift=shift-1;
                if shift<=-(round(rect(4)*0.069444))
                    shift=-(round(rect(4)*0.069444));
                end
            end
            
            
            for i=-(round(rect(4)*0.27778)):(round(rect(4)*0.137)):(round(rect(4)*0.27778))
                for j=-(round(rect(4)*0.27778)):(round(rect(4)*0.137)):(round(rect(4)*0.20833))
                    Screen('FillRect',w,[0 0 0],[xc+i,yc+j,xc+i+(round(rect(4)*0.069444)),yc+j+(round(rect(4)*0.069444))]);
                end
            end
            for i=-(round(rect(4)*0.34722)):(round(rect(4)*0.137)):(round(rect(4)*0.27778))
                for j=-(round(rect(4)*0.20928)):(round(rect(4)*0.137)):(round(rect(4)*0.20833))
                    Screen('FillRect',w,[0 0 0],[xc+i+shift,yc+j,xc+i+(round(rect(4)*0.069444))+shift,yc+j+(round(rect(4)*0.069444))]);
                end
            end
            for i=-(round(rect(4)*0.27778)):(round(rect(4)*0.0685)):(round(rect(4)*0.27778))
                Screen('DrawLine',w,[128 128 128],xc-(round(rect(4)*0.27778)),yc+i,xc+(round(rect(4)*0.27778)),yc+i,2);
            end
            Screen('FillRect',w,[255 255 255],[xc-(round(rect(4)*0.41667)),yc-(round(rect(4)*0.27778)),xc-(round(rect(4)*0.27778)),yc+(round(rect(4)*0.27778))]);
            Screen('FillRect',w,[255 255 255],[xc+(round(rect(4)*0.27778)),yc-(round(rect(4)*0.27778)),xc+(round(rect(4)*0.41667)),yc+(round(rect(4)*0.27778))]);
            Screen('FrameRect',w,[128 128 128],[xc-(round(rect(4)*0.27778)),yc-(round(rect(4)*0.27778)),xc+(round(rect(4)*0.27778)),yc+(round(rect(4)*0.27))]);
            
            Screen('TextSize',w,100);
            text='Cafe Wall Illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='left/right: shift rows';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            
        case 3    %poggendorff illusion
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(down)
                wider=wider+1;
                if wider>=(round(rect(4)*(0.016)))
                    wider=(round(rect(4)*(0.016)));
                end
            elseif keycode(up)
                wider=wider-1;
                if wider<=(round(rect(4)*(-0.017361)))
                    wider=(round(rect(4)*(-0.017361)));
                end
            end
            
            for i=0:200:rect(3)
                Screen('FillRect',w,[0 0 0],[i+(round(rect(4)*(0.017361)))+wider,0,i+(round(rect(4)*0.052083))-wider,rect(4)]);
            end
            
            for i=0:200:rect(3)
                for j=0:100:rect(4)
                    Screen('DrawTexture',w,bt,[],[i-(round(rect(4)*0.069444)),j-15,i+(round(rect(4)*0.13889)),j+15],45);
                end
            end
            
            for i=100:200:rect(3)
                Screen('FillRect',w,[255 255 255],[i+(round(rect(4)*(0.017361))),0,i+(round(rect(4)*0.052083)),rect(4)]);
            end
            
            Screen('FillRect',w,[255 255 255],[textoffset-10,0,rect(3),rect(4)]);
            
            Screen('TextSize',w,101);
            text='Poggendorf Illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[255 255 255]);
            
            Screen('TextSize',w,99);
            text='Poggendorf Illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[255 255 255]);
            
            Screen('TextSize',w,100);
            text='Poggendorf Illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            
            
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='up/down: change column width';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            
        case 4   %ponzo illusion
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(up)
                shift=shift+(round(rect(4)*0.0069444));
                if shift>= (round(rect(4)*0.84722))
                    shift=(round(rect(4)*0.84722));
                end
            elseif keycode(down)
                shift=shift-(round(rect(4)*0.0069444));
                if shift<=0
                    shift=0;
                end
            elseif keycode(right)
                longer=longer+1;
                if longer>=(round(rect(4)*0.23958))
                    longer=(round(rect(4)*0.23958));
                end
            elseif keycode(left)
                longer=longer-1;
                if longer<=0
                    longer=0;
                end
            end
            
            Screen('DrawLine',w,[0 0 0],xc-rect(3)/2,rect(3),xc-rect(3)/16,0,3);
            Screen('DrawLine',w,[0 0 0],xc+rect(3)/2,rect(3),xc+rect(3)/16,0,3);
            Screen('DrawLine',w,[0 0 0],xc-rect(3)/16,(round(rect(4)*0.069444)),xc+rect(3)/16,(round(rect(4)*0.069444)),3);
            Screen('DrawLine',w,[0 0 0],xc-rect(3)/16-longer, rect(4)-(round(rect(4)*0.069444))-shift,xc+rect(3)/16+longer, rect(4)-(round(rect(4)*0.069444))-shift,3);
            
            Screen('TextSize',w,100);
            text='Ponzo Illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,(round(rect(4)*0.069444)),(round(rect(4)*0.034722)),[0 0 0]);
            
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='up/down: adjust bar position';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='left/right: change bar length';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.13889)),[0 0 0]);
            
        case 5 %Ebbinghaus Illusion
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(up)
                shift=shift+1;
                if shift>=(round(rect(4)*0.069444))
                    shift=(round(rect(4)*0.069444));
                end
            elseif keycode(down)
                shift=shift-1;
                if shift<=0
                    shift=0;
                end
            elseif keycode(tkey)
                if toggle==1;
                    toggle=0;
                    WaitSecs(.5);
                else
                    toggle=1;
                    WaitSecs(.5);
                end
                
            end
            
            Screen('FillOval',w,[0 0 0],[xc-rect(3)/6-(round(rect(4)*0.034722))-shift,yc-(round(rect(4)*0.034722))-shift,xc-rect(3)/6+(round(rect(4)*0.034722))+shift,yc+(round(rect(4)*0.034722))+shift]);
            Screen('FillOval',w,[0 0 0],[xc+rect(3)/6-(round(rect(4)*0.034722)),yc-(round(rect(4)*0.034722)),xc+rect(3)/6+(round(rect(4)*0.034722)),yc+(round(rect(4)*0.034722))]);
            
            if toggle==1
                a=6;
                r1=(round(rect(4)*0.20833));
                dr1= (round(rect(4)*0.097222));
                for i=1:a
                    Screen('FillOval',w,[0 0 0],[xc-rect(3)/6+r1*cos(0+(i*pi)/(a/2))-dr1,yc+r1*sin(0+(i*pi)/(a/2))-dr1,...
                        xc-rect(3)/6+r1*cos(0+(i*pi)/(a/2))+dr1,yc+r1*sin(0+(i*pi)/(a/2))+dr1]);
                end
                a1=8;
                r2=(round(rect(4)*0.069444));
                dr2= (round(rect(4)*(0.017361)));
                for i=1:a1
                    Screen('FillOval',w,[0 0 0],[xc+rect(3)/6+r2*cos(0+(i*pi)/(a1/2))-dr2,yc+r2*sin(0+(i*pi)/(a1/2))-dr2,...
                        xc+rect(3)/6+r2*cos(0+(i*pi)/(a1/2))+dr2,yc+r2*sin(0+(i*pi)/(a1/2))+dr2]);
                end
            end
            
            Screen('TextSize',w,100);
            text='Ebbinghaus Illusion';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='up/down: resize left circle';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='"T": toggle surround';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.13889)),[0 0 0]);
        case 6 % Simultaneous contrast
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(tkey)
                if toggle==1;
                    toggle=0;
                    WaitSecs(.5);
                else
                    toggle=1;
                    WaitSecs(.5);
                end
                
            end
            
            if toggle==1;
                if bob==0;
                    for i=rect(4)/2:-5:1
                        Screen('DrawTexture',w,gradt,[],[0,0,rect(3),rect(4)]);
                        Screen('FillRect',w,[255 255 255],[0,0,rect(3),i]);
                        Screen('FillRect',w,[255 255 255],[0,0,i,rect(4)]);
                        Screen('FillRect',w,[255 255 255],[rect(3)-i,0,rect(3),rect(4)]);
                        Screen('FillRect',w,[255 255 255],[0,rect(4)-i,rect(3),rect(4)]);
                        Screen('FillRect',w,[128 128 128],[xc-(round(rect(4)*0.27778)),yc-(round(rect(4)*0.034722)),xc+(round(rect(4)*0.27778)),yc+(round(rect(4)*0.034722))]);
                        Screen('TextSize',w,24);
                        text='escape: quit';
                        Screen('TextSize',w,24);
                        Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
                        text='"T": toggle surround';
                        Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
                        text='# keys: change illusion';
                        Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
                        Screen('TextSize',w,100);
                        text='Simultaneous Contrast';
                        width=RectWidth(Screen('TextBounds',w,text));
                        Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
                        Screen('Flip',w);
                    end
                end
                Screen('DrawTexture',w,gradt,[],[0,0,rect(3),rect(4)]);
                bob=1;
            elseif bob==1;
                for i=1:5:rect(4)/2
                    Screen('DrawTexture',w,gradt,[],[0,0,rect(3),rect(4)]);
                    Screen('FillRect',w,[255 255 255],[0,0,rect(3),i]);
                    Screen('FillRect',w,[255 255 255],[0,0,i,rect(4)]);
                    Screen('FillRect',w,[255 255 255],[rect(3)-i,0,rect(3),rect(4)]);
                    Screen('FillRect',w,[255 255 255],[0,rect(4)-i,rect(3),rect(4)]);
                    Screen('FillRect',w,[128 128 128],[xc-(round(rect(4)*0.27778)),yc-(round(rect(4)*0.034722)),xc+(round(rect(4)*0.27778)),yc+(round(rect(4)*0.034722))]);
                    Screen('TextSize',w,24);
                    text='escape: quit';
                    Screen('TextSize',w,24);
                    Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
                    text='"T": toggle surround';
                    Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
                    text='# keys: change illusion';
                    Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
                    Screen('TextSize',w,100);
                    text='Color Contrast';
                    width=RectWidth(Screen('TextBounds',w,text));
                    Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
                    Screen('Flip',w);
                end
                bob=0;
            end
            Screen('FillRect',w,[128 128 128],[xc-(round(rect(4)*0.27778)),yc-(round(rect(4)*0.034722)),xc+(round(rect(4)*0.27778)),yc+(round(rect(4)*0.034722))]);
            
            Screen('TextSize',w,100);
            text='Color Contrast';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='"T": toggle surround';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            
        case 7  %Shepard's Tables
            [keyisdown, secs, keycode] = KbCheck;
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(up)
                theangle=theangle-1;
                if theangle<=0
                    theangle=0;
                end
            elseif keycode(down)
                theangle=theangle+1;
                if theangle>=63.43
                    theangle=63.43;
                end
            elseif keycode(left)
                shift=shift-5;
                if shift<=-offset
                    shift=-offset;
                end
            elseif keycode(right)
                shift=shift+5;
                if shift>=offset
                    shift=offset;
                end
            elseif keycode (tkey)
                if toggle==1
                    toggle=0;
                    WaitSecs(.5);
                else
                    toggle=1;
                    WaitSecs(.5);
                end
            end
            
            Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale+10,xc+(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale+10,2);
            
            Screen('DrawTexture',w,tr,[],CenterRectOnPoint([0-3 0-3 (round(rect(4)*0.13889))*scale+3 (round(rect(4)*0.13889))*scale+3],xc-offset,yc));
            
            Screen('DrawTexture',w,tr,[],CenterRectOnPoint([0-3 0-3 (round(rect(4)*0.13889))*scale+3 (round(rect(4)*0.13889))*scale+3],xc+offset,yc),63.43);
            
            if toggle==1
                Screen('DrawTexture',w,rtr,[],CenterRectOnPoint([0-3 0-3 (round(rect(4)*0.13889))*scale+3 (round(rect(4)*0.13889))*scale+3],xc+shift,yc),theangle);
            end
            
            Screen('DrawLine',w,[0 0 0],xc+(round(rect(4)*0.069444))*scale-offset,yc-(round(rect(4)*0.069444))*scale,xc+(round(rect(4)*0.069444))*scale-offset,yc,thick);
            Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.069444))*scale-offset,yc+(round(rect(4)*0.069444))*scale,xc-(round(rect(4)*0.069444))*scale-offset,yc+(round(rect(4)*0.13889))*scale,thick);
            %     Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.069444))*scale-offset+10,yc+(round(rect(4)*0.069444))*scale,xc-(round(rect(4)*0.069444))*scale-offset+10,yc+(round(rect(4)*0.13889))*scale,thick);
            Screen('DrawLine',w,[0 0 0],xc-offset,yc+(round(rect(4)*0.069444))*scale,xc-offset,yc+(round(rect(4)*0.13889))*scale,thick);
            
            Screen('Drawline',w,[0 0 0],xc-(round(rect(4)*0.069444))*scale-offset,yc+(round(rect(4)*0.069444))*scale+10,xc-offset,yc+(round(rect(4)*0.069444))*scale+10,thick);
            Screen('Drawline',w,[0 0 0],xc-offset,yc+(round(rect(4)*0.069444))*scale+10,xc+(round(rect(4)*0.069444))*scale-offset,yc-(round(rect(4)*0.069444))*scale+10,thick);
            
            Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.077778))*scale-(round(rect(4)*0.015278))*scale+offset,yc-(round(rect(4)*0.030556))*scale,xc-(round(rect(4)*0.077778))*scale-(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.038889))*scale,thick);
            Screen('DrawLine',w,[0 0 0],xc+(round(rect(4)*0.077778))*scale-(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale+10,xc+(round(rect(4)*0.077778))*scale-(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.038889))*scale,thick);
            Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale,xc-(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.1))*scale,thick);
            Screen('DrawLine',w,[0 0 0],xc+(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale,xc+(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.1))*scale,thick);
            
            Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale+10,xc+(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale+10,thick);
            Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.077778))*scale-(round(rect(4)*0.015278))*scale+offset,yc-(round(rect(4)*0.030556))*scale+10,xc-(round(rect(4)*0.077778))*scale+(round(rect(4)*0.015278))*scale+offset,yc+(round(rect(4)*0.030556))*scale+10,thick);
            
            Screen('TextSize',w,100);
            text='Shepards Tables';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='"T": toggle parallelogram';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='up/down: rotate parallelogram';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            text='left/right: move parallelogram';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.13889)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.17361)),[0 0 0]);
        case 8 %lilac chaser
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            end
            
            k=k+1;
            if k==a+1;
                k=1;
            end
            
            Screen('FillRect',w,[128 128 128],[0,0,rect(3)-1,rect(4)]);
            Screen('DrawLine',w,[128 128 128],rect(3),0,rect(3),rect(4),5);
            
            for i=1:a
                if i~=k
                    for j=dr:-1:1
                        
                        Screen('FillOval',w,[255-(j+(127-dr)) 128 255-(j+(127-dr))],...
                            [xc+rad*cos((i*pi)/(a/2))-(j),yc+rad*sin((i*pi)/(a/2))-(j),...
                            xc+rad*cos((i*pi)/(a/2))+(j),yc+rad*sin((i*pi)/(a/2))+(j)]);
                    end
                end
            end
            
            Screen('Drawline',w,[0 0 0], xc-5,yc,xc+5,yc,2);
            Screen('Drawline',w,[0 0 0], xc,yc-5,xc,yc+5,2);
            
            Screen('TextSize',w,100);
            text='Lilac Chaser';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            
            WaitSecs(.1);
        case 9 %BCE
            [keyisdown,secs,keycode]=KbCheck;
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(up)
                ellmod=ellmod+1;
                
            elseif keycode(down)
                ellmod=ellmod-1;
                if ellmod<1
                    ellmod=1;
                end
                
            elseif keycode(right)
                occmod=occmod+1;
                
            elseif keycode(left)
                occmod=occmod-1;
                
            elseif keycode(greater)
                wider=wider+1;
                
            elseif keycode(lesser)
                wider=wider-1;
                if wider<1;
                    wider=1;
                end
            end
            
            th = mod(360*(GetSecs-start_time)/period,360);
            
            Screen('DrawTexture',w,t,[],[xc-wider-(ellmod/2),yc-(round(rect(4)*0.13889))-ellmod,xc+wider+(ellmod/2),yc+(round(rect(4)*0.13889))+ellmod],th);
            
            Screen('FillRect',w,occcolor,[0,0,xc-(round(rect(4)*(0.017361)))-occmod,yc-(round(rect(4)*(0.017361)))-occmod]);
            Screen('FillRect',w,occcolor,[0,yc+(round(rect(4)*(0.017361)))+occmod,xc-(round(rect(4)*(0.017361)))-occmod,rect(4)]);
            Screen('FillRect',w,occcolor,[xc+(round(rect(4)*(0.017361)))+occmod,0,rect(3),yc-(round(rect(4)*(0.017361)))-occmod]);
            Screen('FillRect',w,occcolor,[xc+(round(rect(4)*(0.017361)))+occmod,yc+(round(rect(4)*(0.017361)))+occmod,rect(3),rect(4)]);
            
            Screen('TextSize',w,100);
            text='Bar Cross Ellipse';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2,(round(rect(4)*0.034722)),[0 0 0]);
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='up/down: change length';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='</>: change width';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
            text='left/right: move occluders';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.13889)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.17361)),[0 0 0]);
        case 10 %Motion After Effect
            
            if keycode(escape)
                break
            elseif keycode(zero)
                illusion=0;
            elseif keycode(one)
                illusion=1;
                theangle=0;
                longer=randi((round(rect(4)*0.041667)))-(randi((round(rect(4)*0.041667))));
            elseif keycode(two)
                illusion=2;
                shift=(round(rect(4)*0.03125));
            elseif keycode(three)
                illusion=3;
                wider=(round(rect(4)*(-0.017361)));
            elseif keycode(four)
                illusion=4;
                longer=randi((round(rect(4)*0.23958)));
                shift=0;
            elseif keycode(five)
                illusion=5;
                toggle=1;
                shift=randi((round(rect(4)*0.069444)));
            elseif keycode(six)
                illusion=6;
                toggle=1;
                bob=1;
            elseif keycode(seven)
                illusion=7;
                shift=0;
                theangle=45;
                scale=2;
                offset=(round(rect(4)*0.34722));
                thick=5;
                toggle=0;
            elseif keycode(eight)
                illusion=8;
                rad=(round(rect(4)*0.20833));
                dr=(round(rect(4)*0.041667));
                a=8;
                k=1;
            elseif keycode(nine)
                illusion=9;
                period=3;
                ellmod=0;
                occmod=0;
                wider=(round(rect(4)*0.069444));
            elseif keycode(ten)
                illusion=10;
                r=[(round(rect(4)*0.069444)) (round(rect(4)*0.17361)) (round(rect(4)*0.38194)) (round(rect(4)*0.59028)) (round(rect(4)*0.79861))];
                a=8;
                lw=10;
            elseif keycode(tkey)
                if toggle==1
                    toggle=0;
                else
                    toggle=1;
                end
                WaitSecs(.1);
            end
            
            if toggle==1;
                bobby=GetSecs;
            else
                bobby=0;
            end
            
            if bobby~=0
                Screen('FillOval',w,[255 0 0],[xc-(round(rect(4)*0.27778))-r(4),yc-r(4),xc-(round(rect(4)*0.27778))+r(4),yc+r(4)]);
                Screen('FillOval',w,[0 255 0],[xc-(round(rect(4)*0.27778))-r(3),yc-r(3),xc-(round(rect(4)*0.27778))+r(3),yc+r(3)]);
                Screen('FillOval',w,[0 0 255],[xc-(round(rect(4)*0.27778))-r(2),yc-r(2),xc-(round(rect(4)*0.27778))+r(2),yc+r(2)]);
                Screen('FillOval',w,[255 255 0],[xc-(round(rect(4)*0.27778))-r(1),yc-r(1),xc-(round(rect(4)*0.27778))+r(1),yc+r(1)]);
            end
            
            for i=0:a
                
                
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(1)*cos(bobby-(i*pi)/a),yc+r(1)*sin(bobby-(i*pi)/a),xc-(round(rect(4)*0.27778))+r(2)*cos(bobby-((i+1)*pi)/a),yc+r(2)*sin(bobby-((i+1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(2)*cos(bobby-((i+1)*pi)/a),yc+r(2)*sin(bobby-((i+1)*pi)/a),xc-(round(rect(4)*0.27778))+r(3)*cos(bobby-((i-1)*pi)/a),yc+r(3)*sin(bobby-((i-1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(3)*cos(bobby-(i*pi)/a),yc+r(3)*sin(bobby-(i*pi)/a),xc-(round(rect(4)*0.27778))+r(4)*cos(bobby-((i+1)*pi)/a),yc+r(4)*sin(bobby-((i+1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(4)*cos(bobby-((i+1)*pi)/a),yc+r(4)*sin(bobby-((i+1)*pi)/a),xc-(round(rect(4)*0.27778))+r(5)*cos(bobby-((i-1)*pi)/a),yc+r(5)*sin(bobby-((i-1)*pi)/a),lw);
                
                Screen('Drawline',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(1)*cos(bobby+(i*pi)/a),yc+r(1)*sin(bobby+(i*pi)/a),xc-(round(rect(4)*0.27778))+r(2)*cos(bobby+((i-1)*pi)/a),yc+r(2)*sin(bobby+((i-1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(2)*cos(bobby+((i-1)*pi)/a),yc+r(2)*sin(bobby+((i-1)*pi)/a),xc-(round(rect(4)*0.27778))+r(3)*cos(bobby+((i+1)*pi)/a),yc+r(3)*sin(bobby+((i+1)*pi)/a),lw);
                
                Screen('Drawline',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(3)*cos(bobby+(i*pi)/a),yc+r(3)*sin(bobby+(i*pi)/a),xc-(round(rect(4)*0.27778))+r(4)*cos(bobby+((i-1)*pi)/a),yc+r(4)*sin(bobby+((i-1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(4)*cos(bobby+((i-1)*pi)/a),yc+r(4)*sin(bobby+((i-1)*pi)/a),xc-(round(rect(4)*0.27778))+r(5)*cos(bobby+((i+1)*pi)/a),yc+r(5)*sin(bobby+((i+1)*pi)/a),lw);
                
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(1)*cos((-bobby)-(i*pi)/a),yc+r(1)*sin((-bobby)-(i*pi)/a),xc-(round(rect(4)*0.27778))+r(2)*cos((-bobby)-((i-1)*pi)/a),yc+r(2)*sin((-bobby)-((i-1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(2)*cos((-bobby)-((i-1)*pi)/a),yc+r(2)*sin((-bobby)-((i-1)*pi)/a),xc-(round(rect(4)*0.27778))+r(3)*cos((-bobby)-((i+1)*pi)/a),yc+r(3)*sin((-bobby)-((i+1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(3)*cos((-bobby)-(i*pi)/a),yc+r(3)*sin((-bobby)-(i*pi)/a),xc-(round(rect(4)*0.27778))+r(4)*cos((-bobby)-((i-1)*pi)/a),yc+r(4)*sin((-bobby)-((i-1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(4)*cos((-bobby)-((i-1)*pi)/a),yc+r(4)*sin((-bobby)-((i-1)*pi)/a),xc-(round(rect(4)*0.27778))+r(5)*cos((-bobby)-((i+1)*pi)/a),yc+r(5)*sin((-bobby)-((i+1)*pi)/a),lw);
                
                Screen('Drawline',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(1)*cos((-bobby)+(i*pi)/a),yc+r(1)*sin((-bobby)+(i*pi)/a),xc-(round(rect(4)*0.27778))+r(2)*cos((-bobby)+((i+1)*pi)/a),yc+r(2)*sin((-bobby)+((i+1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(2)*cos((-bobby)+((i+1)*pi)/a),yc+r(2)*sin((-bobby)+((i+1)*pi)/a),xc-(round(rect(4)*0.27778))+r(3)*cos((-bobby)+((i-1)*pi)/a),yc+r(3)*sin((-bobby)+((i-1)*pi)/a),lw);
                
                Screen('Drawline',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(3)*cos((-bobby)+(i*pi)/a),yc+r(3)*sin((-bobby)+(i*pi)/a),xc-(round(rect(4)*0.27778))+r(4)*cos((-bobby)+((i+1)*pi)/a),yc+r(4)*sin((-bobby)+((i+1)*pi)/a),lw);
                
                Screen('DrawLine',w,[0 0 0],xc-(round(rect(4)*0.27778))+r(4)*cos((-bobby)+((i+1)*pi)/a),yc+r(4)*sin((-bobby)+((i+1)*pi)/a),xc-(round(rect(4)*0.27778))+r(5)*cos((-bobby)+((i-1)*pi)/a),yc+r(5)*sin((-bobby)+((i-1)*pi)/a),lw);
                
                
            end
            
            Screen('FillOval',w,[0 0 0],[xc-(round(rect(4)*0.27778))-4,yc-4,xc-(round(rect(4)*0.27778))+4,yc+4]);
            
            Screen('TextSize',w,100);
            text='Motion Aftereffect';
            width=RectWidth(Screen('TextBounds',w,text));
            Screen('DrawText',w,text,xc-width/2-(round(rect(4)*0.27778)),(round(rect(4)*0.034722)),[0 0 0]);
            Screen('TextSize',w,24);
            text='escape: quit';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.034722)),[0 0 0]);
            text='"T":toggle motion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.069444)),[0 0 0]);
            text='# keys: change illusion';
            Screen('DrawText',w,text,textoffset,(round(rect(4)*0.10417)),[0 0 0]);
    end
    
    Screen('Flip',w);
end

Priority(0);
ShowCursor;
ListenChar(0);
Screen('CloseAll');