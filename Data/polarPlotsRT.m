function [] = polarPlotsRT(data, pCode)

d = data;
pCode;
ff = d(:,1);
sn = d(:,2);
tr = d(:,3);
tLoc = d(:,4);
loc = d(:,5);
abtT = d(:,8);
incV = d(:,7);
TrSp = d(:, 9);
CI = d(:, 14);
FR = d(:, 12)
blkNum = d(:, 17);
RT = d(:, 15);
    theta = [2*pi, pi/3, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];


for i = 1:8
    indecies1 = find(tLoc == i & RT > 0 & ff == 1 & TrSp == 1 & sn == pCode)
    meanPlot1(i) = mean(RT(indecies1));
    pft1 = 'bo-';
    
    indecies2 = find(tLoc == i & RT > 0 & ff == 2& TrSp == 1& sn == pCode)
    meanPlot2(i) = mean(RT(indecies2));
      pft2 = 'bx-';
    
     indecies3 = find(tLoc == i & RT > 0 & ff == 1 & TrSp == 2& sn == pCode)
    meanPlot3(i) = mean(RT(indecies3));
      pft3 = 'ro-';
    
     indecies4 = find(tLoc == i & RT > 0 & ff == 2 & TrSp == 2& sn == pCode)
    meanPlot4(i) = mean(RT(indecies4));
      pft4 = 'rx-';
    
    
    
end

    theta = [2*pi, pi/4, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    rho1 = [meanPlot1(1) meanPlot1(2) meanPlot1(3) meanPlot1(4) meanPlot1(4) meanPlot1(6) meanPlot1(7) meanPlot1(8) meanPlot1(1)]
    rho2 = [meanPlot2(1) meanPlot2(2) meanPlot2(3) meanPlot2(4) meanPlot2(4) meanPlot2(6) meanPlot2(7) meanPlot2(8) meanPlot2(1)]
rho3 = [meanPlot3(1) meanPlot3(2) meanPlot3(3) meanPlot3(4) meanPlot3(4) meanPlot3(6) meanPlot3(7) meanPlot3(8) meanPlot3(1)]
rho4 = [meanPlot4(1) meanPlot4(2) meanPlot4(3) meanPlot4(4) meanPlot4(4) meanPlot4(6) meanPlot4(7) meanPlot4(8) meanPlot4(1)]

    polarj(theta, rho1, pft1); hold on
    polarj(theta, rho2, pft2); hold on 
    polarj(theta, rho3, pft3); hold on 
    polarj(theta, rho4, pft4); hold on 
    pbaspect([1000 1000 1000])


    title('RT and Location of Target')


end 





