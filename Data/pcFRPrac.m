function [] = pcFRPrac (DataMatrix, partCode, FreeForce)

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
CI = d(:, 14);
FR = d(:, 12)
x1 = [1 10 20 30 40 50 60 70 80 90 100 110 120 ];
x2 = [130 140 150 160 170 180 190 200 210 220 230 240];
blkNum = d(:, 17);

for i = 1:2
   indecies = find(blkNum == i &FR > 0 & sn == pCode)
   locFR = FR(indecies);
   x = indecies;
   if ff(x(1)) == 1 && TrSp(x(1)) == 1
       pointForTrial = 'bo-';
   elseif  ff(x(1)) == 1 && TrSp(x(1)) == 2
       
           pointForTrial = 'ro-';
           elseif  ff(x(1)) == 2 && TrSp(x(1)) == 1
       
           pointForTrial = 'bx-';
           elseif  ff(x(1)) == 2 && TrSp(x(1)) == 2
       
           pointForTrial = 'rx-';

    
    
   end

   plot(x, locFR, pointForTrial); hold on




end


