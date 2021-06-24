numTrials = 12;
j = 1;

abortTime = false;
abortFixStart = false;
abortFixSearch = false;
abortHandler = false;

abortedTrials = zeros(numTrials,1);
abortedTrials2 = zeros(numTrials,1);

randSpeedVecData = zeros(numTrials, 1);
correctOrIncorrect = zeros(numTrials,1);
fatigueRating = nan(numTrials,1);
keyPress = zeros(numTrials,1);

%%% 4. Calibrate the eye tracker
Eyelink('command','calibration_area_proportion = 0.5 0.5');
Eyelink('command','validation_area_proportion = 0.48 0.48');
EyelinkDoTrackerSetup(el);
WaitSecs(0.1);

eye_used = Eyelink('EyeAvailable'); % get eye that's tracked (only track left eye)
if eye_used == el.BINOCULAR % if both eyes are tracked
    eye_used = el.LEFT_EYE; % use left eye
end


while  j <= numTrials
    
    abortTime = false;
    abortFixStart = false;
    abortFixSearch = false;
    abortHandler = false;
    
    %% 5. Mark events, messages, etc. in dataviwer trial
        Eyelink('Message', 'TRIAL_%d', numTrials);
        % This supplies the title at the bottom of the eyetracker display
        Eyelink('command', 'record_status_message "TRIAL %d OF %d"', j, numTrials);
        WaitSecs(0.001);
        
        %%% 6. START RECORDING each trial
        Eyelink('StartRecording');
        error=Eyelink('CheckRecording');
        if(error~=0)
            break
        end
    
    if j == 1
        DrawFormattedText(window, 'Force Choice Trials', 'center',...
            screenYpixels * 0.25, [0 0 0]);
        Screen('Flip', window);
        WaitSecs(2);
    end
    
    while j <= numTrials
        
        abortTime = false;
        abortFixStart = false;
        abortFixSearch = false;
        abortHandler = false;
        
        DrawFormattedText(window, 'NEXT TRIAL STARTING','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
        
        if randSpeedVec(blockIndex + j) == 1
            %cross for slow trial
            crossForTrial = dispImageBlueCross;
            timeToWaitResponse = 2;
            randSpeedVecData(j) = 1;
            
        elseif randSpeedVec(blockIndex + j) == 2
            crossForTrial = dispImageRedCross;
            timeToWaitResponse = 0.8;
            randSpeedVecData(j) = 2;
            
            
        end
        
        
        Screen('DrawTexture', window, crossForTrial, [], crossPos);
        Screen('TextSize', window, 30);
        DrawFormattedText(window, 'The reward amount is fixed.', 'center',...
            screenYpixels * 0.25, [0 0 0]);
        
        %calculate random incentive amounts for trial 1 = 2 is the only
        %unique case because there cannot be 2 1 incentives presented the
        %rest follow the order
        % 2 = 2, 3 =3... etc
        if trialData(j, 5)==1
            trialData(j, 5) = 2;
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
        if trialData(j, 4)==1
            Screen('DrawTexture', window, incentiveForTrial, [], rightRectPos);
        elseif trialData(j, 4)==2
            Screen('DrawTexture', window, incentiveForTrial, [], leftRectPos);
        end
        
        Screen('Flip', window);
        WaitSecs(3);
        
        Screen('DrawTexture', window, crossForTrial, [], crossPos);
        
        if strcmp(elstate, 'on')
            % Mark events, messages, etc. in dataviwer trial
            Eyelink('Message', '1');
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
                            
                            abortFixStart = true;
                            
                        end
                    end
                end
            end
        end
        
        if abortFixStart == true
            break
        end
        
        if nofixflag==0
            
            T_delay = randi([3 5],1);
            nofixtimeflag=1;
            startrt=GetSecs;
            totalFixTime =0;
            totalFixTimeout=0;
            Novalid=0;
            
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
            % a value of 1 indicates the right most value position of the
            % circle, a value of 2 indicates a up rihgt diagonal orientation
            % and then continues to increase counter clock wise
            %randTarray
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
            
            Screen('DrawTexture', window, crossForTrial, [], crossPos);
            
            %present task screen for 2 seconds
            [~,start1, ~] =  Screen('Flip', window);
            
            % Continue with trial if meet fixation criteria
            if nofixtimeflag==0
                T_delay = timeToWaitResponse; %%take your search time
                nofixtimeflag=1;
                startrt=GetSecs;
                totalFixTime =0;
                totalFixTimeout=0;
                Novalid=0;
                
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
                
                
                if nofixtimeflag==0
                    % CONTINUE TASK CODE HERE
                    % %
                    % %
                    
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
                        %OFSET STIMULUS REWARD PRESENTATION
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
               
                    %++++++THIS CODE CONTROLLS WEATHER OR NOT THE TRIAL IS ABORTED, IF THE
                    %BOOLEAN CONTAINED IN THE BLOCK IS FALSE THE TRIAL IS ABORTED
                    if flag == 0
                      
                        abortTime = true;
                        break
                        
                    end
                    
                    
                    %record response data
                    correctOrIncorrect(j,1) = response;
                    %print feedback from decesion in trial to screen
                    Screen('DrawTexture', window, dispImageCross, [], centerRect);
                    
                    Screen('Flip', window);
                    
                    WaitSecs(2);
                    
                    
                    
                    
                    %code to ask user for self fatigue assessment every 10 trials
                    decideConfRating = mod(j,10);
                    if decideConfRating == 0 || j == 1
                        
                        DrawFormattedText(window, responseText, 'How woud you rate your mental fatigue?',screenYpixels * 0.25, black);
                        [~, trial_datum, ~, ~, ~ ,~] = Ratings('confidence', window,p);
                        fatigueRating(j) = trial_datum;
                        Screen('DrawTexture', window, dispImageCross, [], centerRect);
                        Screen('Flip', window);
                        WaitSecs(1);
                        
                    end
                elseif nofixtimeflag==1
                    %abort trial code
                    %message: please keep looking at the center, next trial will...
                    
                    abortFixSearch = true;
                    break
                    
                end
                
                % Add trial to cue if does not meet fixation criteria
            elseif nofixtimeflag==1
                %abort trial code
                %message: please keep looking at the center, next trial will...
                
                abortFixSearch = true;
                break
                
            end
            
        elseif nofixflag==1
            %abort trial code
            %message: please keep looking at the center, next trial will...
            
            abortFixStart = true;
            break
            
        end
        
        j =j + 1;
        
    end
    
    if abortTime == true
        abortHandler = true;
        DrawFormattedText(window, 'TOO LATE','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
        DrawFormattedText(window, 'TRY AGAIN','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
    elseif abortFixStart == true
        abortHandler = true;
        DrawFormattedText(window, 'PLEASE FIXATE AT START','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
        DrawFormattedText(window, 'TRY AGAIN','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
    elseif abortFixSearch == true
        abortHandler = true;
        DrawFormattedText(window, 'PLEASE FIXATE AT SEARCH','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
        DrawFormattedText(window, 'TRY AGAIN','center' , yCenter, black);
        Screen('Flip', window);
        WaitSecs(2);
    end
    
    if abortHandler == true
        numTrials = numTrials + 1;
        countAbortForced = countAbortForced + 1;
        randTarray(numTrials) = randTarray(j);
        orientationTArray(numTrials) = orientationTArray(j);
        cardinalVec(numTrials) = cardinalVec(j);
        incentiveVec(numTrials) = incentiveVec(j);
        trialData(numTrials,1) = j;
        trialData(numTrials, 2) = randTarray(j);
        trialData(numTrials, 3) = orientationTArray(j);
        trialData(numTrials, 4) = cardinalVec(j);
        trialData(numTrials, 5) = incentiveVec(j);
        %  randSpeedVecData(numTrials) = randSpeedVec(blockIndex + j);
        randSpeedVec(numTrials) = randSpeedVec(blockIndex + j);
        abortedTrials(numTrials) = 0;
        abortedTrials(j) = 1;
        abortedTrials2(j) = 1;
        correctOrIncorrect(numTrials) = 0;
        respTime(numTrials) = 0;
        fatigueRating(numTrials) = 0;
        keyPress(numTrials) = 0;
    end 
    
    %%% 7. END RECORDING each trial
    Eyelink('StopRecording');
    
    j =j + 1;
    
end

trialData(:, 6) = abortedTrials;
trialData(:, 7) = randSpeedVecData;

if countForceBlocks == 1
    finalTrialData.force.results.correctOrIncorrect = correctOrIncorrect;
    finalTrialData.force.results.respTime = respTime;
    finalTrialData.force.results.abortedTrials = abortedTrials;
    finalTrialData.force.results.fatigueRating = fatigueRating;
    finalTrialData.force.results.keyPress = keyPress;
    finalTrialData.force.trialData.allTrialData = trialData;
    
elseif countForceBlocks ~= 1
    finalTrialData.force.results.correctOrIncorrect = vertcat(finalTrialData.force.results.correctOrIncorrect, correctOrIncorrect);
    finalTrialData.force.results.respTime = vertcat(finalTrialData.force.results.respTime, respTime);
    finalTrialData.force.results.abortedTrials = vertcat(finalTrialData.force.results.abortedTrials, abortedTrials);
    finalTrialData.force.results.fatigueRating = vertcat(finalTrialData.force.results.fatigueRating, fatigueRating);
    finalTrialData.force.results.keyPress = vertcat(finalTrialData.force.results.keyPress, keyPress);
    finalTrialData.force.trialData.allTrialData = vertcat(finalTrialData.force.trialData.allTrialData, trialData);
    
    
end
countForceBlocks = countForceBlocks + 1;
    
        