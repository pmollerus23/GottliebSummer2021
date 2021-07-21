function [] = RTincPlot( matrix, P_code, freeForce )

%RT Summary of this function goes here
%   Detailed explanation goes here
load final;


d = matrix;
inx = find(d(:,8) == 1);
d(inx, :) = [];


FF = d(:,1);
sbjNum = d(:,2);
rt = d(:,15);
speed = d(:,9);
il = d(:,7);

PartRTSInd = find(sbjNum == P_code);
PartRTS = rt(PartRTSInd,:);

minRTS = mean(PartRTS) -0.5;
%maxRTS = mean(PartRTS)+0.2;
maxRTS = 1;
yRNG = [minRTS maxRTS];



y = [];

for i = 1:6
    SlowInd = find(FF == freeForce & sbjNum == P_code & speed == 1 & il == i);
    SlowVec = d(SlowInd,:);
    
    %%%%
    
    FastInd = find(FF == freeForce & sbjNum == P_code & speed == 2 & il == i);
    FastVec = d(FastInd,:);
    
    %%%%
    
    ilLenIndSlow = find(FF == freeForce & sbjNum == P_code & il == i & speed == 1);
    ilLenIndFast = find(FF == freeForce & sbjNum == P_code & il == i & speed == 2);
    ilLenArrSlow = d(ilLenIndSlow,:);
    ilLenArrFast = d(ilLenIndFast,:);
    ilLenSlow = length(ilLenArrSlow);
    ilLenFast = length(ilLenArrFast);
    
    semSlowIND = find(FF == freeForce & sbjNum == P_code & il == i & speed == 1);
    semFastIND = find(FF == freeForce & sbjNum == P_code & il == i & speed == 2);
    semSlowMAT = d(semSlowIND,:);
    semFastMAT = d(semFastIND,:);
    semSlowVec = semSlowMAT(:,15);
    semFastVec = semFastMAT(:,15);
    stdnSlow = std(semSlowVec);
    stdnFast = std(semFastVec);
    SEMslow = stdnSlow/sqrt(ilLenSlow);
    SEMfast = stdnFast/sqrt(ilLenFast);
    
    %%%%
    
    ySlow(i) = mean(SlowVec(:,15));
    ySlowErrPos(i) = ySlow(i) + SEMslow;
    ySlowErrNeg(i) = ySlow(i) - SEMslow;
    yFast(i) = mean(FastVec(:,15));
    yFastErrPos(i) = yFast(i) + SEMfast;
    yFastErrNeg(i) = yFast(i) - SEMfast;
    
    
    %%%
    
    x = 1:6;
    
    plot([i-0.1 i-0.1],[ySlowErrPos(i) ySlowErrNeg(i)],'black'); hold on
    
    plot([i+0.1 i+0.1],[yFastErrPos(i) yFastErrNeg(i)], 'black'); hold on
end



x = 1:6;
if freeForce == 1
    markerForSlow = 'b-o'
    markerForFast = 'r-o';
elseif freeForce == 2
    markerForSlow = 'b-x'
    markerForFast = 'r-x';
end

plot(x-0.1, ySlow, markerForSlow); hold on

plot(x+0.1, yFast, markerForFast); hold on

if freeForce == 1
    markerSlow = 'b-o';
    markerFast = 'r-o';
elseif freeForce == 2
    markerSlow = 'b-x';
    markerFast = 'r-x';
end

plot(x-0.1, ySlow, markerSlow); hold on

plot(x+0.1, yFast, markerFast); hold on

%legend(' ', ' ', 'Regular', 'Speeded')
xlabel('reward sizes 1-6');
ylabel('reaction time (s)');

xticks(x);
xticklabels({'10','14','18','22','26','30'});


ylim(yRNG);

end

