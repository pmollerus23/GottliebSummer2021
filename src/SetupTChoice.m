fatigue_rate_trials=[1 10 20 30 40 50 60 70];
num_practice=10;

KbName('UnifyKeyNames');
    escapeKey = KbName('ESCAPE');
    leftKey = KbName('LeftArrow');
    rightKey = KbName('RightArrow');
    downKey = KbName('DownArrow');
    upKey = KbName('UpArrow');
    twoKey = KbName('2@' );
    threeKey = KbName('3#');
    

et_state=1; %0 = no ET
PsychDefaultSetup(2);
screen = Screen('Screens');
screenNumber = max(screen);


%[window, windowRect] = PsychImaging('OpenWindow', 0, 0.775);
 
[window, windowRect]  = PsychImaging('OpenWindow', screenNumber, 0.775 ,  [0 0 1000 1000], 32, 2);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
numDisp = 1;
numT = 0;

width = windowRect(3);
h = windowRect(4);
mX=windowRect(3); %max X of screens
mY=windowRect(4); %max Y of screen


numTrials = 72;


shapeDist = 1000;
screenWidth = 500;
screenXpixels;

%calculate size of every displayed imageswswsw

[sizeX, sizeY] = visangle2stimsize(1, 1, shapeDist, screenWidth, screenXpixels);


verticalDistVA1 = 6.5;
horizontalDistVA1 = 0;
screenXpixels;
%calculate distance between center and center vertical image
[distX1, distY1] = visangle2stimsize(horizontalDistVA1, verticalDistVA1, shapeDist, screenWidth, screenXpixels);

verticalDistVA2 = 0;
horizontalDistVA2 = 6.5;
screenXpixels;
%calculate distance between center and center horizontal image
[distX2, distY2] = visangle2stimsize(horizontalDistVA2,verticalDistVA2, shapeDist, screenWidth, screenXpixels);

%%% Shape size
verticalDistVA2 = 0.5;
horizontalDistVA2 = 0.5;
screenXpixels;
%calculate distance outer edges of images displayed
[distXShape, distYShape] = visangle2stimsize(verticalDistVA2,horizontalDistVA2, shapeDist, screenWidth, screenXpixels);

%creation of all rectangles used
centerRect = SetRect(xCenter - distXShape, yCenter - distYShape , xCenter + distXShape, yCenter + distYShape);

vertMostRect = SetRect(xCenter - distXShape - distX1, yCenter - distYShape - distY1, xCenter + distXShape + distX1, yCenter + distYShape - distY1);

leftMostRect = SetRect(xCenter - distXShape - distX2, yCenter - distYShape , xCenter + distXShape - distX2, yCenter + distYShape);

topDiagonalLeftRect= SetRect(xCenter - distXShape - distX2, yCenter - distYShape - distY1, xCenter - distXShape - distX2, yCenter - distYShape - distY1);

downMostRect = SetRect(xCenter - distXShape - distX1,  yCenter - distYShape + distY1, xCenter + distXShape + distX1, yCenter + distYShape + distY1);

rightMostRect = SetRect(xCenter - distXShape + distX2, yCenter - distYShape , xCenter + distXShape + distX2, yCenter + distYShape);

diagonalUpLeft = SetRect(xCenter - distXShape - (sqrt(2)/2)*distX2, yCenter - distYShape - (sqrt(2)/2)*distY1, xCenter + distXShape - (sqrt(2)/2)*distX2, yCenter + distYShape - (sqrt(2)/2)*distY1);

diagonalDownLeft = SetRect(xCenter - distXShape - (sqrt(2)/2)*distX2, yCenter - distYShape + (sqrt(2)/2)*distY1, xCenter + distXShape - (sqrt(2)/2)*distX2, yCenter + distYShape + (sqrt(2)/2)*distY1);

diagonalUpRight = SetRect(xCenter - distXShape + (sqrt(2)/2)*distX2, yCenter - distYShape - (sqrt(2)/2)*distY1, xCenter + distXShape + (sqrt(2)/2)*distX2, yCenter + distYShape - (sqrt(2)/2)*distY1);

diagonalDownRight = SetRect(xCenter - distXShape + (sqrt(2)/2)*distX2, yCenter - distYShape + (sqrt(2)/2)*distY1, xCenter + distXShape + (sqrt(2)/2)*distX2, yCenter + distYShape + (sqrt(2)/2)*distY1);


% Setting variable for distance from subject's eyes to screen
viewingDistance = 1000;

% Specifying screen width for visual angle calculation
screenWidth = 500;

%Dimensions of Fixation Cross
[fixationX,fixationY] = visangle2stimsize(1,1,viewingDistance,screenWidth,screenXpixels);

