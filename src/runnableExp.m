%Authors
%Christopher Bell
%Philip Mollerus
%Version 7/27/2021

%Calling GUI script
GUI

%+++++++++++++++++++++DESCTIPTION OF PROGRAM+++++++++++++++++++++++++
%THIS RUNNABLE EXP FILE IS WHERE THE PROGRAM IS RUN FROM. THE PROGRAM WILL
%SET ITSELF UP AND EXECUTE FREE OR FORCE TRIALS DPENDING ON THE VALUES
%GIVEN TO THE GUI. THE BEST DOCUMENTATION CAN BE FOUND IN THE MAIN TRIAL
%BLOCKS: "Practice" AND "FreeTime".

%call setup script to re randomize each trials data i.e target location,
%orientation, etc
%SetupTChoice
SetUpPsychTB;
SetUpEyeLink;

%Intializing variables for creating structs/fields for P1 and P2 data
countForceBlocks = 1;
countFreeBlocks = 1;
countPracticeBlocks = 1;

%Intializing EyeLink setup
elstate = 'on';
if strcmp(elstate,'on')
    
    fileName=sprintf('%s.edf', edfFile); % Data file name
    Eyelink('Openfile',fileName);
    %try
    
    %Setting vector for sequence of blocks
    order1 = [1 2 3 7 8 7 8 5 6 5 6 4];
    order2 = [7];
    
    %GUI order selection
    if trialChoice == 0 
        selection = order1;
    elseif trialChoice ==1
        selection = order2;
    end
    
    %Setting up practice condition for P1 and P2
    P1Practice = false;
    P2Practice = false;
    FR = false;
    
    %Initializing counter for block index
    blockNum = 2;
    practiceNum = 0;
    
    %Main loop that iterates through each block in chosen sequence
    
    %P1 or P2 practice variables correspond to practice completion at the
    %start of each of the two parts of the task. FALSE means practice has
    %been completed
    
    %Speed corresponds to the speed of each block. 1 means SLOW, 2 means
    %FAST
    
    %Feedback corresponds to whether or not feedback is given in that block
    %FALSE means no feedback, TRUE means feedback
    
    %Confidence corresponds to whether confidence ratings are given during
    %that block TRUE means they are, FALSE means they aren't
    %numTrials corresponds to the number of trials set for each block. For
    %full tasks, practice periods before each half of the task have 6
    %TRIALS
    %
    %
    %SELECTION PRESETS:
    %%%1 = NO FEEDBACK, SLOW, CONFIDENCE RATINGS
    %%%2 = NO FEEDBACK, FAST, CONFIDENCE RATINGS
    %%%5 = FEEDBACK, SLOW, NO CONFIDENCE RATINGS
    %%%6 = FEEDBACK, FAST, NO CONFIDENCE RATINGS
    %%%7 = FEEDBACK, SLOW, CONFIDENCE RATINGS
    %%%8 = FEEDBACK, FAST, CONFIDENCE RATINGS
   
    for o = 1:1
            
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %REGULAR NO FEEDBACK TRIALS
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       
        if selection(o) ==1 %speedforce
             
            
            if P1Practice == false
                
                speed = 1;
                feedback = false;
                confidence = true;
                numTrials = 6;
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Practice block start');
                WaitSecs(0.001);
                
                
                end
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey);
                preSlides;
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Practice block start');
                WaitSecs(0.001);
                end
                
                SetUpTrialData;
                Practice;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey)

                P1Practice = true;
                Screen('DrawTexture', window, s9, [], windowRect);
                            Screen('Flip', window);

                KbWait;
                WaitSecs(0.25);
            end
            
            speed = 1;
            feedback = false;
            confidence = true;
            numTrials = 6;
            
            SetUpTrialData;
            
            DrawFormattedText(window, 'Regular No Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
            Screen('Flip', window);
            WaitSecs(1);
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            WaitSecs(0.25);
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback block start');
                WaitSecs(0.001);
            end
            

            practiceNum = practiceNum + 1;
            Practice;
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback block end');
                WaitSecs(0.001);
            end
            
            
            %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            %SPEED NO FEEDBACK TRIALS
            %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            
        elseif selection(o) ==2 %speedPractice
             
             if P1Practice == false
               
                speed = 1;
                feedback = false;
                confidence = true;
                numTrials = 6;
                SetUpTrialData;
                
                DrawFormattedText(window, 'Regular No Feedback Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
              
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Regular No Feedback Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                WaitSecs(0.25);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Regular No Feedback Practice block start');
                    WaitSecs(0.001);
                    
                    
                end
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey)
                preSlides;
                SetUpTrialData;

                
                WaitSecs(0.1);
                Practice;
                P1Practice = true;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey)
                Screen('DrawTexture', window, s9, [], windowRect);
                KbWait;
                WaitSecs(0.25);
            end
            speed = 2;
            feedback = false;
            numTrials = 6;
            confidence = true;
            
            SetUpTrialData;
            
            DrawFormattedText(window, 'Speeded No Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
           
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Speeded No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            WaitSecs(0.25);
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Speeded No Feedback block start');
                WaitSecs(0.001);
            end
            
            practiceNum = practiceNum + 1;
            Practice
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Speeded No Feedback block end');
                WaitSecs(0.001);
            end
            
            
        elseif selection(o)==5
            
            if P2Practice == false
                
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 6;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey)
                P2instr;
                
                WaitSecs(0.1);
                
                DrawFormattedText(window, 'Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P2 Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                WaitSecs(0.25);
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Practice block start');
                WaitSecs(0.001);
                
                
                end
                SetUpTrialData;
                
                KbQueueRelease(deviceIndices);
                KbQueueCreate(deviceIndices);
                KbQueueStart(deviceIndices);
                
                FreeTime;
                P2Practice = true;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey)
                Screen('DrawTexture', window, sc19, [], windowRect);
                Screen('Flip', window);
                KbWait;
                WaitSecs(0.25);
            end
            
            speed = 1;
            feedback = false;
            numTrials = 6;
            confidence = false;
            
            SetUpTrialData;
            
            Screen('DrawTexture', window, regNFB, [], windowRect);
            
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            WaitSecs(0.25);
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular No Feedback block start');
                WaitSecs(0.001);
            end
            
            blockNum = blockNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular No Feedback block end');
                WaitSecs(0.001);
            end
            
        elseif selection(o)==6
             
            if P2Practice == false
                
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 6;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey);
                P2instr;
                
                
                DrawFormattedText(window, 'Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P2 Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                WaitSecs(0.25);
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Practice block start');
                WaitSecs(0.001);
                
                
                end
                SetUpTrialData;

                FreeTime;
                P2Practice = true;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey);
                Screen('DrawTexture', window, sc19, [], windowRect);
                Screen('Flip', window);
                KbWait;
                WaitSecs(0.25);
            end
            
            speed = 2;
            feedback = false;
            numTrials = 6;
            confidence = false;
            
            SetUpTrialData
            
            Screen('DrawTexture', window, fastNFB, [], windowRect);

            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Speeded No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            WaitSecs(0.25);
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Speeded No Feedback block start');
                WaitSecs(0.001);
            end
            
            blockNum = blockNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Speeded No Feedback block end');
                WaitSecs(0.001);
            end
            
        elseif selection(o)==7
             
            if P2Practice == false
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 6;
                SetUpTrialData;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey);
                P2instr;
           
                
                DrawFormattedText(window, 'Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P2 Practice block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                WaitSecs(0.25);
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Practice block start');
                WaitSecs(0.001);
                
                
            end
                FreeTime;
               P2Practice = true;
               RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey);
               Screen('DrawTexture', window, sc19, [], windowRect);
                Screen('Flip', window);
                KbWait;
                WaitSecs(0.25);

            end
            
            speed = 1;
            feedback = true;
            numTrials = 6;
            confidence = false;
            
            SetUpTrialData
           
            Screen('DrawTexture', window, regFB, [], windowRect);

            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            WaitSecs(0.25);
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular Feedback block start');
                WaitSecs(0.001);
            end
            
            blockNum = blockNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular Feedback block end');
                WaitSecs(0.001);
            end
            
        elseif selection(o)==8
             
            if P2Practice == false
                
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 6;
                SetUpTrialData;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey);
                P2instr;
                
                DrawFormattedText(window, 'Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
               
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P2 Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                WaitSecs(0.25);
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Practice block start');
                WaitSecs(0.001);
                
                
            end
                FreeTime;
                P2Practice = true;
                RestrictKeysForKbCheck([]);
                RestrictKeysForKbCheck(upKey);
                Screen('DrawTexture', window, sc19, [], windowRect);
                Screen('Flip', window);
                KbWait;
                WaitSecs(0.25);
            end
            
            speed = 2;
            feedback = true;
            numTrials = 6;
            confidence = false;
            
            SetUpTrialData
            
            Screen('DrawTexture', window, fastFB, [], windowRect);

            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Fast Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            WaitSecs(0.25);
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Fast Feedback block start');
                WaitSecs(0.001);
            end
            
            blockNum = blockNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Fast Feedback block end');
                WaitSecs(0.001);
            end
        elseif selection(o) == 3
            Screen('DrawTexture', window, p1Bonus, [], windowRect);
            Screen('Flip', window);
            KbWait;
            WaitSecs(0.25);
            
        elseif selection(o) == 4
            Screen('DrawTexture', window, p2Bonus, [], windowRect);
            Screen('Flip', window);
            KbWait;
            WaitSecs(0.25);
        end
    end
end

finalTrialData.participant.timeEnded = clock;
finalTrialData.participant.timeTaken = clock - Start_time;

finalTrialData.free.results.allTrialsResponseDataMatrix = horzcat([finalTrialData.free.results.responseTimeIncentive,  finalTrialData.free.results.rewardChoice, finalTrialData.free.results.fatigueRating,  finalTrialData.free.results.keyPress, finalTrialData.free.results.correctOrIncorrect, finalTrialData.free.results.respTime,  finalTrialData.free.results.abortedTrials]);
finalTrialData.free.results.dataDescriptionResponse = {'Column 1 represents the response time for choosing incentive'; 'Column 2 represents the reward choice(difficult = 2, easy = 1)'; 'Columnn 3 represents self assessed fatigue on a scale of 1 to 10';...
    'Column 4 represents key presses to decide the orientation of t( 1 = up, 0 = down)'; 'Columnn 5 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
    'Column 6 represents the time it took for a person to decide the orientation of T'; 'Column 7 represents the aborted trials (1 = aborted, 0 = succesful)'};

finalTrialData.free.trialData.descriptionTrialData = {'Column 1 represents the trial number(1-72 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
    'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)'};

finalTrialData.free.trialData.data = trialData;

practiceTrialData.free.results.allTrialsResponseDataMatrix = horzcat([practiceTrialData.free.results.responseTimeIncentive, practiceTrialData.free.results.rewardChoice, practiceTrialData.free.results.fatigueRating, practiceTrialData.free.results.keyPress, practiceTrialData.free.results.correctOrIncorrect, practiceTrialData.free.results.respTime, practiceTrialData.free.results.abortedTrials]);
practiceTrialData.free.trialData.data = trialData;

cleaned.data = horzcat(finalTrialData.free.trialData.allTrialData,  finalTrialData.free.results.allTrialsResponseDataMatrix);
cleaned.practiceData = horzcat(practiceTrialData.free.trialData.allTrialData, practiceTrialData.free.results.allTrialsResponseDataMatrix);

blockNumVec = cleaned.practiceData(:,10);
cleaned.practiceData = horzcat(cleaned.practiceData, blockNumVec);
cleaned.practiceData(:,10) = [];
indecies = find(cleaned.practiceData(:,7) == 1 |cleaned.practiceData(:,7) == 2 |cleaned.practiceData(:,7) == 3 );
cleaned.practiceData(indecies,7) = 1;
indecies = find(cleaned.practiceData(:,7) == 4 |cleaned.practiceData(:,7) == 5 |cleaned.practiceData(:,7) == 6 );
cleaned.practiceData(indecies,7) = 6;

blockNumVec = cleaned.data(:,10);
cleaned.data = horzcat(cleaned.data, blockNumVec);
cleaned.data(:,10) = [];
cleaned.dataDescription = {'Column 1 is feedback = 2 and no feedback = 1';...
    'Column 2 is the participants code';'Column 3 is the trial number in each block';...
    'Column 4 is the location of the T in the search array, 1 = farthest right and increased counter clockwise, 5 is farthest left';...
    'Column 5 is the orientation of T (1 = upright T, 0 = upsidedown)';...
    'Column 6 is where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';...
    'Column 7 is the incentive value shown 1-6 where an incentive value of 1 will shown as 10, 2 as 14, 3 as 18, 4 as 22, 5 as 26, 6 as 30';...
    'Column 8 is the aborted trials (1 = aborted, 0 = succesful)';...
    'Column 9 is the speed of the given trial, 1 = regular (2 secs) 2 = speeded (0.8 secs)';...
    'Column 10 represents the response time for choosing incentive';...
    'Column 11 represents the reward choice(difficult = 2, easy = 1)';...
    'Columnn 12 represents self assessed fatigue on a scale of 1 to 10';...
     'Column 13 represents key presses to decide the orientation of t( 1 = up, 0 = down)';...
     'Columnn 14 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
     'Column 15 is the time it took for a person to decide the orientation of T';...
     'Column 16 is the aborted trials (1 = aborted, (0, nan) = succesful)';...
    'Column 17 is the block number (3-10)';}

cleaned.dataPracDescription = {'Column 1 is feedback = 2 and no feedback = 1';...
    'Column 2 is the participants code';'Column 3 is the trial number in each block';...
    'Column 4 is the location of the T in the search array, 1 = farthest right and increased counter clockwise, 5 is farthest left';...
    'Column 5 is the orientation of T (1 = upright T, 0 = upsidedown)';...
    'Column 6 is where the incentive is drawn (1 = drawn on right, 2 = drawn on left)';...
    'Column 7 is the incentive value shown 1-6 where an incentive value 1,2,3 will be shown as a 10 and 4,5,6 will be shown as a 30';...
    'Column 8 is the aborted trials (1 = aborted, 0 = succesful)';...
    'Column 9 is the speed of the given trial, 1 = regular (2 secs) 2 = speeded (0.8 secs)';...
    '(NOT IMPORTANT FOR PRACTICE DATA) Column 10 represents the response time for choosing incentive';...
    '(NOT IMPORTANT ALWAYS DIFFICULT) Column 11 represents the reward choice(difficult = 2, easy = 1)';...
    'Columnn 12 represents self assessed percent correct for the first blocks';...
     'Column 13 represents key presses to decide the orientation of t( 1 = up, 0 = down)';...
     'Columnn 14 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
     'Column 15 is the time it took for a person to decide the orientation of T';...
     'Column 16 is the aborted trials (1 = aborted, (0, nan) = succesful)';...
    'Column 17 is the block number (1-2)';}




save('cleaned');
load('cleaned.mat');

try
    fprintf('Receiving data file ''%s''\n', fileName);
    status=Eyelink('ReceiveFile',fileName);
    if status > 0
        fprintf('ReceiveFile status %d\n', status);
    end
    if 2==exist(fileName, 'file')
        fprintf('Data file ''%s'' can be found in ''%s''\n', fileName, pwd );
    end
catch rdf
    fprintf('Problem receiving data file ''%s''\n', fileName );
    rdf;
end

sca;