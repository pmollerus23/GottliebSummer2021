function [ ] = abortPerBlock( matrix, P_code )

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
for i = 0:7
    blockStart = 1+(i*30);
    if speed(1+ (i*30)) ==1 & freeForce(1+ (i*30)) == 1
        for j = 1+(i*30): 1+(i*30)+29
            if abort(j) == 0
                countAbort = countAbort + 1;
            end
        end
        freeSlow = (countAbort/30)* 100;
        
        pointForTrial = 'bx';
        dataForTrial = slowFree;
        freeSlow = 0;
        countAbort = 0;
        chr = 'Regular Force';
       % legendText = convertCharsToStrings(chr);
        m =1;

    elseif speed(1+ (i*30)) ==1 & freeForce(1+ (i*30)) == 2
        for j = 1+(i*30): 1+(i*30)+29
            if abort(j) == 0
                countAbort = countAbort + 1;
            end
        end
        slowForce = (countAbort/30)* 100;
        pointForTrial = 'bo';
        dataForTrial = slowForce;
        slowForce = 0;
        countAbort = 0;
        chr = 'Regular Free';
       % legendText = convertCharsToStrings(chr);
        m = 2;
        xForce

    elseif speed(1+ (i*30)) ==2 & freeForce(1+ (i*30)) == 1
        for j = 1+(i*30): 1+(i*30)+29
            if abort(j) == 0
                countAbort = countAbort + 1;
            end
        end
        fastFree = (countAbort/30)* 100;
        pointForTrial = 'rx';
        dataForTrial = fastFree;
        fastFree = 0;
        countAbort = 0;
        chr = 'Fast Free';
        %legendText = convertCharsToStrings(chr);
        m = 3;

    elseif speed(1+ (i*30)) ==2 & freeForce(1+ (i*30)) == 2
        for j = 1+(i*30): 1+(i*30)+29
            if abort(j) == 0
                countAbort = countAbort + 1;
            end
        end
        fastForce = (countAbort/30)* 100;
        pointForTrial = 'ro';
        dataForTrial = fastForce;
        fastForce = 0;
        countAbort = 0;
        chr = 'Fast Force';
        %legendText = convertCharsToStrings(chr);
        m = 4;

    end
    
   
   
    plot(i+1, dataForTrial, pointForTrial); hold on
    xlim([0 9]);
    
    
%     h = zeros(4, 1);
% h(1) = plot(NaN,NaN,'rx');
% h(2) = plot(NaN,NaN,'ro');
% h(3) = plot(NaN,NaN,'bx');
% h(4) = plot(NaN,NaN,'bo');
% 
% legend(h, 'Fast Force','Fast Free','Regular Force', 'Regular Free');
    
%    if m == 1 && m1 ~=1
%       legARR{counter} = chr;
%        counter = counter + 1;
%        m1 = 1;
%    elseif m ==2  && m2 ~=1
%          legARR{counter} = chr;
%        counter = counter + 1;
%        m2 = 1;
%      elseif m ==3  && m3 ~=1
%         legARR{counter} = chr;
%        counter = counter + 1;
%        m3 = 1;
%      elseif m ==4  && m4 ~=1
%          legARR{counter} = chr;
%        counter = counter + 1;
%        m4 = 1;
%    end
%      
   
%    if counter == 5
%        legend(legARR);
%    end
    title('Percent Aborted Trials per Block')
    %legend(' ', ' ', 'Regular', 'Speeded')
    xlabel('block numbers 1-8');
    ylabel('percent aborted trials');
    m = 0;
    
end



end

