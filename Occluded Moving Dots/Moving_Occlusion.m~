Bar_distance = 20;
Bar_width = 70;
Dot_Direction = 1;     %1=right to left   2=left to right
Bar_Direction = 2;     %1=right to left   2=left to right
Occluded_Object = 1;      %1=Bars occluded   2=Dots occluded
dot_size = 50;
dot_color = 255;
bar_color = 0;
back_color = 128;
v=20;            % velocity of circle (pixels per frame)
va=10;      %velovity of bars

kdown=0;
d = KbName('d');
b = KbName('b');
o = KbName('o');
space = KbName('space');
uparrow = KbName('uparrow');
downarrow = KbName('downarrow');
leftarrow = KbName('leftarrow');
rightarrow = KbName('rightarrow');
escape = KbName('escape');

[w,rect]=Screen('OpenWindow', 0,[back_color back_color back_color]);
x0 = rect(3)/2;% screen center
y0 = rect(4)/2;

ya = 0;
yb = rect(4);

switch Dot_Direction
    case 1
        x=rect(3);
    case 2
        x=0;
end

tha= 2*pi;
th=2*pi;

y=y0;
xmin = -dot_size*2;
xmax = rect(3)+dot_size*2;
dx=v*cos(th);    % circle velocity
dy=v*sin(th);
 

switch Bar_Direction
    case 1
        xamax = 0;
        xa = 0;
    case 2
        xamax = 2*rect(3);
        xa=rect(3);
end

dxa=va*cos(tha);   % velocity of bars


Screen('TextSize',w,24);
text='Which set of dots appear to be moving faster?';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0-100,[0 0 0]);
text='Fixate on the red dot in the upper half of the screen.';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0-50,[0 0 0]);
text='Press d to change the direciton of the dots, b the bars, and o to change which object is occluded.';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0+0,[0 0 0]);
text='Use the up and down arrow keys to adjust the speed of the bars and left and right the dots.';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0+50,[0 0 0]);
text='Hold down the space bar to make the bars dissappear.';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0+100,[0 0 0]);
text='Press any key to begin.';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0+150,[0 0 0]);
Screen('Flip',w);
KbWait;

