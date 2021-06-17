function  [actualFlipTime, trial_datum, RT, startPos, deadline, secsPressed] = Ratings(type, window,p)
black= 0;
curWindow = window;
center = [p.mx p.my];
VASwidth=p.stim.VASwidth_inPixels;   %% Initialise VAS scale
eighVASht=p.stim.VASheight_inPixels;
VASoffset=p.stim.VASoffset_inPixels;
arrowwidth=p.stim.arrowWidth_inPixels;
arrowheight=arrowwidth*2;

% Collect rating
max_x = center(1) + VASwidth/2;
min_x = center(1) - VASwidth/2;
range_x = max_x - min_x;
rng('shuffle');
xpos = center(1) + ((rand.*VASwidth)-VASwidth/2);
startPos = ((xpos-center(1))./range_x)+5;
number_tics = 2;
deadline = 0;

start_time = GetSecs;
secs = start_time;
actualFlipTime = start_time; 

HideCursor(window); 

%KbQueue('start',{'3#','3'})
%KbQueue('flush');%flush out queue



while (secs-start_time)<=p.times.ratingsMaxDuration
    WaitSecs(0.001);
    [x,y,buttons] = GetMouse(window); %N is one button 
    %nEvents = KbQueue('nEvents'); %how many events?  
    SetMouse(p.mx, p.my, window); 
    
    secs = GetSecs;
    if deadline == 0
        if x <p.mx 
            xpos = xpos-VASwidth/65;
        elseif x >p.mx 
            xpos=xpos+ VASwidth/65;
        end

        if xpos>max_x
            xpos = max_x;
        elseif xpos<min_x
            xpos = min_x;
        end
    end 
    
    
    if sum(buttons) > 0  && (secs-start_time) > p.times.noRapidPress
        deadline = 1;
        secsPressed = GetSecs; 
        break
    end 
    
    Screen('DrawLine',curWindow,black,center(1)-VASwidth/2,center(2)+VASoffset,center(1)+VASwidth/2,center(2)+VASoffset); % Draw line
    Screen('DrawLine',curWindow,black,center(1)-VASwidth/2,center(2)+VASoffset+20,center(1)-VASwidth/2,center(2)+VASoffset);    % Draw left major tick
    Screen('DrawLine',curWindow,black,center(1)+VASwidth/2,center(2)+VASoffset+20,center(1)+VASwidth/2,center(2)+VASoffset);  %Draw right major tick
    
   
    question = 'how fatigued are you?';
    placement = 250;
    leftTick = 'not fatigued'; rightTick = 'very fatigued';
    
    
    tickMark = center (1) + linspace(-VASwidth/2,VASwidth/2,number_tics);
    tickLabels = {'0','10'};
    for tick = 1:length(tickLabels)
        Screen('DrawLine',curWindow,black,tickMark(tick),center(2)+VASoffset+10,tickMark(tick),center(2)+VASoffset);
        DrawFormattedText(curWindow,tickLabels{tick},[tickMark(tick)-10],[center(2)+VASoffset-30],black);
        if tick == 1
            Screen('TextSize',window,24);
            DrawFormattedText(curWindow,leftTick,[tickMark(tick)-100],[center(2)+VASoffset-100],black);
        else
            Screen('TextSize',window,24);
            DrawFormattedText(curWindow,rightTick,[tickMark(tick)-100],[center(2)+VASoffset-100],black);
        end
    end
    % Draw confidence text
    DrawFormattedText(curWindow,question,'center',[(1080/2)-150],black);
    
    %keep arrow white
    arrowPoints = [([-0.5 0 0.5]'.*arrowwidth)+xpos ([1 0 1]'.*arrowheight)+center(2)+VASoffset];
    Screen('FillPoly',curWindow,black,arrowPoints);
    Screen('Flip', curWindow);
end

%[pressCodeTime, releaseCodeTime] = KbQueue('stop');

if deadline == 0
    trial_datum = (((xpos-center(1))./range_x));
    secsPressed = GetSecs; 
    RT = secsPressed-actualFlipTime;
elseif deadline==1 %button pressed
    trial_datum =  ((((xpos-center(1))./range_x))+0.5)*10;
    RT = secsPressed - actualFlipTime;    
end
