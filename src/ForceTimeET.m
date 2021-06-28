response = 0;
responseText = 'incorrect';

numTrials = 30;

abortedTrials = nan(numTrials,1);
correctOrIncorrect = nan(numTrials,1);
respTimeInc = nan(numTrials,1);
rewardChoice = nan(numTrials,1);
fatigueRating = nan(numTrials,1);
keyPress = nan(numTrials,1);
abortedTrials2 = nan(numTrials,1);
randSpeedVecData = nan(numTrials, 1);

j = 1;

% %% 4. Calibrate the eye tracker
% Eyelink('command','calibration_area_proportion = 0.5 0.5');
% Eyelink('command','validation_area_proportion = 0.48 0.48');
% EyelinkDoTrackerSetup(el);
% WaitSecs(0.1);

eye_used = Eyelink('EyeAvailable'); % get eye that's tracked (only track left eye)
if eye_used == el.BINOCULAR % if both eyes are tracked
    eye_used = el.LEFT_EYE; % use left eye
end

%     fileName=sprintf('%sF.edf',edfFile); % Data file name
%      Eyelink('Openfile',fileName);

%========================================================================
%this loop itterates the specified number of trials. every iteration, a
%user will have a choice between a easy and a difficult task by selecting
%from two potential choices one of which has higher value than the other.
%if they choose the difficult option, they will be presented with eight
%letters in a circle and have to find a T and report its orientation. in the easy
%choice users will have only the t presented to them and will still have to
%report its orientation. In every trial the user is given a prompt to
%decide on the orientaion of the t and is also given feedback based upon
%weather or not their response was correct. this loop
%handles trial abortions and retries aborted at the end.
%========================================================================
fixation_pos = crossPos;
while j <= numTrials
    
    %% 5. Mark events, messages, etc. in dataviwer trial
    Eyelink('Message', 'TRIAL_%d', numTrials);
    % This supplies the title at the bottom of the eyetracker display
    Eyelink('command', 'record_status_message "TRIAL %d OF %d"', j, numTrials);
    WaitSecs(0.001);
    isEyeInside = true;
    
    %%% 6. START RECORDING each trial
    Eyelink('StartRecording');
    error=Eyelink('CheckRecording');
    if(error~=0)
        %isEyeInside = false;
    end
    
    if j == 1
        DrawFormattedText(window, 'Force Choice Trials', 'center',...
            yCenter, [0 0 0]);
        Screen('Flip', window);
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
    DrawFormattedText(window, 'Reward amount if fixed', 'center',...
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
    if  trialData(j, 4)==1
       % Screen('DrawTexture', window, disOneEasyIncentive, [], leftRectPos);
        Screen('DrawTexture', window, incentiveForTrial, [], rightRectPos);
    elseif  trialData(j, 4)==2
        Screen('DrawTexture', window, incentiveForTrial, [], leftRectPos);
       % Screen('DrawTexture', window, disOneEasyIncentive, [], rightRectPos);
    end
    
    
    
    %Starting response time interval
    [~,actualFlipTime,~,~]= Screen('Flip', window);
    
    %Clearing and initializing keyboard config for trial(i)
    secs = 1;
   % [secs, ~,~] = KbWait;
    
    %Storing response interval time
    respTimeInc(j,1) = secs - actualFlipTime;
    
    [pressed, firstPress] = KbQueueCheck(deviceIndices);
    
    
    WaitSecs(2);
    
    
    
    %%%%%%%%%fixation before trial
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Screen('DrawTexture', window, dispImageCross, [], crossPos);
    Screen('Flip', window);
    
    if strcmp(elstate, 'on')
        % Mark events, messages, etc. in dataviwer trial
        Eyelink('Message', '2');
        WaitSecs(0.001);
    end
    
    % Wait until fixation in fixation cross (abort trial after 200ms)
    T_delay = 0.5; %rand time delay
    nofixflag=1;
    startrt=GetSecs;
    while (GetSecs-startrt)<=T_delay %|| nofixflag==1
        if Eyelink('NewFloatSampleAvailable') > 0
            % get the sample in the form of an event structure
            evt = Eyelink('NewestFloatSample');
            if eye_used ~= -1 % do we know which eye to use yet?
                % if we do, get current gaze position from sample
                x = evt.gx(eye_used+1); % +1 as we're accessing MATLAB array
                y = evt.gy(eye_used+1);
                
                % do we have valid data and is the pupil visible?
                if x~=el.MISSING_DATA && y~=el.MISSING_DATA && evt.pa(eye_used+1)>0
                    eyemx=x;
                    eyemy=y;
                    % if no fixation
                    if (eyemx>fixation_pos(1)-150 && eyemx < fixation_pos(3)+150 && eyemy>fixation_pos(2)-150 && eyemy<fixation_pos(4)+150) %%change fixation_pos
                        nofixflag=0;
                        break
                    elseif (eyemx<fixation_pos(1)-150 || eyemx > fixation_pos(3)+150 || eyemy<fixation_pos(2)-150 || eyemy>fixation_pos(4)+150)% broke fixation reset time
                        nofixflag=1; %no fixation so we go to abort trial
                        % Mark events, messages, etc. in dataviwer trial
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
                        % randSpeedVecData(numTrials) = randSpeedVec(blockIndex + j);
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
                        
                        DrawFormattedText(window, 'Please look at center','center' , yCenter, black);
%                         Screen('Flip', window);
%                         WaitSecs(2);
                        
                        DrawFormattedText(window, 'Try again','center' , yCenter + 75, black);
                        Screen('Flip', window);
                        WaitSecs(4);
                        
                        
                        
                        
                        WaitSecs(0.001);
                    end
                end
            end
        end
    end
    
    if nofixflag==0
        
        T_delay = randi([3 5],1);
        nofixtimeflag=1;
        startrt=GetSecs;
        totalFixTime =0;
        totalFixTimeout=0;
        Novalid=0;
        fixTime = T_delay;
        
        while (GetSecs-startrt)<=T_delay  && Novalid==0
            if Eyelink('NewFloatSampleAvailable') > 0
                % get the sample in the form of an event structure
                evt = Eyelink('NewestFloatSample');
                if eye_used ~= -1 % do we know which eye to use yet?
                    % if we do, get current gaze position from sample
                    
                    x = evt.gx(eye_used+1); % +1 as we're accessing MATLAB array
                    y = evt.gy(eye_used+1);
                    
                    % do we have valid data and is the pupil visible?
                    if x~=el.MISSING_DATA && y~=el.MISSING_DATA && evt.pa(eye_used+1)>0
                        eyemx=x;
                        eyemy=y;
                        % if no fixation
                        if  (eyemx>fixation_pos(1)-150 && eyemx < fixation_pos(3)+150 && eyemy>fixation_pos(2)-150 && eyemy<fixation_pos(4)+150)
                            totalFixTime = totalFixTime + 50;
                            totalFixTimeout=0;
                            if totalFixTime >= fixTime-250
                                nofixtimeflag=0;
                                
                            end
                        elseif (eyemx<fixation_pos(1)-150 || eyemx > fixation_pos(3)+150 || eyemy<fixation_pos(2)-150 || eyemy>fixation_pos(4)+150)% broke fixation reset time
                            totalFixTimeout = totalFixTimeout + 0.5;% change 50ms
                            
                            totalFixTime = 0;
                            if totalFixTimeout >= 250
                                nofixtimeflag =1;
                                Novalid=1;
                            end
                            
                            % Mark events, messages, etc. in dataviwer trial
                            
                            WaitSecs(0.001);
                        end
                    end
                end
            end
        end
    end
    
    if nofixtimeflag==0 && nofixflag == 0
        %%%%the serach screen
        T_delay = timeToWaitResponse; %%take your search time
        nofixtimeflag=1;
        startrt=GetSecs;
        totalFixTime =0;
        totalFixTimeout=0;
        Novalid=0;
        fixTime = T_delay;
        
        %======================================
        %DIFFICULT TASK CODE HERE
        %======================================
        
        Screen('DrawTexture', window, dispImageCross, [], centerRect);
        
        
        
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
        
        
        
        while (GetSecs-startrt)<=T_delay  && Novalid==0
            if Eyelink('NewFloatSampleAvailable') > 0
                % get the sample in the form of an event structure
                evt = Eyelink('NewestFloatSample');
                if eye_used ~= -1 % do we know which eye to use yet?
                    % if we do, get current gaze position from sample
                    
                    x = evt.gx(eye_used+1); % +1 as we're accessing MATLAB array
                    y = evt.gy(eye_used+1);
                    
                    % do we have valid data and is the pupil visible?
                    if x~=el.MISSING_DATA && y~=el.MISSING_DATA && evt.pa(eye_used+1)>0
                        eyemx=x;
                        eyemy=y;
                        % if no fixation
                        if  (eyemx>fixation_pos(1)-150 && eyemx < fixation_pos(3)+150 && eyemy>fixation_pos(2)-150 && eyemy<fixation_pos(4)+150)
                            totalFixTime = totalFixTime + 50;
                            totalFixTimeout=0;
                            if totalFixTime >= fixTime-250
                                nofixtimeflag=0;
                                
                            end
                        elseif (eyemx<fixation_pos(1)-150 || eyemx > fixation_pos(3)+150 || eyemy<fixation_pos(2)-150 || eyemy>fixation_pos(4)+150)% broke fixation reset time
                            totalFixTimeout = totalFixTimeout + 0.5;% change 50ms
                            
                            totalFixTime = 0;
                            if totalFixTimeout >= 250
                                nofixtimeflag =1;
                                Novalid=1;
                            end
                            
                            % Mark events, messages, etc. in dataviwer trial
                            
                            WaitSecs(0.001);
                        end
                    end
                end
            end
            
            [pressed, Press] = KbQueueCheck(deviceIndices);
            
            if Press(downKey)>0 || Press(upKey)>0
                
                respTime(j,1) = GetSecs-start1;
                
                break
            end
            
        end
        
        if nofixtimeflag == 0
            
            % timeToWait = 2;
            startTime = GetSecs;
            timeInLoop = 0;
            flag = 0;
            
            
            %++++++++++++IMPORTANT++++++++++++++
            %THIS KbWait DECIDES IF THE TRIALS IS ABORTED OR NOT, THE KbWait
            %SPECIFIES A TIME TO BE WAITED, IF THAT TIME IS EXCEEDED IT SKIPS
            %THE FOLLOWING IF BLOCK AND EXECUTES CODE TO ABORT THE TRIAL. IF
            %A KEY BOARD INPUT IS DETECTED, IT WILL ENTER THE IF BLOCK AND
            %DECIDE IF THE KEY PRESS WAS CORRECT OR INCORRECT. IF IT WAS NOT
            %CODE WILL TRIGGER TO ABORT THE TRIAL
%             KbWait([], [], start1 + timeToWaitResponse);
            timeWaited = GetSecs;
            respTime(j,1) = timeWaited-start1;
            
%             clear Press;
%             [pressed, Press] = KbQueueCheck(deviceIndices);
            
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
                
                Screen('DrawTexture', window, dispImageCross, [], centerRect);
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
            
             %code for confidence assessment every 10 trials
            decideConfRating = mod(j,10);
            if decideConfRating == 0 || j == 1
                
                DrawFormattedText(window, responseText, 'How would you rate your mental fatigue?',screenYpixels * 0.25, black);
                [~, trial_datum, ~, ~, ~ ,~] = Ratings('confidence', window,p);
                fatigueRating(j) = trial_datum;
%                 Screen('DrawTexture', window, dispImageCross, [], centerRect);
%                 Screen('Flip', window);
%                 WaitSecs(1);
                
            end
            
            
            %++++++THIS CODE CONTROLLS WEATHER OR NOT THE TRIAL IS ABORTED, IF THE
            %BOOLEAN CONTAINED IN THE BLOCK IS FALSE THE TRIAL IS ABORTED
            if flag == 0
                isEyeInside = false;
                text = 'Too slow';
                DrawFormattedText(window, text,'center' , yCenter, black);
%                 Screen('Flip', window);
%                 WaitSecs(2);
                
                
            end
            
            
            %record response data
            correctOrIncorrect(j,1) = response;
            %print feedback from decesion in trial to screen
%             Screen('DrawTexture', window, dispImageCross, [], centerRect);
%             
%             Screen('Flip', window);
%             
%             WaitSecs(2);
            
           
            
            
            
        elseif ~isEyeInside || nofixtimeflag==1
            
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
            % randSpeedVecData(numTrials) = randSpeedVec(blockIndex + j);
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
            
            %Signaling for aborted trials
            
            
            if nofixtimeflag==1
                DrawFormattedText(window, 'Please look at center','center' , yCenter, black);
                
                %         elseif ~fixation2
                %             DrawFormattedText(window, 'BROKE FIXATION AT SEARCH','center' , yCenter, black);
                %             Screen('Flip', window);
                %             WaitSecs(2);
            end
            DrawFormattedText(window, 'Try again','center' , yCenter + 75, black);
            Screen('Flip', window);
            WaitSecs(4);
            
            isEyeInside = true;
            fixation1 = true;
            fixation2 = true;
            
        end
        
        clear firstPress
        
        
        
        %  end
        
    end
    %++++++IMPORTANT+++++++++++++++++++
    %this if statment houses code that takes the data for the setup in the
    %aborted trial and moves it to the end
    if (~isEyeInside || nofixtimeflag==1) && nofixflag == 0
        
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
        % randSpeedVecData(numTrials) = randSpeedVec(blockIndex + j);
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
        
        %Signaling for aborted trials
        
        
        if nofixtimeflag==1
            
            DrawFormattedText(window, 'Please look at center','center' , yCenter, black);
%             Screen('Flip', window);
%             WaitSecs(2);
            %         elseif ~fixation2
            %             DrawFormattedText(window, 'BROKE FIXATION AT SEARCH','center' , yCenter, black);
            %             Screen('Flip', window);
            %             WaitSecs(2);
        end
        
        DrawFormattedText(window, 'Try again','center' , yCenter + 75, black);
        Screen('Flip', window);
        WaitSecs(4);
        
        isEyeInside = true;
        fixation1 = true;
        fixation2 = true;
        
        
        
end


%%% 7. END RECORDING each trial
Eyelink('StopRecording');

j = j + 1;
end

trialData(:, 6) = abortedTrials;
trialData(:, 7) = randSpeedVecData;


if countForceBlocks == 1
    finalTrialData.force.results.responseTimeIncentive =respTimeInc;
    finalTrialData.force.results.rewardChoice = rewardChoice;
    finalTrialData.force.results.correctOrIncorrect = correctOrIncorrect;
    finalTrialData.force.results.respTime = respTime;
    finalTrialData.force.results.abortedTrials = abortedTrials;
    finalTrialData.force.results.fatigueRating = fatigueRating;
    finalTrialData.force.results.keyPress = keyPress;
    finalTrialData.force.trialData.allTrialData = trialData;
elseif countForceBlocks ~= 1
    finalTrialData.force.results.responseTimeIncentive = vertcat(finalTrialData.free.results.responseTimeIncentive, respTimeInc);
    finalTrialData.force.results.rewardChoice = vertcat(finalTrialData.free.results.rewardChoice, rewardChoice);
    finalTrialData.force.results.correctOrIncorrect = vertcat(finalTrialData.free.results.correctOrIncorrect, correctOrIncorrect);
    finalTrialData.force.results.respTime = vertcat(finalTrialData.free.results.respTime, respTime);
    finalTrialData.force.results.abortedTrials = vertcat(finalTrialData.free.results.abortedTrials, abortedTrials);
    finalTrialData.force.results.fatigueRating = vertcat(finalTrialData.free.results.fatigueRating, fatigueRating);
    finalTrialData.force.results.keyPress = vertcat(finalTrialData.free.results.keyPress, keyPress);
    finalTrialData.force.trialData.allTrialData = vertcat(finalTrialData.force.trialData.allTrialData, trialData);
    
end

countForceBlocks = countCountBlocks + 1;