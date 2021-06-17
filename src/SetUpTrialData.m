
numTrials = 72;

%creation of randomized array for T location
ones = zeros(9,1) + 1;
twos = zeros(9,1) + 2;
th = zeros(9,1) + 3;
fours = zeros(9,1) + 4;
fives = zeros(9,1) + 5;
sixes = zeros(9,1) + 6;
sevens = zeros(9,1) + 7;
eights = zeros(9,1) + 8;
Tarray = vertcat(ones, twos, th, fours, fives, sixes, sevens ,eights);
%randomize array for use in trials
randTarray = Tarray(randperm(length(Tarray)));

%creation of randomized array for T orientation (up or down T)
one = zeros(36,1) + 1;
zero = zeros(36,1);
orientationTArray = vertcat(one, zero);
orientationTArray = orientationTArray(randperm(length(orientationTArray)));
randomPresentation = orientationTArray(randperm(length(orientationTArray)));


%create array of values 1-8 to get L locations
randLPositionArray = [1 2 3 4 5 6 7 8];
%create array of values to 1-4 to determine the orientation of the L
%presented (up, sideways, upside down, inverted sideways)
randLOrientationArray = [1 2 3 4 1 2 3 4];




%Vector for randomization of cardinality of incentives
ones1 = zeros(numTrials/2, 1)+1;
twos2 = zeros(numTrials/2, 1)+2;
cardinalVec = vertcat(ones1, twos2);
cardinalVec = cardinalVec(randperm(length(cardinalVec)));

%Vector for randomization of incentive levels
one = zeros(numTrials/6,1)+1;
two = zeros(numTrials/6,1)+2;
three = zeros(numTrials/6,1)+3;
four = zeros(numTrials/6,1)+4;
five = zeros(numTrials/6,1)+5;
six = zeros(numTrials/6,1)+6;

%Vector for randomization of incentive orientation
incentiveVec = vertcat(one, two, three, four, five, six);
incentiveVec = incentiveVec(randperm(length(incentiveVec)));

incentiveOrient = cardinalVec;

%Dimensions of incentive image (384x909 scaled by 0.5??)
dimXincentive = 96;
dimYincentive = 227.25;

%Calculating horizontal visual angle of 5 degrees
[visAngleX] = visangle2stimsize(5,0,viewingDistance,screenWidth,screenXpixels);

%Displaying incentive image (1) @5 visual deg left of center
leftRectPos = SetRect(xCenter - visAngleX - dimXincentive, yCenter - (dimYincentive/2), xCenter - visAngleX, yCenter + (dimYincentive/2));
rightRectPos = SetRect(xCenter + visAngleX, yCenter - (dimYincentive/2), xCenter + visAngleX + dimXincentive, yCenter + (dimYincentive/2));

%Matrices for data aggregate
incentiveAmt = nan(numTrials,1);
rewardChoice = nan(numTrials,1);
respTimeInc = nan(numTrials,1);
orientationOfT = nan(numTrials, 1);
positionOfT = nan(numTrials,1);
correctOrIncorrect = nan(numTrials, 1);
respTime= nan(numTrials ,1);
RestrictKeysForKbCheck([]);
RestrictKeysForKbCheck([upKey, downKey, leftKey, rightKey])

%initialize variable struct for rating function
p.mx = xCenter;
p.my = yCenter;
p.stim.VASwidth_inPixels = 750;
p.stim.VASheight_inPixels = 300;
p.stim.VASoffset_inPixels = 100;
p.stim.arrowWidth_inPixels = 10;
p.times.ratingsMaxDuration = 100;
p.times.noRapidPress = 0;

%checks to ensure all code is reached
% completedForced = 0;
% completedFree = 0;


countAbortForced = 0;
countAbortFree= 0;


x = 1:72;
x = x(:);
trialData = x;
trialData(:, 2) = randTarray;
trialData(:, 3) = orientationTArray;
trialData(:, 4) = cardinalVec;
trialData(:, 5) = incentiveVec;
trialData(:, 6) = correctOrIncorrect;


isEyeInside = true;