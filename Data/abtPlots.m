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
x = 1:6;

for i = 1:2
    perABT = [];
    for j = 1:6
   
   vec = find(ff == FreeForce & abtT == 0 & incV == j& TrSp == i & sn == pCode);
   incTr = find(sn == pCode& ff == FreeForce & (abtT ~= 0| abtT == 0) & incV == j & TrSp == i);
   totalAbt = length(vec);
   torTR = length(incTr);
   perABT(j) = (totalAbt/torTR)*100;

    end
    if i == 1
      plot(x-0.1, perABT, 'bo-'); hold on 
      
    elseif i == 2
      plot(x+0.1, perABT, 'rx-'); hold on 

    end
   
    
    legend('Regular','Speeded')
    title('Percent of Trials Aborted a Function of Reward')
    xlabel('Reward Size (1-6)')
    ylabel('P(Trials Aborted)');

end
    
    




end

