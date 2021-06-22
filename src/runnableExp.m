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
%SetUpEyeLink;
counter = 0;
countForceBlocks = 1;
countFreeBlocks = 1;

forceFirstVec = zeros(2,1) + 1;


if trialChoice == 0
    forceFirstVec(2,1) = 2;
elseif trialChoice == 1
    forceFirstVec(1,1) = 2;
end

%creation of randomized free and forced trial vector
forceVec = zeros(5,1) + 1;
freeVec = zeros(5,1) + 2;
forceFreeVec = vertcat(forceVec, freeVec);
randForceFree = forceFreeVec(randperm(length(forceFreeVec)));
randForceFreeVec = vertcat(forceFirstVec, randForceFree);



completedForced = 0;
completedFree = 0;
trialCount = 1;
practiceForceComplete = false;
practiceFreeComplete = false;
while trialCount <= 12 
    if randForceFreeVec(trialCount) == 1
        if ~practiceForceComplete
            SetUpTrialData;
            %practice trials to familiarize participant to task with 10 trials
            PracticeForce;
            practiceForceComplete = true;
        end
        SetUpTrialData;
        ForceTime2;
        
        
    elseif randForceFreeVec(trialCount) == 2
        if ~practiceFreeComplete
            SetUpTrialData;
            %practice trials to familiarize participant to task with 10 trials
            PracticeFree
            practiceFreeComplete = true;
        end
        SetUpTrialData;
        FreeTime
        
    end
    trialCount = trialCount + 1;
end

%finalize all data and collect data on how long the experiment took a
%participant
finalTrialData.participant.timeEnded = clock;
finalTrialData.participant.timeTaken = clock - Start_time;

finalTrialData.force.results.allTrialsData = horzcat([finalTrialData.force.results.respTime, finalTrialData.force.results.abortedTrials, finalTrialData.force.results.fatigueRating, finalTrialData.force.results.keyPress, finalTrialData.force.results.correctOrIncorrect]);
finalTrialData.force.results.dataDescription = {'Column 1 represents the time it took for a person to decide the orientation of T';'Column 2 represents the aborted trials (1 = aborted, 0 = succesful)';...
    'Columnn 3 represents self assessed fatigue on a scale of 1 to 10';'Column 4 represents key presses to decide the orientation of t( 1 = up, 0 = down)';'Columnn 5 represents weather or not a trial was correct (1 = correct, 0 = incorrect)'};

finalTrialData.force.trialData.description = {'Column 1 represents the trial number(1-12 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
    'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)'}; 

finalTrialData.force.trialData.data = trialData;

finalTrialData.free.results.allTrialsData = horzcat([respTimeInc, rewardChoice, fatigueRating, keyPress, correctOrIncorrect, respTime, abortedTrials]);
finalTrialData.free.results.dataDescription = {'Column 1 represents the response time for choosing incentive'; 'Column 2 represents the reward choice(difficult = 2, easy = 1)'; 'Columnn 3 represents self assessed fatigue on a scale of 1 to 10';...
    'Column 4 represents key presses to decide the orientation of t( 1 = up, 0 = down)'; 'Columnn 5 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';... 
    'Column 6 represents the time it took for a person to decide the orientation of T'; 'Column 7 represents the aborted trials (1 = aborted, 0 = succesful)'};
    
finalTrialData.free.trialData.description = {'Column 1 represents the trial number(1-72 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
    'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)'}; 

finalTrialData.free.trialData.data = trialData;



save('finalTrialData');
load('finalTrialData.mat');
sca;

%load('finalDataFree.mat');
%load('finalDataForce.mat');