function [] = abtPlots(DataMatrix, PartCode, FreeForce);

d = DataMatrix;
pCode = PartCode;
ff = d(:,1);
sn = d(:,2);
tr = d(:,3);
tori = d(:,4);
loc = d(:,5);
abtT = d(:,8);
incV = d(:,7);
TrSp = d(:, 9);
  x = [10 14 18 22 26 30];;

f = 1;

for j = 1:6
   
   vec = find(ff == f & abtT == 0 & incV == j& TrSp == 1 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (abtT ~= 0| abtT == 0) & incV == j & TrSp == 1);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT1(j) = (totalAbt/torTR)*100;
   
   
    vec = find(ff == f & abtT == 0 & incV == j& TrSp == 2 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (abtT ~= 0| abtT == 0) & incV == j & TrSp == 2);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT2(j) = (totalAbt/torTR)*100;

end
max1 = max(perABT1);
f = 2;
for j = 1:6
   
   vec = find(ff == f & abtT == 0 & incV == j& TrSp == 1 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (abtT ~= 0| abtT == 0) & incV == j & TrSp == 1);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT3(j) = (totalAbt/torTR)*100;
   
   vec = find(ff == f & abtT == 0 & incV == j& TrSp == 2 & sn == pCode);
   incTr = find(sn == pCode& ff == f & (abtT ~= 0| abtT == 0) & incV == j & TrSp == 2);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT4(j) = (totalAbt/torTR)*100;

end

maxMat(1) = max(perABT1);
maxMat(2) = max(perABT2);
maxMat(3) = max(perABT3);
maxMat(4) = max(perABT4);
yMAX = max(maxMat) + 5;








for i = 1:2
    perABT = [];
    for j = 1:6
   
   vec = find(ff == FreeForce & abtT == 0 & incV == j& TrSp == i & sn == pCode);
   incTr = find(sn == pCode& ff == FreeForce & (abtT ~= 0| abtT == 0) & incV == j & TrSp == i);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT(j) = (totalAbt/torTR)*100;

    end
    if FreeForce == 1
        markerForSlow = 'b-o'
        markerForFast = 'r-o';
    elseif FreeForce == 2
        markerForSlow = 'b-x'
        markerForFast = 'r-x';
    end
    
    if i == 1
      plot(x-0.1, perABT, markerForSlow); hold on 
      
    elseif i == 2
      plot(x+0.1, perABT, markerForFast); hold on 

    end
   
    yMIN = 0;
    yLIMS = [yMIN yMAX];
     ylim(yLIMS);
    if FreeForce == 1
        text = 'Percent of Free Trials Aborted'
    elseif FreeForce ==2 
       text =  'Percent of Force Trials Aborted'
    end
   % legend('Regular','Speeded')
%     title(text)
    xlabel('Reward Size (1-6)')
    ylabel('P(Trials Aborted)');

end
    
    




end

