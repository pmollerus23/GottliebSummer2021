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

completedForced = 0;
completedFree = 0;
while completedForced + completedFree < 1.5
    if trialChoice == 0
        SetUpTrialData;
        %practice trials to familiarize participant to task with 10 trials
        PracticeForce;
        SetUpTrialData; 
        ForceTime2;
        completedForced = 1;
    elseif trialChoice == 1
        SetUpTrialData;
        %practice trials to familiarize participant to task with 10 trials
        PracticeFree
        SetUpTrialData;
        FreeTime
        completedFree = 1;
        
    end
end

%finalize all data and collect data on how long the experiment took a
%participant
finalTrialData.participant.timeEnded = clock;
finalTrialData.participant.timeTaken = clock - Start_time;

save('finalTrialData');
load('finalTrialData.mat');
sca;

%load('finalDataFree.mat');
%load('finalDataForce.mat');