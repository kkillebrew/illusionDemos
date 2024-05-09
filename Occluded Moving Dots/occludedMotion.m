barWidth = 70;
barDistance = 50;
barSpeed = 22;
dotSpeedRatio = 20;             % initial value for speed of the dots
dotSpeedSwitch = [1 2 3 4 5 6 7];             % chooses the case for speed of the dots in with dotSpeedRatio as the base value (1-.25 of dotSpeedRatio 4-dotSpeedRatio 7-1.75*dotSpeedRatio)
barDirectionRatio = cos(2*pi);  % the initial value of the bar direction
barDirectionSwitch = [1 2 3];         % chooses the case for the bar direction (1-left to right 2-right to left 3-stationary)
occlusionSwitch = [1 2];            % chooses the case for the occlusion (1-bars occluded 2-dots occluded)
dotSize = 50;
repetitions = 20;
barColor = 0;
backColor = 128;
dotColor = 255;
screenTime = .3 + (rand(1) * .4);    %generates random times between 300 and 700 ms to determine how long to display the dots to control for distance judgments
escape = KbName('escape');

[w,rect]=Screen('OpenWindow', 0,[backColor backColor backColor]);
x0 = rect(3)/2;% screen center
y0 = rect(4)/2;
rect_texture = Screen('MakeTexture',w,0);

xBar = x0;
xDot = rect(3)*.2;

num_trials=length(barDirectionSwitch)*length(occlusionSwitch)*length(dotSpeedSwitch)*repetitions;
dotSpeedSwitchList = [ones(num_trials/length(dotSpeedSwitch),1);2*ones(num_trials/length(dotSpeedSwitch),1);3*ones(num_trials/length(dotSpeedSwitch),1);4*ones(num_trials/length(dotSpeedSwitch),1);5*ones(num_trials/length(dotSpeedSwitch),1);6*ones(num_trials/length(dotSpeedSwitch),1);7*ones(num_trials/length(dotSpeedSwitch),1)];
barDirectionSwitchList = [];
for i=1:length(barDirectionSwitch)
    for j=1:length(dotSpeedSwitch)
        barDirectionSwitchList = [barDirectionSwitchList;j*ones(num_trials/(length(dotSpeedSwitch)*length(barDirectionSwitch)),1)];
    end
end
occlusionSwitchList = [];
for i=1:length(dotSpeedSwitch)
    for j=1:length(barDirectionSwitch)
        for k =1:length(occlusionSwitch)
            occlusionSwitchList = [occlusionSwitchList;k*ones(num_trials/(length(dotSpeedSwitch)*length(barDirectionSwitch)*length(occlusionSwitch)),1)];
        end
    end
end
trial_order = randperm(num_trials);

