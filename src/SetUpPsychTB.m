%Initializing keyboard setup
[deviceIndices, deviceNames] = GetKeyboardIndices;
%...
KbQueueCreate(deviceIndices);
KbQueueStart(deviceIndices); % start recording key presses
%...
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
downKey = KbName('DownArrow');
upKey = KbName('UpArrow');
twoKey = KbName('2@' );
threeKey = KbName('3#');

%Initializing EyeLink
et_state=1; %0 = no ET

%Initializing screen for PsychToolBox
PsychDefaultSetup(2);
screen = Screen('Screens');
screenNumber = max(screen);
 
%SCREEN SETTING FOR DEBUG/TEST MODE
[window, windowRect] = PsychImaging('OpenWindow', 0, 0.775);
 
%SCREEN SETTING FOR FULLSCREEN MODE
%[window, windowRect]  = PsychImaging('OpenWindow', screenNumber, 0.775 ,  [0 0 1000 1000], 32, 2);
%...
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

%Configuring search array variables
rad = 70;
numDisp = 1;
numT = 0;

%More screen setup
width = windowRect(3);
h = windowRect(4);
mX=windowRect(3); %max X of screens
mY=windowRect(4); %max Y of screen
%...
shapeDist = 1000;
screenWidth = 500;
screenXpixels;

%calculate size of every displayed image
[sizeX, sizeY] = visangle2stimsize(1, 1, shapeDist, screenWidth, screenXpixels);

%Variables for visual angle degrees
verticalDistVA1 = 6.5;
horizontalDistVA1 = 0;
screenXpixels;

%calculate distance between center and center vertical image
[distX1, distY1] = visangle2stimsize(horizontalDistVA1, verticalDistVA1, shapeDist, screenWidth, screenXpixels);
%...
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

%Configuring colors for display background
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white/2;

%More PsychToolBox setup
ifi = Screen('GetFlipInterval', window);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
numSecs = 1;
numFrames = round(numSecs / ifi);
%...
Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 40);

%Reading images for fixation cross types
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\fixCross';
% fileList = dir(fullfile(folder, '/*.png'));
%...
imageCross = imread('CrossP.png');
dispImageCross = Screen('MakeTexture', window, imageCross);

%Reading images for T's for search array
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\searchArray\T';
% fileList = dir(fullfile(folder, '/*.png'));
%...
imageNormalT = imread('Picture2TT.png');
imageUPT = imread('Picture2TTUD.png');
%...
dispImageUSDT = Screen('MakeTexture', window, imageUPT);
dispImageT = Screen('MakeTexture', window, imageNormalT);

%Reading images for L's for search array
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\searchArray\L';
% fileList = dir(fullfile(folder, '/*.png'));
% %...
imageUDL = imread('LPictureUD.png');
imageNL = imread('LPicture.png');
imageSL = imread('LPictureS.png');
imageSWL = imread('LPictureSW.png');
%...
upsideDownL = Screen('MakeTexture', window, imageUDL);
normalL = Screen('MakeTexture', window, imageNL);
sideL = Screen('MakeTexture', window, imageSL);
sideWL = Screen('MakeTexture', window, imageSWL);

%Reading images for task instruction slides PART ONE
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\instructions\p1instructions';
% fileList = dir(fullfile(folder, '/*.png'));

s1 = imread('Slide1.PNG');
s2 = imread('Slide2.PNG');
s3 = imread('Slide3.PNG');
s4 = imread('Slide4.PNG');
s5 = imread('Slide5.PNG');
s6 = imread('Slide6.PNG');
s7 = imread('Slide7.PNG');
s8 = imread('Slide8.PNG');
s9 = imread('Slide9.PNG');
s10 = imread('Slide10.PNG');
%...
sc1 = Screen('MakeTexture', window, s1);
sc2 = Screen('MakeTexture', window, s2);
sc3 = Screen('MakeTexture', window, s3);
sc4 = Screen('MakeTexture', window, s4);
sc5 = Screen('MakeTexture', window, s5);
sc6 = Screen('MakeTexture', window, s6);
sc7 = Screen('MakeTexture', window, s7);
sc8 = Screen('MakeTexture', window, s8);
sc9 = Screen('MakeTexture', window, s9);
sc10 = Screen('MakeTexture', window, s10);

% %Reading images for task instruction slides PART TWO
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\instructions\p2instructions';
% fileList = dir(fullfile(folder, '/*.png'));

s11 = imread('Slide11.PNG');
s12 = imread('Slide12.PNG');
s13 = imread('Slide13.PNG');
s14 = imread('Slide14.PNG');
s15 = imread('Slide15.PNG');
s16 = imread('Slide16.PNG');
s17 = imread('Slide17.PNG');
s18 = imread('Slide18.PNG');
s19 = imread('Slide19.PNG');
s20 = imread('Slide20.PNG');
%...
sc11 = Screen('MakeTexture', window, s11);
sc12 = Screen('MakeTexture', window, s12);
sc13 = Screen('MakeTexture', window, s13);
sc14 = Screen('MakeTexture', window, s14);
sc15 = Screen('MakeTexture', window, s15);
sc16 = Screen('MakeTexture', window, s16);
sc17 = Screen('MakeTexture', window, s16);
sc18 = Screen('MakeTexture', window, s18);
sc19 = Screen('MakeTexture', window, s19);
sc20 = Screen('MakeTexture', window, s20);

% %Reading images for each incentive level
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\incentives';
% fileList = dir(fullfile(folder, '/*.png'));
%...
imageIncentive1 = imread('Reward11.png');
imageIncentive1EASY = imread('Reward10.png');
imageIncentive2 = imread('Reward14.png');
imageIncentive3 = imread('Reward18.png');
imageIncentive4 = imread('Reward22.png');
imageIncentive5 = imread('Reward26.png');
imageIncentive6 = imread('Reward30.png');
%...
disOneIncentive = Screen('MakeTexture', window, imageIncentive1);
disOneEasyIncentive = Screen('MakeTexture', window, imageIncentive1EASY);
disTwoIncentive = Screen('MakeTexture', window, imageIncentive2);
disThreeIncentive = Screen('MakeTexture', window, imageIncentive3);
disFourIncentive = Screen('MakeTexture', window, imageIncentive4);
disFiveIncentive = Screen('MakeTexture', window, imageIncentive5);
disSixIncentive = Screen('MakeTexture', window, imageIncentive6);

% %Initializing images for BLOCK SIGNAL SLIDES
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\instructions\blockSignal';
% fileList = dir(fullfile(folder, '/*.png'));
%...
imgRegFB = imread('regFB.PNG');
imgFastFB = imread('fastFB.PNG');
imgRegNFB = imread('regNFB.PNG');
imgFastNFB = imread('fastNFB.PNG');
%...
regFB = Screen('MakeTexture', window, imgRegFB);
fastFB = Screen('MakeTexture', window, imgFastFB);
regNFB = Screen('MakeTexture', window, imgRegNFB);
fastNFB = Screen('MakeTexture', window, imgFastNFB);

% %Initializing images for BONUS SLIDES
% folder = 'C:\Users\jglab\Documents\GitHub\GottliebSummer2021\src\resources\instructions\bonus';
% fileList = dir(fullfile(folder, '/*.png'));
%...
imgP1bonus = imread('p1Bonus.PNG');
imgP2bonus = imread('p2Bonus.PNG');
%...
p1Bonus = Screen('MakeTexture', window, imgP1bonus);
p2Bonus = Screen('MakeTexture', window, imgP2bonus);
