function [] = rcPlots (DataMatrix, partCode, FreeForce)

d = DataMatrix;
inx = find(d(:,8) == 1);
d(inx, :) = [];

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
RC = d(:,11);
x = 1:6;


for i = 1:2
    for j =1:6
    
     difCh2 = find(TrSp == i & sn == pCode & ff == 2& RC == 2& incV == j);
    totCh2 = find(TrSp == i & sn == pCode & ff == 2& incV == j);
    pcDif2(j) = (length(difCh2)/ length(totCh2))*100;
    end
    
    if i == 1  
     
       plot(x-0.1, pcDif2, 'bx-'); hold on 

    elseif i ==2 
       
        plot(x+0.1, pcDif2, 'rx-'); hold on 

    end 
        
        
       
       %  legend('Regular Trial','Speeded Trial')

xticks(x);
xticklabels({'10','14','18','22','26','30'});
    xlabel('Reward Size (1-6)')
    ylabel('P(SS8 Selection)');



end 
