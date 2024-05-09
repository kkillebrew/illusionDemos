%%
% Use PPD variables for different screens
% Resolution 2560x1440
% 57 cm viewing distance
% 42.61 PPD 27in (68.6cm) monitors

PPD = 42.6;
backColor = 128;   % color of background
squareColor = 64;    % color of square
barColor = 0;          % color of bar
ratioSize = 3;              % how much bigger the large square will be than the small square
ratioSpeed = 9;             % how fast the square will grow
squareSize = (PPD*4);       % side lengths of square
squareGrowth = (PPD/(ratioSize*ratioSpeed));      % rate at which the square will grow in PPD
iterations = ratioSize*ratioSpeed;     % how many iterations until the square is fully grown

escape = KbName('escape');

[w,rect]=Screen('OpenWindow', 0,[backColor backColor backColor]);
x0 = rect(3)/2;% screen center
y0 = rect(4)/2;

xSquareBuffer = x0/2;     % amount of gray space on the sides of the fully grown square
%ySquareBuffer = ((

xSquare = (x0/2) - squareSize/2;   % Upper left x coord of square
ySquare = (y0/2) - squareSize/2;   % Upper left y coord of square

rectTexture = Screen('MakeTexture',w,0);
[keyisdown, secs, keycode] = KbCheck;
while (~(keycode(escape)))
    for i=1:iterations
        
        destRectSquare = [xSquare, ySquare, xSquare + squareSize, ySquare + squareSize];        %   Tells you where the rectangle is/should be.
        Screen('DrawTexture',w,rectTexture,[],destRectSquare,[],[],[],[squareColor squareColor squareColor]);
        Screen('Flip',w); %Flip
        
        squareSize = squareSize + squareGrowth;
        %     ySquare = (ySquare + (y0/2)/iterations);
        %     xSquare = (xSquare + (x0/2)/iterations);
    end
    for i=1:iterations
        
        destRectSquare = [xSquare, ySquare, xSquare + squareSize, ySquare + squareSize];        %   Tells you where the rectangle is/should be.
        Screen('DrawTexture',w,rectTexture,[],destRectSquare,[],[],[],[squareColor squareColor squareColor]);
        Screen('Flip',w); %Flip
        
        squareSize = squareSize - squareGrowth;
        %     ySquare = (ySquare + (y0/2)/iterations);
        %     xSquare = (xSquare + (x0/2)/iterations);
    end
    [keyisdown, secs, keycode] = KbCheck;
end
Screen('CloseAll');





