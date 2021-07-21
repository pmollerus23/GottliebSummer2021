function [ ] = abortPerBlockPrac( matrix, P_code )

y = [];

d = matrix;
indices = find(d(:,2)~=P_code);
d(indices,:)=[];
speed = d(:,9);
freeForce = d(:,1);
abort = d(:,16);

slowFree = 0;
slowForce = 0;
fastFree = 0;
fastForce = 0;
countAbort = 0;
textArr = [];
m1 = 0;
m2 = 0;
m3 = 0;
m4 = 0;
counter = 1;
legARR = [];
xForce = [];
xFree = [];
blkNum = d(:, 17);
TrSp = d(:, 9);
ff = d(:,1);


for i = 1:2
   indecies = find(blkNum == i& abort == 1)
   abortPlot = length(indecies)/30
   if length(indecies) > 0
   if ff(indecies(1)) == 1 && TrSp(indecies(1)) == 1
       pointForTrial = 'bo-';
   elseif  ff(indecies(1)) == 1 && TrSp(indecies(1)) == 2
       
           pointForTrial = 'ro-';
           elseif  ff(indecies(1)) == 2 && TrSp(indecies(1)) == 1
       
           pointForTrial = 'bx-';
           elseif  ff(indecies(1)) == 2 && TrSp(indecies(1)) == 2
       
           pointForTrial = 'rx-';

    
    
   end
   end
   plot(i, abortPlot, pointForTrial); hold on
end



end

