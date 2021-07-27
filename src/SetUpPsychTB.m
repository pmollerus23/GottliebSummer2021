fatigue_rate_trials=[1 10 20 30 40 50 60 70];
num_practice=10;

[deviceIndices, deviceNames] = GetKeyboardIndices;

KbQueueCreate(deviceIndices);
KbQueueStart(deviceIndices); % start recording key presses


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
rad = 70;

numDisp = 1;
numT = 0;

width = windowRect(3);
h = windowRect(4);
mX=windowRect(3); %max X of screens
mY=windowRect(4); %max Y of screen



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
practiceRect = SetRect(mX-1, mY-1 , mX-1, mY-1);


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


white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white/2;



ifi = Screen('GetFlipInterval', window);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
numSecs = 1;
numFrames = round(numSecs / ifi);

Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 40);
% KbName('UnifyKeyNames');
% escapeKey = KbName('ESCAPE');
% leftKey = KbName('LeftArrow');
% rightKey = KbName('RightArrow');
%Reading images for fixation cross types
imageCross = imread('CrossP.png');
dispImageCross = Screen('MakeTexture', window, imageCross);

imageRedCross = imread('RedCross.png');
dispImageRedCross = Screen('MakeTexture', window, imageRedCross);

imageBlueCross = imread('BlueCross.png');
dispImageBlueCross = Screen('MakeTexture', window, imageBlueCross);

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

%Reading images for task instruction slides
s10 = imread('p2instr1.png');
s11 = imread('p2instr2.png');
s12 = imread('p2instr3.png');
s13 = imread('p2instr4.png');
s14 = imread('p2instr5.png');
s15 = imread('p2instr6.png');
s16 = imread('p2instr7.png');
s17 = imread('p2instr8.png');
s18 = imread('p2instr9.png');
s19 = imread('p2instr10.png');


%...
sc10 = Screen('MakeTexture', window, s10);
sc11 = Screen('MakeTexture', window, s11);
sc12 = Screen('MakeTexture', window, s12);
sc13 = Screen('MakeTexture', window, s13);
sc14 = Screen('MakeTexture', window, s14);
sc15 = Screen('MakeTexture', window, s15);
sc16 = Screen('MakeTexture', window, s16);
sc17 = Screen('MakeTexture', window, s16);
sc18 = Screen('MakeTexture', window, s18);
sc19 = Screen('MakeTexture', window, s19);


%Reading images for each incentive level
imageIncentive1 = imread('Reward11.png');
imageIncentive1EASY = imread('Reward10.png');
imageIncentive2 = imread('Reward14.png');
imageIncentive3 = imread('Reward18.png');
imageIncentive4 = imread('Reward22.png');
imageIncentive5 = imread('Reward26.png');
imageIncentive6 = imread('Reward30.png');

disOneIncentive = Screen('MakeTexture', window, imageIncentive1);
disOneEasyIncentive = Screen('MakeTexture', window, imageIncentive1EASY);
disTwoIncentive = Screen('MakeTexture', window, imageIncentive2);
disThreeIncentive = Screen('MakeTexture', window, imageIncentive3);
disFourIncentive = Screen('MakeTexture', window, imageIncentive4);
disFiveIncentive = Screen('MakeTexture', window, imageIncentive5);
disSixIncentive = Screen('MakeTexture', window, imageIncentive6);

%Initializing images for BLOCK SIGNAL SLIDES
imgRegFB = imread('regFB.png');
imgFastFB = imread('fastFB.png');
imgRegNFB = imread('regNFB.png');
imgFastNFB = imread('fastNFB.png');

%...

regFB = Screen('MakeTexture', window, imgRegFB);
fastFB = Screen('MakeTexture', window, imgFastFB);
regNFB = Screen('MakeTexture', window, imgRegNFB);
fastNFB = Screen('MakeTexture', window, imgFastNFB);

%Initializing images for BONUS SLIDES

imgP1bonus = imread('p1Bonus.png');
imgP2bonus = imread('p2Bonus.png');

%...

p1Bonus = Screen('MakeTexture', window, imgP1bonus);
p2Bonus = Screen('MakeTexture', window, imgP2bonus);