for i = 1:num_trials
    
    dotSpeedSwitchTrial = dotSpeedSwitch(dotSpeedSwitchList(trial_order(i)));
    rawdata(i,1) = dotSpeedSwitchTrial;
    barDirectionSwitchTrial = barDirectionSwitch(barDirectionSwitchList(trial_order(i)));
    rawdata(i,2) = barDirectionSwitchTrial;
    occlusionSwitchTrial = occlusionSwitch(occlusionSwitchList(trial_order(i)));
    rawdata(i,3) = occlusionSwitchTrial;
    
    switch dotSpeedSwitchTrial               % assigns a value to dotSpeed depending on the switch value (in incriments of the dotSpeedRatio)
        case 1
            dotSpeed = dotSpeedRatio*.25;
        case 2
            dotSpeed = dotSpeedRatio*.5;
        case 3
            dotSpeed = dotSpeedRatio*.75;
        case 4
            dotSpeed = dotSpeedRatio;
        case 5
            dotSpeed = dotSpeedRatio*1.25;
        case 6
            dotSpeed = dotSpeedRatio*1.5;
        case 7
            dotSpeed = dotSpeedRatio*1.75;
    end
    
    switch barDirectionSwitchTrial       % assigns a value to barDirection depending on the switch value
        case 1
            barDirection = barDirectionRatio;
        case 2
            barDirection = barDirectionRatio*(-1);
        case 3
            barDirection = barDirectionRatio*0;
    end
    
    t=tic;  % Tic starts a timer and sets it to t which then can be used with toc to compare to a randomly generated time value (screenTime)
    while(toc(t)<screenTime)
        switch occlusionSwitchTrial
            case 1     % Bars are occluded
                Screen('FillOval',w,[255 0 0],[x0-4 y0-204 x0+4 y0-196]);                     %fixation pt.
                
                destRect0 = [xBar-barWidth/2, 0, xBar+barWidth/2, rect(4)];              % assign destination rectangle for central rect
                
                destRect1 = [(xBar-barWidth/2)-((barWidth+barDistance)*1), 0, (xBar+barWidth/2)-((barWidth+barDistance)*1), rect(4)];    % bars the the left
                destRect2 = [(xBar-barWidth/2)-((barWidth+barDistance)*2), 0, (xBar+barWidth/2)-((barWidth+barDistance)*2), rect(4)];
                destRect3 = [(xBar-barWidth/2)-((barWidth+barDistance)*3), 0, (xBar+barWidth/2)-((barWidth+barDistance)*3), rect(4)];
                destRect4 = [(xBar-barWidth/2)-((barWidth+barDistance)*4), 0, (xBar+barWidth/2)-((barWidth+barDistance)*4), rect(4)];
                destRect5 = [(xBar-barWidth/2)-((barWidth+barDistance)*5), 0, (xBar+barWidth/2)-((barWidth+barDistance)*5), rect(4)];
                destRect6 = [(xBar-barWidth/2)-((barWidth+barDistance)*6), 0, (xBar+barWidth/2)-((barWidth+barDistance)*6), rect(4)];
                destRect7 = [(xBar-barWidth/2)-((barWidth+barDistance)*7), 0, (xBar+barWidth/2)-((barWidth+barDistance)*7), rect(4)];
                destRect8 = [(xBar-barWidth/2)-((barWidth+barDistance)*8), 0, (xBar+barWidth/2)-((barWidth+barDistance)*8), rect(4)];
                destRect9 = [(xBar-barWidth/2)-((barWidth+barDistance)*9), 0, (xBar+barWidth/2)-((barWidth+barDistance)*9), rect(4)];
                destRect10 = [(xBar-barWidth/2)-((barWidth+barDistance)*10), 0, (xBar+barWidth/2)-((barWidth+barDistance)*10), rect(4)];
                destRect11 = [(xBar-barWidth/2)-((barWidth+barDistance)*11), 0, (xBar+barWidth/2)-((barWidth+barDistance)*11), rect(4)];
                destRect12 = [(xBar-barWidth/2)-((barWidth+barDistance)*12), 0, (xBar+barWidth/2)-((barWidth+barDistance)*12), rect(4)];
                destRect13 = [(xBar-barWidth/2)-((barWidth+barDistance)*13), 0, (xBar+barWidth/2)-((barWidth+barDistance)*13), rect(4)];
                destRect14 = [(xBar-barWidth/2)-((barWidth+barDistance)*14), 0, (xBar+barWidth/2)-((barWidth+barDistance)*14), rect(4)];
                destRect15 = [(xBar-barWidth/2)-((barWidth+barDistance)*15), 0, (xBar+barWidth/2)-((barWidth+barDistance)*15), rect(4)];
                destRect16 = [(xBar-barWidth/2)-((barWidth+barDistance)*16), 0, (xBar+barWidth/2)-((barWidth+barDistance)*16), rect(4)];
                destRect17 = [(xBar-barWidth/2)-((barWidth+barDistance)*17), 0, (xBar+barWidth/2)-((barWidth+barDistance)*17), rect(4)];
                destRect18 = [(xBar-barWidth/2)-((barWidth+barDistance)*18), 0, (xBar+barWidth/2)-((barWidth+barDistance)*18), rect(4)];
                destRect19 = [(xBar-barWidth/2)-((barWidth+barDistance)*19), 0, (xBar+barWidth/2)-((barWidth+barDistance)*19), rect(4)];
                destRect20 = [(xBar-barWidth/2)-((barWidth+barDistance)*20), 0, (xBar+barWidth/2)-((barWidth+barDistance)*20), rect(4)];
                
                destRect21 = [(xBar-barWidth/2)+((barWidth+barDistance)*1), 0, (xBar+barWidth/2)+((barWidth+barDistance)*1), rect(4)];    % bars the the right
                destRect22 = [(xBar-barWidth/2)+((barWidth+barDistance)*2), 0, (xBar+barWidth/2)+((barWidth+barDistance)*2), rect(4)];
                destRect23 = [(xBar-barWidth/2)+((barWidth+barDistance)*3), 0, (xBar+barWidth/2)+((barWidth+barDistance)*3), rect(4)];
                destRect24 = [(xBar-barWidth/2)+((barWidth+barDistance)*4), 0, (xBar+barWidth/2)+((barWidth+barDistance)*4), rect(4)];
                destRect25 = [(xBar-barWidth/2)+((barWidth+barDistance)*5), 0, (xBar+barWidth/2)+((barWidth+barDistance)*5), rect(4)];
                destRect26 = [(xBar-barWidth/2)+((barWidth+barDistance)*6), 0, (xBar+barWidth/2)+((barWidth+barDistance)*6), rect(4)];
                destRect27 = [(xBar-barWidth/2)+((barWidth+barDistance)*7), 0, (xBar+barWidth/2)+((barWidth+barDistance)*7), rect(4)];
                destRect28 = [(xBar-barWidth/2)+((barWidth+barDistance)*8), 0, (xBar+barWidth/2)+((barWidth+barDistance)*8), rect(4)];
                destRect29 = [(xBar-barWidth/2)+((barWidth+barDistance)*9), 0, (xBar+barWidth/2)+((barWidth+barDistance)*9), rect(4)];
                destRect30 = [(xBar-barWidth/2)+((barWidth+barDistance)*10), 0, (xBar+barWidth/2)+((barWidth+barDistance)*10), rect(4)];
                destRect31 = [(xBar-barWidth/2)+((barWidth+barDistance)*11), 0, (xBar+barWidth/2)+((barWidth+barDistance)*11), rect(4)];
                destRect32 = [(xBar-barWidth/2)+((barWidth+barDistance)*12), 0, (xBar+barWidth/2)+((barWidth+barDistance)*12), rect(4)];
                destRect33 = [(xBar-barWidth/2)+((barWidth+barDistance)*13), 0, (xBar+barWidth/2)+((barWidth+barDistance)*13), rect(4)];
                destRect34 = [(xBar-barWidth/2)+((barWidth+barDistance)*14), 0, (xBar+barWidth/2)+((barWidth+barDistance)*14), rect(4)];
                destRect35 = [(xBar-barWidth/2)+((barWidth+barDistance)*15), 0, (xBar+barWidth/2)+((barWidth+barDistance)*15), rect(4)];
                destRect36 = [(xBar-barWidth/2)+((barWidth+barDistance)*16), 0, (xBar+barWidth/2)+((barWidth+barDistance)*16), rect(4)];
                destRect37 = [(xBar-barWidth/2)+((barWidth+barDistance)*17), 0, (xBar+barWidth/2)+((barWidth+barDistance)*17), rect(4)];
                destRect38 = [(xBar-barWidth/2)+((barWidth+barDistance)*18), 0, (xBar+barWidth/2)+((barWidth+barDistance)*18), rect(4)];
                destRect39 = [(xBar-barWidth/2)+((barWidth+barDistance)*19), 0, (xBar+barWidth/2)+((barWidth+barDistance)*19), rect(4)];
                destRect40 = [(xBar-barWidth/2)+((barWidth+barDistance)*20), 0, (xBar+barWidth/2)+((barWidth+barDistance)*20), rect(4)];
                
                Screen('DrawTexture',w,rect_texture,[],destRect0,[],[],[],[barColor barColor barColor]);         % draw the rectangle
                
                Screen('DrawTexture',w,rect_texture,[],destRect1,[],[],[],[barColor barColor barColor]);         % draw the rectangle's to the left of center bar
                Screen('DrawTexture',w,rect_texture,[],destRect2,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect3,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect4,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect5,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect6,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect7,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect8,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect9,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect10,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect11,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect12,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect13,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect14,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect15,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect16,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect17,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect18,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect19,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect20,[],[],[],[barColor barColor barColor]);
                
                Screen('DrawTexture',w,rect_texture,[],destRect21,[],[],[],[barColor barColor barColor]);         % draw the rectangle's to the right of center bar
                Screen('DrawTexture',w,rect_texture,[],destRect22,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect23,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect24,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect25,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect26,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect27,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect28,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect29,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect30,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect31,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect32,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect33,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect34,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect35,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect36,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect37,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect38,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect39,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect40,[],[],[],[barColor barColor barColor]);
                
                Screen('FillOval',w,[dotColor dotColor dotColor],[xDot-dotSize, rect(4)*.5-dotSize, xDot+dotSize, rect(4)*.5+dotSize]);    % Draws the circle
            case 2     % Dots are occluded
                Screen('FillOval',w,[255 0 0],[x0-4 y0-204 x0+4 y0-196]);                     %fixation pt.
                
                destRect = [xBar-barWidth/2, 0, xBar+barWidth/2, rect(4)];                                         % assign destination rectangle for central rect
                
                destRect1 = [(xBar-barWidth/2)-((barWidth+barDistance)*1), 0, (xBar+barWidth/2)-((barWidth+barDistance)*1), rect(4)];    % bars the the left
                destRect2 = [(xBar-barWidth/2)-((barWidth+barDistance)*2), 0, (xBar+barWidth/2)-((barWidth+barDistance)*2), rect(4)];
                destRect3 = [(xBar-barWidth/2)-((barWidth+barDistance)*3), 0, (xBar+barWidth/2)-((barWidth+barDistance)*3), rect(4)];
                destRect4 = [(xBar-barWidth/2)-((barWidth+barDistance)*4), 0, (xBar+barWidth/2)-((barWidth+barDistance)*4), rect(4)];
                destRect5 = [(xBar-barWidth/2)-((barWidth+barDistance)*5), 0, (xBar+barWidth/2)-((barWidth+barDistance)*5), rect(4)];
                destRect6 = [(xBar-barWidth/2)-((barWidth+barDistance)*6), 0, (xBar+barWidth/2)-((barWidth+barDistance)*6), rect(4)];
                destRect7 = [(xBar-barWidth/2)-((barWidth+barDistance)*7), 0, (xBar+barWidth/2)-((barWidth+barDistance)*7), rect(4)];
                destRect8 = [(xBar-barWidth/2)-((barWidth+barDistance)*8), 0, (xBar+barWidth/2)-((barWidth+barDistance)*8), rect(4)];
                destRect9 = [(xBar-barWidth/2)-((barWidth+barDistance)*9), 0, (xBar+barWidth/2)-((barWidth+barDistance)*9), rect(4)];
                destRect10 = [(xBar-barWidth/2)-((barWidth+barDistance)*10), 0, (xBar+barWidth/2)-((barWidth+barDistance)*10), rect(4)];
                destRect11 = [(xBar-barWidth/2)-((barWidth+barDistance)*11), 0, (xBar+barWidth/2)-((barWidth+barDistance)*11), rect(4)];
                destRect12 = [(xBar-barWidth/2)-((barWidth+barDistance)*12), 0, (xBar+barWidth/2)-((barWidth+barDistance)*12), rect(4)];
                destRect13 = [(xBar-barWidth/2)-((barWidth+barDistance)*13), 0, (xBar+barWidth/2)-((barWidth+barDistance)*13), rect(4)];
                destRect14 = [(xBar-barWidth/2)-((barWidth+barDistance)*14), 0, (xBar+barWidth/2)-((barWidth+barDistance)*14), rect(4)];
                destRect15 = [(xBar-barWidth/2)-((barWidth+barDistance)*15), 0, (xBar+barWidth/2)-((barWidth+barDistance)*15), rect(4)];
                destRect16 = [(xBar-barWidth/2)-((barWidth+barDistance)*16), 0, (xBar+barWidth/2)-((barWidth+barDistance)*16), rect(4)];
                destRect17 = [(xBar-barWidth/2)-((barWidth+barDistance)*17), 0, (xBar+barWidth/2)-((barWidth+barDistance)*17), rect(4)];
                destRect18 = [(xBar-barWidth/2)-((barWidth+barDistance)*18), 0, (xBar+barWidth/2)-((barWidth+barDistance)*18), rect(4)];
                destRect19 = [(xBar-barWidth/2)-((barWidth+barDistance)*19), 0, (xBar+barWidth/2)-((barWidth+barDistance)*19), rect(4)];
                destRect20 = [(xBar-barWidth/2)-((barWidth+barDistance)*20), 0, (xBar+barWidth/2)-((barWidth+barDistance)*20), rect(4)];
                
                destRect21 = [(xBar-barWidth/2)+((barWidth+barDistance)*1), 0, (xBar+barWidth/2)+((barWidth+barDistance)*1), rect(4)];    % bars the the right
                destRect22 = [(xBar-barWidth/2)+((barWidth+barDistance)*2), 0, (xBar+barWidth/2)+((barWidth+barDistance)*2), rect(4)];
                destRect23 = [(xBar-barWidth/2)+((barWidth+barDistance)*3), 0, (xBar+barWidth/2)+((barWidth+barDistance)*3), rect(4)];
                destRect24 = [(xBar-barWidth/2)+((barWidth+barDistance)*4), 0, (xBar+barWidth/2)+((barWidth+barDistance)*4), rect(4)];
                destRect25 = [(xBar-barWidth/2)+((barWidth+barDistance)*5), 0, (xBar+barWidth/2)+((barWidth+barDistance)*5), rect(4)];
                destRect26 = [(xBar-barWidth/2)+((barWidth+barDistance)*6), 0, (xBar+barWidth/2)+((barWidth+barDistance)*6), rect(4)];
                destRect27 = [(xBar-barWidth/2)+((barWidth+barDistance)*7), 0, (xBar+barWidth/2)+((barWidth+barDistance)*7), rect(4)];
                destRect28 = [(xBar-barWidth/2)+((barWidth+barDistance)*8), 0, (xBar+barWidth/2)+((barWidth+barDistance)*8), rect(4)];
                destRect29 = [(xBar-barWidth/2)+((barWidth+barDistance)*9), 0, (xBar+barWidth/2)+((barWidth+barDistance)*9), rect(4)];
                destRect30 = [(xBar-barWidth/2)+((barWidth+barDistance)*10), 0, (xBar+barWidth/2)+((barWidth+barDistance)*10), rect(4)];
                destRect31 = [(xBar-barWidth/2)+((barWidth+barDistance)*11), 0, (xBar+barWidth/2)+((barWidth+barDistance)*11), rect(4)];
                destRect32 = [(xBar-barWidth/2)+((barWidth+barDistance)*12), 0, (xBar+barWidth/2)+((barWidth+barDistance)*12), rect(4)];
                destRect33 = [(xBar-barWidth/2)+((barWidth+barDistance)*13), 0, (xBar+barWidth/2)+((barWidth+barDistance)*13), rect(4)];
                destRect34 = [(xBar-barWidth/2)+((barWidth+barDistance)*14), 0, (xBar+barWidth/2)+((barWidth+barDistance)*14), rect(4)];
                destRect35 = [(xBar-barWidth/2)+((barWidth+barDistance)*15), 0, (xBar+barWidth/2)+((barWidth+barDistance)*15), rect(4)];
                destRect36 = [(xBar-barWidth/2)+((barWidth+barDistance)*16), 0, (xBar+barWidth/2)+((barWidth+barDistance)*16), rect(4)];
                destRect37 = [(xBar-barWidth/2)+((barWidth+barDistance)*17), 0, (xBar+barWidth/2)+((barWidth+barDistance)*17), rect(4)];
                destRect38 = [(xBar-barWidth/2)+((barWidth+barDistance)*18), 0, (xBar+barWidth/2)+((barWidth+barDistance)*18), rect(4)];
                destRect39 = [(xBar-barWidth/2)+((barWidth+barDistance)*19), 0, (xBar+barWidth/2)+((barWidth+barDistance)*19), rect(4)];
                destRect40 = [(xBar-barWidth/2)+((barWidth+barDistance)*20), 0, (xBar+barWidth/2)+((barWidth+barDistance)*20), rect(4)];
                
                Screen('FillOval',w,[dotColor dotColor dotColor],[xDot-dotSize, rect(4)*.5-dotSize, xDot+dotSize, rect(4)*.5+dotSize]);    % Draws the circle
                
                Screen('DrawTexture',w,rect_texture,[],destRect,[],[],[],[barColor barColor barColor]);         % draw the rectangle
                
                Screen('DrawTexture',w,rect_texture,[],destRect1,[],[],[],[barColor barColor barColor]);         % draw the rectangle's to the left of center bar
                Screen('DrawTexture',w,rect_texture,[],destRect2,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect3,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect4,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect5,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect6,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect7,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect8,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect9,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect10,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect11,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect12,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect13,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect14,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect15,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect16,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect17,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect18,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect19,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect20,[],[],[],[barColor barColor barColor]);
                
                Screen('DrawTexture',w,rect_texture,[],destRect21,[],[],[],[barColor barColor barColor]);         % draw the rectangle's to the right of center bar
                Screen('DrawTexture',w,rect_texture,[],destRect22,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect23,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect24,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect25,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect26,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect27,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect28,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect29,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect30,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect31,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect32,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect33,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect34,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect35,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect36,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect37,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect38,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect39,[],[],[],[barColor barColor barColor]);
                Screen('DrawTexture',w,rect_texture,[],destRect40,[],[],[],[barColor barColor barColor]);
        end
        Screen('Flip',w); % draw objects
        
        xDot = xDot+dotSpeed;
        xBar = xBar+barSpeed*barDirection;
    end
    
    Screen('Flip',w);
    WaitSecs(1);
    
    xDot = rect(3)*.2;
    f=tic;
    while (toc(f)<screenTime)
        Screen('FillOval',w,[255 0 0],[x0-4 y0-204 x0+4 y0-196]);                     %fixation pt.
        Screen('FillOval',w,[dotColor dotColor dotColor],[xDot-dotSize, rect(4)*.5-dotSize, xDot+dotSize, rect(4)*.5+dotSize]);    % Draws the circle
        Screen('Flip',w); % draw objects
        xDot = xDot+dotSpeedRatio;
    end
end

Screen('CloseAll');






