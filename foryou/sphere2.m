clear
Screen('Preference', 'SkipSyncTests', 1);
[w,rect]=Screen('OpenWindow',0,[0 0 0]);
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
ListenChar(2);

xc=rect(3)/2;
yc=rect(4)/2;

escape=KbName('escape');

diabase=1000;
basecenx=xc;
baseceny=yc;

cenx=xc;

numcircs=1000;
num2=500;
step=2/numcircs;
steps=0:step:2;

density=.1;

moveamount=.01;

positions=zeros(length(steps),3);
positions3=zeros(length(steps),3);

counter=0;
for i=steps
    counter=counter+1;
    positions(counter,:)=[i,basecenx+(diabase/2)*cos((1+i)*pi),baseceny+(diabase/2)*sin((1+i)*pi)];
end

counter=1;

for i=numcircs/4+1:numcircs*3/4+1
    
    possibley(counter)=positions(i,3);
    possibledia(counter)=abs(basecenx-positions(i,2))*2;
    

        possibleydot(counter)=1-abs(1-positions(i,1))*2;
 
    
    counter=counter+1;
end

for i=1:num2;
    rando=randi(length(possibley));
    ceny(i)=possibley(rando);
    dia(i)=possibledia(rando);
    ydot(i)=possibleydot(rando);
    move(i)=randi(200)/100;
    
    dotr(i)=randi(15)+5;
    dotr(i)=15;
end

[~,~,keycode]=KbCheck;

mover=1;

while ~keycode(escape)
    
    [~,~,keycode]=KbCheck;
    
    if KbCheck
        if mover
            mover=0;
        else
            mover=1;
        end
        KbReleaseWait;
    end
    
    
    
    for i=1:length(dia)
        
        if mover
            
            move(i)=move(i)+moveamount;
            if move(i)>2;
                move(i)=moveamount;
            end
        end
        if move(i)<=1
            xdot=1-abs(1-(move(i)+.5))*2;
        else
            xdot=1-abs(1-(move(i)-.5))*2;
        end
        
        %         xdot=(dia(i)/2-abs((dia(i)/2)*cos((move(i))*pi)))/(dia(i)/2);

        Screen('FillOval',w,[0 0 255],[cenx+(dia(i)/2)*cos((move(i))*pi)-dotr(i)*xdot,ceny(i)-dotr(i)*ydot(i),cenx+(dia(i)/2)*cos((move(i))*pi)+dotr(i)*xdot,ceny(i)+dotr(i)*ydot(i)]);
    end
    
    Screen('Flip',w);
end

bob=dia';
bob(:,2)=ceny';

KbWait;
ListenChar(0);
Screen('CloseAll');