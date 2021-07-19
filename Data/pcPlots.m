function [] = pcPlots (DataMatrix, partCode, FreeForce)

d = DataMatrix;
pCode = partCode;
ff = d(:,1);
sn = d(:,2);
tr = d(:,3);
tori = d(:,4);
loc = d(:,5);
abtT = d(:,8);
incV = d(:,7);
TrSp = d(:, 9);
CI = d(:, 14)
    x = [10 14 18 22 26 30];

f = 1;
for j = 1:6
   
   vec = find(ff == f & CI == 1 & incV == j& TrSp == 1 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (CI == 1| CI == 0) & incV == j & TrSp == 1);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT1(j) = (totalAbt/torTR)*100;
   
   
    vec = find(ff == f & CI == 1& incV == j& TrSp == 2 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (CI == 1| CI == 0) & incV == j & TrSp == 2);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT2(j) = (totalAbt/torTR)*100;

end
max1 = max(perABT1);
f = 2;
for j = 1:6
   
   vec = find(ff == f & CI == 1 & incV == j& TrSp == 1 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (CI == 1| CI == 0) & incV == j & TrSp == 1);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT3(j) = (totalAbt/torTR)*100;
   
   vec = find(ff == f & CI == 1 & incV == j& TrSp == 2 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (CI == 1| CI == 0) & incV == j & TrSp == 2);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT4(j) = (totalAbt/torTR)*100;

end

maxMat(1) = min(perABT1);
maxMat(2) = min(perABT2);
maxMat(3) = min(perABT3);
maxMat(4) = min(perABT4);
yMIN = min(maxMat) - 5;








for i = 1:2
    pC = [];
    for j = 1:6
       correct = find(CI == 1& ff == FreeForce & sn == partCode& TrSp == i& incV == j);
       total = find(ff == FreeForce & sn == partCode& TrSp == i& incV == j);
       pC(j) = (length(correct)/length(total))*100;
       
    end 
    if FreeForce == 1
    markerForSlow = 'b-o'
    markerForFast = 'r-o';
    elseif FreeForce == 2
    markerForSlow = 'b-x'
    markerForFast = 'r-x';
    end
    
     if i == 1
      plot(x-0.1, pC, markerForSlow); hold on 
      
    elseif i == 2
      plot(x+0.1, pC, markerForFast); hold on 
    
    
     end
     yLIMS = [yMIN 100];
     ylim(yLIMS);
     
    %legend('Regular Trial','Speeded Trial')

    
    if FreeForce == 1
%         text = 'Free Choice Percent Correct By Reward';
        
    elseif FreeForce == 2
        
%         text = 'Force Choice Percent Correct By Reward';
        
    end
%       title(text)
    xlabel('Reward Size (1-6)')
    ylabel('Percent Correct');




end