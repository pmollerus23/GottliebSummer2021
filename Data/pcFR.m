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
    vals1 = [];
    vals2 = [];
    
    
   idx =  find(ff == i & sn == pCode & FR > 0 & TrSp == 1)
   vals1 = FR(idx);
   idx2 = find(ff == i & sn == pCode & FR > 0 & TrSp == 2);
   vals2 = FR(idx2);
   totLength = length(vals1) + length(vals2);
   if i == 1
      for j = 1:length(vals1)
          if j == 1
          x1 = zeros(1,(length(vals1)-1));
          f = [1];
          horzcat(f,x1);
          elseif j>1
          x1(j) = x1(j-1) + 10;
          end
          finalIdx = length(vals1)

      end 
      for j = 1:length(vals2)
          if j == 1
          x2 = zeros(1,(length(vals2)-1));
          f = [x1(length(vals1)) + 10];
         x2 =  horzcat(f,x2);
          elseif j > 1
               x2(j) = x2(j-1) + 10;
          end
          finalVal = x2(j);
      end
      plot(x1, vals1, 'bo-'); hold on 
      plot(x2, vals2, 'bx-'); hold on 

      
      
      
   elseif i == 2
       for j = 1:length(vals1)
           if j ==1
               x3(1) = [(finalVal+10)];
               xToCat = zeros(1, length(vals1) - 1)
               x3 = horzcat(x3,xToCat);
           elseif j > 1
               x3(j) = x3(j-1) + 10;
           end
           finalVal = x3(j);
       end
       for j = 1:length(vals2)
          if j == 1
          x4 = zeros(1,(length(vals2)-1));
          f = [finalVal];
          x4 = horzcat(f,x4);
          elseif j > 1
               x4(j) = x4(j-1) + 10;
          end
      end
      
      plot(x3, vals1, 'ro-'); hold on
      plot(x4, vals2, 'rx-'); hold on

    
    
    
   end 

   
   legend('Regular Free Choice','Speeded Free Choice', 'Regular Force Choice', 'Speeded Force Choice');
 title('Fatigue Ratings By Trials')
    xlabel('Trials Number (1-240)')
    ylabel('Fatigue Rating (1-10)');


end


