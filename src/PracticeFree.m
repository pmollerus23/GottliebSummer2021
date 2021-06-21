
%++++++++++++PRACTICE TRIALS CODE+++++++++++++++++++
%the code here is very similar to the code in the main free and force
%choice blocks. Look at "FreeTime" and "ForceTime2" for more in depth
%commenting on how the code works.

%Displaying instruction slides sequence
Screen('DrawTexture', window, FRTA, [], windowRect);
Screen('Flip', window);
KbStrokeWait;
Screen('DrawTexture', window, FRTB, [], windowRect);
Screen('Flip', window);
KbStrokeWait;
Screen('DrawTexture', window, FRTC, [], windowRect);
Screen('Flip', window);
KbStrokeWait;
Screen('DrawTexture', window, FRTD, [], windowRect);
Screen('Flip', window);
KbStrokeWait;


DrawFormattedText(window, sprintf('Press up arrow to Start your %d practice trials',num_practice), 'center',...
    screenYpixels * 0.5, [0 0 0]);
Screen('Flip', window);
KbStrokeWait;
response = 0;
responseText = 'incorrect';
numTrials = 12;
abortedTrials = zeros(numTrials,1);
abortedTrials2 = zeros(numTrials,1);

correctOrIncorrect = zeros(numTrials,1);
respTimeInc = zeros(numTrials,1);
rewardChoice = zeros(numTrials,1);
fatigueRating = nan(numTrials,1);
keyPress = zeros(numTrials,1);
for j=1: 10%numTrials
    
    if j == 1
        DrawFormattedText(window, 'Free Choice Trials', 'center',...
            screenYpixels * 0.25, [0 0 0]);
        Screen('Flip', window);
        WaitSecs(2);
    end
    % while isEyeInside
    
     if randSpeedVec(blockIndex + j) == 1
            %cross for slow trial
            crossForTrial = dispImageBlueCross;
            timeToWaitResponse = 2;
            
        elseif randSpeedVec(blockIndex + j) == 2
            crossForTrial = dispImageRedCross;
            timeToWaitResponse = 0.8;
        end
    
    Screen('DrawTexture', window, crossForTrial, [], crossPos);
    Screen('TextSize', window, 30);
    DrawFormattedText(window, 'Choose the reward amount using the left and right arrow keys', 'center',...
        screenYpixels * 0.25, [0 0 0]);
    
    %if block decides which incentive will be presented to the user
    % 2 = 2 preseted, 3 = 3 presented... etc
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
    
    incentiveAmt(j) = trialData(j, 5);
    
    %decide which side of screen to draw highest incentive in, 1 = higher
    %incentive in users right, 2 = higher incentive on users left
    if  trialData(j, 4)==1
        Screen('DrawTexture', window, disOneEasyIncentive, [], leftRectPos);
        Screen('DrawTexture', window, incentiveForTrial, [], rightRectPos);
    elseif  trialData(j, 4)==2
        Screen('DrawTexture', window, incentiveForTrial, [], leftRectPos);
        Screen('DrawTexture', window, disOneEasyIncentive, [], rightRectPos);
    end
    
    
    
    %Starting response time interval
    [~,actualFlipTime,~,~]= Screen('Flip', window);
    
    %Clearing and initializing keyboard config for trial(i)
    
    [secs, ~,~] = KbWait;
    
    %Storing response interval time
    respTimeInc(j,1) = secs - actualFlipTime;
    
    [pressed, firstPress] = KbQueueCheck(deviceIndices);
    
    
    WaitSecs(0.25);
    
    %Conditional for easy task choice
    if (firstPress(leftKey) > 0 &&  trialData(j, 4)==1) || (firstPress(rightKey) > 0 &&  trialData(j, 4)==2)
        
        %record data on which reward was chosen
        rewardChoice(j,1) = 1;
        
        %======================================
        %EASY TASK CODE HERE
        %======================================
        
        %if block decides the orientation of the t presented, 1 = up, 0 =
        %upside down t
        if trialData(j, 3) == 1
            orientationT = dispImageT;
            
        elseif trialData(j, 3) == 0
            orientationT = dispImageUSDT;
            
        end
        
        %record data on how the t is oriented
        orientationOfT = trialData(j, 3);
        up = 1;
        down = 0;
        
        %code to decide location of the T in array uses predetermined
        %location to decide where t is drawn
        if trialData(j, 2) == 1
            Screen('DrawTexture', window, orientationT, [], rightMostRect);
        elseif trialData(j, 2) == 2
            Screen('DrawTexture', window, orientationT, [], diagonalUpRight);
            
        elseif trialData(j, 2) == 3
            Screen('DrawTexture', window, orientationT, [], vertMostRect);
            
        elseif trialData(j, 2) == 4
            Screen('DrawTexture', window, orientationT, [], diagonalUpLeft);
            
        elseif trialData(j, 2) == 5
            Screen('DrawTexture', window, orientationT, [], leftMostRect);
            
        elseif trialData(j, 2) == 6
            Screen('DrawTexture', window, orientationT, [], diagonalDownLeft);
            
        elseif trialData(j, 2) == 7
            Screen('DrawTexture', window, orientationT, [], downMostRect);
            
        elseif trialData(j, 2) == 8
            Screen('DrawTexture', window, orientationT, [], diagonalDownRight);
            
        end
        %record location of drawn t
        occupiedByT = trialData(j, 2);
        
        %store data on t location in circle
        positionOfT(j,1) = occupiedByT;
        
        
        Screen('DrawTexture', window, crossForTrial, [], centerRect);
        %present task screen for 2 seconds
        [~,start1, ~] =  Screen('Flip', window);
        WaitSecs(0.2);
        
        %timeToWait = 2;
        startTime = GetSecs;
        timeInLoop = 0;
        flag = 0;
        
        %++++++++++++IMPORTANT++++++++++++++
        %THIS KbWait DECIDES IF THE TRIALS IS ABORTED OR NOT, THE KbWait
        %SPECIFIES A TIME TO BE WAITED, IF THAT TIME IS EXCEEDED IT SKIPS
        %THE FOLLOWING IF BLOCK AND EXECUTES CODE TO ABORT THE TRIAL
        KbWait([], [], start1 + timeToWaitResponse);
        timeWaited = GetSecs;
        respTime(j,1) = timeWaited-start1;
        
        clear Press;
        [pressed, Press] = KbQueueCheck(deviceIndices);
        
        if Press(upKey) > 0 || Press(downKey)>0
            %code to tell user how many points they gained
            rewardAmtText = num2str(trialData(j, 5));
            plus = '+';
            responseText = [plus ' ' rewardAmtText];
            flag = 1;
            % code to find if user input was correct
            
            %user presses up arrow and t is up so correct
            if Press(upKey) > 0 && trialData(j, 3) == up
                text = 'correct';
                responseText = '+ 1';
                response = 1;
                keyPress(j,1) = 1;
                
                
                %user presses down arrow and t is down so correct
            elseif Press(downKey) > 0 && trialData(j, 3) == down
                text = 'correct';
                responseText = '+ 1';
                response = 1;
                keyPress(j,1) = 0;
                
                
                %user presses up arrow and t is down so incorrect
            elseif Press(upKey) > 0 && trialData(j, 3) == down
                text = 'incorrect';
                responseText = '+ 0';
                response = 0;
                keyPress(j,1) = 1;
                
                %user presses down arrow and t is up so incorrect
            elseif Press(downKey) > 0 && trialData(j, 3) == up
                text = 'incorrect';
                responseText = '+ 0';
                response = 0;
                keyPress(j,1) = 0;
            end
            
            Screen('DrawTexture', window, crossForTrial, [], centerRect);
            Screen('Flip', window);
            WaitSecs(3-respTime(j,1));
            
            %record response data
            correctOrIncorrect(j,1) = response;
            %print feedback from decesion in trial to screen
            DrawFormattedText(window, text,'center' , yCenter, black);
            DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
            Screen('Flip', window);
            WaitSecs(2)
            % DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
        end
        
        
        
        
        %present user with question
        %         textStrTrial = 'was the T up or down?';
        %         DrawFormattedText(window, textStrTrial,'center', yCenter, black);
        
        if flag == 0
            isEyeInside = false;
            text = 'TOO LATE';
            DrawFormattedText(window, text,'center' , yCenter, black);
            Screen('Flip', window);
            WaitSecs(2);
            
        end
        
        
        %record response data
        correctOrIncorrect(j,1) = response;
        %print feedback from decesion in trial to screen
        Screen('DrawTexture', window, dispImageCross, [], centerRect);
        
        Screen('Flip', window);
        
        WaitSecs(2);
        
        
        
        %code for confidence assessment
        decideConfRating = mod(j,10);
        if decideConfRating == 0
            
            DrawFormattedText(window, responseText, 'How would you rate your mental fatigue?',screenYpixels * 0.25, black);
            [~, trial_datum, ~, ~, ~ ,~] = Ratings('confidence', window,p);
            fatigueRating(j) = trial_datum;
            
            Screen('DrawTexture', window, dispImageCross, [], centerRect);
            Screen('Flip', window);
            WaitSecs(1);
            
        end
        
        
        
        %Conditional for difficult task choice
    elseif (firstPress(leftKey) > 0 &&  trialData(j, 4)==2) || (firstPress(rightKey) > 0 &&  trialData(j, 4)==1)
        
        %record data on which option was chosen
        rewardChoice(j,1) = 2;
        
        %======================================
        %DIFFICULT TASK CODE HERE
        %======================================
        
        Screen('DrawTexture', window, crossForTrial, [], centerRect);
        
        
        
        %determine orientation of t presented 1 means the t is upright 0
        %means the t is upsidedown
        if trialData(j, 3) == 1
            orientationT = dispImageT;
        elseif trialData(j, 3) == 0
            orientationT = dispImageUSDT;
            
        end
        
        %record data on how the t is oriented
        orientationOfT = trialData(j, 3);
        up = 1;
        down = 0;
        
        %drawing T to screen given value in random T location matrix
        % a value of one indicates the right most value position of the
        % circle, a value of two indicates a up rihgt diagonal orientation
        % and then continues to increase counter clock wise
        if trialData(j, 2) == 1
            Screen('DrawTexture', window, orientationT, [], rightMostRect);
            
        elseif trialData(j, 2) == 2
            Screen('DrawTexture', window, orientationT, [], diagonalUpRight);
            
        elseif trialData(j, 2) == 3
            Screen('DrawTexture', window, orientationT, [], vertMostRect);
            
        elseif trialData(j, 2) == 4
            Screen('DrawTexture', window, orientationT, [], diagonalUpLeft);
            
        elseif trialData(j, 2) == 5
            Screen('DrawTexture', window, orientationT, [], leftMostRect);
            
        elseif trialData(j, 2) == 6
            Screen('DrawTexture', window, orientationT, [], diagonalDownLeft);
            
        elseif trialData(j, 2) == 7
            Screen('DrawTexture', window, orientationT, [], downMostRect);
            
        elseif trialData(j, 2) == 8
            Screen('DrawTexture', window, orientationT, [], diagonalDownRight);
            
        end
        %decide where the t is located
        occupiedByT = trialData(j, 2);
        %store data on t location in circle
        positionOfT(j,1) = occupiedByT;
        
        %loop is used to find orientation of L and assign it to trial image
        %and draw to screen
        for k = 1:8
            %find the orientation of the L then assign it to the trial image
            %variable
            if randLOrientationArray(k) == 1
                imageForTrial = upsideDownL;
            elseif randLOrientationArray(k) == 2
                imageForTrial = normalL;
            elseif randLOrientationArray(k) == 3
                imageForTrial = sideL;
            elseif randLOrientationArray(k) == 4
                imageForTrial = sideWL;
            end
            
            %Draw L with proper orientation to all locations except for
            %location where T is located
            if randLPositionArray(k) == occupiedByT
                %do nothing if the positon is occupied by the t for trial
            elseif  randLPositionArray(k) == 1
                Screen('DrawTexture', window, imageForTrial, [], rightMostRect);
            elseif  randLPositionArray(k) == 2
                Screen('DrawTexture', window, imageForTrial, [], diagonalUpRight);
            elseif  randLPositionArray(k) == 3
                Screen('DrawTexture', window, imageForTrial, [], vertMostRect);
            elseif  randLPositionArray(k) == 4
                Screen('DrawTexture', window, imageForTrial, [], diagonalUpLeft);
            elseif  randLPositionArray(k) == 5
                Screen('DrawTexture', window, imageForTrial, [], leftMostRect);
            elseif  randLPositionArray(k) == 6
                Screen('DrawTexture', window, imageForTrial, [], diagonalDownLeft);
            elseif  randLPositionArray(k) == 7
                Screen('DrawTexture', window, imageForTrial, [], downMostRect);
            elseif  randLPositionArray(k) == 8
                Screen('DrawTexture', window, imageForTrial, [], diagonalDownRight);
                
            end
            
        end
        
        
        %present task screen for 2 seconds
        [~,start1, ~] =  Screen('Flip', window);
        WaitSecs(0.2);
        
        %timeToWait = 2;
        startTime = GetSecs;
        timeInLoop = 0;
        flag = 0;
        
        KbWait([], [], start1 + timeToWaitResponse);
        timeWaited = GetSecs;
        respTime(j,1) = timeWaited-start1;
        
        clear Press;
        [pressed, Press] = KbQueueCheck(deviceIndices);
        
        if Press(upKey) > 0 || Press(downKey)>0
            %code to tell user how many points they gained
            rewardAmtText = num2str(trialData(j, 5));
            plus = '+';
            responseText = [plus ' ' rewardAmtText];
            flag = 1;
            % code to find if user input was correct
            
            %user presses up arrow and t is up so correct
            if Press(upKey) > 0 && trialData(j, 3) == up
                text = 'correct';
                response = 1;
                keyPress(j,1) = 1;
                
                
                %user presses down arrow and t is down so correct
            elseif Press(downKey) > 0 && trialData(j, 3) == down
                text = 'correct';
                response = 1;
                keyPress(j,1) = 0;
                
                
                %user presses up arrow and t is down so incorrect
            elseif Press(upKey) > 0 && trialData(j, 3) == down
                text = 'incorrect';
                responseText = '+ 0';
                response = 0;
                keyPress(j,1) = 1;
                
                %user presses down arrow and t is up so incorrect
            elseif Press(downKey) > 0 && trialData(j, 3) == up
                text = 'incorrect';
                responseText = '+ 0';
                response = 0;
                keyPress(j,1) = 0;
            end
            
            Screen('DrawTexture', window, crossForTrial, [], centerRect);
            Screen('Flip', window);
            WaitSecs(3-respTime(j,1));
            
            %record response data
            correctOrIncorrect(j,1) = response;
            %print feedback from decesion in trial to screen
            DrawFormattedText(window, text,'center' , yCenter, black);
            DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
            Screen('Flip', window);
            WaitSecs(2)
            % DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
        end
        
        
        
        
        %present user with question
        %         textStrTrial = 'was the T up or down?';
        %         DrawFormattedText(window, textStrTrial,'center', yCenter, black);
        
        if flag == 0
            isEyeInside = false;
            text = 'TOO LATE';
            DrawFormattedText(window, text,'center' , yCenter, black);
            Screen('Flip', window);
            
            WaitSecs(2)
            
            
        end
        
        
        %record response data
        correctOrIncorrect(j,1) = response;
        %print feedback from decesion in trial to screen
        %    DrawFormattedText(window, text,'center' , yCenter, black);
        Screen('DrawTexture', window, dispImageCross, [], centerRect);
        
        Screen('Flip', window);
        
        WaitSecs(2);
        
        %code for confidence assessment
        decideConfRating = mod(j,10);
        if decideConfRating == 0 || j == 1
            
            DrawFormattedText(window, responseText, 'How would you rate your mental fatigue?',screenYpixels * 0.25, black);
            [~, trial_datum, ~, ~, ~ ,~] = Ratings('confidence', window,p);
            fatigueRating(j) = trial_datum;
            Screen('DrawTexture', window, dispImageCross, [], centerRect);
            Screen('Flip', window);
            WaitSecs(1);
            
        end
        
        
    end
    
    clear firstPress
    
    
    
    %  end
    
    %if statment handles trial abortion and saves data for trial to be re
    %ran at end
    if ~isEyeInside
         numTrials = numTrials + 1;
        countAbortFree = countAbortFree + 1;
        randTarray(numTrials) = randTarray(j);
        orientationTArray(numTrials) = orientationTArray(j);
        cardinalVec(numTrials) = cardinalVec(j);
        incentiveVec(numTrials) = incentiveVec(j);
        trialData(numTrials,1) = j;
        trialData(numTrials, 2) = randTarray(j);
        trialData(numTrials, 3) = orientationTArray(j);
        trialData(numTrials, 4) = cardinalVec(j);
        trialData(numTrials, 5) = incentiveVec(j);
        randSpeedVecData(numTrials) = randSpeedVec(blockIndex + j);
        randSpeedVec(numTrials) = randSpeedVec(blockIndex + j);
        abortedTrials(numTrials) = 0;
        abortedTrials(j) = 1;
        abortedTrials2(j) = 1;
        isEyeInside = true;
        respTimeInc(numTrials) = 0;
        rewardChoice(numTrials) = 0;
        fatigueRating(numTrials) = 0;
        keyPress(numTrials) = 0;
        correctOrIncorrect(numTrials) = 0;
        respTime(numTrials) = 0;
        
        
        
        
        DrawFormattedText(window, 'TRIAL ABORTED','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
        
        
    end
    
    
    
end
trialData(:, 6) = abortedTrials;

finalTrialData.practiceFree.results.responseTimeIncentive =respTimeInc;
finalTrialData.practiceFree.results.rewardChoice = rewardChoice;
finalTrialData.practiceFree.results.fatigueRating = fatigueRating;
finalTrialData.practiceFree.results.keyPress = keyPress;
finalTrialData.practiceFree.results.correctOrIncorrect = correctOrIncorrect;
finalTrialData.practiceFree.results.respTimeSearch = respTime;
finalTrialData.practiceFree.results.abortedTrials = abortedTrials;
finalTrialData.practiceFree.results.allTrialsData = vertcat([respTimeInc, rewardChoice, fatigueRating, keyPress, correctOrIncorrect, respTime, abortedTrials2]);
finalTrialData.practiceFree.results.dataDescription = {'Column 1 represents the response time for choosing incentive'; 'Column 2 represents the reward choice(difficult = 2, easy = 1)'; 'Columnn 3 represents self assessed fatigue on a scale of 1 to 10';...
    'Column 4 represents key presses to decide the orientation of t( 1 = up, 0 = down)'; 'Columnn 5 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
    'Column 6 represents the time it took for a person to decide the orientation of T'; 'Column 7 represents the aborted trials (1 = aborted, 0 = succesful)'};

finalTrialData.practiceFree.trialData.description = {'Column 1 represents the trial number(1-12 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
    'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)'};


finalTrialData.practiceFree.trialData.data = trialData;


%finalDataFree = [incentiveAmt,trialData(:, 3),trialData(:, 2),correctOrIncorrect,respTime];

%save('V1mollerusBell\finalDataFree.mat','finalData');
%save('V1mollerusBell\finalTrialData.mat','finalTrialData');

% load('finalDataFree.mat');











