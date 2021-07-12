function [] = RTincPlot( matrix, P_code, freeForce )

%RT Summary of this function goes here
%   Detailed explanation goes here
load final;

d = matrix;

FF = d(:,1);
sbjNum = d(:,2);
rt = d(:,15);
speed = d(:,9);
il = d(:,7);

PartRTSInd = find(sbjNum == P_code);
PartRTS = rt(PartRTSInd,:);

minRTS = mean(PartRTS) -0.2;
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
    
    plot(x-0.1, ySlow, 'b-o'); hold on
   
    plot(x+0.1, yFast, 'r-o'); hold on
    
    if freeForce == 1 
        text = 'Reaction Times as a Function of Reward Size For Free Trials';
    elseif freeForce ==2
        text = 'Reaction Times as a Function of Reward Size For Force Trials';
        
    end
    title(text)
    %legend(' ', ' ', 'Regular', 'Speeded')
    xlabel('reward sizes 1-6');
    ylabel('reaction time (s)');
    
    
     ylim(yRNG);

end

