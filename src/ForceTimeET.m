response = 0;
responseText = 'incorrect';

numTrials = 6;

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

%========================================================================
%this loop itterates the specified number of trials. every iteration, a
%user will have a difficult task. 
%they will be presented with eight
%letters in a circle and have to find a T and report its orientation.
%In every trial the user is given a prompt to
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
    flag = 1;
    %easy is set to false so the DrawTLLocation script will always draw 7
    %L's and 1 T because these are force trials
    easy = false; 
    %is Force is set to true so only one incentive will be drawn in the
    %DrawIncentive script
    isForce = true;  

    %draw incentive at the start of a new trial. Script controlls for both
    %free and force trials 
    DrawIncentive;
    
    %Starting response time interval
    [~,actualFlipTime,~,~]= Screen('Flip', window);
    
    %Clearing and initializing keyboard config for trial(i)
    secs = 1;
    
    %Storing response interval time
    respTimeInc(j,1) = secs - actualFlipTime;
    
    [pressed, firstPress] = KbQueueCheck(deviceIndices);

    WaitSecs(2);
    
    %%%%%%%%%fixation before trial
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
                        %trial aborted if fixation is broken
                        abortForce;
                    end
                end
            end
        end
    end
    
    
    %enters this fixation if the initial fixation is held and accepted
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
    
    
    %if both fixation checks have passed, person enters search task here in
    %this if statement
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
        %draw T in random location with random orientation to screen and also draw l with random position
        %and orientation to screen
        DrawTLLocation;
        
        %present task screen for 2 seconds
        [~,start1, ~] =  Screen('Flip', window);
         
        %%%checks if person is fixating on center while searching array for
        %%% T orientation
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
                
                %record response time for decesion 
                %if statement here also breaks loop if there is a key press
                respTime(j,1) = GetSecs-start1;
                break
            end
        end
        
        %if fixation was held during search this if statement executes and
        %decised weather or not the users decesion was correct or incorrect
        if nofixtimeflag == 0
            
            % timeToWait = 2;
            startTime = GetSecs;
            timeInLoop = 0;
            flag = 0;
            %record response time after button pressed, if trial runs out
            %of time response time for that trial will be recorded as a nan
            timeWaited = GetSecs;
            respTime(j,1) = timeWaited-start1;
            
            %the code housed in this script decides weather or not the user
            %was correct of incorrect
            CorrectDecision; 
            
            %code for confidence assessment every 10 trials
            decideConfRating = mod(j,10);
            if decideConfRating == 0 || j == 1
                DrawFormattedText(window, responseText, 'How would you rate your mental fatigue?',screenYpixels * 0.25, black);
                [~, trial_datum, ~, ~, ~ ,~] = Ratings('confidence', window,p);
                fatigueRating(j) = trial_datum;
            end
            
            %++++++THIS CODE CONTROLLS WEATHER OR NOT THE TRIAL IS ABORTED, IF THE
            %the trial continues for too long
            if flag == 0
                abortForce;
            end

            %record response data
            correctOrIncorrect(j,1) = response;
         %this if statment executes if the fixation during the search delay
         %is broken
        elseif ~isEyeInside || nofixtimeflag==1
            abortForce;
        end
        
        clear firstPress
    end
    %aborts trial if initial fixation on incentives is broken
    if (~isEyeInside || nofixtimeflag==1) && nofixflag == 0
        abortForce;
         
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
    finalTrialData.force.results.responseTimeIncentive = vertcat(finalTrialData.force.results.responseTimeIncentive, respTimeInc);
    finalTrialData.force.results.rewardChoice = vertcat(finalTrialData.force.results.rewardChoice, rewardChoice);
    finalTrialData.force.results.correctOrIncorrect = vertcat(finalTrialData.force.results.correctOrIncorrect, correctOrIncorrect);
    finalTrialData.force.results.respTime = vertcat(finalTrialData.force.results.respTime, respTime);
    finalTrialData.force.results.abortedTrials = vertcat(finalTrialData.force.results.abortedTrials, abortedTrials);
    finalTrialData.force.results.fatigueRating = vertcat(finalTrialData.force.results.fatigueRating, fatigueRating);
    finalTrialData.force.results.keyPress = vertcat(finalTrialData.force.results.keyPress, keyPress);
    finalTrialData.force.trialData.allTrialData = vertcat(finalTrialData.force.trialData.allTrialData, trialData);
    
end

countForceBlocks = countForceBlocks + 1;