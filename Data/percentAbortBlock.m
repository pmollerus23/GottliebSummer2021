function [ output_args ] = percentAbortBlock( matrix, P_code )
load final;

d = final.data;
sbjNum = d(:,2);

y = [];

sbjInd = find(sbjNum == 2);
sbjMat = d(sbjInd,:);
speed = sbjMat(:,9);
freeForce = sbjMat(:,1);



for s = 1:2
    speedInd = find(speed == s);
    sbjSpeedMat = sbjMat(speedInd,:);
    abortVec = sbjSpeedMat(:,16);
    freeForceVec = sbjSpeedMat(:,1);
    
    numAbort1 = 0;
    numAbort2 = 0;
    numAbort3 = 0;
    numAbort4 = 0;
    
    for i = 1:120
        if abortVec(i) == 0 & i <= 30
            numAbort1 = numAbort1 + 1;
        elseif abortVec(i) == 0 & i <= 60
            numAbort2 = numAbort2 + 1;
        elseif abortVec(i) == 0 & i <= 90
            numAbort3 = numAbort3 + 1;
        elseif abortVec(i) == 0 & i <= 120
            numAbort4 = numAbort4 + 1;
        end
    end
    numAbortBlockVec = [numAbort1, numAbort2, numAbort3, numAbort4];
    
    for j = 1:4
        yPoint(j) = numAbortBlockVec(j);
    end
    
    
    x = 1:4;
    
    if s == 1
        if freeForceVec(i) == 1
            plot(x-0.1, ((yPoint/30)*100), 'b-o'); hold on
        elseif freeForceVec(i) == 2
            plot(x-0.1, ((yPoint/30)*100), 'b-x'); hold on
        end
    elseif s == 2
        if freeForceVec(i) == 1
            plot(x-0.1, ((yPoint/30)*100), 'r-o'); hold on
        elseif freeForceVec(i) == 2
            plot(x-0.1, ((yPoint/30)*100), 'r-x'); hold on
        end
        
    end
    
    title('Percent Aborted Trials per Block')
    %legend(' ', ' ', 'Regular', 'Speeded')
    xlabel('block numbers 1-4');
    ylabel('percent aborted trials');
    
end

end

