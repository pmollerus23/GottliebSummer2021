if j == 1 && isForce == true
    DrawFormattedText(window, 'Force Choice Trials', 'center',...
        yCenter, [0 0 0]);
    Screen('Flip', window);
    trialText = 'Reward Amount Is Fixed';

    WaitSecs(2);
    
elseif j == 1 && isForce == false
    DrawFormattedText(window, 'Free Choice Trials', 'center',...
        yCenter, [0 0 0]);
    Screen('Flip', window);
    trialText = 'Choose Reward Amount';
    WaitSecs(2);
end


    
    DrawFormattedText(window, 'Next trial starting','center' , yCenter, black);
    Screen('Flip', window);
    WaitSecs(2);
    
    %     Screen('DrawTexture', window, dispImageCross, [], crossPos);
    %     Screen('Flip', window);
    
    
    
    % while isEyeInside
    %Conditional for trial speed (including fixation cross signal
    %color: 1 is slow (2s, blue cross) 2 is fast (800ms, red cross)
    if speed == 1
        %cross for slow trial
        %dispImageCross = dispImageBlueCross;
        randSpeedVecData(j) = 1;
        timeToWaitResponse = 2;
        
    elseif speed == 2
        %dispImageCross = dispImageRedCross;
        randSpeedVecData(j) = 2;
        timeToWaitResponse = 0.8;
    end
    
    Screen('DrawTexture', window, dispImageCross, [], crossPos);
    Screen('TextSize', window, 30);
    DrawFormattedText(window, trialText, 'center',...
        screenYpixels * 0.25, [0 0 0]);
    
    %calculate random incentive amounts for trial 1 = 2 is the only
    %unique case because there cannot be 2 1 incentives presented the
    %rest follow the order
    % 2 = 2, 3 =3... etc
    if trialData(j, 5)==1
        incentiveForTrial = disOneIncentive;
    elseif trialData(j, 5)==2
        incentiveForTrial= disTwoIncentive;
    elseif trialData(j, 5)==3
        incentiveForTrial= disThreeIncentive;
    elseif trialData(j, 5)==4
        incentiveForTrial= disFourIncentive;
    elseif trialData(j, 5)==5
        incentiveForTrial= disFiveIncentive;
    elseif trialData(j, 5)==6
        incentiveForTrial= disSixIncentive;
    end
    
    incentiveAmt(j) = incentiveVec(j);
    
    
    %make random position of incentives for presentation, if trual data
    %= 1, the larger incentive will be presented on the right and if it
    %is 2 the larger incentive will be presented on the users left
    if  trialData(j, 4)==1 && isForce == false
        Screen('DrawTexture', window, disOneEasyIncentive, [], leftRectPos);
        Screen('DrawTexture', window, incentiveForTrial, [], rightRectPos);
    elseif  trialData(j, 4)==2 && isForce == false
        Screen('DrawTexture', window, incentiveForTrial, [], leftRectPos);
        Screen('DrawTexture', window, disOneEasyIncentive, [], rightRectPos);
        
    elseif  trialData(j, 4)==1 && isForce == true
        Screen('DrawTexture', window, incentiveForTrial, [], rightRectPos);
        
    elseif  trialData(j, 4)==2 && isForce == true
        Screen('DrawTexture', window, incentiveForTrial, [], leftRectPos);

    end