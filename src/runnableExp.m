%Authors
%Christopher Bell
%Philip Mollerus
%Version 6/17/2021

GUI

%+++++++++++++++++++++DESCTIPTION OF PROGRAM+++++++++++++++++++++++++
%THIS RUNNABLE EXP FILE IS WHERE THE PROGRAM IS RAN FROM. THE PROGRAM WILL
%SET ITSELF UP AND EXECUTE FREE OR FORCE TRIALS DPENDING ON THE VALUES
%GIVEN TO THE GUI. THE BEST DOCUMENTATION CAN BE FOUND IN THE MAIN TRIAL
%BLOCKS, "ForceTime2' AND "FreeTime".

%call setup script to re randomize each trials data i.e target location,
%orientation, etc
%SetupTChoice
SetUpPsychTB;
SetUpEyeLink;
countForceBlocks = 1;
countFreeBlocks = 1;
countPracticeBlocks = 1;
elstate = 'on';
if strcmp(elstate,'on')
    
    fileName=sprintf('%s.edf', edfFile); % Data file name
    Eyelink('Openfile',fileName);
    %try
    
    
    order1 = [1 2 1 2];
    order2 = [1];
    
    if trialChoice == 0
        selection = order1;
    elseif trialChoice ==1
        selection = order2;
    end
    P1Practice = false;
    P2Practice = false;
    FR = false;
    blockNum = 0;
    practiceNum = 8;
    
    for o = 1:1
            
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %REGULAR NO FEEDBACK TRIALS
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       
        if selection(o) ==1 %speedforce
             Eyelink('command','calibration_area_proportion = 0.5 0.5');
        Eyelink('command','validation_area_proportion = 0.48 0.48');
        EyelinkDoTrackerSetup(el);
        WaitSecs(0.1);
            
            if P1Practice == false
                
                speed = 1;
                feedback = false;
                confidence = false;
                numTrials = 3;
                SetUpTrialData;
                
                DrawFormattedText(window, 'Regular No Feedback  Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Regular No Feedback Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback Practice block start');
                WaitSecs(0.001);
                
                
            end
                Practice;
                P1Practice = true;
            end
            
            speed = 1;
            feedback = false;
            confidence = false;
            numTrials = 42;
            
            SetUpTrialData;
            
            DrawFormattedText(window, 'Regular No Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
            
            
            
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback block start');
                WaitSecs(0.001);
            end
            
            blockNum = blockNum + 1;
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
             Eyelink('command','calibration_area_proportion = 0.5 0.5');
        Eyelink('command','validation_area_proportion = 0.48 0.48');
        EyelinkDoTrackerSetup(el);
        WaitSecs(0.1);
             if P1Practice == false
               
                speed = 1;
                feedback = false;
                confidence = false;
                numTrials = 3;
                SetUpTrialData;
                
                DrawFormattedText(window, 'Regular No Feedback  Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Regular No Feedback Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback Practice block start');
                WaitSecs(0.001);
                
                
            end
                Practice;
                 P1Practice = true;
            end
            speed = 2;
            feedback = false;
            numTrials = 42;
            confidence = true;
            
            SetUpTrialData;
            
            DrawFormattedText(window, 'P1 Speeded No Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
            
            
            
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Speeded No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Speeded No Feedback block start');
                WaitSecs(0.001);
            end
            
            blockNum = blockNum + 1;
            Practice
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Speeded No Feedback block end');
                WaitSecs(0.001);
            end
            
            
        elseif selection(o)==5
             Eyelink('command','calibration_area_proportion = 0.5 0.5');
        Eyelink('command','validation_area_proportion = 0.48 0.48');
        EyelinkDoTrackerSetup(el);
        WaitSecs(0.1);
            if P2Practice == false
                
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 3;
                SetUpTrialData;
                
                DrawFormattedText(window, 'Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P2 Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular No Feedback Practice block start');
                WaitSecs(0.001);
                
                
            end
                FreeTime;
                P2Practice = true;
            end
            
            speed = 1;
            feedback = false;
            numTrials = 30;
            confidence = false;
            
            SetUpTrialData
            
            DrawFormattedText(window, 'Regular No Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow key to continue...','center' , yCenter + 75, black);
            
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Regular No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Regular No Feedback block start');
                WaitSecs(0.001);
            end
            
            practiceNum = practiceNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'Regular No Feedback block end');
                WaitSecs(0.001);
            end
            
        elseif selection(o)==6
             Eyelink('command','calibration_area_proportion = 0.5 0.5');
        Eyelink('command','validation_area_proportion = 0.48 0.48');
        EyelinkDoTrackerSetup(el);
        WaitSecs(0.1);
            if P2Practice == false
                
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 3;
                SetUpTrialData;
                
                DrawFormattedText(window, 'Regular No Feedback  Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Regular No Feedback Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback Practice block start');
                WaitSecs(0.001);
                
                
            end
                FreeTime;
                P2Practice = true;
            end
            
            speed = 2;
            feedback = false;
            numTrials = 30;
            confidence = false;
            
            SetUpTrialData
            
            DrawFormattedText(window, 'Speeded No Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow key to continue...','center' , yCenter + 75, black);
            
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Speeded No Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Speeded No Feedback block start');
                WaitSecs(0.001);
            end
            
            practiceNum = practiceNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Speeded No Feedback block end');
                WaitSecs(0.001);
            end
            
        elseif selection(o)==7
             Eyelink('command','calibration_area_proportion = 0.5 0.5');
        Eyelink('command','validation_area_proportion = 0.48 0.48');
        EyelinkDoTrackerSetup(el);
        WaitSecs(0.1);
            if P2Practice == false
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 3;
                SetUpTrialData;
                
                DrawFormattedText(window, 'Regular No Feedback  Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Regular No Feedback Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback Practice block start');
                WaitSecs(0.001);
                
                
            end
                FreeTime;
               P2Practice = true;

            end
            
            speed = 1;
            feedback = true;
            numTrials = 30;
            confidence = false;
            
            SetUpTrialData
            
            DrawFormattedText(window, 'Regular Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
            
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular Feedback block start');
                WaitSecs(0.001);
            end
            
            practiceNum = practiceNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Regular Feedback block end');
                WaitSecs(0.001);
            end
            
        elseif selection(o)==8
             Eyelink('command','calibration_area_proportion = 0.5 0.5');
        Eyelink('command','validation_area_proportion = 0.48 0.48');
        EyelinkDoTrackerSetup(el);
        WaitSecs(0.1);
            if P2Practice == false
                
                speed = 1;
                feedback = true;
                confidence = false;
                numTrials = 3;
                SetUpTrialData;
                
                DrawFormattedText(window, 'Regular No Feedback  Practice block now starting','center' , yCenter, black);
                DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
                
                
                
                Screen('Flip', window);
                
                if strcmp(elstate, 'on')
                    % Mark events, messages, etc. in dataviwer trial
                    Eyelink('Message', 'P1 Regular No Feedback Practice  block signal shown');
                    WaitSecs(0.001);
                end
                
                KbWait;
                
                if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P1 Regular No Feedback Practice block start');
                WaitSecs(0.001);
                
                
            end
                FreeTime;
                P2Practice = true;
            end
            
            speed = 2;
            feedback = true;
            numTrials = 30;
            confidence = false;
            
            SetUpTrialData
            
            DrawFormattedText(window, 'Fast Feedback block now starting','center' , yCenter, black);
            DrawFormattedText(window, 'Press arrow keys to continue...','center' , yCenter + 75, black);
            
            Screen('Flip', window);
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Fast Feedback block signal shown');
                WaitSecs(0.001);
            end
            
            KbWait;
            
            
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Fast Feedback block start');
                WaitSecs(0.001);
            end
            
            practiceNum = practiceNum + 1;
            FreeTime;
            
            if strcmp(elstate, 'on')
                % Mark events, messages, etc. in dataviwer trial
                Eyelink('Message', 'P2 Fast Feedback block end');
                WaitSecs(0.001);
            end
            
        end
    end
end


% download data file
%%% This after Psychtoolbox setup

%SetUpEyeLink;
%         counter = 0;
%
%         countForceBlocks = 1;
%         countFreeBlocks = 1;
%
%         forceFirstVec = zeros(2,1) + 1;
%
%
%         if trialChoice == 0
%             forceFirstVec(2,1) = 2;
%         elseif trialChoice == 1
%             forceFirstVec(1,1) = 2;
%         end
%
%         %creation of randomized free and forced trial vector
%         forceVec = zeros(5,1) + 1;
%         freeVec = zeros(5,1) + 2;
%         forceFreeVec = vertcat(forceVec, freeVec);
%         randForceFree = forceFreeVec(randperm(length(forceFreeVec)));
%         randForceFreeVec = vertcat(forceFirstVec, randForceFree);
%
%
%
%         completedForced = 0;
%         completedFree = 0;
%         trialCount = 1;
%         practiceForceComplete = false;
%         practiceFreeComplete = false;
%         while trialCount <= 2
%             if randForceFreeVec(trialCount) == 1
%                 %         if ~practiceForceComplete
%                 %             SetUpTrialData;
%                 %             %practice trials to familiarize participant to task with 10 trials
%                 %             PracticeForce;
%                 %             practiceForceComplete = true;
%                 %         end
%                 SetUpTrialData;
%                 testTTT      ;
%
%
%             elseif randForceFreeVec(trialCount) == 2
%                 %         if ~practiceFreeComplete
%                 %             SetUpTrialData;
%                 %             %practice trials to familiarize participant to task with 10 trials
%                 %             PracticeFree
%                 %             practiceFreeComplete = true;
%                 %         end
%                 SetUpTrialData;
%                 FreeTime;
%
%             end
%             trialCount = trialCount + 1;
%         end
%





%catch
%finalize all data and collect data on how long the experiment took a
%participant
finalTrialData.participant.timeEnded = clock;
finalTrialData.participant.timeTaken = clock - Start_time;

%     finalTrialData.force.results.allTrialsResponseDataMatrix = horzcat([finalTrialData.force.results.responseTimeIncentive,  finalTrialData.force.results.rewardChoice, finalTrialData.force.results.fatigueRating, finalTrialData.force.results.keyPress, finalTrialData.force.results.correctOrIncorrect, finalTrialData.force.results.respTime, finalTrialData.force.results.abortedTrials]);
%     finalTrialData.force.results.dataDescriptionResponse = {'Column 1 represents the time it took for a person to decide the orientation of T';'Column 2 represents the aborted trials (1 = aborted, 0 = succesful)';...
%         'Columnn 3 represents self assessed fatigue on a scale of 1 to 10';'Column 4 represents key presses to decide the orientation of t( 1 = up, 0 = down)';'Columnn 5 represents weather or not a trial was correct (1 = correct, 0 = incorrect)'};
%
%     finalTrialData.force.trialData.descriptionTrialData = {'Column 1 represents the trial number(1-12 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
%         'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)'};
%     finalTrialData.force.trialData.data = trialData;

finalTrialData.free.results.allTrialsResponseDataMatrix = horzcat([finalTrialData.free.results.responseTimeIncentive,  finalTrialData.free.results.rewardChoice, finalTrialData.free.results.fatigueRating,  finalTrialData.free.results.keyPress, finalTrialData.free.results.correctOrIncorrect, finalTrialData.free.results.respTime,  finalTrialData.free.results.abortedTrials]);
finalTrialData.free.results.dataDescriptionResponse = {'Column 1 represents the response time for choosing incentive'; 'Column 2 represents the reward choice(difficult = 2, easy = 1)'; 'Columnn 3 represents self assessed fatigue on a scale of 1 to 10';...
    'Column 4 represents key presses to decide the orientation of t( 1 = up, 0 = down)'; 'Columnn 5 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
    'Column 6 represents the time it took for a person to decide the orientation of T'; 'Column 7 represents the aborted trials (1 = aborted, 0 = succesful)'};

finalTrialData.free.trialData.descriptionTrialData = {'Column 1 represents the trial number(1-72 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
    'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)'};

finalTrialData.free.trialData.data = trialData;

practiceTrialData.free.results.allTrialsResponseDataMatrix = horzcat([practiceTrialData.free.results.responseTimeIncentive, practiceTrialData.free.results.rewardChoice, practiceTrialData.free.results.fatigueRating, practiceTrialData.free.results.keyPress, practiceTrialData.free.results.correctOrIncorrect, practiceTrialData.free.results.respTime, practiceTrialData.free.results.abortedTrials]);
practiceTrialData.free.trialData.data = trialData;

% % % % cleaned.allDataForce = horzcat(finalTrialData.force.trialData.allTrialData, finalTrialData.force.results.allTrialsResponseDataMatrix);
cleaned.data = horzcat(finalTrialData.free.trialData.allTrialData,  finalTrialData.free.results.allTrialsResponseDataMatrix);
% % % % cleaned.allData = vertcat(cleaned.allData);
cleaned.practiceData = horzcat(practiceTrialData.free.trialData.allTrialData, practiceTrialData.free.results.allTrialsResponseDataMatrix);

blockNumVec = cleaned.practiceData(:,10);
cleaned.practiceData = horzcat(cleaned.practiceData, blockNumVec);
cleaned.practiceData(:,10) = [];

blockNumVec = cleaned.data(:,10);
cleaned.data = horzcat(cleaned.data, blockNumVec);
cleaned.data(:,10) = [];


% % % % % % % % % % % % % % AbortIndices = find(cleaned.allData(:,16)==1);
%         cleaned.allData(indices,:) = [];



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
%end
%end
sca;

%load('finalDataFree.mat');
%load('finalDataForce.mat');