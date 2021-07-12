function [ ] = prctAbortBlock( matrix, P_code )
d = matrix;
code = P_code;
pCodeCol = d(:,2);
pInd = find(pCodeCol == P_code);
pMat = d(pInd,:);

y = [];

condition = pMat(:,1);
speed = pMat(:,9);
abort = pMat(:,16);

cnt1 = 0;
cnt2 = 0;
yPointArr = [];

x = 1:4;
for c = 1:2
    cnt1 = cnt1 + 1;
    
    for s = 1:2
        cnt2 = cnt2 + 1;
        
        numAbort = length(find(speed==s & condition==c & abort==0));
        percentAbort = numAbort/(length(find(speed==s & condition==c)));
        yPointArr(cnt1, cnt2) = percentAbort;
        yConditonVec(cnt1, cnt2) = c;
        ySpeedVec(cnt1, cnt2) = s;
     
    end
    
end

for i = 1:2
    for j = 1:2
        if 
    end
end
 
end