[keyisdown, secs, keycode] = KbCheck;
rect_texture = Screen('MakeTexture',w,0);
while(~(keycode(escape)))
    
    if keycode(d) && Dot_Direction==1
        Dot_Direction = 2;
    elseif keycode(d) && Dot_Direction==2
        Dot_Direction = 1;
    end
    
    if keycode(b) && Bar_Direction==1
        Bar_Direction = 2;
    elseif keycode(b) && Bar_Direction==2
        Bar_Direction = 1;
    end
    
    if keycode(o) && Occluded_Object==1
        Occluded_Object = 2;
    elseif keycode(o) && Occluded_Object==2
        Occluded_Object = 1;
    end
    
    if keycode(space) && Bar_Direction==1
        xa = -100000;
    elseif keycode(space) && Bar_Direction==2
        xa = 10000;
    end       
    
    if keycode(rightarrow)
        v = v + .1;
        dx=v*cos(th);
    end
    
    if keycode(leftarrow)
        v = v - .1;
        dx=v*cos(th);
    end
    
    if keycode(uparrow)
        va = va + .1;
        dxa=va*cos(tha);
    end 
    
    if keycode(downarrow)
        va = va - .1;
        dxa=va*cos(tha);
    end
 
    switch Occluded_Object
        
        case 1
            
            destrect_31 = [xa-Bar_width*30-Bar_distance*30, ya, xa-Bar_distance*30-Bar_width*29, yb];
            destrect_30 = [xa-Bar_width*29-Bar_distance*29, ya, xa-Bar_distance*29-Bar_width*28, yb];
            destrect_29 = [xa-Bar_width*28-Bar_distance*28, ya, xa-Bar_distance*28-Bar_width*27, yb];
            destrect_28 = [xa-Bar_width*27-Bar_distance*27, ya, xa-Bar_distance*27-Bar_width*26, yb];
            destrect_27 = [xa-Bar_width*26-Bar_distance*26, ya, xa-Bar_distance*26-Bar_width*25, yb];
            destrect_26 = [xa-Bar_width*25-Bar_distance*25, ya, xa-Bar_distance*25-Bar_width*24, yb];
            destrect_25 = [xa-Bar_width*24-Bar_distance*24, ya, xa-Bar_distance*24-Bar_width*23, yb];
            destrect_24 = [xa-Bar_width*23-Bar_distance*23, ya, xa-Bar_distance*23-Bar_width*22, yb];
            destrect_23 = [xa-Bar_width*22-Bar_distance*22, ya, xa-Bar_distance*22-Bar_width*21, yb];
            destrect_22 = [xa-Bar_width*21-Bar_distance*21, ya, xa-Bar_distance*21-Bar_width*20, yb];
            destrect_21 = [xa-Bar_width*20-Bar_distance*20, ya, xa-Bar_distance*20-Bar_width*19, yb];
            destrect_20 = [xa-Bar_width*19-Bar_distance*19, ya, xa-Bar_distance*19-Bar_width*18, yb];
            destrect_19 = [xa-Bar_width*18-Bar_distance*18, ya, xa-Bar_distance*18-Bar_width*17, yb];
            destrect_18 = [xa-Bar_width*17-Bar_distance*17, ya, xa-Bar_distance*17-Bar_width*16, yb];
            destrect_17 = [xa-Bar_width*16-Bar_distance*16, ya, xa-Bar_distance*16-Bar_width*15, yb];
            destrect_16 = [xa-Bar_width*15-Bar_distance*15, ya, xa-Bar_distance*15-Bar_width*14, yb];
            destrect_15 = [xa-Bar_width*14-Bar_distance*14, ya, xa-Bar_distance*14-Bar_width*13, yb];
            destrect_14 = [xa-Bar_width*13-Bar_distance*13, ya, xa-Bar_distance*13-Bar_width*12, yb];
            destrect_13 = [xa-Bar_width*12-Bar_distance*12, ya, xa-Bar_distance*12-Bar_width*11, yb];
            destrect_12 = [xa-Bar_width*11-Bar_distance*11, ya, xa-Bar_distance*11-Bar_width*10, yb];
            destrect_11 = [xa-Bar_width*10-Bar_distance*10, ya, xa-Bar_distance*10-Bar_width*9, yb];
            destrect_10 = [xa-Bar_width*9-Bar_distance*9, ya, xa-Bar_distance*9-Bar_width*8, yb];
            destrect_9 = [xa-Bar_width*8-Bar_distance*8, ya, xa-Bar_distance*8-Bar_width*7, yb];
            destrect_8 = [xa-Bar_width*7-Bar_distance*7, ya, xa-Bar_distance*7-Bar_width*6, yb];
            destrect_7 = [xa-Bar_width*6-Bar_distance*6, ya, xa-Bar_distance*6-Bar_width*5, yb];
            destrect_6 = [xa-Bar_width*5-Bar_distance*5, ya, xa-Bar_distance*5-Bar_width*4, yb];
            destrect_5 = [xa-Bar_width*4-Bar_distance*4, ya, xa-Bar_distance*4-Bar_width*3, yb];
            destrect_4 = [xa-Bar_width*3-Bar_distance*3, ya, xa-Bar_distance*3-Bar_width*2, yb];
            destrect_3 = [xa-Bar_width*2-Bar_distance*2, ya, xa-Bar_distance*2-Bar_width, yb];
            destrect_2 = [xa-Bar_width-Bar_distance, ya, xa-Bar_distance, yb];
            destrect1 = [xa, ya, xa+Bar_width, yb];%Tells you where the rectangle is/should be.
            destrect2 = [xa+Bar_width+Bar_distance, ya, xa+Bar_distance+Bar_width*2, yb];
            destrect3 = [xa+Bar_distance*2+Bar_width*2, ya, xa+Bar_distance*2+Bar_width*3, yb];
            destrect4 = [xa+Bar_distance*3+Bar_width*3, ya, xa+Bar_distance*3+Bar_width*4, yb];
            destrect5 = [xa+Bar_distance*4+Bar_width*4, ya, xa+Bar_distance*4+Bar_width*5, yb];
            destrect6 = [xa+Bar_distance*5+Bar_width*5, ya, xa+Bar_distance*5+Bar_width*6, yb];
            destrect7 = [xa+Bar_distance*6+Bar_width*6, ya, xa+Bar_distance*6+Bar_width*7, yb];
            destrect8 = [xa+Bar_distance*7+Bar_width*7, ya, xa+Bar_distance*7+Bar_width*8, yb];
            destrect9 = [xa+Bar_distance*8+Bar_width*8, ya, xa+Bar_distance*8+Bar_width*9, yb];
            destrect10 = [xa+Bar_distance*9+Bar_width*9, ya, xa+Bar_distance*9+Bar_width*10, yb];
            destrect11 = [xa+Bar_distance*10+Bar_width*10, ya, xa+Bar_distance*10+Bar_width*11, yb];
            destrect12 = [xa+Bar_distance*11+Bar_width*11, ya, xa+Bar_distance*11+Bar_width*12, yb];
            destrect13 = [xa+Bar_distance*12+Bar_width*12, ya, xa+Bar_distance*12+Bar_width*13, yb];
            destrect14 = [xa+Bar_distance*13+Bar_width*13, ya, xa+Bar_distance*13+Bar_width*14, yb];
            destrect15 = [xa+Bar_distance*14+Bar_width*14, ya, xa+Bar_distance*14+Bar_width*15, yb];
            destrect16 = [xa+Bar_distance*15+Bar_width*15, ya, xa+Bar_distance*15+Bar_width*16, yb];
            destrect17 = [xa+Bar_distance*16+Bar_width*16, ya, xa+Bar_distance*16+Bar_width*17, yb];
            destrect18 = [xa+Bar_distance*17+Bar_width*17, ya, xa+Bar_distance*17+Bar_width*18, yb];
            destrect19 = [xa+Bar_distance*18+Bar_width*18, ya, xa+Bar_distance*18+Bar_width*19, yb];
            destrect20 = [xa+Bar_distance*19+Bar_width*19, ya, xa+Bar_distance*19+Bar_width*20, yb];
            destrect21 = [xa+Bar_distance*20+Bar_width*20, ya, xa+Bar_distance*20+Bar_width*21, yb];
            destrect22 = [xa+Bar_distance*21+Bar_width*21, ya, xa+Bar_distance*21+Bar_width*22, yb];
            destrect23 = [xa+Bar_distance*22+Bar_width*22, ya, xa+Bar_distance*22+Bar_width*23, yb];
            destrect24 = [xa+Bar_distance*23+Bar_width*23, ya, xa+Bar_distance*23+Bar_width*24, yb];
            destrect25 = [xa+Bar_distance*24+Bar_width*24, ya, xa+Bar_distance*24+Bar_width*25, yb];
            destrect26 = [xa+Bar_distance*25+Bar_width*25, ya, xa+Bar_distance*25+Bar_width*26, yb];
            
            Screen('DrawTexture',w,rect_texture,[],destrect_31,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_30,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_29,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_28,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_27,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_26,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_25,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_24,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_23,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_22,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_21,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_20,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_19,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_18,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_17,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_16,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_15,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_14,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_13,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_12,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_11,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_10,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_9,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_8,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_7,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_6,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_5,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_4,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_3,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_2,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect1,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect2,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect3,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect4,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect5,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect6,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect7,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect8,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect9,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect10,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect11,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect12,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect13,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect14,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect15,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect16,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect17,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect18,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect19,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect20,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect21,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect22,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect23,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect24,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect25,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect26,[],[],[],[bar_color bar_color bar_color]);
            
            Screen('FillOval',w,[dot_color dot_color dot_color],[x-dot_size, y-dot_size, x+dot_size, y+dot_size]);
            Screen('FillOval',w,[dot_color dot_color dot_color],[x+dot_size*3, y-dot_size, x+dot_size*5, y+dot_size]);
            
            Screen('FillOval',w,[255 0 0],[x0-4 y0-204 x0+4 y0-196]);                     %fixation pt.
            
            Screen('Flip',w); %Flip
            
            switch Bar_Direction
                case 1
                    xa=xa-dxa;
                    if(xa+Bar_distance*25+Bar_width*26 < rect(3))
                        xa=rect(3)+10;
                    end
                case 2
                    xa=xa+dxa;
                    if(xa-Bar_width*30-Bar_distance*30 > 0)
                        xa=rect(3)-10;
                    end
            end
            
            switch Dot_Direction
                case 1
                    x=x-dx; % compute new position
                    if(x < xmin)
                        x=rect(3);
                    end
                    
                case 2
                    x=x+dx; % compute new position
                    if(x > xmax)
                        x=0;
                    end
                    
            end
            
        case 2
            
            
            destrect_31 = [xa-Bar_width*30-Bar_distance*30, ya, xa-Bar_distance*30-Bar_width*29, yb];
            destrect_30 = [xa-Bar_width*29-Bar_distance*29, ya, xa-Bar_distance*29-Bar_width*28, yb];
            destrect_29 = [xa-Bar_width*28-Bar_distance*28, ya, xa-Bar_distance*28-Bar_width*27, yb];
            destrect_28 = [xa-Bar_width*27-Bar_distance*27, ya, xa-Bar_distance*27-Bar_width*26, yb];
            destrect_27 = [xa-Bar_width*26-Bar_distance*26, ya, xa-Bar_distance*26-Bar_width*25, yb];
            destrect_26 = [xa-Bar_width*25-Bar_distance*25, ya, xa-Bar_distance*25-Bar_width*24, yb];
            destrect_25 = [xa-Bar_width*24-Bar_distance*24, ya, xa-Bar_distance*24-Bar_width*23, yb];
            destrect_24 = [xa-Bar_width*23-Bar_distance*23, ya, xa-Bar_distance*23-Bar_width*22, yb];
            destrect_23 = [xa-Bar_width*22-Bar_distance*22, ya, xa-Bar_distance*22-Bar_width*21, yb];
            destrect_22 = [xa-Bar_width*21-Bar_distance*21, ya, xa-Bar_distance*21-Bar_width*20, yb];
            destrect_21 = [xa-Bar_width*20-Bar_distance*20, ya, xa-Bar_distance*20-Bar_width*19, yb];
            destrect_20 = [xa-Bar_width*19-Bar_distance*19, ya, xa-Bar_distance*19-Bar_width*18, yb];
            destrect_19 = [xa-Bar_width*18-Bar_distance*18, ya, xa-Bar_distance*18-Bar_width*17, yb];
            destrect_18 = [xa-Bar_width*17-Bar_distance*17, ya, xa-Bar_distance*17-Bar_width*16, yb];
            destrect_17 = [xa-Bar_width*16-Bar_distance*16, ya, xa-Bar_distance*16-Bar_width*15, yb];
            destrect_16 = [xa-Bar_width*15-Bar_distance*15, ya, xa-Bar_distance*15-Bar_width*14, yb];
            destrect_15 = [xa-Bar_width*14-Bar_distance*14, ya, xa-Bar_distance*14-Bar_width*13, yb];
            destrect_14 = [xa-Bar_width*13-Bar_distance*13, ya, xa-Bar_distance*13-Bar_width*12, yb];
            destrect_13 = [xa-Bar_width*12-Bar_distance*12, ya, xa-Bar_distance*12-Bar_width*11, yb];
            destrect_12 = [xa-Bar_width*11-Bar_distance*11, ya, xa-Bar_distance*11-Bar_width*10, yb];
            destrect_11 = [xa-Bar_width*10-Bar_distance*10, ya, xa-Bar_distance*10-Bar_width*9, yb];
            destrect_10 = [xa-Bar_width*9-Bar_distance*9, ya, xa-Bar_distance*9-Bar_width*8, yb];
            destrect_9 = [xa-Bar_width*8-Bar_distance*8, ya, xa-Bar_distance*8-Bar_width*7, yb];
            destrect_8 = [xa-Bar_width*7-Bar_distance*7, ya, xa-Bar_distance*7-Bar_width*6, yb];
            destrect_7 = [xa-Bar_width*6-Bar_distance*6, ya, xa-Bar_distance*6-Bar_width*5, yb];
            destrect_6 = [xa-Bar_width*5-Bar_distance*5, ya, xa-Bar_distance*5-Bar_width*4, yb];
            destrect_5 = [xa-Bar_width*4-Bar_distance*4, ya, xa-Bar_distance*4-Bar_width*3, yb];
            destrect_4 = [xa-Bar_width*3-Bar_distance*3, ya, xa-Bar_distance*3-Bar_width*2, yb];
            destrect_3 = [xa-Bar_width*2-Bar_distance*2, ya, xa-Bar_distance*2-Bar_width, yb];
            destrect_2 = [xa-Bar_width-Bar_distance, ya, xa-Bar_distance, yb];
            destrect1 = [xa, ya, xa+Bar_width, yb];%Tells you where the rectangle is/should be.
            destrect2 = [xa+Bar_width+Bar_distance, ya, xa+Bar_distance+Bar_width*2, yb];
            destrect3 = [xa+Bar_distance*2+Bar_width*2, ya, xa+Bar_distance*2+Bar_width*3, yb];
            destrect4 = [xa+Bar_distance*3+Bar_width*3, ya, xa+Bar_distance*3+Bar_width*4, yb];
            destrect5 = [xa+Bar_distance*4+Bar_width*4, ya, xa+Bar_distance*4+Bar_width*5, yb];
            destrect6 = [xa+Bar_distance*5+Bar_width*5, ya, xa+Bar_distance*5+Bar_width*6, yb];
            destrect7 = [xa+Bar_distance*6+Bar_width*6, ya, xa+Bar_distance*6+Bar_width*7, yb];
            destrect8 = [xa+Bar_distance*7+Bar_width*7, ya, xa+Bar_distance*7+Bar_width*8, yb];
            destrect9 = [xa+Bar_distance*8+Bar_width*8, ya, xa+Bar_distance*8+Bar_width*9, yb];
            destrect10 = [xa+Bar_distance*9+Bar_width*9, ya, xa+Bar_distance*9+Bar_width*10, yb];
            destrect11 = [xa+Bar_distance*10+Bar_width*10, ya, xa+Bar_distance*10+Bar_width*11, yb];
            destrect12 = [xa+Bar_distance*11+Bar_width*11, ya, xa+Bar_distance*11+Bar_width*12, yb];
            destrect13 = [xa+Bar_distance*12+Bar_width*12, ya, xa+Bar_distance*12+Bar_width*13, yb];
            destrect14 = [xa+Bar_distance*13+Bar_width*13, ya, xa+Bar_distance*13+Bar_width*14, yb];
            destrect15 = [xa+Bar_distance*14+Bar_width*14, ya, xa+Bar_distance*14+Bar_width*15, yb];
            destrect16 = [xa+Bar_distance*15+Bar_width*15, ya, xa+Bar_distance*15+Bar_width*16, yb];
            destrect17 = [xa+Bar_distance*16+Bar_width*16, ya, xa+Bar_distance*16+Bar_width*17, yb];
            destrect18 = [xa+Bar_distance*17+Bar_width*17, ya, xa+Bar_distance*17+Bar_width*18, yb];
            destrect19 = [xa+Bar_distance*18+Bar_width*18, ya, xa+Bar_distance*18+Bar_width*19, yb];
            destrect20 = [xa+Bar_distance*19+Bar_width*19, ya, xa+Bar_distance*19+Bar_width*20, yb];
            destrect21 = [xa+Bar_distance*20+Bar_width*20, ya, xa+Bar_distance*20+Bar_width*21, yb];
            destrect22 = [xa+Bar_distance*21+Bar_width*21, ya, xa+Bar_distance*21+Bar_width*22, yb];
            destrect23 = [xa+Bar_distance*22+Bar_width*22, ya, xa+Bar_distance*22+Bar_width*23, yb];
            destrect24 = [xa+Bar_distance*23+Bar_width*23, ya, xa+Bar_distance*23+Bar_width*24, yb];
            destrect25 = [xa+Bar_distance*24+Bar_width*24, ya, xa+Bar_distance*24+Bar_width*25, yb];
            destrect26 = [xa+Bar_distance*25+Bar_width*25, ya, xa+Bar_distance*25+Bar_width*26, yb];
            
            Screen('FillOval',w,[dot_color dot_color dot_color],[x-dot_size, y-dot_size, x+dot_size, y+dot_size]);
            Screen('FillOval',w,[dot_color dot_color dot_color],[x-(-dot_size*4 + dot_size), y-dot_size, x+(dot_size*4 + dot_size), y+dot_size]);
            
            
            Screen('DrawTexture',w,rect_texture,[],destrect_31,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_30,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_29,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_28,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_27,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_26,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_25,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_24,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_23,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_22,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_21,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_20,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_19,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_18,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_17,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_16,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_15,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_14,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_13,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_12,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_11,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_10,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_9,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_8,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_7,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_6,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_5,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_4,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_3,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect_2,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect1,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect2,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect3,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect4,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect5,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect6,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect7,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect8,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect9,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect10,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect11,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect12,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect13,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect14,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect15,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect16,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect17,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect18,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect19,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect20,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect21,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect22,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect23,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect24,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect25,[],[],[],[bar_color bar_color bar_color]);
            Screen('DrawTexture',w,rect_texture,[],destrect26,[],[],[],[bar_color bar_color bar_color]);
            
            Screen('FillOval',w,[255 0 0],[x0-4 y0-204 x0+4 y0-196]);                     %fixation pt.
            
            Screen('Flip',w); %Flip
            
            switch Bar_Direction
                case 1
                    xa=xa-dxa;
                    if(xa+Bar_distance*25+Bar_width*26 < rect(3))
                        xa=rect(3)+10;
                    end
                case 2
                    xa=xa+dxa;
                    if(xa-Bar_width*30-Bar_distance*30 > 0)
                        xa=rect(3)-10;
                    end
            end
            
            switch Dot_Direction
                case 1
                    x=x-dx; % compute new position
                    if(x < xmin)
                        x=rect(3);
                    end
                    
                case 2
                    x=x+dx; % compute new position
                    if(x > xmax)
                        x=0;
                    end
                    
            end
            
    end
    
    % check whether any keys are depressed
    [keyisdown, secs, keycode] = KbCheck;
end
Screen('CloseAll');


