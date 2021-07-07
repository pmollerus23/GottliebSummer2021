isEyeInside = false;
if flag == 0
    text = 'Too slow';
    DrawFormattedText(window, text,'center' , yCenter-75, black);
    
elseif (nofixtimeflag==1 || nofixflag == 1) && flag == 1
 
    DrawFormattedText(window, 'Please look at center','center' , yCenter, black);
    
end


flag = 1;


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
% randSpeedVec(numTrials) = randSpeedVec(blockIndex + j);
abortedTrials(numTrials) = 0;
abortedTrials(j) = 1;
abortedTrials2(j) = 1;
%isEyeInside = true;
respTimeInc(numTrials) = 0;
rewardChoice(numTrials) = 0;
fatigueRating(numTrials) = 0;
keyPress(numTrials) = 0;
correctOrIncorrect(numTrials) = 0;
respTime(numTrials) = 0;

%Signaling for aborted trials




DrawFormattedText(window, 'Try again','center' , yCenter + 75, black);
Screen('Flip', window);
WaitSecs(4);

isEyeInside = true;
fixation1 = true;
fixation2 = true;

        