%Centering fixation cross on screen
crossPos = SetRect(xCenter - (fixationX/2), yCenter - (fixationY/2), xCenter + (fixationX/2), yCenter + (fixationY/2));

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


white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white/2;



ifi = Screen('GetFlipInterval', window);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
numSecs = 1;
numFrames = round(numSecs / ifi);

Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 40);
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
[deviceIndices, deviceNames] = GetKeyboardIndices;

KbQueueCreate(deviceIndices);
KbQueueStart(deviceIndices); % start recording key presses

imageCross = imread('CrossP.png');
dispImageCross = Screen('MakeTexture', window, imageCross);

imageNormalT = imread('Picture2TT.png');
dispImageT = Screen('MakeTexture', window, imageNormalT);

imageUPT = imread('Picture2TTUD.png');
dispImageUSDT = Screen('MakeTexture', window, imageUPT);

imageUDL = imread('LPictureUD.png');
upsideDownL = Screen('MakeTexture', window, imageUDL);

imageNL = imread('LPicture.png');
normalL = Screen('MakeTexture', window, imageNL);

imageSL = imread('LPictureS.png');
sideL = Screen('MakeTexture', window, imageSL);

imageSWL = imread('LPictureSW.png');
sideWL = Screen('MakeTexture', window, imageSWL);

%%% This after Psychtoolbox setup
if et_state==1
    disp('Setting up Eyelink');
    %%% 1. Provide Eyelink with details about the graphics environment
    % and perform some initializations. The information is returned
    % in a structure that also contains useful default
    % and control codes (e.g. tracker state bit and Eyelink key values).
    el=EyelinkInitDefaults(window);
    
    % overrride default gray background of eyelink, otherwise runs end
    % up gray! also, probably best to calibrate with same colors of
    % background / stimuli as participant will encounter
    el.backgroundcolour = 0.75; % gray screen background
    % el.foregroundcolour = white;
    % el.msgfontcolour = white;
    % el.imgtitlecolour = white;
    % el.calibrationtargetcolour=[white white white];
    EyelinkUpdateDefaults(el);
    
    %%% 2. Initialization of the connection with the Eyelink
    % exit program if this fails
    dummymode =0;
    if ~EyelinkInit(dummymode)
        fprintf('Eyelink Init aborted.\n');
        % **here execute any cleanup and shutdown functions**
        Screen('closeall');
        return;
    end
    
    [v, vs]=Eyelink('GetTrackerVersion');
    fprintf('Running experiment on a ''%s'' tracker.\n', vs );
    
    %%% 3.Set up eye tracker configuration
    % Setting the proper recording resolution, proper calibration type,
    % as well as the data file content;
    % configuration settings
    Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, mX-1, mY-1);
    Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, mX-1, mY-1);
    
    % set EDF file contents using the file_sample_data and
    % file-event_filter commands
    % set link data thtough link_sample_data and link_event_filter
    Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
    Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
    
    Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,GAZERES,AREA,STATUS,INPUT');
    Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,HREF,GAZERES,AREA,STATUS,INPUT');

    % Tell the Eyelink to send a fixation update every 50 ms
    Eyelink('command', 'fixation_update_interval = %d', 50);
    Eyelink('command', 'fixation_update_accumulate = %d', 50);
    
    % set sample rate in camera setup screen
    Eyelink('command', 'sample_rate = %d', 1000);
    
    %%% 4. Calibrate the eye tracker
    Eyelink('command','calibration_area_proportion = 0.5 0.5');
    Eyelink('command','validation_area_proportion = 0.48 0.48');
    EyelinkDoTrackerSetup(el);
    WaitSecs(0.1);
    
    eye_used = Eyelink('EyeAvailable'); % get eye that's tracked (only track left eye)
    if eye_used == el.BINOCULAR % if both eyes are tracked
        eye_used = el.LEFT_EYE; % use left eye
    end
    
end


fileName=sprintf('%s.edf', edfFile); % Data file name
    Eyelink('Openfile',fileName);
    

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

%Reading images for each incentive level
imageIncentive1 = imread('Reward1.1.png');
imageIncentive2 = imread('Reward2.1.png');
imageIncentive3 = imread('Reward3.1.png');
imageIncentive4 = imread('Reward4.1.png');
imageIncentive5 = imread('Reward5.1.png');
imageIncentive6 = imread('Reward6.1.png');

disOneIncentive = Screen('MakeTexture', window, imageIncentive1);
disTwoIncentive = Screen('MakeTexture', window, imageIncentive2);
disThreeIncentive = Screen('MakeTexture', window, imageIncentive3);
disFourIncentive = Screen('MakeTexture', window, imageIncentive4);
disFiveIncentive = Screen('MakeTexture', window, imageIncentive5);
disSixIncentive = Screen('MakeTexture', window, imageIncentive6);

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