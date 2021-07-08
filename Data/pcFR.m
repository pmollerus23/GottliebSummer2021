function [] = pcFR (DataMatrix, partCode, FreeForce)

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



for i = 1:2 
    vals = [];
   idx =  find(ff == i & sn == pCode & FR > 0)
   vals = FR(idx);
   
   if i == 1
      for j = 1:length(vals)
          if j == 1
          x1 = zeros(1,(length(vals)-1));
          f = [1];
          horzcat(f,x1);
          elseif j>1
          x1(j) = x1(j-1) + 10;
          end
          finalIdx = length(vals)

      end 
      plot(x1, vals, 'bo-'); hold on 
      
      
      
   elseif i == 2
       for j = 2:length(vals)
           if j ==1
               x2 = [(x1(finalIdx)+10)];
               xToCat = zeros(1, length(vals) - 1)
               x2 = horzcat(x2,xToCat);
           elseif j > 1
               x2(j) = x2(j-1) + 10;
           end
       end
      plot(x2, vals, 'rx-'); hold on
    
    
    
   end 

   
   legend('Free Choice','Force Choice')
 title('Fatigue Ratings By Trials')
    xlabel('Trials Number (1-240)')
    ylabel('Fatigue Rating (1-10)');


end


